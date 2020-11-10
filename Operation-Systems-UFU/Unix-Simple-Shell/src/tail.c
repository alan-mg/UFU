
#include <stdio.h>

int main( int argc, char *argv[] ) {
  int linhas = 0;
  int linhas_ref = 0;
  if ( argc == 2 ) {
    static int c;
    FILE *f = fopen( argv[1], "r" );
    if ( f ) {
      while (( c = getc( f )) != EOF ) {      
	if ( c == '\n' ) { linhas++; }
      } rewind( f );
      printf( "\x1b[0;72A" );
      while (( c = getc( f )) != EOF ) {      
	if ( c == '\n' ) { linhas_ref++; }
	if ( linhas_ref > ( linhas - 11 )) { putchar( c ); }
      } fclose( f ); 
    } else {
      perror( "tail" ); }
  } return 0;
}
