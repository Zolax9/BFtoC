#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main()
{
    char inp[65536];
    FILE* f_inp = fopen("inp.bf", "r");
    FILE* f_out = fopen("out.c", "w");

    fgets(inp, 65536, f_inp);
    fclose(f_inp);

    fputs("#include <stdlib.h>\n#include <stdio.h>\n#include <string.h>\nint main() { unsigned int *mem = malloc(256 * sizeof(unsigned int)); memset(mem, 0, 256 * sizeof(unsigned int)); size_t pointer = 0; ", f_out);
    size_t i = 0;

    while (inp[i] != '!')
    {
        switch (inp[i])
        {
            case '<':
                fputs("pointer = pointer == 0 ? 255 : pointer - 1; ", f_out);
                break;

            case '>':
                fputs("pointer = pointer == 255 ? 0 : pointer + 1; ", f_out);
                break;

            case '+':
                fputs("mem[pointer] = mem[pointer] == 65535 ? 0 : ++mem[pointer]; ", f_out);
                break;

            case '-':
                fputs("mem[pointer] = mem[pointer] == 0 ? 65535 : --mem[pointer]; ", f_out);
                break;

            case '[':
                fputs("while (mem[pointer] != 0) { ", f_out);
                break;

            case ']':
                fputs("} ", f_out);
                break;

            case ',':
                fputs("scanf(\"\\n%c\", &mem[pointer]); ", f_out);
                break;

            case '.':
                fputs("printf(\"%c\", mem[pointer]); ", f_out);
                break;
        }
        ++i;
    }

    fputs("};\n", f_out);
    fclose(f_out);
};
