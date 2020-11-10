#include <stdio.h>

int main( int argc, char *argv[] ) {
  int linhas = 0;
  if ( argc == 2 ) {
    static int c;
    FILE *f = fopen( argv[1], "r" );
    if ( f ) {
      while (( c = getc( f )) != EOF ) {      
	if ( c == '\n' ) { linhas++; }
	if ( linhas < 10 ) { putchar( c ); }
      } printf( "\n" );
      fclose( f ); 
    } else {
      perror( "head" );
    } 
  } return 0;
}
    
