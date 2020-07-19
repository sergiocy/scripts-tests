
import pandas as pd
from sklearn.model_selection import train_test_split


#FILE_DATA_TRAIN = '../../../var-scdata/input/santander-customer-satisfaction/train.csv'
FILE_DATA_TRAIN = '/var/scdata/input/santander-customer-satisfaction/train.csv'



data = pd.read_csv(FILE_DATA_TRAIN, nrows = 50000)
print(data.head())
print(data.columns)




train, test, y_train, y_test = train_test_split(data.drop('TARGET', axis = 1)
                                                   , data['TARGET']
                                                   , test_size = 0.3
                                                   , random_state = 0)

print('datasets shapes: {0}  -  {1}'.format(train.shape, test.shape))

'''

sel_var = VarianceThreshold(threshold=0)
sel_var.fit(train)

len(sel_var.get_support()[sel_var.get_support() == True])


#train = train
#train.columns[sel_var.get_support()]
cols_sel = [col for col in train.columns[sel_var.get_support()]]
train = train[cols_sel]
train.shape


len([col for col in train.columns if train[col].std() == 0])
'''









