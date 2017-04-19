#include <gu/defs.h>
#include <gu/mem.h>
#include <gu/map.h>
#include <gu/assert.h>
#include <gu/prime.h>
#include <gu/string.h>

typedef struct GuMapData GuMapData;

struct GuMapData {
	uint8_t* keys;
	uint8_t* values;
	size_t n_occupied;
	size_t n_entries;
	size_t zero_idx;
};

struct GuMap {
	GuHasher* hasher;
	size_t key_size;
	size_t value_size;
	const void* default_value;
	GuMapData data;
	
	GuFinalizer fin;
};

static void
gu_map_finalize(GuFinalizer* fin)
{
	GuMap* map = gu_container(fin, GuMap, fin);
	gu_mem_buf_free(map->data.keys);
	if (map->value_size) {
		gu_mem_buf_free(map->data.values);
	}
}

static const GuWord gu_map_empty_key = 0;

static bool
gu_map_buf_is_zero(const uint8_t* p, size_t sz) {
	while (sz >= sizeof(GuWord)) {
		sz -= sizeof(GuWord);
		if (memcmp(&p[sz], &gu_map_empty_key, sizeof(GuWord)) != 0) {
			return false;
		}
	}
	return (memcmp(p, &gu_map_empty_key, sz) == 0);
}

static bool
gu_map_entry_is_free(GuMap* map, GuMapData* data, size_t idx)
{
	if (idx == data->zero_idx) {
		return false;
	} else if (map->hasher == gu_addr_hasher) {
		const void* key = ((const void**)data->keys)[idx];
		return key == NULL;
	} else if (map->hasher == gu_word_hasher) {
		GuWord key = ((GuWord*)data->keys)[idx];
		return key == 0;
	} else if (map->hasher == gu_string_hasher) {
		GuString key = ((GuString*)data->keys)[idx];
		return key == NULL;
	}
	const void* key = &data->keys[idx * map->key_size];
	return gu_map_buf_is_zero(key, map->key_size);
}

static bool
gu_map_lookup(GuMap* map, const void* key, size_t* idx_out)
{
	size_t n = map->data.n_entries;
	if (map->hasher == gu_addr_hasher) {
		GuHash hash = (GuHash) key;
		size_t idx = hash % n;
		size_t offset = (hash % (n - 2)) + 1;
		while (true) {
			const void* entry_key =
				((const void**)map->data.keys)[idx];
			if (entry_key == NULL && map->data.zero_idx != idx) {
				*idx_out = idx;
				return false;
			} else if (entry_key == key) {
				*idx_out = idx;
				return true;
			}
			idx = (idx + offset) % n;
		}
	} else if (map->hasher == gu_word_hasher) {
		GuWord w = *(const GuWord*)key;
		GuHash hash = (GuHash) w;
		size_t idx = hash % n;
		size_t offset = (hash % (n - 2)) + 1;
		while (true) {
			GuWord entry_key = ((GuWord*)map->data.keys)[idx];
			if (entry_key == 0 && map->data.zero_idx != idx) {
				*idx_out = idx;
				return false;
			} else if (entry_key == w) {
				*idx_out = idx;
				return true;
			}
			idx = (idx + offset) % n;
		}
	} else if (map->hasher == gu_string_hasher) {
		GuHasher* hasher = map->hasher;
		GuEquality* eq = (GuEquality*) hasher;
		GuHash hash = hasher->hash(hasher, key);
		size_t idx = hash % n;
		size_t offset = (hash % (n - 2)) + 1;
		while (true) {
			GuString entry_key =
				((GuString*)map->data.keys)[idx];
			if (entry_key == NULL && map->data.zero_idx != idx) {
				*idx_out = idx;
				return false;
			} else if (eq->is_equal(eq, key, entry_key)) {
				*idx_out = idx;
				return true;
			}
			idx = (idx + offset) % n;
		}
	} else {
		GuHasher* hasher = map->hasher;
		GuEquality* eq = (GuEquality*) hasher;
		GuHash hash = hasher->hash(hasher, key);
		size_t idx = hash % n;
		size_t offset = (hash % (n - 2)) + 1;
		size_t key_size = map->key_size;
		while (true) {
			void* entry_key = &map->data.keys[idx * key_size];
			if (gu_map_buf_is_zero(entry_key, key_size) &&
			    map->data.zero_idx != idx) {
				*idx_out = idx;
				return false;
			} else if (eq->is_equal(eq, key, entry_key)) {
				*idx_out = idx;
				return true;
			}
			idx = (idx + offset) % n;
		}
	}

	gu_impossible();
	return false;
}
	

static void
gu_map_resize(GuMap* map, size_t req_entries)
{
	GuMapData* data = &map->data;
	GuMapData old_data = *data;

	size_t key_size = map->key_size;
	size_t key_alloc = 0;
	data->keys = gu_mem_buf_alloc(req_entries * key_size, &key_alloc);

	size_t value_size = map->value_size;
	size_t value_alloc = 0;
	if (value_size) {
		data->values = gu_mem_buf_alloc(req_entries * value_size,
						    &value_alloc);
		memset(data->values, 0, value_alloc);
	}
	
	data->n_entries = gu_twin_prime_inf(value_size ?
					    GU_MIN(key_alloc / key_size,
						   value_alloc / value_size)
					    : key_alloc / key_size);
	if (map->hasher == gu_addr_hasher) {
		for (size_t i = 0; i < data->n_entries; i++) {
			((const void**)data->keys)[i] = NULL;
		}
	} else if (map->hasher == gu_string_hasher) {
		for (size_t i = 0; i < data->n_entries; i++) {
			((GuString*)data->keys)[i] = NULL;
		}
	} else {
		memset(data->keys, 0, key_alloc);
	}

	gu_assert(data->n_entries > data->n_occupied);
	
	data->n_occupied = 0;
	data->zero_idx = SIZE_MAX;

	for (size_t i = 0; i < old_data.n_entries; i++) {
		if (gu_map_entry_is_free(map, &old_data, i)) {
			continue;
		}
		void* old_key = &old_data.keys[i * key_size];
		if (map->hasher == gu_addr_hasher) {
			old_key = *(void**)old_key;
		} else if (map->hasher == gu_string_hasher) {
			old_key = (void*) *(GuString*)old_key;
		}
		void* old_value = &old_data.values[i * value_size];

		memcpy(gu_map_insert(map, old_key),
		       old_value, map->value_size);
	}

	gu_mem_buf_free(old_data.keys);
	if (value_size) {
		gu_mem_buf_free(old_data.values);
	}
}


static bool
gu_map_maybe_resize(GuMap* map)
{
	if (map->data.n_entries <=
	    map->data.n_occupied + (map->data.n_occupied / 4)) {
		size_t req_entries =
			gu_twin_prime_sup(GU_MAX(11, map->data.n_occupied * 4 / 3 + 1));
		gu_map_resize(map, req_entries);
		return true;
	}
	return false;
}

GU_API void*
gu_map_find(GuMap* map, const void* key)
{
	size_t idx;
	bool found = gu_map_lookup(map, key, &idx);
	if (found) {
		return &map->data.values[idx * map->value_size];
	}
	return NULL;
}

GU_API const void*
gu_map_find_default(GuMap* map, const void* key)
{
	void* p = gu_map_find(map, key);
	return p ? p : map->default_value;
}

GU_API const void*
gu_map_find_key(GuMap* map, const void* key)
{
	size_t idx;
	bool found = gu_map_lookup(map, key, &idx);
	if (found) {
		return &map->data.keys[idx * map->key_size];
	}
	return NULL;
}

GU_API bool
gu_map_has(GuMap* ht, const void* key)
{
	size_t idx;
	return gu_map_lookup(ht, key, &idx);
}

GU_API void*
gu_map_insert(GuMap* map, const void* key)
{
	size_t idx;
	bool found = gu_map_lookup(map, key, &idx);
	if (!found) {
		if (gu_map_maybe_resize(map)) {
			found = gu_map_lookup(map, key, &idx);
			gu_assert(!found);
		}
		if (map->hasher == gu_addr_hasher) {
			((const void**)map->data.keys)[idx] = key;
		} else if (map->hasher == gu_string_hasher) {
			((GuString*)map->data.keys)[idx] = key;
		} else {
			memcpy(&map->data.keys[idx * map->key_size],
			       key, map->key_size);
		}
		if (map->default_value) {
			memcpy(&map->data.values[idx * map->value_size],
			       map->default_value, map->value_size);
		}
		if (gu_map_entry_is_free(map, &map->data, idx)) {
			gu_assert(map->data.zero_idx == SIZE_MAX);
			map->data.zero_idx = idx;
		}
		map->data.n_occupied++;
	}
	return &map->data.values[idx * map->value_size];
}

GU_API void
gu_map_iter(GuMap* map, GuMapItor* itor, GuExn* err)
{
	for (size_t i = 0; i < map->data.n_entries && gu_ok(err); i++) {
		if (gu_map_entry_is_free(map, &map->data, i)) {
			continue;
		}
		const void* key = &map->data.keys[i * map->key_size];
		void* value = &map->data.values[i * map->value_size];
		if (map->hasher == gu_addr_hasher) {
			key = *(const void* const*) key;
		} else if (map->hasher == gu_string_hasher) {
			key = *(GuString*) key;
		}
		itor->fn(itor, key, value, err);
	}
}

typedef struct {
	GuEnum en;
	GuMap* ht;
	size_t i;
	GuMapKeyValue x;
} GuMapEnum;

static void
gu_map_enum_next(GuEnum* self, void* to, GuPool* pool)
{
	*((GuMapKeyValue**) to) = NULL;

	size_t i;
	GuMapEnum* en = (GuMapEnum*) self;
	for (i = en->i; i < en->ht->data.n_entries; i++) {
		if (gu_map_entry_is_free(en->ht, &en->ht->data, i)) {
			continue;
		}
		en->x.key   = &en->ht->data.keys[i * en->ht->key_size];
		en->x.value = &en->ht->data.values[i * en->ht->value_size];
		if (en->ht->hasher == gu_addr_hasher) {
			en->x.key = *(const void* const*) en->x.key;
		} else if (en->ht->hasher == gu_string_hasher) {
			en->x.key = *(GuString*) en->x.key;
		}

		*((GuMapKeyValue**) to) = &en->x;
		break;
	}
	
	en->i = i+1;
}

GU_API GuEnum*
gu_map_enum(GuMap* ht, GuPool* pool)
{
	GuMapEnum* en = gu_new(GuMapEnum, pool);
	en->en.next = gu_map_enum_next;
	en->ht = ht;
	en->i  = 0;
	return &en->en;
}

GU_API size_t
gu_map_count(GuMap* map)
{
	size_t count = 0;
	for (size_t i = 0; i < map->data.n_entries; i++) {
		if (gu_map_entry_is_free(map, &map->data, i)) {
			continue;
		}
		count++;
	}
	return count;
}

static const uint8_t gu_map_no_values[1] = { 0 };

GU_API GuMap*
gu_make_map(size_t key_size, GuHasher* hasher,
	    size_t value_size, const void* default_value,
	    size_t init_size,
	    GuPool* pool)
{
	GuMapData data = {
		.n_occupied = 0,
		.n_entries = 0,
		.keys = NULL,
		.values = value_size ? NULL : (uint8_t*) gu_map_no_values,
		.zero_idx = SIZE_MAX
	};
	GuMap* map = gu_new(GuMap, pool);
	map->default_value = default_value;
	map->hasher = hasher;
	map->data = data;
	map->key_size = key_size;
	map->value_size = value_size;
	map->fin.fn = gu_map_finalize;
	gu_pool_finally(pool, &map->fin);

	init_size = gu_twin_prime_sup(init_size);
	gu_map_resize(map, init_size);
	return map;
}
