
user/_find:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "user/user.h"
#include "kernel/fs.h"

char*
fmtname(char *path)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	84aa                	mv	s1,a0
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  10:	00000097          	auipc	ra,0x0
  14:	348080e7          	jalr	840(ra) # 358 <strlen>
  18:	02051793          	slli	a5,a0,0x20
  1c:	9381                	srli	a5,a5,0x20
  1e:	97a6                	add	a5,a5,s1
  20:	02f00693          	li	a3,47
  24:	0097e963          	bltu	a5,s1,36 <fmtname+0x36>
  28:	0007c703          	lbu	a4,0(a5)
  2c:	00d70563          	beq	a4,a3,36 <fmtname+0x36>
  30:	17fd                	addi	a5,a5,-1
  32:	fe97fbe3          	bgeu	a5,s1,28 <fmtname+0x28>
    ;
  p++;
  36:	00178493          	addi	s1,a5,1

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  3a:	8526                	mv	a0,s1
  3c:	00000097          	auipc	ra,0x0
  40:	31c080e7          	jalr	796(ra) # 358 <strlen>
  44:	2501                	sext.w	a0,a0
  46:	47b5                	li	a5,13
  48:	00a7fa63          	bgeu	a5,a0,5c <fmtname+0x5c>
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), '\0', DIRSIZ-strlen(p));
  return buf;
}
  4c:	8526                	mv	a0,s1
  4e:	70a2                	ld	ra,40(sp)
  50:	7402                	ld	s0,32(sp)
  52:	64e2                	ld	s1,24(sp)
  54:	6942                	ld	s2,16(sp)
  56:	69a2                	ld	s3,8(sp)
  58:	6145                	addi	sp,sp,48
  5a:	8082                	ret
  memmove(buf, p, strlen(p));
  5c:	8526                	mv	a0,s1
  5e:	00000097          	auipc	ra,0x0
  62:	2fa080e7          	jalr	762(ra) # 358 <strlen>
  66:	00001997          	auipc	s3,0x1
  6a:	faa98993          	addi	s3,s3,-86 # 1010 <buf.1106>
  6e:	0005061b          	sext.w	a2,a0
  72:	85a6                	mv	a1,s1
  74:	854e                	mv	a0,s3
  76:	00000097          	auipc	ra,0x0
  7a:	45a080e7          	jalr	1114(ra) # 4d0 <memmove>
  memset(buf+strlen(p), '\0', DIRSIZ-strlen(p));
  7e:	8526                	mv	a0,s1
  80:	00000097          	auipc	ra,0x0
  84:	2d8080e7          	jalr	728(ra) # 358 <strlen>
  88:	0005091b          	sext.w	s2,a0
  8c:	8526                	mv	a0,s1
  8e:	00000097          	auipc	ra,0x0
  92:	2ca080e7          	jalr	714(ra) # 358 <strlen>
  96:	1902                	slli	s2,s2,0x20
  98:	02095913          	srli	s2,s2,0x20
  9c:	4639                	li	a2,14
  9e:	9e09                	subw	a2,a2,a0
  a0:	4581                	li	a1,0
  a2:	01298533          	add	a0,s3,s2
  a6:	00000097          	auipc	ra,0x0
  aa:	2dc080e7          	jalr	732(ra) # 382 <memset>
  return buf;
  ae:	84ce                	mv	s1,s3
  b0:	bf71                	j	4c <fmtname+0x4c>

00000000000000b2 <find>:

void find(char* path, char* name){
  b2:	d8010113          	addi	sp,sp,-640
  b6:	26113c23          	sd	ra,632(sp)
  ba:	26813823          	sd	s0,624(sp)
  be:	26913423          	sd	s1,616(sp)
  c2:	27213023          	sd	s2,608(sp)
  c6:	25313c23          	sd	s3,600(sp)
  ca:	25413823          	sd	s4,592(sp)
  ce:	25513423          	sd	s5,584(sp)
  d2:	25613023          	sd	s6,576(sp)
  d6:	23713c23          	sd	s7,568(sp)
  da:	0500                	addi	s0,sp,640
  dc:	892a                	mv	s2,a0
  de:	89ae                	mv	s3,a1
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
  e0:	4581                	li	a1,0
  e2:	00000097          	auipc	ra,0x0
  e6:	4e4080e7          	jalr	1252(ra) # 5c6 <open>
  ea:	06054d63          	bltz	a0,164 <find+0xb2>
  ee:	84aa                	mv	s1,a0
    fprintf(2, "find: cannot open .\n");
    return;
  } 
  
  if(fstat(fd, &st) < 0){
  f0:	d8840593          	addi	a1,s0,-632
  f4:	00000097          	auipc	ra,0x0
  f8:	4ea080e7          	jalr	1258(ra) # 5de <fstat>
  fc:	06054e63          	bltz	a0,178 <find+0xc6>
    fprintf(2, "find: cannot stat .\n");
    close(fd);
    return;
  }

switch(st.type){
 100:	d9041783          	lh	a5,-624(s0)
 104:	0007869b          	sext.w	a3,a5
 108:	4705                	li	a4,1
 10a:	0ae68063          	beq	a3,a4,1aa <find+0xf8>
 10e:	37f9                	addiw	a5,a5,-2
 110:	17c2                	slli	a5,a5,0x30
 112:	93c1                	srli	a5,a5,0x30
 114:	00f76e63          	bltu	a4,a5,130 <find+0x7e>
  case T_DEVICE:
  case T_FILE:
        if(strcmp(name, fmtname(path))==0) printf("%s\n", path);
 118:	854a                	mv	a0,s2
 11a:	00000097          	auipc	ra,0x0
 11e:	ee6080e7          	jalr	-282(ra) # 0 <fmtname>
 122:	85aa                	mv	a1,a0
 124:	854e                	mv	a0,s3
 126:	00000097          	auipc	ra,0x0
 12a:	206080e7          	jalr	518(ra) # 32c <strcmp>
 12e:	c525                	beqz	a0,196 <find+0xe4>
      }
      if(strcmp(".", fmtname(buf))!= 0 && strcmp("..", fmtname(buf))!= 0) find(buf, name);
    }
    break;
  }
  close(fd);
 130:	8526                	mv	a0,s1
 132:	00000097          	auipc	ra,0x0
 136:	47c080e7          	jalr	1148(ra) # 5ae <close>


}
 13a:	27813083          	ld	ra,632(sp)
 13e:	27013403          	ld	s0,624(sp)
 142:	26813483          	ld	s1,616(sp)
 146:	26013903          	ld	s2,608(sp)
 14a:	25813983          	ld	s3,600(sp)
 14e:	25013a03          	ld	s4,592(sp)
 152:	24813a83          	ld	s5,584(sp)
 156:	24013b03          	ld	s6,576(sp)
 15a:	23813b83          	ld	s7,568(sp)
 15e:	28010113          	addi	sp,sp,640
 162:	8082                	ret
    fprintf(2, "find: cannot open .\n");
 164:	00001597          	auipc	a1,0x1
 168:	93c58593          	addi	a1,a1,-1732 # aa0 <malloc+0xe4>
 16c:	4509                	li	a0,2
 16e:	00000097          	auipc	ra,0x0
 172:	762080e7          	jalr	1890(ra) # 8d0 <fprintf>
    return;
 176:	b7d1                	j	13a <find+0x88>
    fprintf(2, "find: cannot stat .\n");
 178:	00001597          	auipc	a1,0x1
 17c:	94058593          	addi	a1,a1,-1728 # ab8 <malloc+0xfc>
 180:	4509                	li	a0,2
 182:	00000097          	auipc	ra,0x0
 186:	74e080e7          	jalr	1870(ra) # 8d0 <fprintf>
    close(fd);
 18a:	8526                	mv	a0,s1
 18c:	00000097          	auipc	ra,0x0
 190:	422080e7          	jalr	1058(ra) # 5ae <close>
    return;
 194:	b75d                	j	13a <find+0x88>
        if(strcmp(name, fmtname(path))==0) printf("%s\n", path);
 196:	85ca                	mv	a1,s2
 198:	00001517          	auipc	a0,0x1
 19c:	96050513          	addi	a0,a0,-1696 # af8 <malloc+0x13c>
 1a0:	00000097          	auipc	ra,0x0
 1a4:	75e080e7          	jalr	1886(ra) # 8fe <printf>
 1a8:	b761                	j	130 <find+0x7e>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 1aa:	854a                	mv	a0,s2
 1ac:	00000097          	auipc	ra,0x0
 1b0:	1ac080e7          	jalr	428(ra) # 358 <strlen>
 1b4:	2541                	addiw	a0,a0,16
 1b6:	20000793          	li	a5,512
 1ba:	00a7fb63          	bgeu	a5,a0,1d0 <find+0x11e>
      printf("ls: path too long\n");
 1be:	00001517          	auipc	a0,0x1
 1c2:	91250513          	addi	a0,a0,-1774 # ad0 <malloc+0x114>
 1c6:	00000097          	auipc	ra,0x0
 1ca:	738080e7          	jalr	1848(ra) # 8fe <printf>
      break;
 1ce:	b78d                	j	130 <find+0x7e>
    strcpy(buf, path);
 1d0:	85ca                	mv	a1,s2
 1d2:	db040513          	addi	a0,s0,-592
 1d6:	00000097          	auipc	ra,0x0
 1da:	13a080e7          	jalr	314(ra) # 310 <strcpy>
    p = buf+strlen(buf);
 1de:	db040513          	addi	a0,s0,-592
 1e2:	00000097          	auipc	ra,0x0
 1e6:	176080e7          	jalr	374(ra) # 358 <strlen>
 1ea:	02051913          	slli	s2,a0,0x20
 1ee:	02095913          	srli	s2,s2,0x20
 1f2:	db040793          	addi	a5,s0,-592
 1f6:	993e                	add	s2,s2,a5
    *p++ = '/';
 1f8:	00190a13          	addi	s4,s2,1
 1fc:	02f00793          	li	a5,47
 200:	00f90023          	sb	a5,0(s2)
      if(strcmp(".", fmtname(buf))!= 0 && strcmp("..", fmtname(buf))!= 0) find(buf, name);
 204:	00001a97          	auipc	s5,0x1
 208:	8fca8a93          	addi	s5,s5,-1796 # b00 <malloc+0x144>
 20c:	00001b97          	auipc	s7,0x1
 210:	8fcb8b93          	addi	s7,s7,-1796 # b08 <malloc+0x14c>
        printf("ls: cannot stat %s\n", buf);
 214:	00001b17          	auipc	s6,0x1
 218:	8d4b0b13          	addi	s6,s6,-1836 # ae8 <malloc+0x12c>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 21c:	4641                	li	a2,16
 21e:	da040593          	addi	a1,s0,-608
 222:	8526                	mv	a0,s1
 224:	00000097          	auipc	ra,0x0
 228:	37a080e7          	jalr	890(ra) # 59e <read>
 22c:	47c1                	li	a5,16
 22e:	f0f511e3          	bne	a0,a5,130 <find+0x7e>
      if(de.inum == 0)
 232:	da045783          	lhu	a5,-608(s0)
 236:	d3fd                	beqz	a5,21c <find+0x16a>
      memmove(p, de.name, DIRSIZ);
 238:	4639                	li	a2,14
 23a:	da240593          	addi	a1,s0,-606
 23e:	8552                	mv	a0,s4
 240:	00000097          	auipc	ra,0x0
 244:	290080e7          	jalr	656(ra) # 4d0 <memmove>
      p[DIRSIZ] = 0;
 248:	000907a3          	sb	zero,15(s2)
      if(stat(buf, &st) < 0){
 24c:	d8840593          	addi	a1,s0,-632
 250:	db040513          	addi	a0,s0,-592
 254:	00000097          	auipc	ra,0x0
 258:	1ec080e7          	jalr	492(ra) # 440 <stat>
 25c:	04054463          	bltz	a0,2a4 <find+0x1f2>
      if(strcmp(".", fmtname(buf))!= 0 && strcmp("..", fmtname(buf))!= 0) find(buf, name);
 260:	db040513          	addi	a0,s0,-592
 264:	00000097          	auipc	ra,0x0
 268:	d9c080e7          	jalr	-612(ra) # 0 <fmtname>
 26c:	85aa                	mv	a1,a0
 26e:	8556                	mv	a0,s5
 270:	00000097          	auipc	ra,0x0
 274:	0bc080e7          	jalr	188(ra) # 32c <strcmp>
 278:	d155                	beqz	a0,21c <find+0x16a>
 27a:	db040513          	addi	a0,s0,-592
 27e:	00000097          	auipc	ra,0x0
 282:	d82080e7          	jalr	-638(ra) # 0 <fmtname>
 286:	85aa                	mv	a1,a0
 288:	855e                	mv	a0,s7
 28a:	00000097          	auipc	ra,0x0
 28e:	0a2080e7          	jalr	162(ra) # 32c <strcmp>
 292:	d549                	beqz	a0,21c <find+0x16a>
 294:	85ce                	mv	a1,s3
 296:	db040513          	addi	a0,s0,-592
 29a:	00000097          	auipc	ra,0x0
 29e:	e18080e7          	jalr	-488(ra) # b2 <find>
 2a2:	bfad                	j	21c <find+0x16a>
        printf("ls: cannot stat %s\n", buf);
 2a4:	db040593          	addi	a1,s0,-592
 2a8:	855a                	mv	a0,s6
 2aa:	00000097          	auipc	ra,0x0
 2ae:	654080e7          	jalr	1620(ra) # 8fe <printf>
        continue;
 2b2:	b7ad                	j	21c <find+0x16a>

00000000000002b4 <main>:


int main(int argc, char *argv[]){
 2b4:	1141                	addi	sp,sp,-16
 2b6:	e406                	sd	ra,8(sp)
 2b8:	e022                	sd	s0,0(sp)
 2ba:	0800                	addi	s0,sp,16

  if (argc != 3){
 2bc:	470d                	li	a4,3
 2be:	02e50063          	beq	a0,a4,2de <main+0x2a>
    fprintf(2, "Usage: find <dir> <name>\n");
 2c2:	00001597          	auipc	a1,0x1
 2c6:	84e58593          	addi	a1,a1,-1970 # b10 <malloc+0x154>
 2ca:	4509                	li	a0,2
 2cc:	00000097          	auipc	ra,0x0
 2d0:	604080e7          	jalr	1540(ra) # 8d0 <fprintf>
    exit(1);
 2d4:	4505                	li	a0,1
 2d6:	00000097          	auipc	ra,0x0
 2da:	2b0080e7          	jalr	688(ra) # 586 <exit>
 2de:	87ae                	mv	a5,a1
  }	

  find(argv[1], argv[2]);
 2e0:	698c                	ld	a1,16(a1)
 2e2:	6788                	ld	a0,8(a5)
 2e4:	00000097          	auipc	ra,0x0
 2e8:	dce080e7          	jalr	-562(ra) # b2 <find>




  exit(0);
 2ec:	4501                	li	a0,0
 2ee:	00000097          	auipc	ra,0x0
 2f2:	298080e7          	jalr	664(ra) # 586 <exit>

00000000000002f6 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 2f6:	1141                	addi	sp,sp,-16
 2f8:	e406                	sd	ra,8(sp)
 2fa:	e022                	sd	s0,0(sp)
 2fc:	0800                	addi	s0,sp,16
  extern int main();
  main();
 2fe:	00000097          	auipc	ra,0x0
 302:	fb6080e7          	jalr	-74(ra) # 2b4 <main>
  exit(0);
 306:	4501                	li	a0,0
 308:	00000097          	auipc	ra,0x0
 30c:	27e080e7          	jalr	638(ra) # 586 <exit>

0000000000000310 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 310:	1141                	addi	sp,sp,-16
 312:	e422                	sd	s0,8(sp)
 314:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 316:	87aa                	mv	a5,a0
 318:	0585                	addi	a1,a1,1
 31a:	0785                	addi	a5,a5,1
 31c:	fff5c703          	lbu	a4,-1(a1)
 320:	fee78fa3          	sb	a4,-1(a5)
 324:	fb75                	bnez	a4,318 <strcpy+0x8>
    ;
  return os;
}
 326:	6422                	ld	s0,8(sp)
 328:	0141                	addi	sp,sp,16
 32a:	8082                	ret

000000000000032c <strcmp>:

int
strcmp(const char *p, const char *q)
{
 32c:	1141                	addi	sp,sp,-16
 32e:	e422                	sd	s0,8(sp)
 330:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 332:	00054783          	lbu	a5,0(a0)
 336:	cb91                	beqz	a5,34a <strcmp+0x1e>
 338:	0005c703          	lbu	a4,0(a1)
 33c:	00f71763          	bne	a4,a5,34a <strcmp+0x1e>
    p++, q++;
 340:	0505                	addi	a0,a0,1
 342:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 344:	00054783          	lbu	a5,0(a0)
 348:	fbe5                	bnez	a5,338 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 34a:	0005c503          	lbu	a0,0(a1)
}
 34e:	40a7853b          	subw	a0,a5,a0
 352:	6422                	ld	s0,8(sp)
 354:	0141                	addi	sp,sp,16
 356:	8082                	ret

0000000000000358 <strlen>:

uint
strlen(const char *s)
{
 358:	1141                	addi	sp,sp,-16
 35a:	e422                	sd	s0,8(sp)
 35c:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 35e:	00054783          	lbu	a5,0(a0)
 362:	cf91                	beqz	a5,37e <strlen+0x26>
 364:	0505                	addi	a0,a0,1
 366:	87aa                	mv	a5,a0
 368:	4685                	li	a3,1
 36a:	9e89                	subw	a3,a3,a0
 36c:	00f6853b          	addw	a0,a3,a5
 370:	0785                	addi	a5,a5,1
 372:	fff7c703          	lbu	a4,-1(a5)
 376:	fb7d                	bnez	a4,36c <strlen+0x14>
    ;
  return n;
}
 378:	6422                	ld	s0,8(sp)
 37a:	0141                	addi	sp,sp,16
 37c:	8082                	ret
  for(n = 0; s[n]; n++)
 37e:	4501                	li	a0,0
 380:	bfe5                	j	378 <strlen+0x20>

0000000000000382 <memset>:

void*
memset(void *dst, int c, uint n)
{
 382:	1141                	addi	sp,sp,-16
 384:	e422                	sd	s0,8(sp)
 386:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 388:	ce09                	beqz	a2,3a2 <memset+0x20>
 38a:	87aa                	mv	a5,a0
 38c:	fff6071b          	addiw	a4,a2,-1
 390:	1702                	slli	a4,a4,0x20
 392:	9301                	srli	a4,a4,0x20
 394:	0705                	addi	a4,a4,1
 396:	972a                	add	a4,a4,a0
    cdst[i] = c;
 398:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 39c:	0785                	addi	a5,a5,1
 39e:	fee79de3          	bne	a5,a4,398 <memset+0x16>
  }
  return dst;
}
 3a2:	6422                	ld	s0,8(sp)
 3a4:	0141                	addi	sp,sp,16
 3a6:	8082                	ret

00000000000003a8 <strchr>:

char*
strchr(const char *s, char c)
{
 3a8:	1141                	addi	sp,sp,-16
 3aa:	e422                	sd	s0,8(sp)
 3ac:	0800                	addi	s0,sp,16
  for(; *s; s++)
 3ae:	00054783          	lbu	a5,0(a0)
 3b2:	cb99                	beqz	a5,3c8 <strchr+0x20>
    if(*s == c)
 3b4:	00f58763          	beq	a1,a5,3c2 <strchr+0x1a>
  for(; *s; s++)
 3b8:	0505                	addi	a0,a0,1
 3ba:	00054783          	lbu	a5,0(a0)
 3be:	fbfd                	bnez	a5,3b4 <strchr+0xc>
      return (char*)s;
  return 0;
 3c0:	4501                	li	a0,0
}
 3c2:	6422                	ld	s0,8(sp)
 3c4:	0141                	addi	sp,sp,16
 3c6:	8082                	ret
  return 0;
 3c8:	4501                	li	a0,0
 3ca:	bfe5                	j	3c2 <strchr+0x1a>

00000000000003cc <gets>:

char*
gets(char *buf, int max)
{
 3cc:	711d                	addi	sp,sp,-96
 3ce:	ec86                	sd	ra,88(sp)
 3d0:	e8a2                	sd	s0,80(sp)
 3d2:	e4a6                	sd	s1,72(sp)
 3d4:	e0ca                	sd	s2,64(sp)
 3d6:	fc4e                	sd	s3,56(sp)
 3d8:	f852                	sd	s4,48(sp)
 3da:	f456                	sd	s5,40(sp)
 3dc:	f05a                	sd	s6,32(sp)
 3de:	ec5e                	sd	s7,24(sp)
 3e0:	1080                	addi	s0,sp,96
 3e2:	8baa                	mv	s7,a0
 3e4:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3e6:	892a                	mv	s2,a0
 3e8:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3ea:	4aa9                	li	s5,10
 3ec:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 3ee:	89a6                	mv	s3,s1
 3f0:	2485                	addiw	s1,s1,1
 3f2:	0344d863          	bge	s1,s4,422 <gets+0x56>
    cc = read(0, &c, 1);
 3f6:	4605                	li	a2,1
 3f8:	faf40593          	addi	a1,s0,-81
 3fc:	4501                	li	a0,0
 3fe:	00000097          	auipc	ra,0x0
 402:	1a0080e7          	jalr	416(ra) # 59e <read>
    if(cc < 1)
 406:	00a05e63          	blez	a0,422 <gets+0x56>
    buf[i++] = c;
 40a:	faf44783          	lbu	a5,-81(s0)
 40e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 412:	01578763          	beq	a5,s5,420 <gets+0x54>
 416:	0905                	addi	s2,s2,1
 418:	fd679be3          	bne	a5,s6,3ee <gets+0x22>
  for(i=0; i+1 < max; ){
 41c:	89a6                	mv	s3,s1
 41e:	a011                	j	422 <gets+0x56>
 420:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 422:	99de                	add	s3,s3,s7
 424:	00098023          	sb	zero,0(s3)
  return buf;
}
 428:	855e                	mv	a0,s7
 42a:	60e6                	ld	ra,88(sp)
 42c:	6446                	ld	s0,80(sp)
 42e:	64a6                	ld	s1,72(sp)
 430:	6906                	ld	s2,64(sp)
 432:	79e2                	ld	s3,56(sp)
 434:	7a42                	ld	s4,48(sp)
 436:	7aa2                	ld	s5,40(sp)
 438:	7b02                	ld	s6,32(sp)
 43a:	6be2                	ld	s7,24(sp)
 43c:	6125                	addi	sp,sp,96
 43e:	8082                	ret

0000000000000440 <stat>:

int
stat(const char *n, struct stat *st)
{
 440:	1101                	addi	sp,sp,-32
 442:	ec06                	sd	ra,24(sp)
 444:	e822                	sd	s0,16(sp)
 446:	e426                	sd	s1,8(sp)
 448:	e04a                	sd	s2,0(sp)
 44a:	1000                	addi	s0,sp,32
 44c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 44e:	4581                	li	a1,0
 450:	00000097          	auipc	ra,0x0
 454:	176080e7          	jalr	374(ra) # 5c6 <open>
  if(fd < 0)
 458:	02054563          	bltz	a0,482 <stat+0x42>
 45c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 45e:	85ca                	mv	a1,s2
 460:	00000097          	auipc	ra,0x0
 464:	17e080e7          	jalr	382(ra) # 5de <fstat>
 468:	892a                	mv	s2,a0
  close(fd);
 46a:	8526                	mv	a0,s1
 46c:	00000097          	auipc	ra,0x0
 470:	142080e7          	jalr	322(ra) # 5ae <close>
  return r;
}
 474:	854a                	mv	a0,s2
 476:	60e2                	ld	ra,24(sp)
 478:	6442                	ld	s0,16(sp)
 47a:	64a2                	ld	s1,8(sp)
 47c:	6902                	ld	s2,0(sp)
 47e:	6105                	addi	sp,sp,32
 480:	8082                	ret
    return -1;
 482:	597d                	li	s2,-1
 484:	bfc5                	j	474 <stat+0x34>

0000000000000486 <atoi>:

int
atoi(const char *s)
{
 486:	1141                	addi	sp,sp,-16
 488:	e422                	sd	s0,8(sp)
 48a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 48c:	00054603          	lbu	a2,0(a0)
 490:	fd06079b          	addiw	a5,a2,-48
 494:	0ff7f793          	andi	a5,a5,255
 498:	4725                	li	a4,9
 49a:	02f76963          	bltu	a4,a5,4cc <atoi+0x46>
 49e:	86aa                	mv	a3,a0
  n = 0;
 4a0:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 4a2:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 4a4:	0685                	addi	a3,a3,1
 4a6:	0025179b          	slliw	a5,a0,0x2
 4aa:	9fa9                	addw	a5,a5,a0
 4ac:	0017979b          	slliw	a5,a5,0x1
 4b0:	9fb1                	addw	a5,a5,a2
 4b2:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 4b6:	0006c603          	lbu	a2,0(a3)
 4ba:	fd06071b          	addiw	a4,a2,-48
 4be:	0ff77713          	andi	a4,a4,255
 4c2:	fee5f1e3          	bgeu	a1,a4,4a4 <atoi+0x1e>
  return n;
}
 4c6:	6422                	ld	s0,8(sp)
 4c8:	0141                	addi	sp,sp,16
 4ca:	8082                	ret
  n = 0;
 4cc:	4501                	li	a0,0
 4ce:	bfe5                	j	4c6 <atoi+0x40>

00000000000004d0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4d0:	1141                	addi	sp,sp,-16
 4d2:	e422                	sd	s0,8(sp)
 4d4:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 4d6:	02b57663          	bgeu	a0,a1,502 <memmove+0x32>
    while(n-- > 0)
 4da:	02c05163          	blez	a2,4fc <memmove+0x2c>
 4de:	fff6079b          	addiw	a5,a2,-1
 4e2:	1782                	slli	a5,a5,0x20
 4e4:	9381                	srli	a5,a5,0x20
 4e6:	0785                	addi	a5,a5,1
 4e8:	97aa                	add	a5,a5,a0
  dst = vdst;
 4ea:	872a                	mv	a4,a0
      *dst++ = *src++;
 4ec:	0585                	addi	a1,a1,1
 4ee:	0705                	addi	a4,a4,1
 4f0:	fff5c683          	lbu	a3,-1(a1)
 4f4:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 4f8:	fee79ae3          	bne	a5,a4,4ec <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 4fc:	6422                	ld	s0,8(sp)
 4fe:	0141                	addi	sp,sp,16
 500:	8082                	ret
    dst += n;
 502:	00c50733          	add	a4,a0,a2
    src += n;
 506:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 508:	fec05ae3          	blez	a2,4fc <memmove+0x2c>
 50c:	fff6079b          	addiw	a5,a2,-1
 510:	1782                	slli	a5,a5,0x20
 512:	9381                	srli	a5,a5,0x20
 514:	fff7c793          	not	a5,a5
 518:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 51a:	15fd                	addi	a1,a1,-1
 51c:	177d                	addi	a4,a4,-1
 51e:	0005c683          	lbu	a3,0(a1)
 522:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 526:	fee79ae3          	bne	a5,a4,51a <memmove+0x4a>
 52a:	bfc9                	j	4fc <memmove+0x2c>

000000000000052c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 52c:	1141                	addi	sp,sp,-16
 52e:	e422                	sd	s0,8(sp)
 530:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 532:	ca05                	beqz	a2,562 <memcmp+0x36>
 534:	fff6069b          	addiw	a3,a2,-1
 538:	1682                	slli	a3,a3,0x20
 53a:	9281                	srli	a3,a3,0x20
 53c:	0685                	addi	a3,a3,1
 53e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 540:	00054783          	lbu	a5,0(a0)
 544:	0005c703          	lbu	a4,0(a1)
 548:	00e79863          	bne	a5,a4,558 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 54c:	0505                	addi	a0,a0,1
    p2++;
 54e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 550:	fed518e3          	bne	a0,a3,540 <memcmp+0x14>
  }
  return 0;
 554:	4501                	li	a0,0
 556:	a019                	j	55c <memcmp+0x30>
      return *p1 - *p2;
 558:	40e7853b          	subw	a0,a5,a4
}
 55c:	6422                	ld	s0,8(sp)
 55e:	0141                	addi	sp,sp,16
 560:	8082                	ret
  return 0;
 562:	4501                	li	a0,0
 564:	bfe5                	j	55c <memcmp+0x30>

0000000000000566 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 566:	1141                	addi	sp,sp,-16
 568:	e406                	sd	ra,8(sp)
 56a:	e022                	sd	s0,0(sp)
 56c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 56e:	00000097          	auipc	ra,0x0
 572:	f62080e7          	jalr	-158(ra) # 4d0 <memmove>
}
 576:	60a2                	ld	ra,8(sp)
 578:	6402                	ld	s0,0(sp)
 57a:	0141                	addi	sp,sp,16
 57c:	8082                	ret

000000000000057e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 57e:	4885                	li	a7,1
 ecall
 580:	00000073          	ecall
 ret
 584:	8082                	ret

0000000000000586 <exit>:
.global exit
exit:
 li a7, SYS_exit
 586:	4889                	li	a7,2
 ecall
 588:	00000073          	ecall
 ret
 58c:	8082                	ret

000000000000058e <wait>:
.global wait
wait:
 li a7, SYS_wait
 58e:	488d                	li	a7,3
 ecall
 590:	00000073          	ecall
 ret
 594:	8082                	ret

0000000000000596 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 596:	4891                	li	a7,4
 ecall
 598:	00000073          	ecall
 ret
 59c:	8082                	ret

000000000000059e <read>:
.global read
read:
 li a7, SYS_read
 59e:	4895                	li	a7,5
 ecall
 5a0:	00000073          	ecall
 ret
 5a4:	8082                	ret

00000000000005a6 <write>:
.global write
write:
 li a7, SYS_write
 5a6:	48c1                	li	a7,16
 ecall
 5a8:	00000073          	ecall
 ret
 5ac:	8082                	ret

00000000000005ae <close>:
.global close
close:
 li a7, SYS_close
 5ae:	48d5                	li	a7,21
 ecall
 5b0:	00000073          	ecall
 ret
 5b4:	8082                	ret

00000000000005b6 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5b6:	4899                	li	a7,6
 ecall
 5b8:	00000073          	ecall
 ret
 5bc:	8082                	ret

00000000000005be <exec>:
.global exec
exec:
 li a7, SYS_exec
 5be:	489d                	li	a7,7
 ecall
 5c0:	00000073          	ecall
 ret
 5c4:	8082                	ret

00000000000005c6 <open>:
.global open
open:
 li a7, SYS_open
 5c6:	48bd                	li	a7,15
 ecall
 5c8:	00000073          	ecall
 ret
 5cc:	8082                	ret

00000000000005ce <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5ce:	48c5                	li	a7,17
 ecall
 5d0:	00000073          	ecall
 ret
 5d4:	8082                	ret

00000000000005d6 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5d6:	48c9                	li	a7,18
 ecall
 5d8:	00000073          	ecall
 ret
 5dc:	8082                	ret

00000000000005de <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5de:	48a1                	li	a7,8
 ecall
 5e0:	00000073          	ecall
 ret
 5e4:	8082                	ret

00000000000005e6 <link>:
.global link
link:
 li a7, SYS_link
 5e6:	48cd                	li	a7,19
 ecall
 5e8:	00000073          	ecall
 ret
 5ec:	8082                	ret

00000000000005ee <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5ee:	48d1                	li	a7,20
 ecall
 5f0:	00000073          	ecall
 ret
 5f4:	8082                	ret

00000000000005f6 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5f6:	48a5                	li	a7,9
 ecall
 5f8:	00000073          	ecall
 ret
 5fc:	8082                	ret

00000000000005fe <dup>:
.global dup
dup:
 li a7, SYS_dup
 5fe:	48a9                	li	a7,10
 ecall
 600:	00000073          	ecall
 ret
 604:	8082                	ret

0000000000000606 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 606:	48ad                	li	a7,11
 ecall
 608:	00000073          	ecall
 ret
 60c:	8082                	ret

000000000000060e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 60e:	48b1                	li	a7,12
 ecall
 610:	00000073          	ecall
 ret
 614:	8082                	ret

0000000000000616 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 616:	48b5                	li	a7,13
 ecall
 618:	00000073          	ecall
 ret
 61c:	8082                	ret

000000000000061e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 61e:	48b9                	li	a7,14
 ecall
 620:	00000073          	ecall
 ret
 624:	8082                	ret

0000000000000626 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 626:	1101                	addi	sp,sp,-32
 628:	ec06                	sd	ra,24(sp)
 62a:	e822                	sd	s0,16(sp)
 62c:	1000                	addi	s0,sp,32
 62e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 632:	4605                	li	a2,1
 634:	fef40593          	addi	a1,s0,-17
 638:	00000097          	auipc	ra,0x0
 63c:	f6e080e7          	jalr	-146(ra) # 5a6 <write>
}
 640:	60e2                	ld	ra,24(sp)
 642:	6442                	ld	s0,16(sp)
 644:	6105                	addi	sp,sp,32
 646:	8082                	ret

0000000000000648 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 648:	7139                	addi	sp,sp,-64
 64a:	fc06                	sd	ra,56(sp)
 64c:	f822                	sd	s0,48(sp)
 64e:	f426                	sd	s1,40(sp)
 650:	f04a                	sd	s2,32(sp)
 652:	ec4e                	sd	s3,24(sp)
 654:	0080                	addi	s0,sp,64
 656:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 658:	c299                	beqz	a3,65e <printint+0x16>
 65a:	0805c863          	bltz	a1,6ea <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 65e:	2581                	sext.w	a1,a1
  neg = 0;
 660:	4881                	li	a7,0
 662:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 666:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 668:	2601                	sext.w	a2,a2
 66a:	00000517          	auipc	a0,0x0
 66e:	4ce50513          	addi	a0,a0,1230 # b38 <digits>
 672:	883a                	mv	a6,a4
 674:	2705                	addiw	a4,a4,1
 676:	02c5f7bb          	remuw	a5,a1,a2
 67a:	1782                	slli	a5,a5,0x20
 67c:	9381                	srli	a5,a5,0x20
 67e:	97aa                	add	a5,a5,a0
 680:	0007c783          	lbu	a5,0(a5)
 684:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 688:	0005879b          	sext.w	a5,a1
 68c:	02c5d5bb          	divuw	a1,a1,a2
 690:	0685                	addi	a3,a3,1
 692:	fec7f0e3          	bgeu	a5,a2,672 <printint+0x2a>
  if(neg)
 696:	00088b63          	beqz	a7,6ac <printint+0x64>
    buf[i++] = '-';
 69a:	fd040793          	addi	a5,s0,-48
 69e:	973e                	add	a4,a4,a5
 6a0:	02d00793          	li	a5,45
 6a4:	fef70823          	sb	a5,-16(a4)
 6a8:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 6ac:	02e05863          	blez	a4,6dc <printint+0x94>
 6b0:	fc040793          	addi	a5,s0,-64
 6b4:	00e78933          	add	s2,a5,a4
 6b8:	fff78993          	addi	s3,a5,-1
 6bc:	99ba                	add	s3,s3,a4
 6be:	377d                	addiw	a4,a4,-1
 6c0:	1702                	slli	a4,a4,0x20
 6c2:	9301                	srli	a4,a4,0x20
 6c4:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 6c8:	fff94583          	lbu	a1,-1(s2)
 6cc:	8526                	mv	a0,s1
 6ce:	00000097          	auipc	ra,0x0
 6d2:	f58080e7          	jalr	-168(ra) # 626 <putc>
  while(--i >= 0)
 6d6:	197d                	addi	s2,s2,-1
 6d8:	ff3918e3          	bne	s2,s3,6c8 <printint+0x80>
}
 6dc:	70e2                	ld	ra,56(sp)
 6de:	7442                	ld	s0,48(sp)
 6e0:	74a2                	ld	s1,40(sp)
 6e2:	7902                	ld	s2,32(sp)
 6e4:	69e2                	ld	s3,24(sp)
 6e6:	6121                	addi	sp,sp,64
 6e8:	8082                	ret
    x = -xx;
 6ea:	40b005bb          	negw	a1,a1
    neg = 1;
 6ee:	4885                	li	a7,1
    x = -xx;
 6f0:	bf8d                	j	662 <printint+0x1a>

00000000000006f2 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6f2:	7119                	addi	sp,sp,-128
 6f4:	fc86                	sd	ra,120(sp)
 6f6:	f8a2                	sd	s0,112(sp)
 6f8:	f4a6                	sd	s1,104(sp)
 6fa:	f0ca                	sd	s2,96(sp)
 6fc:	ecce                	sd	s3,88(sp)
 6fe:	e8d2                	sd	s4,80(sp)
 700:	e4d6                	sd	s5,72(sp)
 702:	e0da                	sd	s6,64(sp)
 704:	fc5e                	sd	s7,56(sp)
 706:	f862                	sd	s8,48(sp)
 708:	f466                	sd	s9,40(sp)
 70a:	f06a                	sd	s10,32(sp)
 70c:	ec6e                	sd	s11,24(sp)
 70e:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 710:	0005c903          	lbu	s2,0(a1)
 714:	18090f63          	beqz	s2,8b2 <vprintf+0x1c0>
 718:	8aaa                	mv	s5,a0
 71a:	8b32                	mv	s6,a2
 71c:	00158493          	addi	s1,a1,1
  state = 0;
 720:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 722:	02500a13          	li	s4,37
      if(c == 'd'){
 726:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 72a:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 72e:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 732:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 736:	00000b97          	auipc	s7,0x0
 73a:	402b8b93          	addi	s7,s7,1026 # b38 <digits>
 73e:	a839                	j	75c <vprintf+0x6a>
        putc(fd, c);
 740:	85ca                	mv	a1,s2
 742:	8556                	mv	a0,s5
 744:	00000097          	auipc	ra,0x0
 748:	ee2080e7          	jalr	-286(ra) # 626 <putc>
 74c:	a019                	j	752 <vprintf+0x60>
    } else if(state == '%'){
 74e:	01498f63          	beq	s3,s4,76c <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 752:	0485                	addi	s1,s1,1
 754:	fff4c903          	lbu	s2,-1(s1)
 758:	14090d63          	beqz	s2,8b2 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 75c:	0009079b          	sext.w	a5,s2
    if(state == 0){
 760:	fe0997e3          	bnez	s3,74e <vprintf+0x5c>
      if(c == '%'){
 764:	fd479ee3          	bne	a5,s4,740 <vprintf+0x4e>
        state = '%';
 768:	89be                	mv	s3,a5
 76a:	b7e5                	j	752 <vprintf+0x60>
      if(c == 'd'){
 76c:	05878063          	beq	a5,s8,7ac <vprintf+0xba>
      } else if(c == 'l') {
 770:	05978c63          	beq	a5,s9,7c8 <vprintf+0xd6>
      } else if(c == 'x') {
 774:	07a78863          	beq	a5,s10,7e4 <vprintf+0xf2>
      } else if(c == 'p') {
 778:	09b78463          	beq	a5,s11,800 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 77c:	07300713          	li	a4,115
 780:	0ce78663          	beq	a5,a4,84c <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 784:	06300713          	li	a4,99
 788:	0ee78e63          	beq	a5,a4,884 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 78c:	11478863          	beq	a5,s4,89c <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 790:	85d2                	mv	a1,s4
 792:	8556                	mv	a0,s5
 794:	00000097          	auipc	ra,0x0
 798:	e92080e7          	jalr	-366(ra) # 626 <putc>
        putc(fd, c);
 79c:	85ca                	mv	a1,s2
 79e:	8556                	mv	a0,s5
 7a0:	00000097          	auipc	ra,0x0
 7a4:	e86080e7          	jalr	-378(ra) # 626 <putc>
      }
      state = 0;
 7a8:	4981                	li	s3,0
 7aa:	b765                	j	752 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 7ac:	008b0913          	addi	s2,s6,8
 7b0:	4685                	li	a3,1
 7b2:	4629                	li	a2,10
 7b4:	000b2583          	lw	a1,0(s6)
 7b8:	8556                	mv	a0,s5
 7ba:	00000097          	auipc	ra,0x0
 7be:	e8e080e7          	jalr	-370(ra) # 648 <printint>
 7c2:	8b4a                	mv	s6,s2
      state = 0;
 7c4:	4981                	li	s3,0
 7c6:	b771                	j	752 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7c8:	008b0913          	addi	s2,s6,8
 7cc:	4681                	li	a3,0
 7ce:	4629                	li	a2,10
 7d0:	000b2583          	lw	a1,0(s6)
 7d4:	8556                	mv	a0,s5
 7d6:	00000097          	auipc	ra,0x0
 7da:	e72080e7          	jalr	-398(ra) # 648 <printint>
 7de:	8b4a                	mv	s6,s2
      state = 0;
 7e0:	4981                	li	s3,0
 7e2:	bf85                	j	752 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 7e4:	008b0913          	addi	s2,s6,8
 7e8:	4681                	li	a3,0
 7ea:	4641                	li	a2,16
 7ec:	000b2583          	lw	a1,0(s6)
 7f0:	8556                	mv	a0,s5
 7f2:	00000097          	auipc	ra,0x0
 7f6:	e56080e7          	jalr	-426(ra) # 648 <printint>
 7fa:	8b4a                	mv	s6,s2
      state = 0;
 7fc:	4981                	li	s3,0
 7fe:	bf91                	j	752 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 800:	008b0793          	addi	a5,s6,8
 804:	f8f43423          	sd	a5,-120(s0)
 808:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 80c:	03000593          	li	a1,48
 810:	8556                	mv	a0,s5
 812:	00000097          	auipc	ra,0x0
 816:	e14080e7          	jalr	-492(ra) # 626 <putc>
  putc(fd, 'x');
 81a:	85ea                	mv	a1,s10
 81c:	8556                	mv	a0,s5
 81e:	00000097          	auipc	ra,0x0
 822:	e08080e7          	jalr	-504(ra) # 626 <putc>
 826:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 828:	03c9d793          	srli	a5,s3,0x3c
 82c:	97de                	add	a5,a5,s7
 82e:	0007c583          	lbu	a1,0(a5)
 832:	8556                	mv	a0,s5
 834:	00000097          	auipc	ra,0x0
 838:	df2080e7          	jalr	-526(ra) # 626 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 83c:	0992                	slli	s3,s3,0x4
 83e:	397d                	addiw	s2,s2,-1
 840:	fe0914e3          	bnez	s2,828 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 844:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 848:	4981                	li	s3,0
 84a:	b721                	j	752 <vprintf+0x60>
        s = va_arg(ap, char*);
 84c:	008b0993          	addi	s3,s6,8
 850:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 854:	02090163          	beqz	s2,876 <vprintf+0x184>
        while(*s != 0){
 858:	00094583          	lbu	a1,0(s2)
 85c:	c9a1                	beqz	a1,8ac <vprintf+0x1ba>
          putc(fd, *s);
 85e:	8556                	mv	a0,s5
 860:	00000097          	auipc	ra,0x0
 864:	dc6080e7          	jalr	-570(ra) # 626 <putc>
          s++;
 868:	0905                	addi	s2,s2,1
        while(*s != 0){
 86a:	00094583          	lbu	a1,0(s2)
 86e:	f9e5                	bnez	a1,85e <vprintf+0x16c>
        s = va_arg(ap, char*);
 870:	8b4e                	mv	s6,s3
      state = 0;
 872:	4981                	li	s3,0
 874:	bdf9                	j	752 <vprintf+0x60>
          s = "(null)";
 876:	00000917          	auipc	s2,0x0
 87a:	2ba90913          	addi	s2,s2,698 # b30 <malloc+0x174>
        while(*s != 0){
 87e:	02800593          	li	a1,40
 882:	bff1                	j	85e <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 884:	008b0913          	addi	s2,s6,8
 888:	000b4583          	lbu	a1,0(s6)
 88c:	8556                	mv	a0,s5
 88e:	00000097          	auipc	ra,0x0
 892:	d98080e7          	jalr	-616(ra) # 626 <putc>
 896:	8b4a                	mv	s6,s2
      state = 0;
 898:	4981                	li	s3,0
 89a:	bd65                	j	752 <vprintf+0x60>
        putc(fd, c);
 89c:	85d2                	mv	a1,s4
 89e:	8556                	mv	a0,s5
 8a0:	00000097          	auipc	ra,0x0
 8a4:	d86080e7          	jalr	-634(ra) # 626 <putc>
      state = 0;
 8a8:	4981                	li	s3,0
 8aa:	b565                	j	752 <vprintf+0x60>
        s = va_arg(ap, char*);
 8ac:	8b4e                	mv	s6,s3
      state = 0;
 8ae:	4981                	li	s3,0
 8b0:	b54d                	j	752 <vprintf+0x60>
    }
  }
}
 8b2:	70e6                	ld	ra,120(sp)
 8b4:	7446                	ld	s0,112(sp)
 8b6:	74a6                	ld	s1,104(sp)
 8b8:	7906                	ld	s2,96(sp)
 8ba:	69e6                	ld	s3,88(sp)
 8bc:	6a46                	ld	s4,80(sp)
 8be:	6aa6                	ld	s5,72(sp)
 8c0:	6b06                	ld	s6,64(sp)
 8c2:	7be2                	ld	s7,56(sp)
 8c4:	7c42                	ld	s8,48(sp)
 8c6:	7ca2                	ld	s9,40(sp)
 8c8:	7d02                	ld	s10,32(sp)
 8ca:	6de2                	ld	s11,24(sp)
 8cc:	6109                	addi	sp,sp,128
 8ce:	8082                	ret

00000000000008d0 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8d0:	715d                	addi	sp,sp,-80
 8d2:	ec06                	sd	ra,24(sp)
 8d4:	e822                	sd	s0,16(sp)
 8d6:	1000                	addi	s0,sp,32
 8d8:	e010                	sd	a2,0(s0)
 8da:	e414                	sd	a3,8(s0)
 8dc:	e818                	sd	a4,16(s0)
 8de:	ec1c                	sd	a5,24(s0)
 8e0:	03043023          	sd	a6,32(s0)
 8e4:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8e8:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8ec:	8622                	mv	a2,s0
 8ee:	00000097          	auipc	ra,0x0
 8f2:	e04080e7          	jalr	-508(ra) # 6f2 <vprintf>
}
 8f6:	60e2                	ld	ra,24(sp)
 8f8:	6442                	ld	s0,16(sp)
 8fa:	6161                	addi	sp,sp,80
 8fc:	8082                	ret

00000000000008fe <printf>:

void
printf(const char *fmt, ...)
{
 8fe:	711d                	addi	sp,sp,-96
 900:	ec06                	sd	ra,24(sp)
 902:	e822                	sd	s0,16(sp)
 904:	1000                	addi	s0,sp,32
 906:	e40c                	sd	a1,8(s0)
 908:	e810                	sd	a2,16(s0)
 90a:	ec14                	sd	a3,24(s0)
 90c:	f018                	sd	a4,32(s0)
 90e:	f41c                	sd	a5,40(s0)
 910:	03043823          	sd	a6,48(s0)
 914:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 918:	00840613          	addi	a2,s0,8
 91c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 920:	85aa                	mv	a1,a0
 922:	4505                	li	a0,1
 924:	00000097          	auipc	ra,0x0
 928:	dce080e7          	jalr	-562(ra) # 6f2 <vprintf>
}
 92c:	60e2                	ld	ra,24(sp)
 92e:	6442                	ld	s0,16(sp)
 930:	6125                	addi	sp,sp,96
 932:	8082                	ret

0000000000000934 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 934:	1141                	addi	sp,sp,-16
 936:	e422                	sd	s0,8(sp)
 938:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 93a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 93e:	00000797          	auipc	a5,0x0
 942:	6c27b783          	ld	a5,1730(a5) # 1000 <freep>
 946:	a805                	j	976 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 948:	4618                	lw	a4,8(a2)
 94a:	9db9                	addw	a1,a1,a4
 94c:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 950:	6398                	ld	a4,0(a5)
 952:	6318                	ld	a4,0(a4)
 954:	fee53823          	sd	a4,-16(a0)
 958:	a091                	j	99c <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 95a:	ff852703          	lw	a4,-8(a0)
 95e:	9e39                	addw	a2,a2,a4
 960:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 962:	ff053703          	ld	a4,-16(a0)
 966:	e398                	sd	a4,0(a5)
 968:	a099                	j	9ae <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 96a:	6398                	ld	a4,0(a5)
 96c:	00e7e463          	bltu	a5,a4,974 <free+0x40>
 970:	00e6ea63          	bltu	a3,a4,984 <free+0x50>
{
 974:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 976:	fed7fae3          	bgeu	a5,a3,96a <free+0x36>
 97a:	6398                	ld	a4,0(a5)
 97c:	00e6e463          	bltu	a3,a4,984 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 980:	fee7eae3          	bltu	a5,a4,974 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 984:	ff852583          	lw	a1,-8(a0)
 988:	6390                	ld	a2,0(a5)
 98a:	02059713          	slli	a4,a1,0x20
 98e:	9301                	srli	a4,a4,0x20
 990:	0712                	slli	a4,a4,0x4
 992:	9736                	add	a4,a4,a3
 994:	fae60ae3          	beq	a2,a4,948 <free+0x14>
    bp->s.ptr = p->s.ptr;
 998:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 99c:	4790                	lw	a2,8(a5)
 99e:	02061713          	slli	a4,a2,0x20
 9a2:	9301                	srli	a4,a4,0x20
 9a4:	0712                	slli	a4,a4,0x4
 9a6:	973e                	add	a4,a4,a5
 9a8:	fae689e3          	beq	a3,a4,95a <free+0x26>
  } else
    p->s.ptr = bp;
 9ac:	e394                	sd	a3,0(a5)
  freep = p;
 9ae:	00000717          	auipc	a4,0x0
 9b2:	64f73923          	sd	a5,1618(a4) # 1000 <freep>
}
 9b6:	6422                	ld	s0,8(sp)
 9b8:	0141                	addi	sp,sp,16
 9ba:	8082                	ret

00000000000009bc <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9bc:	7139                	addi	sp,sp,-64
 9be:	fc06                	sd	ra,56(sp)
 9c0:	f822                	sd	s0,48(sp)
 9c2:	f426                	sd	s1,40(sp)
 9c4:	f04a                	sd	s2,32(sp)
 9c6:	ec4e                	sd	s3,24(sp)
 9c8:	e852                	sd	s4,16(sp)
 9ca:	e456                	sd	s5,8(sp)
 9cc:	e05a                	sd	s6,0(sp)
 9ce:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9d0:	02051493          	slli	s1,a0,0x20
 9d4:	9081                	srli	s1,s1,0x20
 9d6:	04bd                	addi	s1,s1,15
 9d8:	8091                	srli	s1,s1,0x4
 9da:	0014899b          	addiw	s3,s1,1
 9de:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 9e0:	00000517          	auipc	a0,0x0
 9e4:	62053503          	ld	a0,1568(a0) # 1000 <freep>
 9e8:	c515                	beqz	a0,a14 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9ea:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9ec:	4798                	lw	a4,8(a5)
 9ee:	02977f63          	bgeu	a4,s1,a2c <malloc+0x70>
 9f2:	8a4e                	mv	s4,s3
 9f4:	0009871b          	sext.w	a4,s3
 9f8:	6685                	lui	a3,0x1
 9fa:	00d77363          	bgeu	a4,a3,a00 <malloc+0x44>
 9fe:	6a05                	lui	s4,0x1
 a00:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a04:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a08:	00000917          	auipc	s2,0x0
 a0c:	5f890913          	addi	s2,s2,1528 # 1000 <freep>
  if(p == (char*)-1)
 a10:	5afd                	li	s5,-1
 a12:	a88d                	j	a84 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 a14:	00000797          	auipc	a5,0x0
 a18:	60c78793          	addi	a5,a5,1548 # 1020 <base>
 a1c:	00000717          	auipc	a4,0x0
 a20:	5ef73223          	sd	a5,1508(a4) # 1000 <freep>
 a24:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a26:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a2a:	b7e1                	j	9f2 <malloc+0x36>
      if(p->s.size == nunits)
 a2c:	02e48b63          	beq	s1,a4,a62 <malloc+0xa6>
        p->s.size -= nunits;
 a30:	4137073b          	subw	a4,a4,s3
 a34:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a36:	1702                	slli	a4,a4,0x20
 a38:	9301                	srli	a4,a4,0x20
 a3a:	0712                	slli	a4,a4,0x4
 a3c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a3e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a42:	00000717          	auipc	a4,0x0
 a46:	5aa73f23          	sd	a0,1470(a4) # 1000 <freep>
      return (void*)(p + 1);
 a4a:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a4e:	70e2                	ld	ra,56(sp)
 a50:	7442                	ld	s0,48(sp)
 a52:	74a2                	ld	s1,40(sp)
 a54:	7902                	ld	s2,32(sp)
 a56:	69e2                	ld	s3,24(sp)
 a58:	6a42                	ld	s4,16(sp)
 a5a:	6aa2                	ld	s5,8(sp)
 a5c:	6b02                	ld	s6,0(sp)
 a5e:	6121                	addi	sp,sp,64
 a60:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a62:	6398                	ld	a4,0(a5)
 a64:	e118                	sd	a4,0(a0)
 a66:	bff1                	j	a42 <malloc+0x86>
  hp->s.size = nu;
 a68:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a6c:	0541                	addi	a0,a0,16
 a6e:	00000097          	auipc	ra,0x0
 a72:	ec6080e7          	jalr	-314(ra) # 934 <free>
  return freep;
 a76:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a7a:	d971                	beqz	a0,a4e <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a7c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a7e:	4798                	lw	a4,8(a5)
 a80:	fa9776e3          	bgeu	a4,s1,a2c <malloc+0x70>
    if(p == freep)
 a84:	00093703          	ld	a4,0(s2)
 a88:	853e                	mv	a0,a5
 a8a:	fef719e3          	bne	a4,a5,a7c <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 a8e:	8552                	mv	a0,s4
 a90:	00000097          	auipc	ra,0x0
 a94:	b7e080e7          	jalr	-1154(ra) # 60e <sbrk>
  if(p == (char*)-1)
 a98:	fd5518e3          	bne	a0,s5,a68 <malloc+0xac>
        return 0;
 a9c:	4501                	li	a0,0
 a9e:	bf45                	j	a4e <malloc+0x92>
