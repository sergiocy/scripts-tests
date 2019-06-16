
#import pyspark
from pyspark.sql import SparkSession
import pyspark.sql.functions as fn
from pyspark.sql.types import *




spark = SparkSession.builder.appName('abc').getOrCreate()


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



spark.stop()