#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/wait.h>

#define VERDE "\x1b[32m"
#define BRANCO "\x1b[0m"
#define TOK_TAMANHOBUFFER 64
#define TOK_DELIM " \t\r\n\a"

char *ler_linha( void );
char *dividir_linha( char *linha );
int executar( char **args );


//Parse
int main( void ) {
  int rodando = 1;
  int status;
  char *linha;
  char **args;
  while( rodando ) {
    printf( VERDE "$ " BRANCO);
    linha = ler_linha();
    args = dividir_linha( linha );
    status = executar( args );
    if ( strcmp( args[0], "exit" ) == 0 ) { rodando = 0; }
    free( linha );
    free( args );
  } return 0;
}

char *ler_linha( void ) {
  char *linha = NULL;
  ssize_t tamanho_buffer = 0;
  getline( &linha, &tamanho_buffer, stdin );
  return linha;
}

char *dividir_linha( char *linha ) {
  int tamanho_buffer = TOK_TAMANHOBUFFER, pos = 0;
  char **tokens = malloc( tamanho_buffer * sizeof( char* ));
  char *token;
  token = strtok( linha, TOK_DELIM );
  while ( token != NULL ) {
    tokens[pos] = token;
    pos++;
    if ( pos >= tamanho_buffer ) {
      tamanho_buffer += TOK_TAMANHOBUFFER;
      tokens = realloc( tokens, tamanho_buffer * sizeof( char* ));
    } token = strtok( NULL, TOK_DELIM );
  } tokens[pos] = NULL;
  return tokens;
}

int executar( char **args ) {
  pid_t pid, wpid;
  int status;
  pid = fork();
  if ( pid == 0 ) {
    if ( execvp( args[0], args ) == -1 ) {}
  } else {     
    while ( !WIFEXITED( status ) && !WIFSIGNALED( status )); {
      wpid = waitpid( pid, &status, WUNTRACED ); }
  } return 1;
}

