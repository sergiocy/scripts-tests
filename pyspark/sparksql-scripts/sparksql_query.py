from pyspark.sql import SparkSession
import time
from subprocess import Popen, PIPE


def run_cmd(args_list):
        """
        run linux commands
        """
        print('Running system command: {0}'.format(' '.join(args_list)))
        proc = Popen(args_list, stdout=PIPE, stderr=PIPE)
        s_output, s_err = proc.communicate()
        s_return = proc.returncode
        return s_return, s_output, s_err

def run(query, output_file):
    spark = SparkSession.builder.appName("Query maker"). \
        enableHiveSupport().getOrCreate()

    hdfs_dir_path = "/user/name_user/{}".format(output_file.split(".")[-2])

    local_file_path = "/home/name_user/R/{}".format(output_file)

    print(query)

    df = spark.sql(query)

    df.write.csv(hdfs_dir_path)

    spark.stop()

    # Run Hadoop getmerge command in Python
    run_cmd(['hdfs', 'dfs', '-getmerge', hdfs_dir_path, local_file_path])
    run_cmd(['hdfs', 'dfs', '-rm', '-r', hdfs_dir_path])


if __name__ == '__main__':

    start = time.time()
    
    run("select * from hive_name_table", "data_name_file.txt" )

    end = time.time()

    print("\nExecution of job took {0} seconds".format(end-start))