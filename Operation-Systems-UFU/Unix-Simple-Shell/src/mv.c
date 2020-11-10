#include <stdio.h>

int main( int argc, char *argv[] ) {
  if ( argc == 3 ) {
      static char c;
      FILE *file1 = fopen( argv[1], "r" );
      FILE *file2 = fopen( argv[2], "w" );
      if ( file1 ) {
      	while ((c = fgetc( file1 )) != EOF ) {
	  fputc( c, file2 );
	} fclose( file1 );
     	fclose( file2 );
      	remove( argv[1] ); }
  } else {
    perror( "mv" );
  } return 0;
}
