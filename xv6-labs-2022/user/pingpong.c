#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
 
  char buf[16];  

  if (argc > 2){
    fprintf(2, "Usage: pingpong\n");
    exit(1);
  }

  int childp[2];
  int parentp[2];

  pipe(childp);
  pipe(parentp);

  
  int pid = fork();
  
  if(pid > 0){ //parent
 
    write(parentp[1], "ping", 4);
    
    read(childp[0], buf, 4);

    fprintf(2, "%d: received %s\n", getpid(), buf);
	
     
     
     	
  }   
  else{
   

    read(parentp[0], buf, 4);	  

    fprintf(2, "%d: received %s\n", getpid(), buf);    

    write(childp[1], "pong", 4);

    exit(0);    
  }



  exit(0);
}

