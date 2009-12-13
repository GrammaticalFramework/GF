#ifndef GFCC_TERM_H
#define GFCC_TERM_H

#include <stdio.h>

typedef enum {
	/* size = variable */
	TERM_ARRAY,
	TERM_SEQUENCE,
	TERM_VARIANTS,
	TERM_GLUE,
	/* size = 2 */
	TERM_RECORD_PARAM,
	TERM_SUFFIX_TABLE,
	/* size = 0 */
	TERM_META,
	TERM_STRING,
	TERM_INTEGER
} TermType;

struct Term_ {
	TermType type;
	union {
		const char *string_value;
		int integer_value;
		int size;
	} value;
	struct Term_ *args[0];
};

typedef struct Term_ Term;



static inline Term *term_get_child(Term *t, int n) {
	return t->args[n];
}

static inline void term_set_child(Term *t, int n, Term *c) {
	t->args[n] = c;
}

extern void term_alloc_pool(size_t size);
extern void term_free_pool();
extern void *term_alloc(size_t size);


extern Term *term_array(int n, ...);
extern Term *term_seq(int n, ...);
extern Term *term_variants(int n, ...);
extern Term *term_glue(int n, ...);

extern Term *term_rp(Term *t1, Term *t2);
extern Term *term_suffix(const char *pref, Term *suf);
extern Term *term_str(const char *s);
extern Term *term_int(int i);
extern Term *term_meta();

extern Term *term_sel_int(Term *t, int i);
extern Term *term_sel(Term *t1, Term *t2);


extern void term_print(FILE *stream, Term *t);

#endif
