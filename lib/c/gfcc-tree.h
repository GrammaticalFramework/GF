#ifndef GFCC_TREE_H
#define GFCC_TREE_H

typedef enum {
	ATOM_STRING,
	ATOM_INTEGER,
	ATOM_DOUBLE,
	ATOM_META,
	ATOM_FIRST_FUN
} atom_type;

struct Tree_{
	atom_type type;
	union {
		const char *string_value;
		int integer_value;
		double double_value;
		int size;
	} value;
	struct Tree_ *args[0];
};

typedef struct Tree_ Tree;

static inline Tree *tree_get_child(Tree *t, int n) {
	return t->args[n];
}

static inline void tree_set_child(Tree *t, int n, Tree *a) {
	t->args[n] = a;
}

extern int arity(Tree *t);


extern Tree *tree_string(const char *s);

extern Tree *tree_integer(int i);

extern Tree *tree_double(double d);

extern Tree *tree_meta();

extern Tree *tree_fun(atom_type f, int n);


extern void tree_free(Tree *t);

#endif
