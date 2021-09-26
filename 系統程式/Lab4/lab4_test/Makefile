TARGET=fig4_22
test:$(TARGET)
	bash createFile.sh
	./$(TARGET) `cat /tmp/${USER}/esllab20140411.sp`

$(TARGET): fig4_22.c error.c path_alloc.c
	gcc $^ -o $@

clean:
	rm -f fig4_22
