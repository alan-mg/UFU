#include <stdio.h>
#include <unistd.h>

int main( int argc, char *argv[] ) {
  if ( argc == 3 ) {
    link( argv[1], argv[2] );
  } else {
    perror( "ln" );
  } return 0;
}
