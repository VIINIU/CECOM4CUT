CC		= gcc
CFLAGS	= -Wall -Wextra -Werror

TARGET	= image_process
SRCS	= main.c image_process.c
OBJS	= $(SRCS:.c=.o)
LIBS	= -ljpeg

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) -o $(TARGET) $(OBJS) $(LIBS)

$(OBJS): $(SRCS)
	$(CC) -c $(SRCS)

clean:
	rm -rf $(OBJS)

fclean: clean
	rm -rf $(TARGET)

re: fclean all

#.PHONY clean fclean re $(TARGET)
