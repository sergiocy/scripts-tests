#include <iostream>

#include <DataFileReader.cpp>
//extern void DataFileReader()

//using namespace std;

#define FILENAME "C:/sc-sync/projects/data/input/clusters/test/data_clustering_test.csv"


int main()
{
    std::cout << "hello world" << std::endl;

    std::cout << FILENAME << std::endl;

    DataFileReader reader(FILENAME);

    return 0;
}
