#include "gfcc-tree.h"

#include <stdlib.h>


extern int arity(Tree *t) {
	switch (t->type) {
	case ATOM_STRING: 
	case ATOM_INTEGER:
	case ATOM_DOUBLE:
	case ATOM_META:
		return 0;
	default:
		return t->value.size;
	}
}

static Tree *create_tree(atom_type c, int n) {
	Tree *t = (Tree *)malloc(sizeof(Tree) + n * sizeof(Tree *));
	t->type = c;
	return t;
}

extern Tree *tree_string(const char *s) {
	Tree *t = create_tree(ATOM_STRING, 0);
	t->value.string_value = s;
	return t;
}

extern Tree *tree_integer(int i) {
	Tree *t = create_tree(ATOM_INTEGER, 0);
	t->value.integer_value = i;
	return t;
}

extern Tree *tree_double(double d) {
	Tree *t = create_tree(ATOM_DOUBLE, 0);
	t->value.double_value = d;
	return t;
}

extern Tree *tree_meta() {
	return create_tree(ATOM_META, 0);
}

extern Tree *tree_fun(atom_type f, int n) {
	Tree *t = create_tree(f, n);
	t->value.size = n;
	return t;
}


extern void tree_free(Tree *t) {
	int n = arity(t);
	int i;

	for (i = 0; i < n; i++) {
		tree_free(tree_get_child(t,i));
	}
	free(t);
}
