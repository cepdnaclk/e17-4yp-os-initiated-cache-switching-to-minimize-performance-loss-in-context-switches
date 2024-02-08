#include <stdio.h>

int main() {
   int array[5] = {1, 2, 3, 4, 5};
   int sum, loop;

   sum = 0;
   
   for(loop = 4; loop >= 0; loop--) {
      sum = sum + array[loop];      
   }

//    printf("Sum of array is %d.", sum);   

   return 0;
}