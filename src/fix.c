#include <stdio.h>

main() {
   int c;
   while((c = getchar()) != EOF) {
        if (c != 0342 && c != 0206) {
	   if (c == 0220)
	      c = '_';
	   else if (c == 0221) 
	      c = '^';
	   putchar(c);
        }
   }
}

