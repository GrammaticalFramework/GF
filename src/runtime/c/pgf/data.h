#ifndef PGF_DATA_H_
#define PGF_DATA_H_

#include <gu/variant.h>
#include <gu/map.h>
#include <gu/string.h>
#include <gu/seq.h>
#include <pgf/pgf.h>

typedef struct PgfCCat PgfCCat;

typedef GuSeq PgfCCats;

#define PgfCIdMap GuStringMap

typedef struct {
	PgfCId name;
	PgfLiteral value;
} PgfFlag;

typedef GuSeq PgfFlags;

extern GuOrder pgf_flag_order[1];

// PgfPatt

typedef GuVariant PgfPatt;

typedef enum {
	PGF_PATT_APP,
	PGF_PATT_VAR,
	PGF_PATT_AS,
	PGF_PATT_WILD,
	PGF_PATT_LIT,
	PGF_PATT_IMPL_ARG,
	PGF_PATT_TILDE,
	PGF_PATT_NUM_TAGS
} PgfPattTag;

typedef	struct {
	PgfCId ctor;
	size_t n_args;
	PgfPatt args[];
} PgfPattApp;

typedef struct {
	PgfLiteral lit;
} PgfPattLit;

typedef struct {
	PgfCId var;
} PgfPattVar;

typedef struct {
	PgfCId var;
	PgfPatt patt;
} PgfPattAs;

typedef void PgfPattWild;

typedef struct {
	PgfPatt patt;
} PgfPattImplArg;

typedef struct {
	PgfExpr expr;
} PgfPattTilde;

typedef struct {
	PgfExpr body;
	size_t n_patts;
	PgfPatt patts[];
} PgfEquation;

typedef GuSeq PgfEquations;

typedef void *PgfFunction;

typedef struct {
	PgfCId name;
	PgfType* type;
	int arity;
	PgfEquations* defns; // maybe null
	PgfExprProb ep;
	void* predicate;
	struct {
		PgfFunction code;
		union {
			size_t caf_offset;
			PgfFunction* con;
		};
	} closure;
} PgfAbsFun;

typedef GuSeq PgfAbsFuns;

extern GuOrder pgf_absfun_order[1];

typedef GuMap PgfMetaChildMap;

typedef struct {
	PgfCId name;
	PgfHypos* context;

	prob_t prob;

	void* predicate;
} PgfAbsCat;

typedef GuSeq PgfAbsCats;

extern GuOrder pgf_abscat_order[1];


typedef struct PgfEvalGates PgfEvalGates;

typedef struct {
	PgfCId name;
	PgfFlags* aflags;
	PgfAbsFuns* funs;
	PgfAbsCats* cats;
	PgfAbsFun* abs_lin_fun;
	PgfEvalGates* eval_gates;
} PgfAbstr;

typedef enum {
  PGF_INSTR_CHECK_ARGS  =  0,
  PGF_INSTR_CASE        =  1,
  PGF_INSTR_CASE_LIT    =  2,
  PGF_INSTR_SAVE        =  3,
  PGF_INSTR_ALLOC       =  4,
  PGF_INSTR_PUT_CONSTR  =  5,
  PGF_INSTR_PUT_CLOSURE =  6,
  PGF_INSTR_PUT_LIT     =  7,
  PGF_INSTR_SET         =  8,
  PGF_INSTR_SET_PAD     =  9,
  PGF_INSTR_PUSH_FRAME  = 10,
  PGF_INSTR_PUSH        = 11,
  PGF_INSTR_TUCK        = 12,
  PGF_INSTR_EVAL        = 13,
  PGF_INSTR_DROP        = 16,
  PGF_INSTR_JUMP        = 17,
  PGF_INSTR_FAIL        = 18,
  PGF_INSTR_PUSH_ACCUM  = 19,
  PGF_INSTR_POP_ACCUM   = 20,
  PGF_INSTR_ADD         = 21,
} PgfInstruction;

typedef GuSeq PgfConcrs;

extern GuOrder pgf_concr_order[1];

struct PgfPGF {
	uint16_t major_version;
	uint16_t minor_version;
	PgfFlags* gflags;
	PgfAbstr abstract;
	PgfConcrs* concretes;
	GuPool* pool;         // the pool in which the grammar is allocated
};

typedef struct {
	PgfAbsCat *abscat;
	PgfCCats* cats;

	size_t n_lins;
	GuString labels[];
	/**< Labels for tuples. All nested tuples, records and tables
	 * in the GF linearization types are flattened into a single
	 * tuple in the corresponding PGF concrete category. This
	 * field holds the labels that indicate which GF field or
	 * parameter (or their combination) each tuple element
	 * represents. */
} PgfCncCat;

typedef GuSeq PgfTokens;

bool
pgf_tokens_equal(PgfTokens* t1, PgfTokens* t2);

typedef GuSeq PgfSymbols;

typedef struct {
	PgfSymbols* form;
	/**< The form of this variant as a list of tokens. */

	GuStrings* prefixes;
	/**< The prefixes of the following symbol that trigger this
	 * form. */
} PgfAlternative;

typedef struct PgfItemConts PgfItemConts;

typedef PgfCIdMap PgfPrintNames;

typedef GuStringMap PgfCncFunOverloadMap;

typedef GuMap PgfCncOverloadMap;

typedef struct PgfItem PgfItem;

typedef GuVariant PgfSymbol;

typedef enum {
	PGF_SYMBOL_CAT,
	PGF_SYMBOL_LIT,
	PGF_SYMBOL_VAR,
	PGF_SYMBOL_KS,
	PGF_SYMBOL_KP,
	PGF_SYMBOL_BIND,
	PGF_SYMBOL_SOFT_BIND,
	PGF_SYMBOL_NE,
	PGF_SYMBOL_SOFT_SPACE,
	PGF_SYMBOL_CAPIT,
	PGF_SYMBOL_ALL_CAPIT,
} PgfSymbolTag;

typedef struct {
	int d;
	int r;
} PgfSymbolIdx;

typedef PgfSymbolIdx PgfSymbolCat, PgfSymbolLit, PgfSymbolVar;

typedef struct {
	char token[0];   // a flexible array that contains the token
} PgfSymbolKS;

typedef struct PgfSymbolKP
/** A prefix-dependent symbol. The form that this symbol takes
 * depends on the form of a prefix of the following symbol. */
{
	PgfSymbols* default_form;
	/**< Default form that this symbol takes if none of of the
	 * variant forms is triggered. */

	size_t n_forms;
	PgfAlternative forms[]; 
	/**< Variant forms whose choise depends on the following
	 * symbol. */
} PgfSymbolKP;

typedef struct {
} PgfSymbolNE;

typedef struct {
} PgfSymbolBIND;

typedef struct {
} PgfSymbolCAPIT;

typedef GuBuf PgfProductionIdx;

typedef struct {
	PgfSymbols* syms; // -> PgfSymbol
	PgfProductionIdx* idx;
} PgfSequence;

typedef GuSeq PgfSequences;

typedef struct {
	PgfAbsFun* absfun;
	PgfExprProb *ep;
    int funid;
	size_t n_lins;
	PgfSequence* lins[];
} PgfCncFun;

typedef GuSeq PgfCncFuns; 

struct PgfConcr {
	PgfCId name;
	PgfAbstr* abstr;
	PgfFlags* cflags;
	PgfPrintNames* printnames;
    GuMap* ccats;
	PgfCncFunOverloadMap* fun_indices;
	PgfCncOverloadMap* coerce_idx;
    PgfCncFuns* cncfuns;
    PgfSequences* sequences;
	PgfCIdMap* cnccats;
	int total_cats;
	
	GuPool* pool;     // if the language is loaded separately then this is the pool
	GuFinalizer fin;  // and this is the finalizer in the pool of the whole grammar
};



// PgfProduction

typedef GuVariant PgfProduction;

typedef enum {
	PGF_PRODUCTION_APPLY,
	PGF_PRODUCTION_COERCE,
	PGF_PRODUCTION_EXTERN
} PgfProductionTag;

typedef struct {
	PgfCCat* ccat;
	PgfCCats* hypos;
} PgfPArg;

typedef GuSeq PgfPArgs;

typedef struct {
	PgfCncFun* fun; 
	PgfPArgs* args;
} PgfProductionApply;

typedef struct PgfProductionCoerce
/** A coercion. This production is a logical union of the coercions of
 * another FId. This allows common subsets of productions to be
 * shared. */
{
	PgfCCat* coerce;
} PgfProductionCoerce;

typedef struct {
	PgfExprProb *ep;
    GuSeq* lins;
} PgfProductionExtern;

typedef struct {
	PgfExprProb *ep;
	PgfPArgs* args;
} PgfProductionMeta;

typedef GuSeq PgfProductionSeq;

typedef struct {
	PgfCCat* ccat;
	size_t lin_idx;
	PgfProductionApply* papp;
} PgfProductionIdxEntry;

struct PgfCCat {
	PgfCncCat* cnccat;
	PgfCncFuns* lindefs;
	PgfCncFuns* linrefs;
	size_t n_synprods;
	PgfProductionSeq* prods;
	float viterbi_prob;
	int fid;
	PgfItemConts* conts;
	struct PgfAnswers* answers;
	GuFinalizer fin[0];
};

#endif
