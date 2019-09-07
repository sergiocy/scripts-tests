# -*- coding: utf-8 -*-

import os
import sys
import numpy as np

from service.utils import create_logger




PATH_DATA = '../../../data/input/jigsaw-toxic-comment-classification-challenge/train.csv'
PATH_LOG_FILE = '../../../log/log_course_nlp_keras.log'




if __name__=='__main__':

    logger = create_logger(PATH_LOG_FILE)
    logger.info('path_data: ' + path_data)
    logger.info('path_log: ' + path_data)


    
