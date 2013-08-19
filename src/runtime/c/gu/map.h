#ifndef GU_MAP_H_
#define GU_MAP_H_

#include <gu/hash.h>
#include <gu/mem.h>
#include <gu/exn.h>
#include <gu/enum.h>

typedef struct GuMapItor GuMapItor;

struct GuMapItor {
	void (*fn)(GuMapItor* self, const void* key, void* value,
		   GuExn *err);
};

typedef struct GuMap GuMap;

GuMap*
gu_make_map(size_t key_size, GuHasher* hasher,
	    size_t value_size, const void* default_value,
	    GuPool* pool);

#define gu_new_map(K, HASHER, V, DV, POOL)			\
	(gu_make_map(sizeof(K), (HASHER), sizeof(V), (DV), (POOL)))

#define gu_new_set(K, HASHER, POOL)			\
	(gu_make_map(sizeof(K), (HASHER), 0, NULL, (POOL)))

#define gu_new_addr_map(K, V, DV, POOL)				\
	(gu_make_map(0, NULL, sizeof(V), (DV), (POOL)))

size_t
gu_map_count(GuMap* map);

void*
gu_map_find_full(GuMap* ht, void* key_inout);

const void*
gu_map_find_default(GuMap* ht, const void* key);

#define gu_map_get(MAP, KEYP, V)		\
	(*(V*)gu_map_find_default((MAP), (KEYP)))

void*
gu_map_find(GuMap* ht, const void* key);

#define gu_map_set(MAP, KEYP, V, VAL)				\
	GU_BEGIN						\
	V* gu_map_set_p_ = gu_map_find((MAP), (KEYP));		\
	*gu_map_set_p_ = (VAL);					\
	GU_END

const void*
gu_map_find_key(GuMap* ht, const void* key);

bool
gu_map_has(GuMap* ht, const void* key);

void*
gu_map_insert(GuMap* ht, const void* key);

#define gu_map_put(MAP, KEYP, V, VAL)				\
	GU_BEGIN						\
	V* gu_map_put_p_ = gu_map_insert((MAP), (KEYP));	\
	*gu_map_put_p_ = (VAL);					\
	GU_END

void
gu_map_iter(GuMap* ht, GuMapItor* itor, GuExn* err);

typedef struct {
	const void* key;
	void* value;
} GuMapKeyValue;

GuEnum*
gu_map_enum(GuMap* ht, GuPool* pool);

typedef GuMap GuIntMap;

#define gu_new_int_map(VAL_T, DEFAULT, POOL)		\
	gu_new_map(int, gu_int_hasher, VAL_T, DEFAULT, POOL)


#if defined(GU_TYPE_H_) && !defined(GU_MAP_H_TYPE_)
#define GU_MAP_H_TYPE_

extern GU_DECLARE_KIND(GuMap);

typedef const struct GuMapType GuMapType, GuType_GuMap;

struct GuMapType {
	GuType_abstract abstract_base;
	GuHasher* hasher;
	GuType* key_type;
	GuType* value_type;
	const void* default_value;
};

GuMap*
gu_map_type_make(GuMapType* mtype, GuPool* pool);

#define gu_map_type_new(MAP_T, POOL)			\
	gu_map_type_make(gu_type_cast(gu_type(MAP_T), GuMap), (POOL))

#define GU_TYPE_INIT_GuMap(k_, t_, kt_, h_, vt_, dv_)			\
	{								\
		.abstract_base = GU_TYPE_INIT_abstract(k_, t_, _),	\
		.hasher = h_,						\
		.key_type = kt_,					\
		.value_type = vt_,					\
		.default_value = dv_					\
	}

#define gu_type__GuIntMap gu_type__GuMap

typedef GuType_GuMap GuType_GuIntMap;

#define GU_TYPE_INIT_GuIntMap(KIND, MAP_T, VAL_T, DEFAULT)	\
	GU_TYPE_INIT_GuMap(KIND, MAP_T, gu_type(int), gu_int_hasher,	\
			   VAL_T, DEFAULT)

#endif

#endif // GU_MAP_H_
