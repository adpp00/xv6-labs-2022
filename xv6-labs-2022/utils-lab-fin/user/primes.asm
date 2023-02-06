
user/_primes:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argc, char *argv[]){
   0:	710d                	addi	sp,sp,-352
   2:	ee86                	sd	ra,344(sp)
   4:	eaa2                	sd	s0,336(sp)
   6:	e6a6                	sd	s1,328(sp)
   8:	e2ca                	sd	s2,320(sp)
   a:	fe4e                	sd	s3,312(sp)
   c:	fa52                	sd	s4,304(sp)
   e:	f656                	sd	s5,296(sp)
  10:	f25a                	sd	s6,288(sp)
  12:	1280                	addi	s0,sp,352
  int i;

  if (argc > 2){
  14:	4789                	li	a5,2
  16:	02a7d063          	bge	a5,a0,36 <main+0x36>
    fprintf(2, "Usage: primes\n");
  1a:	00001597          	auipc	a1,0x1
  1e:	8f658593          	addi	a1,a1,-1802 # 910 <malloc+0xe4>
  22:	4509                	li	a0,2
  24:	00000097          	auipc	ra,0x0
  28:	71c080e7          	jalr	1820(ra) # 740 <fprintf>
    exit(1);
  2c:	4505                	li	a0,1
  2e:	00000097          	auipc	ra,0x0
  32:	3c8080e7          	jalr	968(ra) # 3f6 <exit>

  char div;
  char c;
  char num;
  int n;
  pipe(p[0]);
  36:	ea840513          	addi	a0,s0,-344
  3a:	00000097          	auipc	ra,0x0
  3e:	3cc080e7          	jalr	972(ra) # 406 <pipe>

  for(i = 2; i<35; i++){ //pass 35 num
  42:	4489                	li	s1,2
  44:	02300913          	li	s2,35
    c = i;
  48:	ea940323          	sb	s1,-346(s0)
    write(p[0][1], &c, 1);
  4c:	4605                	li	a2,1
  4e:	ea640593          	addi	a1,s0,-346
  52:	eac42503          	lw	a0,-340(s0)
  56:	00000097          	auipc	ra,0x0
  5a:	3c0080e7          	jalr	960(ra) # 416 <write>
  for(i = 2; i<35; i++){ //pass 35 num
  5e:	2485                	addiw	s1,s1,1
  60:	ff2494e3          	bne	s1,s2,48 <main+0x48>
  } 
  
    close(p[0][1]);
  64:	eac42503          	lw	a0,-340(s0)
  68:	00000097          	auipc	ra,0x0
  6c:	3b6080e7          	jalr	950(ra) # 41e <close>

  for(i = 1; i<35; i++){ //at start, only p[i-1][0] is open
  70:	eb040913          	addi	s2,s0,-336
    close(p[0][1]);
  74:	4981                	li	s3,0

        close(p[i-1][0]);
        exit(0); //finished 
      }

      fprintf(2, "prime %d\n", (int)div); //print prime
  76:	00001a17          	auipc	s4,0x1
  7a:	8aaa0a13          	addi	s4,s4,-1878 # 920 <malloc+0xf4>
  for(i = 1; i<35; i++){ //at start, only p[i-1][0] is open
  7e:	02200a93          	li	s5,34
      n = read(p[i-1][0], &div, 1); //read from pipe
  82:	00098b1b          	sext.w	s6,s3
  86:	84ca                	mv	s1,s2
  88:	4605                	li	a2,1
  8a:	ea740593          	addi	a1,s0,-345
  8e:	ff892503          	lw	a0,-8(s2)
  92:	00000097          	auipc	ra,0x0
  96:	37c080e7          	jalr	892(ra) # 40e <read>
      if(n == 0) {
  9a:	c935                	beqz	a0,10e <main+0x10e>
      fprintf(2, "prime %d\n", (int)div); //print prime
  9c:	ea744603          	lbu	a2,-345(s0)
  a0:	85d2                	mv	a1,s4
  a2:	4509                	li	a0,2
  a4:	00000097          	auipc	ra,0x0
  a8:	69c080e7          	jalr	1692(ra) # 740 <fprintf>
      
      pipe(p[i]);
  ac:	854a                	mv	a0,s2
  ae:	00000097          	auipc	ra,0x0
  b2:	358080e7          	jalr	856(ra) # 406 <pipe>

      for(;;){
        n = read(p[i-1][0], &num, 1); //read from pipe
  b6:	4605                	li	a2,1
  b8:	ea540593          	addi	a1,s0,-347
  bc:	ff84a503          	lw	a0,-8(s1)
  c0:	00000097          	auipc	ra,0x0
  c4:	34e080e7          	jalr	846(ra) # 40e <read>
        if(n == 0) break;
  c8:	c149                	beqz	a0,14a <main+0x14a>
        if(n < 0) {
  ca:	06054263          	bltz	a0,12e <main+0x12e>
          fprintf(2, "read error\n");
          exit(1);
        }
        if((int)num % (int)div != 0){
  ce:	ea544783          	lbu	a5,-347(s0)
  d2:	ea744703          	lbu	a4,-345(s0)
  d6:	02e7e7bb          	remw	a5,a5,a4
  da:	dff1                	beqz	a5,b6 <main+0xb6>
          if(write(p[i][1], &num, 1) != 1){
  dc:	4605                	li	a2,1
  de:	ea540593          	addi	a1,s0,-347
  e2:	40c8                	lw	a0,4(s1)
  e4:	00000097          	auipc	ra,0x0
  e8:	332080e7          	jalr	818(ra) # 416 <write>
  ec:	4785                	li	a5,1
  ee:	fcf504e3          	beq	a0,a5,b6 <main+0xb6>
            fprintf(2, "write error\n");
  f2:	00001597          	auipc	a1,0x1
  f6:	84e58593          	addi	a1,a1,-1970 # 940 <malloc+0x114>
  fa:	4509                	li	a0,2
  fc:	00000097          	auipc	ra,0x0
 100:	644080e7          	jalr	1604(ra) # 740 <fprintf>
            exit(1);
 104:	4505                	li	a0,1
 106:	00000097          	auipc	ra,0x0
 10a:	2f0080e7          	jalr	752(ra) # 3f6 <exit>
        close(p[i-1][0]);
 10e:	003b1793          	slli	a5,s6,0x3
 112:	fc040713          	addi	a4,s0,-64
 116:	97ba                	add	a5,a5,a4
 118:	ee87a503          	lw	a0,-280(a5)
 11c:	00000097          	auipc	ra,0x0
 120:	302080e7          	jalr	770(ra) # 41e <close>
        exit(0); //finished 
 124:	4501                	li	a0,0
 126:	00000097          	auipc	ra,0x0
 12a:	2d0080e7          	jalr	720(ra) # 3f6 <exit>
          fprintf(2, "read error\n");
 12e:	00001597          	auipc	a1,0x1
 132:	80258593          	addi	a1,a1,-2046 # 930 <malloc+0x104>
 136:	4509                	li	a0,2
 138:	00000097          	auipc	ra,0x0
 13c:	608080e7          	jalr	1544(ra) # 740 <fprintf>
          exit(1);
 140:	4505                	li	a0,1
 142:	00000097          	auipc	ra,0x0
 146:	2b4080e7          	jalr	692(ra) # 3f6 <exit>
        }


      }

      close(p[i][1]);
 14a:	40c8                	lw	a0,4(s1)
 14c:	00000097          	auipc	ra,0x0
 150:	2d2080e7          	jalr	722(ra) # 41e <close>
  for(i = 1; i<35; i++){ //at start, only p[i-1][0] is open
 154:	2985                	addiw	s3,s3,1
 156:	0921                	addi	s2,s2,8
 158:	f35995e3          	bne	s3,s5,82 <main+0x82>


  //make pipe, pass all numbers that is not divided.
  
   
  exit(0);
 15c:	4501                	li	a0,0
 15e:	00000097          	auipc	ra,0x0
 162:	298080e7          	jalr	664(ra) # 3f6 <exit>

0000000000000166 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 166:	1141                	addi	sp,sp,-16
 168:	e406                	sd	ra,8(sp)
 16a:	e022                	sd	s0,0(sp)
 16c:	0800                	addi	s0,sp,16
  extern int main();
  main();
 16e:	00000097          	auipc	ra,0x0
 172:	e92080e7          	jalr	-366(ra) # 0 <main>
  exit(0);
 176:	4501                	li	a0,0
 178:	00000097          	auipc	ra,0x0
 17c:	27e080e7          	jalr	638(ra) # 3f6 <exit>

0000000000000180 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 180:	1141                	addi	sp,sp,-16
 182:	e422                	sd	s0,8(sp)
 184:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 186:	87aa                	mv	a5,a0
 188:	0585                	addi	a1,a1,1
 18a:	0785                	addi	a5,a5,1
 18c:	fff5c703          	lbu	a4,-1(a1)
 190:	fee78fa3          	sb	a4,-1(a5)
 194:	fb75                	bnez	a4,188 <strcpy+0x8>
    ;
  return os;
}
 196:	6422                	ld	s0,8(sp)
 198:	0141                	addi	sp,sp,16
 19a:	8082                	ret

000000000000019c <strcmp>:

int
strcmp(const char *p, const char *q)
{
 19c:	1141                	addi	sp,sp,-16
 19e:	e422                	sd	s0,8(sp)
 1a0:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1a2:	00054783          	lbu	a5,0(a0)
 1a6:	cb91                	beqz	a5,1ba <strcmp+0x1e>
 1a8:	0005c703          	lbu	a4,0(a1)
 1ac:	00f71763          	bne	a4,a5,1ba <strcmp+0x1e>
    p++, q++;
 1b0:	0505                	addi	a0,a0,1
 1b2:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1b4:	00054783          	lbu	a5,0(a0)
 1b8:	fbe5                	bnez	a5,1a8 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1ba:	0005c503          	lbu	a0,0(a1)
}
 1be:	40a7853b          	subw	a0,a5,a0
 1c2:	6422                	ld	s0,8(sp)
 1c4:	0141                	addi	sp,sp,16
 1c6:	8082                	ret

00000000000001c8 <strlen>:

uint
strlen(const char *s)
{
 1c8:	1141                	addi	sp,sp,-16
 1ca:	e422                	sd	s0,8(sp)
 1cc:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1ce:	00054783          	lbu	a5,0(a0)
 1d2:	cf91                	beqz	a5,1ee <strlen+0x26>
 1d4:	0505                	addi	a0,a0,1
 1d6:	87aa                	mv	a5,a0
 1d8:	4685                	li	a3,1
 1da:	9e89                	subw	a3,a3,a0
 1dc:	00f6853b          	addw	a0,a3,a5
 1e0:	0785                	addi	a5,a5,1
 1e2:	fff7c703          	lbu	a4,-1(a5)
 1e6:	fb7d                	bnez	a4,1dc <strlen+0x14>
    ;
  return n;
}
 1e8:	6422                	ld	s0,8(sp)
 1ea:	0141                	addi	sp,sp,16
 1ec:	8082                	ret
  for(n = 0; s[n]; n++)
 1ee:	4501                	li	a0,0
 1f0:	bfe5                	j	1e8 <strlen+0x20>

00000000000001f2 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1f2:	1141                	addi	sp,sp,-16
 1f4:	e422                	sd	s0,8(sp)
 1f6:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1f8:	ce09                	beqz	a2,212 <memset+0x20>
 1fa:	87aa                	mv	a5,a0
 1fc:	fff6071b          	addiw	a4,a2,-1
 200:	1702                	slli	a4,a4,0x20
 202:	9301                	srli	a4,a4,0x20
 204:	0705                	addi	a4,a4,1
 206:	972a                	add	a4,a4,a0
    cdst[i] = c;
 208:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 20c:	0785                	addi	a5,a5,1
 20e:	fee79de3          	bne	a5,a4,208 <memset+0x16>
  }
  return dst;
}
 212:	6422                	ld	s0,8(sp)
 214:	0141                	addi	sp,sp,16
 216:	8082                	ret

0000000000000218 <strchr>:

char*
strchr(const char *s, char c)
{
 218:	1141                	addi	sp,sp,-16
 21a:	e422                	sd	s0,8(sp)
 21c:	0800                	addi	s0,sp,16
  for(; *s; s++)
 21e:	00054783          	lbu	a5,0(a0)
 222:	cb99                	beqz	a5,238 <strchr+0x20>
    if(*s == c)
 224:	00f58763          	beq	a1,a5,232 <strchr+0x1a>
  for(; *s; s++)
 228:	0505                	addi	a0,a0,1
 22a:	00054783          	lbu	a5,0(a0)
 22e:	fbfd                	bnez	a5,224 <strchr+0xc>
      return (char*)s;
  return 0;
 230:	4501                	li	a0,0
}
 232:	6422                	ld	s0,8(sp)
 234:	0141                	addi	sp,sp,16
 236:	8082                	ret
  return 0;
 238:	4501                	li	a0,0
 23a:	bfe5                	j	232 <strchr+0x1a>

000000000000023c <gets>:

char*
gets(char *buf, int max)
{
 23c:	711d                	addi	sp,sp,-96
 23e:	ec86                	sd	ra,88(sp)
 240:	e8a2                	sd	s0,80(sp)
 242:	e4a6                	sd	s1,72(sp)
 244:	e0ca                	sd	s2,64(sp)
 246:	fc4e                	sd	s3,56(sp)
 248:	f852                	sd	s4,48(sp)
 24a:	f456                	sd	s5,40(sp)
 24c:	f05a                	sd	s6,32(sp)
 24e:	ec5e                	sd	s7,24(sp)
 250:	1080                	addi	s0,sp,96
 252:	8baa                	mv	s7,a0
 254:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 256:	892a                	mv	s2,a0
 258:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 25a:	4aa9                	li	s5,10
 25c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 25e:	89a6                	mv	s3,s1
 260:	2485                	addiw	s1,s1,1
 262:	0344d863          	bge	s1,s4,292 <gets+0x56>
    cc = read(0, &c, 1);
 266:	4605                	li	a2,1
 268:	faf40593          	addi	a1,s0,-81
 26c:	4501                	li	a0,0
 26e:	00000097          	auipc	ra,0x0
 272:	1a0080e7          	jalr	416(ra) # 40e <read>
    if(cc < 1)
 276:	00a05e63          	blez	a0,292 <gets+0x56>
    buf[i++] = c;
 27a:	faf44783          	lbu	a5,-81(s0)
 27e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 282:	01578763          	beq	a5,s5,290 <gets+0x54>
 286:	0905                	addi	s2,s2,1
 288:	fd679be3          	bne	a5,s6,25e <gets+0x22>
  for(i=0; i+1 < max; ){
 28c:	89a6                	mv	s3,s1
 28e:	a011                	j	292 <gets+0x56>
 290:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 292:	99de                	add	s3,s3,s7
 294:	00098023          	sb	zero,0(s3)
  return buf;
}
 298:	855e                	mv	a0,s7
 29a:	60e6                	ld	ra,88(sp)
 29c:	6446                	ld	s0,80(sp)
 29e:	64a6                	ld	s1,72(sp)
 2a0:	6906                	ld	s2,64(sp)
 2a2:	79e2                	ld	s3,56(sp)
 2a4:	7a42                	ld	s4,48(sp)
 2a6:	7aa2                	ld	s5,40(sp)
 2a8:	7b02                	ld	s6,32(sp)
 2aa:	6be2                	ld	s7,24(sp)
 2ac:	6125                	addi	sp,sp,96
 2ae:	8082                	ret

00000000000002b0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2b0:	1101                	addi	sp,sp,-32
 2b2:	ec06                	sd	ra,24(sp)
 2b4:	e822                	sd	s0,16(sp)
 2b6:	e426                	sd	s1,8(sp)
 2b8:	e04a                	sd	s2,0(sp)
 2ba:	1000                	addi	s0,sp,32
 2bc:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2be:	4581                	li	a1,0
 2c0:	00000097          	auipc	ra,0x0
 2c4:	176080e7          	jalr	374(ra) # 436 <open>
  if(fd < 0)
 2c8:	02054563          	bltz	a0,2f2 <stat+0x42>
 2cc:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2ce:	85ca                	mv	a1,s2
 2d0:	00000097          	auipc	ra,0x0
 2d4:	17e080e7          	jalr	382(ra) # 44e <fstat>
 2d8:	892a                	mv	s2,a0
  close(fd);
 2da:	8526                	mv	a0,s1
 2dc:	00000097          	auipc	ra,0x0
 2e0:	142080e7          	jalr	322(ra) # 41e <close>
  return r;
}
 2e4:	854a                	mv	a0,s2
 2e6:	60e2                	ld	ra,24(sp)
 2e8:	6442                	ld	s0,16(sp)
 2ea:	64a2                	ld	s1,8(sp)
 2ec:	6902                	ld	s2,0(sp)
 2ee:	6105                	addi	sp,sp,32
 2f0:	8082                	ret
    return -1;
 2f2:	597d                	li	s2,-1
 2f4:	bfc5                	j	2e4 <stat+0x34>

00000000000002f6 <atoi>:

int
atoi(const char *s)
{
 2f6:	1141                	addi	sp,sp,-16
 2f8:	e422                	sd	s0,8(sp)
 2fa:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2fc:	00054603          	lbu	a2,0(a0)
 300:	fd06079b          	addiw	a5,a2,-48
 304:	0ff7f793          	andi	a5,a5,255
 308:	4725                	li	a4,9
 30a:	02f76963          	bltu	a4,a5,33c <atoi+0x46>
 30e:	86aa                	mv	a3,a0
  n = 0;
 310:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 312:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 314:	0685                	addi	a3,a3,1
 316:	0025179b          	slliw	a5,a0,0x2
 31a:	9fa9                	addw	a5,a5,a0
 31c:	0017979b          	slliw	a5,a5,0x1
 320:	9fb1                	addw	a5,a5,a2
 322:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 326:	0006c603          	lbu	a2,0(a3)
 32a:	fd06071b          	addiw	a4,a2,-48
 32e:	0ff77713          	andi	a4,a4,255
 332:	fee5f1e3          	bgeu	a1,a4,314 <atoi+0x1e>
  return n;
}
 336:	6422                	ld	s0,8(sp)
 338:	0141                	addi	sp,sp,16
 33a:	8082                	ret
  n = 0;
 33c:	4501                	li	a0,0
 33e:	bfe5                	j	336 <atoi+0x40>

0000000000000340 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 340:	1141                	addi	sp,sp,-16
 342:	e422                	sd	s0,8(sp)
 344:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 346:	02b57663          	bgeu	a0,a1,372 <memmove+0x32>
    while(n-- > 0)
 34a:	02c05163          	blez	a2,36c <memmove+0x2c>
 34e:	fff6079b          	addiw	a5,a2,-1
 352:	1782                	slli	a5,a5,0x20
 354:	9381                	srli	a5,a5,0x20
 356:	0785                	addi	a5,a5,1
 358:	97aa                	add	a5,a5,a0
  dst = vdst;
 35a:	872a                	mv	a4,a0
      *dst++ = *src++;
 35c:	0585                	addi	a1,a1,1
 35e:	0705                	addi	a4,a4,1
 360:	fff5c683          	lbu	a3,-1(a1)
 364:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 368:	fee79ae3          	bne	a5,a4,35c <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 36c:	6422                	ld	s0,8(sp)
 36e:	0141                	addi	sp,sp,16
 370:	8082                	ret
    dst += n;
 372:	00c50733          	add	a4,a0,a2
    src += n;
 376:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 378:	fec05ae3          	blez	a2,36c <memmove+0x2c>
 37c:	fff6079b          	addiw	a5,a2,-1
 380:	1782                	slli	a5,a5,0x20
 382:	9381                	srli	a5,a5,0x20
 384:	fff7c793          	not	a5,a5
 388:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 38a:	15fd                	addi	a1,a1,-1
 38c:	177d                	addi	a4,a4,-1
 38e:	0005c683          	lbu	a3,0(a1)
 392:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 396:	fee79ae3          	bne	a5,a4,38a <memmove+0x4a>
 39a:	bfc9                	j	36c <memmove+0x2c>

000000000000039c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 39c:	1141                	addi	sp,sp,-16
 39e:	e422                	sd	s0,8(sp)
 3a0:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3a2:	ca05                	beqz	a2,3d2 <memcmp+0x36>
 3a4:	fff6069b          	addiw	a3,a2,-1
 3a8:	1682                	slli	a3,a3,0x20
 3aa:	9281                	srli	a3,a3,0x20
 3ac:	0685                	addi	a3,a3,1
 3ae:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3b0:	00054783          	lbu	a5,0(a0)
 3b4:	0005c703          	lbu	a4,0(a1)
 3b8:	00e79863          	bne	a5,a4,3c8 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3bc:	0505                	addi	a0,a0,1
    p2++;
 3be:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 3c0:	fed518e3          	bne	a0,a3,3b0 <memcmp+0x14>
  }
  return 0;
 3c4:	4501                	li	a0,0
 3c6:	a019                	j	3cc <memcmp+0x30>
      return *p1 - *p2;
 3c8:	40e7853b          	subw	a0,a5,a4
}
 3cc:	6422                	ld	s0,8(sp)
 3ce:	0141                	addi	sp,sp,16
 3d0:	8082                	ret
  return 0;
 3d2:	4501                	li	a0,0
 3d4:	bfe5                	j	3cc <memcmp+0x30>

00000000000003d6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3d6:	1141                	addi	sp,sp,-16
 3d8:	e406                	sd	ra,8(sp)
 3da:	e022                	sd	s0,0(sp)
 3dc:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3de:	00000097          	auipc	ra,0x0
 3e2:	f62080e7          	jalr	-158(ra) # 340 <memmove>
}
 3e6:	60a2                	ld	ra,8(sp)
 3e8:	6402                	ld	s0,0(sp)
 3ea:	0141                	addi	sp,sp,16
 3ec:	8082                	ret

00000000000003ee <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3ee:	4885                	li	a7,1
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3f6:	4889                	li	a7,2
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <wait>:
.global wait
wait:
 li a7, SYS_wait
 3fe:	488d                	li	a7,3
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 406:	4891                	li	a7,4
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <read>:
.global read
read:
 li a7, SYS_read
 40e:	4895                	li	a7,5
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <write>:
.global write
write:
 li a7, SYS_write
 416:	48c1                	li	a7,16
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <close>:
.global close
close:
 li a7, SYS_close
 41e:	48d5                	li	a7,21
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <kill>:
.global kill
kill:
 li a7, SYS_kill
 426:	4899                	li	a7,6
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <exec>:
.global exec
exec:
 li a7, SYS_exec
 42e:	489d                	li	a7,7
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <open>:
.global open
open:
 li a7, SYS_open
 436:	48bd                	li	a7,15
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 43e:	48c5                	li	a7,17
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 446:	48c9                	li	a7,18
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 44e:	48a1                	li	a7,8
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <link>:
.global link
link:
 li a7, SYS_link
 456:	48cd                	li	a7,19
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 45e:	48d1                	li	a7,20
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 466:	48a5                	li	a7,9
 ecall
 468:	00000073          	ecall
 ret
 46c:	8082                	ret

000000000000046e <dup>:
.global dup
dup:
 li a7, SYS_dup
 46e:	48a9                	li	a7,10
 ecall
 470:	00000073          	ecall
 ret
 474:	8082                	ret

0000000000000476 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 476:	48ad                	li	a7,11
 ecall
 478:	00000073          	ecall
 ret
 47c:	8082                	ret

000000000000047e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 47e:	48b1                	li	a7,12
 ecall
 480:	00000073          	ecall
 ret
 484:	8082                	ret

0000000000000486 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 486:	48b5                	li	a7,13
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 48e:	48b9                	li	a7,14
 ecall
 490:	00000073          	ecall
 ret
 494:	8082                	ret

0000000000000496 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 496:	1101                	addi	sp,sp,-32
 498:	ec06                	sd	ra,24(sp)
 49a:	e822                	sd	s0,16(sp)
 49c:	1000                	addi	s0,sp,32
 49e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4a2:	4605                	li	a2,1
 4a4:	fef40593          	addi	a1,s0,-17
 4a8:	00000097          	auipc	ra,0x0
 4ac:	f6e080e7          	jalr	-146(ra) # 416 <write>
}
 4b0:	60e2                	ld	ra,24(sp)
 4b2:	6442                	ld	s0,16(sp)
 4b4:	6105                	addi	sp,sp,32
 4b6:	8082                	ret

00000000000004b8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4b8:	7139                	addi	sp,sp,-64
 4ba:	fc06                	sd	ra,56(sp)
 4bc:	f822                	sd	s0,48(sp)
 4be:	f426                	sd	s1,40(sp)
 4c0:	f04a                	sd	s2,32(sp)
 4c2:	ec4e                	sd	s3,24(sp)
 4c4:	0080                	addi	s0,sp,64
 4c6:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4c8:	c299                	beqz	a3,4ce <printint+0x16>
 4ca:	0805c863          	bltz	a1,55a <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4ce:	2581                	sext.w	a1,a1
  neg = 0;
 4d0:	4881                	li	a7,0
 4d2:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 4d6:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4d8:	2601                	sext.w	a2,a2
 4da:	00000517          	auipc	a0,0x0
 4de:	47e50513          	addi	a0,a0,1150 # 958 <digits>
 4e2:	883a                	mv	a6,a4
 4e4:	2705                	addiw	a4,a4,1
 4e6:	02c5f7bb          	remuw	a5,a1,a2
 4ea:	1782                	slli	a5,a5,0x20
 4ec:	9381                	srli	a5,a5,0x20
 4ee:	97aa                	add	a5,a5,a0
 4f0:	0007c783          	lbu	a5,0(a5)
 4f4:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 4f8:	0005879b          	sext.w	a5,a1
 4fc:	02c5d5bb          	divuw	a1,a1,a2
 500:	0685                	addi	a3,a3,1
 502:	fec7f0e3          	bgeu	a5,a2,4e2 <printint+0x2a>
  if(neg)
 506:	00088b63          	beqz	a7,51c <printint+0x64>
    buf[i++] = '-';
 50a:	fd040793          	addi	a5,s0,-48
 50e:	973e                	add	a4,a4,a5
 510:	02d00793          	li	a5,45
 514:	fef70823          	sb	a5,-16(a4)
 518:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 51c:	02e05863          	blez	a4,54c <printint+0x94>
 520:	fc040793          	addi	a5,s0,-64
 524:	00e78933          	add	s2,a5,a4
 528:	fff78993          	addi	s3,a5,-1
 52c:	99ba                	add	s3,s3,a4
 52e:	377d                	addiw	a4,a4,-1
 530:	1702                	slli	a4,a4,0x20
 532:	9301                	srli	a4,a4,0x20
 534:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 538:	fff94583          	lbu	a1,-1(s2)
 53c:	8526                	mv	a0,s1
 53e:	00000097          	auipc	ra,0x0
 542:	f58080e7          	jalr	-168(ra) # 496 <putc>
  while(--i >= 0)
 546:	197d                	addi	s2,s2,-1
 548:	ff3918e3          	bne	s2,s3,538 <printint+0x80>
}
 54c:	70e2                	ld	ra,56(sp)
 54e:	7442                	ld	s0,48(sp)
 550:	74a2                	ld	s1,40(sp)
 552:	7902                	ld	s2,32(sp)
 554:	69e2                	ld	s3,24(sp)
 556:	6121                	addi	sp,sp,64
 558:	8082                	ret
    x = -xx;
 55a:	40b005bb          	negw	a1,a1
    neg = 1;
 55e:	4885                	li	a7,1
    x = -xx;
 560:	bf8d                	j	4d2 <printint+0x1a>

0000000000000562 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 562:	7119                	addi	sp,sp,-128
 564:	fc86                	sd	ra,120(sp)
 566:	f8a2                	sd	s0,112(sp)
 568:	f4a6                	sd	s1,104(sp)
 56a:	f0ca                	sd	s2,96(sp)
 56c:	ecce                	sd	s3,88(sp)
 56e:	e8d2                	sd	s4,80(sp)
 570:	e4d6                	sd	s5,72(sp)
 572:	e0da                	sd	s6,64(sp)
 574:	fc5e                	sd	s7,56(sp)
 576:	f862                	sd	s8,48(sp)
 578:	f466                	sd	s9,40(sp)
 57a:	f06a                	sd	s10,32(sp)
 57c:	ec6e                	sd	s11,24(sp)
 57e:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 580:	0005c903          	lbu	s2,0(a1)
 584:	18090f63          	beqz	s2,722 <vprintf+0x1c0>
 588:	8aaa                	mv	s5,a0
 58a:	8b32                	mv	s6,a2
 58c:	00158493          	addi	s1,a1,1
  state = 0;
 590:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 592:	02500a13          	li	s4,37
      if(c == 'd'){
 596:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 59a:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 59e:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 5a2:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5a6:	00000b97          	auipc	s7,0x0
 5aa:	3b2b8b93          	addi	s7,s7,946 # 958 <digits>
 5ae:	a839                	j	5cc <vprintf+0x6a>
        putc(fd, c);
 5b0:	85ca                	mv	a1,s2
 5b2:	8556                	mv	a0,s5
 5b4:	00000097          	auipc	ra,0x0
 5b8:	ee2080e7          	jalr	-286(ra) # 496 <putc>
 5bc:	a019                	j	5c2 <vprintf+0x60>
    } else if(state == '%'){
 5be:	01498f63          	beq	s3,s4,5dc <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 5c2:	0485                	addi	s1,s1,1
 5c4:	fff4c903          	lbu	s2,-1(s1)
 5c8:	14090d63          	beqz	s2,722 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 5cc:	0009079b          	sext.w	a5,s2
    if(state == 0){
 5d0:	fe0997e3          	bnez	s3,5be <vprintf+0x5c>
      if(c == '%'){
 5d4:	fd479ee3          	bne	a5,s4,5b0 <vprintf+0x4e>
        state = '%';
 5d8:	89be                	mv	s3,a5
 5da:	b7e5                	j	5c2 <vprintf+0x60>
      if(c == 'd'){
 5dc:	05878063          	beq	a5,s8,61c <vprintf+0xba>
      } else if(c == 'l') {
 5e0:	05978c63          	beq	a5,s9,638 <vprintf+0xd6>
      } else if(c == 'x') {
 5e4:	07a78863          	beq	a5,s10,654 <vprintf+0xf2>
      } else if(c == 'p') {
 5e8:	09b78463          	beq	a5,s11,670 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 5ec:	07300713          	li	a4,115
 5f0:	0ce78663          	beq	a5,a4,6bc <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5f4:	06300713          	li	a4,99
 5f8:	0ee78e63          	beq	a5,a4,6f4 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 5fc:	11478863          	beq	a5,s4,70c <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 600:	85d2                	mv	a1,s4
 602:	8556                	mv	a0,s5
 604:	00000097          	auipc	ra,0x0
 608:	e92080e7          	jalr	-366(ra) # 496 <putc>
        putc(fd, c);
 60c:	85ca                	mv	a1,s2
 60e:	8556                	mv	a0,s5
 610:	00000097          	auipc	ra,0x0
 614:	e86080e7          	jalr	-378(ra) # 496 <putc>
      }
      state = 0;
 618:	4981                	li	s3,0
 61a:	b765                	j	5c2 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 61c:	008b0913          	addi	s2,s6,8
 620:	4685                	li	a3,1
 622:	4629                	li	a2,10
 624:	000b2583          	lw	a1,0(s6)
 628:	8556                	mv	a0,s5
 62a:	00000097          	auipc	ra,0x0
 62e:	e8e080e7          	jalr	-370(ra) # 4b8 <printint>
 632:	8b4a                	mv	s6,s2
      state = 0;
 634:	4981                	li	s3,0
 636:	b771                	j	5c2 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 638:	008b0913          	addi	s2,s6,8
 63c:	4681                	li	a3,0
 63e:	4629                	li	a2,10
 640:	000b2583          	lw	a1,0(s6)
 644:	8556                	mv	a0,s5
 646:	00000097          	auipc	ra,0x0
 64a:	e72080e7          	jalr	-398(ra) # 4b8 <printint>
 64e:	8b4a                	mv	s6,s2
      state = 0;
 650:	4981                	li	s3,0
 652:	bf85                	j	5c2 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 654:	008b0913          	addi	s2,s6,8
 658:	4681                	li	a3,0
 65a:	4641                	li	a2,16
 65c:	000b2583          	lw	a1,0(s6)
 660:	8556                	mv	a0,s5
 662:	00000097          	auipc	ra,0x0
 666:	e56080e7          	jalr	-426(ra) # 4b8 <printint>
 66a:	8b4a                	mv	s6,s2
      state = 0;
 66c:	4981                	li	s3,0
 66e:	bf91                	j	5c2 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 670:	008b0793          	addi	a5,s6,8
 674:	f8f43423          	sd	a5,-120(s0)
 678:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 67c:	03000593          	li	a1,48
 680:	8556                	mv	a0,s5
 682:	00000097          	auipc	ra,0x0
 686:	e14080e7          	jalr	-492(ra) # 496 <putc>
  putc(fd, 'x');
 68a:	85ea                	mv	a1,s10
 68c:	8556                	mv	a0,s5
 68e:	00000097          	auipc	ra,0x0
 692:	e08080e7          	jalr	-504(ra) # 496 <putc>
 696:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 698:	03c9d793          	srli	a5,s3,0x3c
 69c:	97de                	add	a5,a5,s7
 69e:	0007c583          	lbu	a1,0(a5)
 6a2:	8556                	mv	a0,s5
 6a4:	00000097          	auipc	ra,0x0
 6a8:	df2080e7          	jalr	-526(ra) # 496 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6ac:	0992                	slli	s3,s3,0x4
 6ae:	397d                	addiw	s2,s2,-1
 6b0:	fe0914e3          	bnez	s2,698 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 6b4:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 6b8:	4981                	li	s3,0
 6ba:	b721                	j	5c2 <vprintf+0x60>
        s = va_arg(ap, char*);
 6bc:	008b0993          	addi	s3,s6,8
 6c0:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 6c4:	02090163          	beqz	s2,6e6 <vprintf+0x184>
        while(*s != 0){
 6c8:	00094583          	lbu	a1,0(s2)
 6cc:	c9a1                	beqz	a1,71c <vprintf+0x1ba>
          putc(fd, *s);
 6ce:	8556                	mv	a0,s5
 6d0:	00000097          	auipc	ra,0x0
 6d4:	dc6080e7          	jalr	-570(ra) # 496 <putc>
          s++;
 6d8:	0905                	addi	s2,s2,1
        while(*s != 0){
 6da:	00094583          	lbu	a1,0(s2)
 6de:	f9e5                	bnez	a1,6ce <vprintf+0x16c>
        s = va_arg(ap, char*);
 6e0:	8b4e                	mv	s6,s3
      state = 0;
 6e2:	4981                	li	s3,0
 6e4:	bdf9                	j	5c2 <vprintf+0x60>
          s = "(null)";
 6e6:	00000917          	auipc	s2,0x0
 6ea:	26a90913          	addi	s2,s2,618 # 950 <malloc+0x124>
        while(*s != 0){
 6ee:	02800593          	li	a1,40
 6f2:	bff1                	j	6ce <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 6f4:	008b0913          	addi	s2,s6,8
 6f8:	000b4583          	lbu	a1,0(s6)
 6fc:	8556                	mv	a0,s5
 6fe:	00000097          	auipc	ra,0x0
 702:	d98080e7          	jalr	-616(ra) # 496 <putc>
 706:	8b4a                	mv	s6,s2
      state = 0;
 708:	4981                	li	s3,0
 70a:	bd65                	j	5c2 <vprintf+0x60>
        putc(fd, c);
 70c:	85d2                	mv	a1,s4
 70e:	8556                	mv	a0,s5
 710:	00000097          	auipc	ra,0x0
 714:	d86080e7          	jalr	-634(ra) # 496 <putc>
      state = 0;
 718:	4981                	li	s3,0
 71a:	b565                	j	5c2 <vprintf+0x60>
        s = va_arg(ap, char*);
 71c:	8b4e                	mv	s6,s3
      state = 0;
 71e:	4981                	li	s3,0
 720:	b54d                	j	5c2 <vprintf+0x60>
    }
  }
}
 722:	70e6                	ld	ra,120(sp)
 724:	7446                	ld	s0,112(sp)
 726:	74a6                	ld	s1,104(sp)
 728:	7906                	ld	s2,96(sp)
 72a:	69e6                	ld	s3,88(sp)
 72c:	6a46                	ld	s4,80(sp)
 72e:	6aa6                	ld	s5,72(sp)
 730:	6b06                	ld	s6,64(sp)
 732:	7be2                	ld	s7,56(sp)
 734:	7c42                	ld	s8,48(sp)
 736:	7ca2                	ld	s9,40(sp)
 738:	7d02                	ld	s10,32(sp)
 73a:	6de2                	ld	s11,24(sp)
 73c:	6109                	addi	sp,sp,128
 73e:	8082                	ret

0000000000000740 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 740:	715d                	addi	sp,sp,-80
 742:	ec06                	sd	ra,24(sp)
 744:	e822                	sd	s0,16(sp)
 746:	1000                	addi	s0,sp,32
 748:	e010                	sd	a2,0(s0)
 74a:	e414                	sd	a3,8(s0)
 74c:	e818                	sd	a4,16(s0)
 74e:	ec1c                	sd	a5,24(s0)
 750:	03043023          	sd	a6,32(s0)
 754:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 758:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 75c:	8622                	mv	a2,s0
 75e:	00000097          	auipc	ra,0x0
 762:	e04080e7          	jalr	-508(ra) # 562 <vprintf>
}
 766:	60e2                	ld	ra,24(sp)
 768:	6442                	ld	s0,16(sp)
 76a:	6161                	addi	sp,sp,80
 76c:	8082                	ret

000000000000076e <printf>:

void
printf(const char *fmt, ...)
{
 76e:	711d                	addi	sp,sp,-96
 770:	ec06                	sd	ra,24(sp)
 772:	e822                	sd	s0,16(sp)
 774:	1000                	addi	s0,sp,32
 776:	e40c                	sd	a1,8(s0)
 778:	e810                	sd	a2,16(s0)
 77a:	ec14                	sd	a3,24(s0)
 77c:	f018                	sd	a4,32(s0)
 77e:	f41c                	sd	a5,40(s0)
 780:	03043823          	sd	a6,48(s0)
 784:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 788:	00840613          	addi	a2,s0,8
 78c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 790:	85aa                	mv	a1,a0
 792:	4505                	li	a0,1
 794:	00000097          	auipc	ra,0x0
 798:	dce080e7          	jalr	-562(ra) # 562 <vprintf>
}
 79c:	60e2                	ld	ra,24(sp)
 79e:	6442                	ld	s0,16(sp)
 7a0:	6125                	addi	sp,sp,96
 7a2:	8082                	ret

00000000000007a4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7a4:	1141                	addi	sp,sp,-16
 7a6:	e422                	sd	s0,8(sp)
 7a8:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7aa:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7ae:	00001797          	auipc	a5,0x1
 7b2:	8527b783          	ld	a5,-1966(a5) # 1000 <freep>
 7b6:	a805                	j	7e6 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7b8:	4618                	lw	a4,8(a2)
 7ba:	9db9                	addw	a1,a1,a4
 7bc:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7c0:	6398                	ld	a4,0(a5)
 7c2:	6318                	ld	a4,0(a4)
 7c4:	fee53823          	sd	a4,-16(a0)
 7c8:	a091                	j	80c <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7ca:	ff852703          	lw	a4,-8(a0)
 7ce:	9e39                	addw	a2,a2,a4
 7d0:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 7d2:	ff053703          	ld	a4,-16(a0)
 7d6:	e398                	sd	a4,0(a5)
 7d8:	a099                	j	81e <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7da:	6398                	ld	a4,0(a5)
 7dc:	00e7e463          	bltu	a5,a4,7e4 <free+0x40>
 7e0:	00e6ea63          	bltu	a3,a4,7f4 <free+0x50>
{
 7e4:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7e6:	fed7fae3          	bgeu	a5,a3,7da <free+0x36>
 7ea:	6398                	ld	a4,0(a5)
 7ec:	00e6e463          	bltu	a3,a4,7f4 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7f0:	fee7eae3          	bltu	a5,a4,7e4 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 7f4:	ff852583          	lw	a1,-8(a0)
 7f8:	6390                	ld	a2,0(a5)
 7fa:	02059713          	slli	a4,a1,0x20
 7fe:	9301                	srli	a4,a4,0x20
 800:	0712                	slli	a4,a4,0x4
 802:	9736                	add	a4,a4,a3
 804:	fae60ae3          	beq	a2,a4,7b8 <free+0x14>
    bp->s.ptr = p->s.ptr;
 808:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 80c:	4790                	lw	a2,8(a5)
 80e:	02061713          	slli	a4,a2,0x20
 812:	9301                	srli	a4,a4,0x20
 814:	0712                	slli	a4,a4,0x4
 816:	973e                	add	a4,a4,a5
 818:	fae689e3          	beq	a3,a4,7ca <free+0x26>
  } else
    p->s.ptr = bp;
 81c:	e394                	sd	a3,0(a5)
  freep = p;
 81e:	00000717          	auipc	a4,0x0
 822:	7ef73123          	sd	a5,2018(a4) # 1000 <freep>
}
 826:	6422                	ld	s0,8(sp)
 828:	0141                	addi	sp,sp,16
 82a:	8082                	ret

000000000000082c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 82c:	7139                	addi	sp,sp,-64
 82e:	fc06                	sd	ra,56(sp)
 830:	f822                	sd	s0,48(sp)
 832:	f426                	sd	s1,40(sp)
 834:	f04a                	sd	s2,32(sp)
 836:	ec4e                	sd	s3,24(sp)
 838:	e852                	sd	s4,16(sp)
 83a:	e456                	sd	s5,8(sp)
 83c:	e05a                	sd	s6,0(sp)
 83e:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 840:	02051493          	slli	s1,a0,0x20
 844:	9081                	srli	s1,s1,0x20
 846:	04bd                	addi	s1,s1,15
 848:	8091                	srli	s1,s1,0x4
 84a:	0014899b          	addiw	s3,s1,1
 84e:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 850:	00000517          	auipc	a0,0x0
 854:	7b053503          	ld	a0,1968(a0) # 1000 <freep>
 858:	c515                	beqz	a0,884 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 85a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 85c:	4798                	lw	a4,8(a5)
 85e:	02977f63          	bgeu	a4,s1,89c <malloc+0x70>
 862:	8a4e                	mv	s4,s3
 864:	0009871b          	sext.w	a4,s3
 868:	6685                	lui	a3,0x1
 86a:	00d77363          	bgeu	a4,a3,870 <malloc+0x44>
 86e:	6a05                	lui	s4,0x1
 870:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 874:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 878:	00000917          	auipc	s2,0x0
 87c:	78890913          	addi	s2,s2,1928 # 1000 <freep>
  if(p == (char*)-1)
 880:	5afd                	li	s5,-1
 882:	a88d                	j	8f4 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 884:	00000797          	auipc	a5,0x0
 888:	78c78793          	addi	a5,a5,1932 # 1010 <base>
 88c:	00000717          	auipc	a4,0x0
 890:	76f73a23          	sd	a5,1908(a4) # 1000 <freep>
 894:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 896:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 89a:	b7e1                	j	862 <malloc+0x36>
      if(p->s.size == nunits)
 89c:	02e48b63          	beq	s1,a4,8d2 <malloc+0xa6>
        p->s.size -= nunits;
 8a0:	4137073b          	subw	a4,a4,s3
 8a4:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8a6:	1702                	slli	a4,a4,0x20
 8a8:	9301                	srli	a4,a4,0x20
 8aa:	0712                	slli	a4,a4,0x4
 8ac:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8ae:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8b2:	00000717          	auipc	a4,0x0
 8b6:	74a73723          	sd	a0,1870(a4) # 1000 <freep>
      return (void*)(p + 1);
 8ba:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8be:	70e2                	ld	ra,56(sp)
 8c0:	7442                	ld	s0,48(sp)
 8c2:	74a2                	ld	s1,40(sp)
 8c4:	7902                	ld	s2,32(sp)
 8c6:	69e2                	ld	s3,24(sp)
 8c8:	6a42                	ld	s4,16(sp)
 8ca:	6aa2                	ld	s5,8(sp)
 8cc:	6b02                	ld	s6,0(sp)
 8ce:	6121                	addi	sp,sp,64
 8d0:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 8d2:	6398                	ld	a4,0(a5)
 8d4:	e118                	sd	a4,0(a0)
 8d6:	bff1                	j	8b2 <malloc+0x86>
  hp->s.size = nu;
 8d8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8dc:	0541                	addi	a0,a0,16
 8de:	00000097          	auipc	ra,0x0
 8e2:	ec6080e7          	jalr	-314(ra) # 7a4 <free>
  return freep;
 8e6:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 8ea:	d971                	beqz	a0,8be <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8ec:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8ee:	4798                	lw	a4,8(a5)
 8f0:	fa9776e3          	bgeu	a4,s1,89c <malloc+0x70>
    if(p == freep)
 8f4:	00093703          	ld	a4,0(s2)
 8f8:	853e                	mv	a0,a5
 8fa:	fef719e3          	bne	a4,a5,8ec <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 8fe:	8552                	mv	a0,s4
 900:	00000097          	auipc	ra,0x0
 904:	b7e080e7          	jalr	-1154(ra) # 47e <sbrk>
  if(p == (char*)-1)
 908:	fd5518e3          	bne	a0,s5,8d8 <malloc+0xac>
        return 0;
 90c:	4501                	li	a0,0
 90e:	bf45                	j	8be <malloc+0x92>
