DBGEXE:=BFtoC-debug
RELEXE:=BFtoC-release
DBGOBJDIR:=obj/debug
RELOBJDIR:=obj/release

CFLAGS:= -pedantic -Wall -Wextra
CFLAGS+= -std=c99 -I ./include

SRC:=$(wildcard src/*.c)
INC:=$(wildcard include/*.h)
DBGOBJ:=$(SRC:src/%.c=obj/debug/%.o)
RELOBJ:=$(SRC:src/%.c=obj/release/%.o)

CC=gcc

.PHONY: all debug release clean style

all: debug release

debug:CFLAGS+= -g
release: CFLAGS+= -O3

debug: $(DBGOBJ)
	$(CC) $(DBGOBJ) -o bin/debug/$(DBGEXE)

release: $(RELOBJ)
	$(CC) $(RELOBJ) -o bin/release/$(RELEXE)

$(DBGOBJDIR)/%.o : src/%.c
	$(CC) $(CFLAGS) -c $< -o $@

$(RELOBJDIR)/%.o : src/%.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm obj/debug/* obj/release/* $(DBGEXE) $(RELEXE) -f

style: $(SRC) $(INC)
	astyle -A10 -s4 -S -p -xg -j -z2 -n src/* include/*
