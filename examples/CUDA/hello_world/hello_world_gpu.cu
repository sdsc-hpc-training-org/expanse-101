// Cuda By Example - By Sanders and Kudrot
//
// Hello World Program in CUDA C
//
// Contains a function that is executed on the device (GPU)
//

#include<stdio.h>

__global__ void my_kernel(void){
 // nothing done here 
}

int main(void) {

  my_kernel<<<1,1>>>();
  printf("Hello World!\n");
  return 0;

}
