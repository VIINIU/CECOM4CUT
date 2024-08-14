#ifndef CECOM4CUT_IMAGE_PROCESS_H
# define CECOM4CUT_IMAGE_PROCESS_H

# include <stdio.h>
# include <stdlib.h>
# include <string.h>

# include <jpeglib.h>

# define FALSE 0
# define TRUE 1
# define RESULT_WIDTH 320

struct jpeg_decompress_struct   cinfo;
struct jpeg_error_mgr           jerr;

void			write_1bit_bmp(FILE *res_file, unsigned char *image_buffer, int width, int height);
unsigned char	*resize_image(unsigned char *image_buffer, int *org_width, int *org_height, int new_width, int *new_height);

#endif
