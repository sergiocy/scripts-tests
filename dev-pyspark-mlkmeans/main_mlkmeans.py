# -*- coding: utf-8 -*-

import numpy as np
import matplotlib.pyplot as plt
from pyspark.ml.clustering import KMeans
from pyspark.ml.feature import VectorAssembler

from service.spark.create_spark_session import create_spark_session
from controller.mlkmeans.get_data import get_data
from controller.mlkmeans.define_features import features_90



#path_data = '../../../data/input/clusters/test/data_clustering_flight_test.csv'
path_data = '../../../data/input/clusters/real/data_clustering_flight.csv'


def model1():
    print('test')
    print('path_data: ' + path_data)


    spark = create_spark_session()
    data = get_data(path_data, spark)
    print('original dataset shape: ( {0} , {1} )'.format(data.count(), len(data.columns)))

    
    
    ####
    #### ...data wrangling...
    ids90, features90 = features_90()

    data90 = data.select(ids90+features90)
    print('90 dataset shape: ( {0} , {1} )'.format(data90.count(), len(data90.columns)))

    data90 = data90.drop("cd_flight_number")
    data90 = data90.drop("cd_airport_pair")
    data90 = data90.drop("dt_flight_local_zone")
    #data90 = data90.drop("id_flight")
    print('90 dataset shape: ( {0} , {1} )'.format(data90.count(), len(data90.columns)))

    print( 'number of rows with r or l null: {0}'.format(data90.filter((data90.r_90 == None) | (data90.l_90 == None)).count()) )
    data90 = data90.filter(data90.r_90.isNotNull() | data90.l_90.isNotNull())
    print( 'number of rows with r or l null: {0}'.format(data90[(data90.r_90 == None) | (data90.l_90 == None)].count()) )
    print('90 dataset shape: ( {0} , {1} )'.format(data90.count(), len(data90.columns)))
    
    
    ####
    #### ...launch training model...
    vecAssembler = VectorAssembler(inputCols=features90, outputCol="features")
    data90 = vecAssembler.transform(data90).select('*')
    data90.show()  

    #### ...elbow criterium to define k...
    #cost = np.zeros(20)
    #for k in range(2,20):
    #    kmeans = KMeans().setK(k).setSeed(1).setFeaturesCol("features")
    #    model = kmeans.fit(data90.sample(False, 0.1, seed=42))
    #    cost[k] = model.computeCost(data90)
    #print(cost)
    #fig, ax = plt.subplots(1,1, figsize =(8,20))
    #ax.plot(range(2,20),cost[2:20])
    #ax.set_xlabel('k')
    #ax.set_ylabel('cost')
    #plt.show()

    k = 6
    kmeans = KMeans().setK(k).setSeed(1).setFeaturesCol("features")
    model = kmeans.fit(data90)
    centers = model.clusterCenters()

    print("Cluster Centers: ")
    for center in centers:
        print(center)  

    pred = model.transform(data90).select('id_flight', 'prediction')
    pred.show() 

    data90 = pred.join(data90, 'id_flight') 
    data90.show()

    
    spark.stop()




if __name__=='__main__':
    print('test')
    print('path_data: ' + path_data)


    spark = create_spark_session()
    data = get_data(path_data, spark)
    print('original dataset shape: ( {0} , {1} )'.format(data.count(), len(data.columns)))

    
    
    ####
    #### ...data wrangling...
    ids90, features90 = features_90()

    data90 = data.select(ids90+features90)
    print('90 dataset shape: ( {0} , {1} )'.format(data90.count(), len(data90.columns)))

    data90 = data90.drop("cd_flight_number")
    data90 = data90.drop("cd_airport_pair")
    data90 = data90.drop("dt_flight_local_zone")
    #data90 = data90.drop("id_flight")
    print('90 dataset shape: ( {0} , {1} )'.format(data90.count(), len(data90.columns)))

    print( 'number of rows with r or l null: {0}'.format(data90.filter((data90.r_90 == None) | (data90.l_90 == None)).count()) )
    data90 = data90.filter(data90.r_90.isNotNull() | data90.l_90.isNotNull())
    print( 'number of rows with r or l null: {0}'.format(data90[(data90.r_90 == None) | (data90.l_90 == None)].count()) )
    print('90 dataset shape: ( {0} , {1} )'.format(data90.count(), len(data90.columns)))
    
    
    ####
    #### ...launch training model...
    vecAssembler = VectorAssembler(inputCols=features90, outputCol="features")
    data90 = vecAssembler.transform(data90).select('*')
    data90.show()  

    #### ...elbow criterium to define k...
    #cost = np.zeros(20)
    #for k in range(2,20):
    #    kmeans = KMeans().setK(k).setSeed(1).setFeaturesCol("features")
    #    model = kmeans.fit(data90.sample(False, 0.1, seed=42))
    #    cost[k] = model.computeCost(data90)
    #print(cost)
    #fig, ax = plt.subplots(1,1, figsize =(8,20))
    #ax.plot(range(2,20),cost[2:20])
    #ax.set_xlabel('k')
    #ax.set_ylabel('cost')
    #plt.show()

    k = 6
    kmeans = KMeans().setK(k).setSeed(1).setFeaturesCol("features")
    model = kmeans.fit(data90)
    centers = model.clusterCenters()

    print("Cluster Centers: ")
    for center in centers:
        print(center)  

    pred = model.transform(data90).select('id_flight', 'prediction')
    pred.show() 

    data90 = pred.join(data90, 'id_flight') 
    data90.show()

    
    spark.stop()


