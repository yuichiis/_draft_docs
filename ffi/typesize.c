#include <stdio.h>

typedef enum _TestEnum {
    A = 1,
    B = 2,
    C = 3,
} TestEnum;

void main(int ac, char *av[])
{
    TestEnum a;
    printf("size=%zd\n",sizeof(a));
    printf("bit=%zd\n",sizeof(a)*8);
}