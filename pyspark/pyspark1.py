
#import pyspark
from pyspark.sql import SparkSession
import pyspark.sql.functions as fn
from pyspark.sql.types import *
import pyspark.ml.feature as ft




spark = SparkSession.builder.appName('test').getOrCreate()


'''
df = spark.createDataFrame([
(1, 144.5, 5.9, 33, 'M'),
(2, 167.2, 5.4, 45, 'M'),
(3, 124.1, 5.2, 23, 'F'),
(4, 144.5, 5.9, 33, 'M'),
(5, 133.2, 5.7, 54, 'F'),
(3, 124.1, 5.2, 23, 'F'),
(5, 129.2, 5.3, 42, 'M'),
(5, 129.2, 5.3, None, 'M'),
(5, 129.2, None, 42, None),
], ['id', 'weight', 'height', 'age', 'gender'])

df.show()
print(df.count())
print(df.distinct().count())


df = df.dropDuplicates()
df.show() 
print(df.count())
print(df.distinct().count())

print(df.columns)


df.agg(fn.count('id').alias('count'), fn.countDistinct('id').alias('distinct')).show()


counting = [df.select(c).distinct().count() for c in df.columns]
print(counting)
'''



####
#### ...working with csv dataset...
'''
scheme1 = StructType([StructField("custID", StringType(), True)
                    , StructField("gender", IntegerType(), True)
                    , StructField("state", IntegerType(), True)
                    , StructField("cardholder", IntegerType(), True)
                    , StructField("balance", IntegerType(), True)
                    , StructField("numTrans", IntegerType(), True)
                    , StructField("numIntlTrans", IntegerType(), True)
                    , StructField("creditLine", IntegerType(), True)
                    , StructField("fraudRisk", IntegerType(), True)
                    ])

fraud = spark.read.csv('ccFraud.csv', header=True, schema=scheme1)

print(type(fraud))
fraud.show(5)
fraud.printSchema()


fraud.groupby('gender').count().show()

fraud.describe('gender').show()
fraud.describe('numTrans').show()
'''


'''
scheme1 = StructType([StructField("INFANT_ALIVE_AT_REPORT", IntegerType(), True)
                    , StructField("BIRTH_PLACE", StringType(), True)
                    , StructField("MOTHER_AGE_YEARS", IntegerType(), True)
                    , StructField("FATHER_COMBINED_AGE", IntegerType(), True)
                    , StructField("CIG_BEFORE", IntegerType(), True)
                    , StructField("CIG_1_TRI", IntegerType(), True)
                    , StructField("CIG_2_TRI", IntegerType(), True)
                    , StructField("CIG_3_TRI", IntegerType(), True)
                    , StructField("MOTHER_HEIGHT_IN", IntegerType(), True)
                    , StructField("MOTHER_PRE_WEIGHT", IntegerType(), True)
                    , StructField("MOTHER_DELIVERY_WEIGHT", IntegerType(), True)
                    , StructField("MOTHER_WEIGHT_GAIN", IntegerType(), True)
                    , StructField("DIABETES_PRE", IntegerType(), True)
                    , StructField("DIABETES_GEST", IntegerType(), True)
                    , StructField("HYP_TENS_PRE", IntegerType(), True)
                    , StructField("HYP_TENS_GEST", IntegerType(), True)
                    , StructField("PREV_BIRTH_PRETERM", IntegerType(), True)
                    ])

births = spark.read.csv('births_transformed.csv', header=True, schema=scheme1)

births.show(5)

featuresCreator = ft.VectorAssembler(inputCols=['HYP_TENS_GEST'], outputCol='new_feature')


#featuresCreator.show(5)
'''

dt = '2019-06-16'

df = spark.createDataFrame([
    ('2019-10-15', 'z', 'null'), 
    ('2019-06-16', 'z', 'null'),
    ('2019-07-16', 'c', 'null'),
    ('2019-06-17', 'null', 'null'),
    ('2019-05-16', 'null', '4.0')],
    ['low', 'high', 'normal'])

df.show()


df = df.withColumn('normal', fn.datediff(fn.to_date(df.low, 'yyyy-MM-dd'), fn.to_date(fn.lit(dt), 'yyyy-MM-dd')))

#df.normal = fn.datediff(fn.to_date(df.low, 'yyyy-MM-dd'), fn.to_date(fn.lit(dt), 'yyyy-MM-dd'))

#SELECT abs(datediff(date(low)), date(from_date))) as diff_days from df

#df = spark.sql("""SELECT * FROM revenue.ds_looktobook_cumulative where ndo = 0""")

df.show()


spark.stop()