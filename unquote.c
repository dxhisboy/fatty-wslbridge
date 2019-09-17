#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <unistd.h>
static inline int argcpy(char *dst, char *src){
  int len = strlen(src);
  if (src[0] == '\'' && src[len - 1] == '\'' ||
      src[0] == '\"' && src[len - 1] == '\"') {
    src = src + 1;
    len = len - 2;
  }
  memcpy(dst, src, len);
  dst[len] = 0;
  return len;
}
int main(int argc, char **argv){
  int i;
  char arg_in[ARG_MAX];
  char *arg_ptr[ARG_MAX];
  char *arg_cur = arg_in;
  for (i = 1; i < argc; i ++){
    arg_ptr[i - 1] = arg_cur;
    int len = argcpy(arg_cur, argv[i]);
    arg_cur += len + 1;
  }
  arg_ptr[argc - 1] = NULL;
  execvp(arg_ptr[0], arg_ptr);
}
