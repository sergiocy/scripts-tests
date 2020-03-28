# ---
# jupyter:
#   jupytext:
#     formats: ipynb,py:light
#     text_representation:
#       extension: .py
#       format_name: light
#       format_version: '1.4'
#       jupytext_version: 1.2.4
#   kernelspec:
#     display_name: Python 3
#     language: python
#     name: python3
# ---

# +
import pandas as pd
import numpy as np

from sklearn.model_selection import train_test_split
from sklearn.feature_selection import VarianceThreshold
# -

FILE_DATA_TRAIN = '../../00data/input/santander-customer-satisfaction/train.csv'



data = pd.read_csv(FILE_DATA_TRAIN, nrows = 50000)
data.head()



# +
train, test, y_train, y_test = train_test_split(data.drop('TARGET', axis = 1)
                                                   , data['TARGET']
                                                   , test_size = 0.3
                                                   , random_state = 0)

train.shape, test.shape

# +
sel_var = VarianceThreshold(threshold=0)
sel_var.fit(train)

len(sel_var.get_support()[sel_var.get_support() == True])


#train = train
#train.columns[sel_var.get_support()]
cols_sel = [col for col in train.columns[sel_var.get_support()]]
train = train[cols_sel]
train.shape
# -

len([col for col in train.columns if train[col].std() == 0])










