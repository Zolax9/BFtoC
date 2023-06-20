#!/bin/zsh

if [ "$1" = "debug" ] || [ "$1" = "release" ]; then
  cp inp.bf bin/$1
  cd bin/$1
  echo Translating Brainfuck to C code
  ./BFtoC-$1
  echo Compiling C code
  gcc -o out-$1 out.c
  chmod +x out-$1
  mv out-$1 ../../
  echo Binary compiled!
else
    echo "ERROR: Directory '$1' does not exist!"
fi
exit
