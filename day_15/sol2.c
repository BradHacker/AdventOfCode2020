#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
  int *values = (int *)malloc(sizeof(int) * 30000000);
  for (int i = 0; i < 30000000; i++)
  {
    values[i] = -1;
  }
  int speaking = -1;
  int nextNumber = -1;
  int turnNumber = 1;

  for (int i = 1; i < argc; i++)
  {
    speaking = atoi(argv[i]);
    values[speaking] = turnNumber;
    turnNumber++;
  }

  printf("Imported %d starting numbers\nGenerating numbers...\n", argc - 1);

  nextNumber = 0;
  while (turnNumber < 30000000)
  {
    speaking = nextNumber;
    if (values[speaking] != -1)
    {
      nextNumber = turnNumber - values[speaking];
    }
    else
    {
      nextNumber = 0;
    }
    values[speaking] = turnNumber;
    turnNumber++;
  }

  printf("The %dth value is %d\n", turnNumber, nextNumber);

  free(values);
}