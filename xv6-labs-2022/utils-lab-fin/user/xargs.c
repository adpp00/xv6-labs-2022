#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/param.h"

int main(int argc, char *argv[])
{ //read from stdin, each line

 
  //MAXARG per block, MAXINPUT needed?


  if (argc < 2){
    fprintf(2, "Usage: xargx arg ...\n");
    exit(1);
  }	

  //1. make new argv array, 
  
  char *buf[MAXARG];
  int i;

  for(i = 1; i < argc; i++){
    buf[i-1] = argv[i];
  }
  i = argc - 1;

  char params[MAXARG][32];

  char c;
  int paramidx = 0;
  int lengthidx = 0;


  paramidx = 0;
  lengthidx = 0;
  while(read(0, &c, 1) > 0){
    if(c == ' '){
      params[paramidx][lengthidx] = 0;
      buf[i++] = params[paramidx];
      paramidx ++;
      lengthidx = 0;
    }

    else if (c == '\n'){
      params[paramidx][lengthidx] = 0;
      buf[i++] = params[paramidx];

      if(fork() == 0){ //child 
        exec(argv[1],buf);
      }

      paramidx = 0;
      lengthidx = 0;
      wait(0);
      i = argc - 1;
    }

    else {
      params[paramidx][lengthidx] = c;
      lengthidx ++ ;
    }
  }

  exit(0);      

}

