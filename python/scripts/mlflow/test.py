
import os


currentfilepath = os.path.realpath(__file__)
print(currentfilepath)

dircurrentfilepath = os.path.dirname(currentfilepath)
print(dircurrentfilepath)

dir_project = os.path.split(dircurrentfilepath)[0]
print(dir_project)

filepath = '{0}{1}python{2}data{3}{4}'.format(dir_project, os.sep, os.sep, os.sep, 'data-test.txt')
print(filepath)


if os.path.exists(filepath):
    print('exists')
    os.rename(filepath, '{0}{1}python{2}data{3}{4}'.format(os.path.split(dircurrentfilepath)[0], os.sep, os.sep, os.sep, 'data-test-newname.txt'))


