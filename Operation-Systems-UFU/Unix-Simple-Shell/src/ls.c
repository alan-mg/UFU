#include <stdio.h>
#include <dirent.h>

int main( int argc, char *argv[] ) {
  struct dirent *d;
  DIR *dr = opendir( argv[1] );
  if ( dr == NULL ) {
    dr = opendir( "." );
    while (( d = readdir( dr )) != NULL ) {
      printf( "%s\n", d->d_name ); } 
  } else {
    while (( d = readdir( dr )) != NULL ) {
    printf( "%s  ", d->d_name );
  } printf( "\n" );
    closedir( dr );
  } return 0;
}
