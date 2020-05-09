
#include <vector>
#include <iostream>
using namespace std;
using std::vector;

#define HEIGHT 5
#define WIDTH 3


void showMatrix(vector<vector<int>> a){
	cout << "hola" << endl;
	
	unsigned int r = 0;
	while(r < a.size()){
		for(unsigned int c=0; c < a[0].size(); c++){
			cout << a[r][c] << " - ";
		
		}
		cout << endl;
		r++;	
	}
	//cout << a[0][0] << endl;
}	


int main() {
  vector<vector<int> > array2D;

  // Set up sizes. (HEIGHT x WIDTH)
  array2D.resize(HEIGHT);
  for (int i = 0; i < HEIGHT; ++i)
    array2D[i].resize(WIDTH);

  // Put some values in
  array2D[1][2] = 6;
  array2D[3][1] = 5;
  
  showMatrix(array2D);

  return 0;
}
