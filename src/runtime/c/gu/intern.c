#include "intern.h"

struct GuIntern {
	GuPool* str_pool;
	GuMap* map;
};

GuIntern*
gu_new_intern(GuPool* str_pool, GuPool* pool)
{
	GuIntern* intern = gu_new(GuIntern, pool);
	intern->str_pool = str_pool;
	intern->map = gu_new_set(const char*, gu_str_hasher, pool);
	return intern;
}

const char*
gu_intern_str(GuIntern* intern, const char* cstr)
{
	const char* const* strp = gu_map_find_key(intern->map, &cstr);
	if (strp) {
		return *strp;
	}
	const char* str = gu_strdup(cstr, intern->str_pool);
	gu_map_insert(intern->map, &str);
	return str;
}




struct GuSymTable {
	GuPool* sym_pool;
	GuMap* map;
};

GuSymTable*
gu_new_symtable(GuPool* sym_pool, GuPool* pool)
{
	GuSymTable* tab = gu_new(GuSymTable, pool);
	tab->sym_pool = sym_pool;
	tab->map = gu_new_set(GuSymbol, gu_string_hasher, pool);
	return tab;
}

GuSymbol
gu_symtable_intern(GuSymTable* tab, GuString string)
{
	if (gu_string_is_stable(string)) {
		return string;
	}
	const GuSymbol* symp = gu_map_find_key(tab->map, &string);
	if (symp) {
		return *symp;
	}
	GuSymbol sym = gu_string_copy(string, tab->sym_pool);
	gu_map_insert(tab->map, &sym);
	return sym;
}
