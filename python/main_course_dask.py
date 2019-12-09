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

    # ...operations...
    print((dask_arr + 100).compute())
    print((dask_arr * (-1)).compute())

    # ...reductions...
    print(dask_arr.sum().compute())

    # ...matrix...
    dask_ones = da.ones((10, 3), chunks = 2, dtype = int)
    print(dask_ones.compute())

    print(dask_ones.mean(axis = 0).compute())
    print(dask_ones.mean(axis = 1).compute())

    # ...slicing and broadcasting...
    print(da.add(dask_arr, da_from_np).compute())


    ###########################################
    ############## SECTION 3 ###################
    # ...lazy function...
    def my_lazy_func(a, b):
        a = a + 2
        b = b + 10
        # return a, b  # ...output of usual function..
        yield a, b  # ...output of lazy function

    print(my_lazy_func(1, 1))
    print(next(my_lazy_func(1, 1)))


    from dask import delayed, compute

    def fun_1(x):
        y = x**2
        return y

    final_result = []
    for i in range(0, 10):
        res = delayed(fun_1(i))
        final_result.append(res)

    print(final_result)
    #print(da.from_array(np.asarray(final_result)).compute())

    final_sum = delayed(sum)(final_result)
    print(final_sum)
    print(final_sum.compute())


    final_result = []

    @delayed
    def fun_1(x):
        y = x**2
        return y

    for i in range(0, 10):
        final_result.append(delayed(fun_1(i)))
    
    final_sum = delayed(sum)(final_result)
    print(final_sum)
    print(final_sum.compute())



    ################################################
    ##### section 4: dataframes
    







































    
