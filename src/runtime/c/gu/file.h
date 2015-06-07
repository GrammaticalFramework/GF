#ifndef GU_FILE_H_
#define GU_FILE_H_

#include <gu/in.h>
#include <gu/out.h>
#include <stdio.h>

GuOut*
gu_file_out(FILE* file, GuPool* pool);

GuIn* 
gu_file_in(FILE* file, GuPool* pool);

#endif // GU_FILE_H_
