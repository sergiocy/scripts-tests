# -*- coding: utf-8 -*-

import numpy as np
import dask.array as da
#import dask.visualize



#PATH_DATA = '../../../0-data/input/jigsaw-toxic-comment-classification-challenge/train.csv'
#PATH_LOG_FILE = '../../../0-log/log_course_nlp_keras.log'





if __name__=='__main__':

    print("dask course tests")

    ###########################################
    ############## SECTION 2 ################### 
    #### first tests... numpy comparison...
    np_arr = np.random.randint(20, size = 20)
    print(np_arr)

    dask_arr = da.random.randint(20, size = 20, chunks = 5)
    print(dask_arr)


    # ...to view dask_arr we need... (similar to collect() in spark)...
    print(dask_arr.compute())

    # ...to get chunks...
    print(dask_arr.chunks)

    # ...from np to dask..
    da_from_np = da.from_array(np_arr, chunks = 2)
    print(da_from_np.compute())

    # ...visualize graph... (...for this i must use jupyter or save as file...)
    print(da_from_np.sum())
    #da_from_np.visualize(filename='test.svg')
    #da_from_np.visualize()

    # ...some computes
    print(da_from_np.mean().compute())



    
