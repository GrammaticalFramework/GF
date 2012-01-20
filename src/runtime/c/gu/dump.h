#ifndef GU_DUMP_H_
#define GU_DUMP_H_

#include <gu/defs.h>
#include <gu/yaml.h>
#include <gu/type.h>
#include <gu/map.h>

typedef struct GuDump GuDump;

struct GuDump {
	GuPool* pool;
	GuYaml* yaml;
	GuMap* data;
	GuTypeMap* dumpers;
	bool print_address;
};

typedef void (*GuDumpFn)(GuFn* self, GuType* type, const void* value, GuDump* ctx);

GuDump*
gu_new_dump(GuWriter* wtr, GuTypeTable* dumpers, GuExn* err, GuPool* pool);

void
gu_dump(GuType* type, const void* value, GuDump* ctx);

void
gu_dump_stderr(GuType* type, const void* value, GuExn* err);

extern GuTypeTable
gu_dump_table;


#endif // GU_DUMP_H_
