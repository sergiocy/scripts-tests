# -*- coding: utf-8 -*-

from pyspark.sql.types import *


def get_data(path_file_data, sparkSession):

    scheme1 = StructType([
                        StructField("cd_flight_number", IntegerType(), True)
                        , StructField("cd_airport_pair", StringType(), True)
                        , StructField("dt_flight_local_zone", DateType(), True)
                        , StructField("id_flight", IntegerType(), True)
                        , StructField("l_90", FloatType(), True)
                        , StructField("r_90", FloatType(), True)
                        , StructField("l_60", FloatType(), True)
                        , StructField("r_60", FloatType(), True)
                        , StructField("l_40", FloatType(), True)
                        , StructField("r_40", FloatType(), True)
                        , StructField("l_30", FloatType(), True)
                        , StructField("r_30", FloatType(), True)
                        , StructField("l_20", FloatType(), True)
                        , StructField("r_20", FloatType(), True)
                        , StructField("l_13", FloatType(), True)
                        , StructField("r_13", FloatType(), True)
                        , StructField("l_6", FloatType(), True)
                        , StructField("r_6", FloatType(), True)
                        , StructField("l_3", FloatType(), True)
                        , StructField("r_3", FloatType(), True)
                        , StructField("l_0", FloatType(), True)
                        , StructField("r_0", FloatType(), True)
                        ])

    data = sparkSession.read.csv(path_file_data, header=True, schema=scheme1)

    return data

