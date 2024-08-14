#include <stdio.h>

extern void* cmapcc_new(void);
extern void cmapcc_delete(void *obj);
extern void cmapcc_hello(void *obj);

int main(int ac, char *av[])
{
    printf("Hello C!\n");
    void *h = cmapcc_new();
    cmapcc_hello(h);
    cmapcc_delete(h);
    return 0;
}
