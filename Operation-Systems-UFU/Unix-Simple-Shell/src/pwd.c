#include <stdio.h>
#include <unistd.h>

int main( void ) {
  char a[256];
  printf( "%s\n", getcwd( a, 256 ));
  return 0;
}
