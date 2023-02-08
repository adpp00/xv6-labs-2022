#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "proc.h"
#include "sysinfo.h"

int
systeminfo(uint64 addr) {

  struct proc *p = myproc();
  struct sysinfo sinfo;

  sinfo.freemem = freemem();
  sinfo.nproc = nproc();


  if(copyout(p->pagetable, addr, (char *)&sinfo, sizeof(sinfo)) < 0)
    return -1;
  return 0;
}