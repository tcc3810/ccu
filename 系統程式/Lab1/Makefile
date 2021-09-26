TARGET=shell

$(TARGET): fig1_10.o error.o
	$(CC) -o $@ $^ 

fig1_10.o: fig1_10.c
error.o: error.c

clean:
	rm -f fig1_10.o error.o $(TARGET)
