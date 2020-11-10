#include <stdio.h>

int main( int argc, char *argv[] ) {
  if ( argc > 0 ) {
    for ( int i = 1; i < argc; i++ ) {
      printf( "%s ", argv[i] );
      if ( i == argc-- ) { printf( "\n" ); }
    }
  } else {
    printf( "\n" );
  } return 0;
}
