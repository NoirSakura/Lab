lab2:src/lab2.y src/lab2.l
	bison -d -o src/lab2syx.c src/lab2.y
	flex -o src/lab2lex.c src/lab2.l
	gcc -Wall -o bin/lab2 src/lab2syx.c src/lab2lex.c -lfl 
clean:
	rm src/lab2lex.c
	rm src/lab2syx.h
	rm src/lab2syx.c
	rm bin/lab2