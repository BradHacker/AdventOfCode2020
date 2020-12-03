#include <stdlib.h>
#include <stdio.h>

int main()
{
  FILE* fp;
  char* line = NULL;
  size_t len = 0;
  ssize_t read;

  fp = fopen("input.txt", "r");
  if (fp == NULL)
    exit(EXIT_FAILURE);

  int x = 0;

  int num_trees = 0;

  while ((read = getline(&line, &len, fp)) != -1) {
    if (feof(fp))
      break;

    if (line[x] == '#') {
      num_trees++;
      line[x] = '0';
    } else {
      line[x] = 'X';
    }
    
    printf("%s", line);

    x = (x + 3) % 31;
  }

  printf("\nHit %d trees\n", num_trees);

  fclose(fp);
  if (line)
    free(line);
  return 0;
}