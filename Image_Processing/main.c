#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "image_process.h"

FILE    *open_file(char *filename);
void    exit_err(char *msg);

int main(int argc, char **argv)
{
    char    *org_file_name;
    char    *res_file_name;
    FILE    *org_file;
    FILE    *res_file;

    if (argc != 3)
        exit_err("usage: ./image_process <original file> <result file>");
    org_file_name = strdup(argv[1]);
    res_file_name = strdup(argv[2]);
	printf("Original Filename: %s / Result Filename: %s\n", org_file_name, res_file_name);
    org_file = open_file(org_file_name);
    if (org_file == NULL)
        exit_err("Failed to open original file.");
    free(org_file_name);
    free(res_file_name);
	return (0);
}

FILE    *open_file(char *filename)
{
    FILE *tmp_file;

    tmp_file = fopen(filename, "rb");
    return tmp_file;
}

void    exit_err(char *msg)
{
    fprintf(stderr, "Error: msg\n");
    exit(1);
}