

import time
import logging
from datetime import datetime, date, timedelta
from pyspark import SparkConf, SparkContext
from pyspark.sql import SQLContext, SparkSession
from pyspark.sql.functions import *
from pyspark.sql.types import StructType
from pyspark.sql.types import StructField
from pyspark.sql.types import StringType
from pyspark.sql import HiveContext




def create_spark_session1():
    conf = (SparkConf()
            .setMaster("local")
            .setAppName("anomaly-selection")
            .set("spark.executor.memory", "1g"))

    spark = SparkSession.builder.config(conf = conf).enableHiveSupport().getOrCreate()

    return spark



def create_spark_session2(name, max_executors='3', executor_memory='6g'):
    return(SparkSession\
    .builder\
    .appName(name)\
    .config("spark.dynamicAllocation.enabled", 'true')\
    .config("spark.dynamicAllocation.maxExecutors", max_executors if max_executors is not None else '3')\
    .config("spark.dynamicAllocation.minExecutors", '1')\
    .config('spark.executor.cores', '8')\
    .config('spark.cores.max', '8')\
    .config("spark.executor.memory", executor_memory if executor_memory is not None else '6g')\
    .config("spark.sql.crossJoin.enabled", "true")\
    .config("spark.shuffle.service.enabled", "true")\
    .config("spark.sql.parquet.writeLegacyFormat", "true")\
    .config("spark.sql.sources.partitionOverwriteMode", "dynamic")\
    .enableHiveSupport()\
    .getOrCreate())




def get_df_from_hive(spark_context, hive_table_name, hive_table_name_temp, qry_hive):
    #print("complete function to recover data from s3/hive with sparksql") 

    hive_context = HiveContext(spark_context)
    df_output = hive_context.table(hive_table_name)
    
    #### ...testing objects...
    #df_output.show(3)
    #print(type(df_output))
    #print((df_output.count(), len(df_output.columns)))


    #### ...getting subset of interest...
    #### ...we register table to query with sql...
    df_output.registerTempTable(hive_table_name_temp)

    #print(qry_hive)

    df_output_filtered = hive_context.sql(qry_hive)
    #print((df_output_filtered.count(), len(df_output_filtered.columns)))

    return df_output_filtered




def get_df_from_file(path_file, col_names, sep, ctrl_header):
    
    rdd_df = sc.textFile(path_file)
    print(rdd_df.take(3))

    rdd_df = rdd_df.map(lambda r: r.split(sep))
    print(rdd_df.take(3))

    print(rdd_df.count())

    if ctrl_header == True:
        col_names = rdd_df.first()
        print(col_names )

        #rdd_df = rdd_df.map(lambda r:  )

    
    sqlContext = SQLContext(sc)

    #schema = StructType([StructField(str(i), StringType(), True) for i in range(6)])
    df = sqlContext.createDataFrame(rdd_df)

    print( type(df) )
    df.printSchema()
    print(df.head(2))
    df.show(2)




    #sqlContext = SQLContext(sc)
    #df = sqlContext.createDataFrame(rdd_df) # create a dataframe - notice the extra whitespaces in the date strings
    #df.collect()

    #rdd2 = rdd1.map(lambda row: row.split(','))
    #rdd2 = rdd2.map(lambda r: (r[0], r[1]))

    #print(rdd2.take(1))
    #print( rdd2.count() )

    #rdd3 = rdd2.filter(lambda r : r[0] == '1220')
    #print(rdd3.count())

    #rdd3.collect()
    return 'null'
    



def get_control_day(ini_date, end_date, day_ow = 0):

    #current_date = datetime.strptime(current_date, format_date)
    #ini_date = current_date - timedelta(days = 7)
    ini_date = ini_date + timedelta(days = 1)

    print(ini_date)
    print( type(ini_date) )
    print(ini_date.weekday())

    dts = [ini_date + timedelta(days=x) for x in range((end_date-ini_date).days + 1)]
    print(dts)

    for dt in dts:
        print(dt.weekday())
        if dt.weekday() == day_ow:
            ctrl_day = dt

    return ctrl_day




def selecting_anomalies(df, current_day, n_times_anomaly):
    print("selecting anomalies")
    print(current_day)

    print((df.count(), len(df.columns)))
    #df.printSchema()

    ####
    #### ...count anomalies in before days...
    df_before = df.filter(df.dt_sales_date < current_day) 
    print((df_before.count(), len(df_before.columns)))

    df_before = df_before.groupby('id_flight').count()
    #df_before.show(5)
    df_before = df_before.withColumnRenamed("count", "n")
    #df_before.show(5)
    #df_before.printSchema()

    df_before = df_before.filter(df_before.n == n_times_anomaly)
    print((df_before.count(), len(df_before.columns)))


    #### ...get anomalies of today
    df_current = df.filter(df.dt_sales_date >= current_day) 
    ##df_current = df_current.select("id_flight", "target_is_anomaly_s")
    #
    ##df_current.show(5)
    print((df_current.count(), len(df_current.columns)))

    df_b = df_before.alias('df_b')
    df_c = df_current.alias('df_c')
    #df_result = df_b.join(df_c, df_b.id_flight == df_c.id_flight, how = 'left').select('df_c.*')
    df_result = df_b.join(df_c, df_b.id_flight == df_c.id_flight).select('df_c.*')
    print((df_result.count(), len(df_result.columns)))

    return df_result




def selecting_new_anomalies(spark, df, current_day, ctrl_day):
    print("selecting anomalies")
    print(current_day)
    print(ctrl_day)
    print(type(current_day))
    print(type(ctrl_day))

    ####
    #### ...if today is the control day, then, we get all anomalies detected (type_reg = output_raw)
    if current_day == ctrl_day:
        df_result = df.filter(df.type_reg == 'output_raw')
        df_result = df.filter(df.dt == current_date.strftime(format_date))
    
    ####
    #### ...if not, we get anomalies not in before days (warning, because in that case we will need anomalies loaded in table with "type_reg = output")
    else:
        df_result = df.filter(df.type_reg == 'output_raw')

        df_before = df_result.filter( (df_result.dt >= ctrl_day.strftime(format_date)) & (df_result.dt < current_day.strftime(format_date)) )
        df_today = df_result.filter( df_result.dt == current_day.strftime(format_date) )

        df_before.createOrReplaceTempView("before")
        df_today.createOrReplaceTempView("today")

        df_result = spark.sql( " SELECT today.* FROM today LEFT JOIN before ON today.id = before.id WHERE before.id IS NULL " )
        print(type(df_result))


    return df_result




def write_to_s3(df, s3_path):
    #df.write.parquet(s3_path, mode="overwrite")
    #df.write.csv(table_info.s3_path, mode="overwrite", sep="|")  
    # 
    #df.write.format("com.databricks.spark.csv").codec("gzip").save('my_directory/my_file.gzip')  
    # df.write.format("com.databricks.spark.csv").option("codec", "org.apache.hadoop.io.compress.GzipCodec").save(my_directory) 
    df.write.csv(s3_path, mode="overwrite", sep="|", compression = "gzip")  





if __name__ == '__main__':

    ####
    #### start the time and define the sparkSession   
    start = time.time()
    #spark = create_spark_session1()
    spark = create_spark_session2("anomaly-selection")
    sc = spark.sparkContext



    ####
    #### define dates to work (time intervals)
    format_date = '%Y-%m-%d'
    #current_date = '2018-11-12'
    current_date = 'CURRENT_DATE'
    current_date = datetime.strptime(current_date, format_date)
    ini_date = current_date - timedelta(days = 7)
    end_date = current_date
    print('ini_date: ' , str(ini_date))
    print('end_date: ' , str(end_date))

    #define the "control_day" (day when recover and review past anomalies)
    #we define that day depends on the day of the week.
    #i.e. mondays will be the control day. 
    #we will need recover the last monday in time interval considered (one week)
    ctrl_day = get_control_day(ini_date, end_date, day_ow = 0)
    print('control_day: '+ str(ctrl_day))
    print(type(ctrl_day))

    print('ini_date: ' , str(ini_date))
    print('end_date: ' , str(end_date))


        ####
    #### define log-file
    log_filename = 'PATH_LOG_FILE'
    logging.basicConfig(filename = log_filename, level = logging.INFO)
    logging.info('#### STARTING SELECTION ANOMALIES PROCESS #### ' + str(datetime.now()) )
    logging.info(str(datetime.now()) + ' - SELECTION ANOMALIES PROCESS - current day: ' + str(current_date) )




    #### GET DATAFRAME FROM HIVE
    #### ...another function to get data through hive (to s3)
    logging.info(str(datetime.now()) + ' - SELECTION ANOMALIES PROCESS - ' + ' getting data from hive in output raw ')
    table_name = "hive_scheme.name_table"
    table_name_temp = "df_temp"

    #qry_hive = " select * from " + table_name_temp + " where dt > date('" + ini_date.strftime(format_date) + "') and dt <= date('" + end_date.strftime(format_date) + "') and type_reg = 'output_raw'" 
    qry_hive = " select * from " + table_name_temp + " where dt > date('" + ini_date.strftime(format_date) + "') and dt <= date('" + end_date.strftime(format_date) + "') " 
    print(qry_hive)
    logging.info(str(datetime.now()) + ' - SELECTION ANOMALIES PROCESS - ' + ' querying: ' + qry_hive)
    
    df_selected = get_df_from_hive(sc, table_name, table_name_temp, qry_hive)
    print("df_selected")

    #print( (df_selected.count(), len(df_selected.columns)) )
   




    ####
    #### GET DATAFRAME FROM FILE WITH/WITHOUT HEADER
    #### format df
    #path_file = 'C:/../test.txt'
    #name_fields = ['atr_od', 'mean', 'sd', 'coef', 'max', 'min']
    #sep = ","
    #df = get_df_from_file(path_file, name_fields, sep, True)




    ####
    #### ...filtering functions... 
    #### ...we can test different options...  
    n_times_anomaly = 2 

    #df_selected_anomalies = selecting_anomalies(df_selected, current_date.strftime(format_date), n_times_anomaly)
    df_selected_anomalies = selecting_new_anomalies(spark, df_selected, current_date, ctrl_day)
    #df_selected_anomalies = df_selected


    print("df_selected_anomalies")
    print((df_selected_anomalies.count(), len(df_selected_anomalies.columns)))
    df_selected_anomalies.printSchema()
    #print(df_selected_anomalies.head(3))


    #df_selected_anomalies = df_selected_anomalies.filter(df_selected_anomalies.dt_sales_date == current_date.strftime(format_date))
    #df_selected_anomalies = df_selected_anomalies.filter(df_selected_anomalies.dt_sales_date == datetime.strptime(current_date, format_date))
   
    print(type(current_date.strftime(format_date)))
    print(df_selected_anomalies.take(1))
    print(current_date.strftime(format_date))
    print((df_selected_anomalies.count(), len(df_selected_anomalies.columns)))
    logging.info(str(datetime.now()) + ' - SELECTION ANOMALIES PROCESS - ' + ' anomalies selected: ' + str(df_selected_anomalies.count()) )


    ####
    #### ...writting in s3... 
    #s3_path = "s3://../ds-anomaly-detection-output/dt=" + current_date.strftime(format_date) + "/type_reg=output/"
    s3_path = "PATH_S3_OUTPUT"
    logging.info(str(datetime.now()) + ' - SELECTION ANOMALIES PROCESS - ' + ' loading in s3 ' )
    write_to_s3(df_selected_anomalies, s3_path)


    ####
    #### ADDITIONAL
    #### - include logger (and remove prints)
    #### - maybe, include config??
    #### - change name table in hive query INTO the function
    

    sc.stop()
    logging.info(str(datetime.now()) + ' - SELECTION ANOMALIES PROCESS - ' + ' ending process ' )

    end = time.time()
    print("\nExecution of job took {0} seconds".format(end-start))
