#include <stdio.h>
#include <unistd.h>

int main( int argc, char *argv[] ) {
  if ( argc == 2 ) {
    chdir( argv[1] );
  } else {
    perror( "cd" );
  } return 0;
}

// Muda apenas o diretório para este processo, então quando executado
// por si só não muda o diretório do shell atual.
// Mas executado dentro deste shell, ele vai mudar, mas quando o shell
// é encerrado, iremos voltar onde o shell estava
