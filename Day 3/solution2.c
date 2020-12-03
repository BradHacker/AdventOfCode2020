#include <stdlib.h>
#include <stdio.h>

int main(int argc, char* argv[])
{
  if (argc % 2 != 1) {
    printf("USAGE: ./sol2 [Slope X 1] [Slope Y 1] [Slope X 2] [Slope Y 2] [...]\n");
    exit(EXIT_SUCCESS);
  }

  FILE* fp;
  char* line = NULL;
  size_t len = 0;
  ssize_t read;

  int num_slopes = (argc - 1) / 2;
  int* trees = (int*)malloc(sizeof(int) * num_slopes);
  int* locations = (int*)malloc(sizeof(int) * num_slopes);
  int* xSlopes = (int*)malloc(sizeof(int) * num_slopes);
  int* ySlopes = (int*)malloc(sizeof(int) * num_slopes);

  for (int a = 0; a < num_slopes; a++) {
    xSlopes[a] = atoi(argv[a * 2 + 1]);
    ySlopes[a] = atoi(argv[a * 2 + 2]);
  }

  fp = fopen("input.txt", "r");
  if (fp == NULL)
    exit(EXIT_FAILURE);

  int line_num = 0;
  int num_trees = 0;

  while ((read = getline(&line, &len, fp)) != -1) {
    if (feof(fp))
      break;
    
    for (int i = 0; i < num_slopes; i++) {
      if (line_num % ySlopes[i] == 0) {
        if (line[locations[i]] == '#')
          trees[i]++;
        locations[i] = (locations[i] + xSlopes[i]) % 31;
      }
    }
    line_num++;
  }

  int product = 1;
  for (int i = 0; i < num_slopes; i++) {
    printf("Right %d, down %d\n", xSlopes[i], ySlopes[i]);
    printf("Hit %d trees\n-----\n", trees[i]);
    product *= trees[i];
  }

  printf("Product: %d\n", product);

  free(trees);
  free(locations);
  free(xSlopes);
  free(ySlopes);
  fclose(fp);
  if (line)
    free(line);
  return 0;
}