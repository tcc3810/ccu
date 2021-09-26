SHELL = /bin/bash
CC = gcc
CFLAGS = -g -lm -pthread
SRC = $(wildcard *.c)
EXE = $(patsubst %.c, %, $(SRC))

all: ${EXE}

%:	%.c
	${CC} ${CFLAGS} $@.c -o $@ -lm

clean:
	rm ${EXE}

