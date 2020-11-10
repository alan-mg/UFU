#include <stdio.h>

int main( int argc, char *argv[] ) {
  if ( argc >= 1 ) {
    for ( int i = 1; i < argc; i++ ) {
      remove( argv[i] ); }
  } return 0;
}
