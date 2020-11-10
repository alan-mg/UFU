#include <stdio.h>

int main( int argc, char *argv[] ) {
  int linhas = 0;
  if ( argc == 2 ) {
    static int c;
    FILE *f = fopen( argv[1], "r" );
    if ( f ) {
      while (( c = getc( f )) != EOF ) {      
	if ( c == '\n' ) { linhas++; }
      } fclose( f ); 
    } else {
      perror( "lc" );
    } printf( "%d\n", linhas );
  } return 0;
}
    
