# -*- coding: utf-8 -*-
"""
Created on Sat Oct  6 21:52:26 2018

@author: scordoba
"""

import findspark
findspark.init()
import pyspark
sc = pyspark.SparkContext(appName="myAppName")