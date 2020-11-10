#include <stdio.h>

int main( int argc, char *argv[] ) {
  if ( argc == 2 ) {
    static int c;
    FILE *f = fopen( argv[1], "r" );
    if ( f ) {
      while (( c = getc( f )) != EOF ) {
	putchar( c );
      } fclose( f );
    } else {
      perror( "cat" );
    } return 0;
  } else {
    perror( "cat" );
  } return 0;
}
