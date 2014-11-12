#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
  float f1, f2, f3, f4;
  char* s1[256]; 

  float total_energy = 0;
  float prev_time=0;
  float prev_power=0;
  float start_time = atof(argv[2]);
  float end_time = atof(argv[2]) + atof(argv[3]);

  FILE *fp;
  fp = fopen(argv[1], "r");

  fscanf(fp, "%s %s %s %s %s %s %s %s %s %s %s", s1, s1, s1, s1, s1, s1, s1, s1, s1, s1, s1); 

  while (fscanf(fp, "%g,%g,%g,%g\n", &f1, &f2, &f3, &f4) == 4) { 
     if (f1 > start_time) {
         if (f1 <= end_time)
             total_energy += ((f1 - prev_time) * (f3 + prev_power));    
         else
             break;
     }
     prev_time = f1;
     prev_power = f3;
  }

  printf("Total energy consumption: %g Joule\n", total_energy / 2000.0);

}
