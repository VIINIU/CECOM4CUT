CC	= gcc
CFLAGS	= -Wall -Wextra -Werror

TARGET	= image_process
SRCS	= main.c
OBJS	= $(SRCS:.c=.o)

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) -o $(TARGET) $(OBJS)

$(OBJS): $(SRCS)
	$(CC) -c $(SRCS)

clean:
	rm -rf $(OBJS)

fclean: clean
	rm -rf $(TARGET)

re: fclean all

#.PHONY clean fclean re $(TARGET)
