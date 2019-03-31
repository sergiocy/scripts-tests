JUPYTER AS REST SERVICE
========================================
We will comment the process and steps to use jupyter notebook as REST service.

## Updating Anaconda
In first place we will update Anaconda in the same way that explain [here](http://www.manejandodatos.es/2014/05/actualizando-ipython-anaconda/). Maybe, it is no needed in all cases but I did it.

Basicly,

* Update Anaconda packages, 
	`conda update anaconda`
    
* Update iPython,
	`conda update ipython`
    
* Clean old tar-files
	`conda clean -t`


## Install 'jupyter_kernel_gateway' 

[Here](https://jupyter-kernel-gateway.readthedocs.io/en/latest/getting-started.html) we can find instructions. But, esentially,

* Install "jupyter_kernel_gateway",
	`pip install jupyter_kernel_gateway`
    

## Start jupyter as rest service

Now, to start a jupyter notebook as rest service, only we must execute the next instruction,

`jupyter kernelgateway --KernelGatewayApp.api='kernel_gateway.notebook_http' --KernelGatewayApp.seed_uri="notebook-path”`

With that, our notebook will be rise in port 8888.

Of course, our notebook will need some sentences to define the API. Next, we will find some examples.

## Examples 

### 1.- "hello world" in a GET request

In this case (**"first-example-jupyter-as-rest.ipynb"**), we only need the next cell

```
# GET /hello/world
print("hello world")
```

To observe the "# GET" label to define the URL of our API (**NOTE:** the space between "#" and "GET" is necessary). To view the effect, we can start our browser in `"localhost:8888/hello/world"`.


### 2.- a first example of a POST request

Here (**"second-example-jupyter-as-rest.ipynb"**) we show a first example of a POST request. In the code we can see the request body. 

In the **first cell** we put the needed imports,
```
import json
import requests

##########################
# POST-REQUEST EXAMPLE:
# ...the header...
# {
#    "content-type":"application/json"
# }
# ...the body...
# {
#    "test1":"hola"
#    "test2":"mundo"
# }
##########################
```

and, in the (**second cell**) we define the API,
```
# POST /first

# ...we recover the request...
request = json.loads(REQUEST)

# ...by default, we get the request in a variable "body"...
# ...and we recover each variable in the body of JSON input...
test_var1 = request['body'].get('test1')
test_var2 = request['body'].get('test2')
```

The **third cell** is to define de response,
```
# POST /first

# ...we build and JSON response and we print it...
print(json.dumps({
    "headers" : {
        "Content-Type" : "application/json"
    },
    "status" : 201,
    "res" : {
        "test1" : test_var1,
        "test2" : test_var2
    }
}))
```

**NOTE:** to observe that all cells starts with the definition of request type.


### 3.- Implementing some functionality

Many functionalities require some calculation. For example, a simple sum of numbers received by POST request (**"third-example-jupyter-as-rest.ipynb"**).

In the **first cell** the imports,

```
import json
import requests

##########################
# POST-REQUEST EXAMPLE:
# ...the header...
# {
#    "content-type":"application/json"
# }
# ...the body...
# {
#    "number1":1
#    "number2":1
#    "number3":1
# }
##########################
```

in the **second cell** we get the input parameters; 3 integer numbers in this case,

```
# POST /sum

# ...we recover the request...
request = json.loads(REQUEST)
# ...by default, we get the request in a variable "body"...
body = request['body']

# ...and we recover each number...
value1 = body.get('number1')
value2 = body.get('number2')
value3 = body.get('number3')
```

The **third cell** is to implement functionality,

```
# POST /sum
# ...we can implement functionalities. For example the sum of input numbers...
res = value1 + value2 + value3
```

and finally we send the result,
```
# POST /sum

# ...we build and JSON response and we print it...
print(json.dumps({
        "result" : res       
}))
```


### 4.- Joining csvs with pandas as REST-service

In this example we test an implementation af a service that receive two data files and execute a join generating a new file containing the result.

In the **first cell** we put the imports,
```
import pandas as pd
import json
import requests

##########################
# POST-REQUEST EXAMPLE (from "postman"):
# ...the header...
# {
#    "content-type":"application/json"
# }
# ...the body...
# {
#{
#	"file1" : {
#		"path":"./data1.csv",
#		"sep":",",
#		"enc":"utf-8"
#	},
#	"file2" : {
#		"path":"./data2.csv",
#		"sep":",",
#		"enc":"utf-8"
#	}
#}
# }
##########################
```

and, in the **second cell**, we get the parameters sended in request (file-path, separator and encoding)
```
# POST /join

# ...we put the files in the same folder that notebook...
# ...in this way, the (relative) path is the file name...

# ...variable REQUEST defined to test the next code...
#REQUEST = json.dumps({
#    'body': {
#        "file1" : {
#            "path":"./data1.csv",
#            "sep":",",
#            "enc":"utf-8"
#        },
#        "file2" : {
#            "path":"./data2.csv",
#            "sep":",",
#            "enc":"utf-8"
#        }
#    }
#})


# ...we recover the file paths in the request...
request = json.loads(REQUEST)
body = request['body']

path1 = body.get('file1').get('path')
sep1 = body.get('file1').get('sep')
enc1 = body.get('file1').get('enc')
path2 = body.get('file2').get('path')
sep2 = body.get('file2').get('sep')
enc2 = body.get('file2').get('enc')
```

In the **third cell** we implement the join,
```
# POST /join

# WE READ CSVS AND LOAD IN PANDAS
df_l = pd.read_csv(path1, sep=sep1, encoding=enc1)
df_r = pd.read_csv(path2, sep=sep2, encoding=enc2)

df_join = pd.merge(df_l, df_r, how='inner')
```

and, finally, in the **fourth cell** we print th result and generate the output file,
```
# POST /join

# ...we build and JSON response and we print it...
print(json.dumps({
        "result" : df_join.to_json()  
        #df_join.to_json()    
}))

# ...we generate a csv with result...
df_join.to_csv('join.csv', encoding="utf-8")
```


