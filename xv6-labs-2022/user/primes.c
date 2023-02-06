#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argc, char *argv[]){
  int i;

  if (argc > 2){
    fprintf(2, "Usage: primes\n");
    exit(1);
  }

  
  int p[35][2];


  char div;
  char c;
  char num;
  int n;
  pipe(p[0]);

  for(i = 2; i<35; i++){ //pass 35 num
    c = i;
    write(p[0][1], &c, 1);
  } 
  
    close(p[0][1]);

  for(i = 1; i<35; i++){ //at start, only p[i-1][0] is open
    
      n = read(p[i-1][0], &div, 1); //read from pipe

      if(n == 0) {

        close(p[i-1][0]);
        exit(0); //finished 
      }

      fprintf(2, "prime %d\n", (int)div); //print prime
      
      pipe(p[i]);

      for(;;){
        n = read(p[i-1][0], &num, 1); //read from pipe
        if(n == 0) break;
        if(n < 0) {
          fprintf(2, "read error\n");
          exit(1);
        }
        if((int)num % (int)div != 0){
          if(write(p[i][1], &num, 1) != 1){
            fprintf(2, "write error\n");
            exit(1);
          }
        }


      }

      close(p[i][1]);
  }


  //make pipe, pass all numbers that is not divided.
  
   
  exit(0);
}
