
# Sys.getenv('SPARK_HOME')

#.libPaths(c(file.path(Sys.getenv("SPARK_HOME"),"R/lib/"),.libPaths()))
#library(SparkR)
#library(magrittr)

library(SparkR)
library(magrittr)



#### ...toy datasets...
emp <- data.frame( employee = c(1,2,3,4,5,6),
                   employeename = c('Alice', 'Bob', 'Carla', 'Daniel', 'Evelyn', 'Ferdinand'),
                   departament = c(11, 11, 12, 12, 13, 21),
                   salary = c(800, 600, 900, 1000, 800, 700))
dep <- data.frame( departament = c(11,12,13,14),
                   departamentname = c('production', 'sales', 'marketing', 'research'),
                   manager = c(1,4,5,'NA') )




#### ...sparkR.init() deprecated!!
#sc <- sparkR.init(master = "local[*]",appName = "Primera Prueba")
# sc <- sparkR.session(appName = "R Spark SQL basic example", 
#                      sparkConfig = list(spark.some.config.option = "some-value"))
sc <- sparkR.session(appName = "R Spark SQL basic example", 
               sparkConfig = list(spark.some.config.option = "some-value"))

#### dataframes as spark-dataframes
spark_emp <- createDataFrame(emp)
spark_dep <- createDataFrame(dep)

head(SparkR::select(spark_emp, "employee"))

#### spark-dataframes as tables, to querying with sql...
createOrReplaceTempView(spark_emp, "table_emp")
createOrReplaceTempView(spark_dep, "table_dep")
head( SparkR::sql("SELECT * FROM table_emp") ) 



sparkR.stop()

