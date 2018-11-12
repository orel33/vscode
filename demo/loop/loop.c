#include <unistd.h>
#include <stdio.h>

int main(int argc, char const *argv[])
{
    int i = 1;
    while (1)
    {
        printf("tempus fugit... %d sec\n", i);
        sleep(1);
        i++;
    }

    return 0;
}
