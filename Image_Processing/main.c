#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char **argv)
{
    char    *org_file_name;
    char    *res_file_name;

    if (argc != 3)
    {
        fprintf(stderr, "usage: ./image_process <original file> <result file>");
        return (1);
    }
    org_file_name = strdup(argv[1]);
    res_file_name = strdup(argv[2]);
	printf("Original Filename: %s / Result Filename: %s\n", org_file_name, res_file_name);
    free(org_file_name);
    free(res_file_name);
	return (0);
}
