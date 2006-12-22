#include "gfcc-term.h"

#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>

static void *buffer = NULL;
static size_t current;

extern void term_alloc_pool(size_t size) {
	if (buffer == NULL) 
		buffer = malloc(size);
	current = 0;
}

extern void term_free_pool() {
	if (buffer != NULL)
		free(buffer);
	buffer = NULL;
}

extern void *term_alloc(size_t size) {
	void *off = buffer + current;
	current += size;
	return off;
}

static inline Term *create_term(TermType type, int n) {
	Term *t = (Term*)term_alloc(sizeof(Term) + n * sizeof(Term *));
	t->type = type;
	t->value.size = n; /* FIXME: hack! */
	return t;
}

extern Term *term_array(int n, ...) {
	Term *t = create_term(TERM_ARRAY, n);
	va_list ap;
	int i;

	va_start(ap, n);
	for (i = 0; i < n; i++) {
		term_set_child(t, i, va_arg(ap, Term *));
	}
	va_end(ap);

	return t;
}

extern Term *term_seq(int n, ...) {
	Term *t = create_term(TERM_SEQUENCE, n);
	va_list ap;
	int i;

	va_start(ap, n);
	for (i = 0; i < n; i++) {
		term_set_child(t, i, va_arg(ap, Term *));
	}
	va_end(ap);

	return t;
}

extern Term *term_variants(int n, ...) {
	Term *t = create_term(TERM_VARIANTS, n);
	va_list ap;
	int i;

	va_start(ap, n);
	for (i = 0; i < n; i++) {
		term_set_child(t, i, va_arg(ap, Term *));
	}
	va_end(ap);

	return t;
}

extern Term *term_glue(int n, ...) {
	Term *t = create_term(TERM_GLUE, n);
	va_list ap;
	int i;

	va_start(ap, n);
	for (i = 0; i < n; i++) {
		term_set_child(t, i, va_arg(ap, Term *));
	}
	va_end(ap);

	return t;
}

extern Term *term_rp(Term *t1, Term *t2) {
	Term *t = create_term(TERM_RECORD_PARAM, 2);
	term_set_child(t, 0, t1);
	term_set_child(t, 1, t2);
	return t;
}

extern Term *term_suffix(const char *pref, Term *suf) {
	Term *t = create_term(TERM_SUFFIX_TABLE, 2);
	term_set_child(t,0,term_str(pref));
	term_set_child(t,1,suf);
	return t;
}

extern Term *term_str(const char *s) {
	Term *t = create_term(TERM_STRING, 0);
	t->value.string_value = s;
	return t;
}

extern Term *term_int(int i) {
	Term *t = create_term(TERM_INTEGER,0);
	t->value.integer_value = i;
	return t;
}

extern Term *term_meta() {
	return create_term(TERM_META, 0);
}



extern Term *term_sel_int(Term *t, int i) {
	switch (t->type) {
	case TERM_ARRAY:
		return term_get_child(t,i);
	case TERM_SUFFIX_TABLE:
		return term_glue(2,
				 term_get_child(t,0), 
				 term_sel_int(term_get_child(t,1),i));
	case TERM_META:
		return t;
	default: 
		fprintf(stderr,"Error: term_sel_int %d %d\n", t->type, i);
		exit(1);
		return NULL;
  }
}

extern Term *term_sel(Term *t1, Term *t2) {
	switch (t2->type) {
	case TERM_INTEGER:
		return term_sel_int(t1, t2->value.integer_value);
	case TERM_RECORD_PARAM:
		return term_sel(t1,term_get_child(t2,0));
	case TERM_META:
		return term_sel_int(t1,0);
	default: 
		fprintf(stderr,"Error: term_sel %d %d\n", t1->type, t2->type);
		exit(1);
		return 0;
	}
}



static void term_print_sep(FILE *stream, Term *t, const char *sep) {
	int n = t->value.size;
	int i;

	for (i = 0; i < n; i++) {
		term_print(stream, term_get_child(t,i));
		if (i < n-1) {
			fputs(sep, stream);
		}
	}
}

extern void term_print(FILE *stream, Term *t) {
	switch (t->type) {
	case TERM_ARRAY:
		term_print(stream, term_get_child(t,0));
		break;
	case TERM_SEQUENCE:
		term_print_sep(stream, t, " ");
		break;
	case TERM_VARIANTS:
		term_print_sep(stream, t, "/");
		break;
	case TERM_GLUE:
		term_print_sep(stream, t, "");
		break;
	case TERM_RECORD_PARAM:
		term_print(stream, term_get_child(t,0));
		break;
	case TERM_SUFFIX_TABLE:
		term_print(stream, term_get_child(t,0));
		term_print(stream, term_get_child(t,1));
		break;
	case TERM_META:
		fputs("?", stream);
		break;
	case TERM_STRING: 
		fputs(t->value.string_value, stream);
		break;
	case TERM_INTEGER: 
		fprintf(stream, "%d", t->value.integer_value);
		break;
	default:
		fprintf(stderr,"Error: term_print %d\n", t->type);
		exit(1);
	}
}
