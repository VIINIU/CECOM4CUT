#include "image_process.h"

void	write_1bit_bmp(const char *filename, unsigned char *image_buffer, int width, int height)
{
    FILE *file = fopen(filename, "wb");
    if (!file)
	{
        fprintf(stderr, "Failed to open file for writing\n");
        exit(1);
    }

    int padded_width = (width + 31) / 32 * 4;
    int filesize = 54 + padded_width * height;

    unsigned char bmpfileheader[14] = {
        'B', 'M',
        filesize & 0xFF, (filesize >> 8) & 0xFF, (filesize >> 16) & 0xFF, (filesize >> 24) & 0xFF,
        0, 0, 0, 0,
        54, 0, 0, 0
    };

    unsigned char bmpinfoheader[40] = {
        40, 0, 0, 0,
        width & 0xFF, (width >> 8) & 0xFF, (width >> 16) & 0xFF, (width >> 24) & 0xFF,
        height & 0xFF, (height >> 8) & 0xFF, (height >> 16) & 0xFF, (height >> 24) & 0xFF,
        1, 0, 1, 0,
        0, 0, 0, 0,
        padded_width * height & 0xFF, (padded_width * height >> 8) & 0xFF, (padded_width * height >> 16) & 0xFF, (padded_width * height >> 24) & 0xFF,
        0x13, 0x0B, 0, 0, 0x13, 0x0B, 0, 0,
        2, 0, 0, 0, 2, 0, 0, 0
    };

    unsigned char color_palette[8] = { 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00 };

    fwrite(bmpfileheader, 1, 14, file);
    fwrite(bmpinfoheader, 1, 40, file);
    fwrite(color_palette, 1, 8, file);

    unsigned char *bmp_buffer = (unsigned char *)calloc(padded_width, 1);
    for (int y = 0; y < height; y++)
	{
        memset(bmp_buffer, 0, padded_width);
        for (int x = 0; x < width; x++)
		{
            int byte_idx = x / 8;
            int bit_idx = 7 - (x % 8);
            unsigned char pixel = image_buffer[(height - y - 1) * width + x];
            if (pixel < 128)
                bmp_buffer[byte_idx] |= (1 << bit_idx);
        }
        fwrite(bmp_buffer, 1, padded_width, file);
    }

    free(bmp_buffer);
    fclose(file);
}

unsigned char *resize_image(unsigned char *image_buffer, int orig_width, int orig_height, int new_width, int *new_height)
{
    *new_height = orig_height * new_width / orig_width;
    unsigned char *resized_buffer = (unsigned char *)malloc(new_width * (*new_height) * sizeof(unsigned char));

    for (int y = 0; y < *new_height; y++)
	{
        for (int x = 0; x < new_width; x++)
		{
            int orig_x = x * orig_width / new_width;
            int orig_y = y * orig_height / *new_height;
            resized_buffer[y * new_width + x] = image_buffer[orig_y * orig_width + orig_x];
        }
    }

    return resized_buffer;
}
