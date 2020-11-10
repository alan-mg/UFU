#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <signal.h>

int main( int argc, char *argv[] ) {
  if ( argc == 2 ) {
    for ( int i = 1; i < argc; i++ ) {
        kill( atoi( argv[i] ), 1 );
    } return 0;
  } else {
      perror( "kill" );
      return 1; 
  }
}
