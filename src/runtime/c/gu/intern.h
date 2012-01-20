#ifndef GU_INTERN_H_
#define GU_INTERN_H_

#include <gu/map.h>
#include <gu/str.h>
#include <gu/string.h>

typedef struct GuIntern GuIntern;

GuIntern* gu_new_intern(GuPool* str_pool, GuPool* pool);
const char* gu_intern_str(GuIntern* intern, const char* cstr);


typedef struct GuSymTable GuSymTable;

typedef GuString GuSymbol;

GuSymTable*
gu_new_symtable(GuPool* sym_pool, GuPool* pool);

GuSymbol
gu_symtable_intern(GuSymTable* symtab, GuString string);

#endif /* GU_INTERN_H_ */
