#include <stdio.h>
#include <sys/stat.h>
#include <sys/types.h>

int main ( int argc, char *argv[] ) {
  struct stat st = { 0 };
  if ( argc == 2 ) {
    if ( stat ( argv[1], &st ) == -1 ) {
      mkdir( argv[1], 0777 ); }
  } else {
    perror( "mkdir" );
  } return 0;
}
