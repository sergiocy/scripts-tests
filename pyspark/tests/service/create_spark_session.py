# -*- coding: utf-8 -*-

from pyspark.sql import SparkSession


def create_spark_session(appName='test'):
    spark = SparkSession.builder.appName(appName).getOrCreate()    

    return spark