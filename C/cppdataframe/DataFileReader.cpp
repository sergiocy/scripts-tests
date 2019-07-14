

class DataFileReader
{
	std::string fileName;
	std::string delimeter;

    public:
        DataFileReader(std::string filename, std::string delm = ",") : fileName(filename), delimeter(delm)
        {
            std::cout << "creating object DataFileReader" << std::endl;
        }

};
