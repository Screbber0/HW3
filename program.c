#include <stdio.h>
#include <math.h>

long factorial(int x) {
    long sum = 1;
    for (int i = 1; i <= x; ++i) {
        sum *= i;
    }
    return sum;
}

void printResult(double x, int m) {
    double exact = pow((1 + x), m);
    double result = 0;
    int i = 0;
    while (exact - result > 0.001 * exact) {
        int coefficient = 1;
        for (int j = m; j >= m - i + 1; --j) {
            coefficient *= j;
        }
        result += coefficient * pow(x, i) / factorial(i);
        ++i;
    }
    printf("%lf", result);
}

int main() {
    double x;
    int m;
    scanf("%lf", &x);
    scanf("%d", &m);
    printResult(x, m);
}
