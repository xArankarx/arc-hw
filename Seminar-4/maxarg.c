#include <limits.h>
#include <stdio.h>

char checkMultOverflow(unsigned long long val1, int val2) {
	for (int i = 2; i <= val2; ++i) {
		if (val1 * i < val1) {
			return 1;
		}
	}
	return 0;
}

int factorial (int n) {
  return (n < 2) ? 1 : n * factorial (n - 1);
}

int main() {
    unsigned long long fact = 1;
    int i = 2;
    for (; i <= INT_MAX; ++i) {
    	if (checkMultOverflow(fact, i)) {
    		break;
    	}
    	fact *= i;
    }
    printf("Максимальное значение аргумента: %d", i - 1);
    return 0;
}
