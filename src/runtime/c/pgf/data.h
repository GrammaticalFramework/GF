#ifndef PGF_DATA_H_
#define PGF_DATA_H_

#include <gu/variant.h>
#include <gu/map.h>
#include <gu/string.h>
#include <gu/type.h>
#include <gu/seq.h>
#include <pgf/pgf.h>

typedef struct PgfCCat PgfCCat;
extern GU_DECLARE_TYPE(PgfCCat, abstract);

typedef GuSeq PgfCCats;

#define PgfCIdMap GuStringMap			 
typedef PgfCIdMap PgfFlags; // PgfCId -> PgfLiteral
extern GU_DECLARE_TYPE(PgfFlags, GuMap);

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
	GuLength n_args;
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
	GuLength n_patts;
	PgfPatt patts[];
} PgfEquation;

typedef GuSeq PgfEquations;

typedef struct {
	PgfCId name;
	PgfType* type;
	int arity;
	PgfEquations* defns; // maybe null
	PgfExprProb ep;
	void* predicate;
	void* function;
} PgfAbsFun;

extern GU_DECLARE_TYPE(PgfAbsFun, abstract);

typedef GuMap PgfMetaChildMap;
extern GU_DECLARE_TYPE(PgfMetaChildMap, GuMap);

typedef struct {
	PgfCId name;
	PgfHypos* context;

	prob_t prob;

	void* predicate;
} PgfAbsCat;

extern GU_DECLARE_TYPE(PgfAbsCat, abstract);

typedef struct {
	PgfCId name;
	PgfFlags* aflags;
	PgfCIdMap* funs; // |-> PgfAbsFun*
	PgfCIdMap* cats; // |-> PgfAbsCat*
	PgfAbsFun* abs_lin_fun;
} PgfAbstr;

typedef enum {
  PGF_INSTR_ENTER,
  PGF_INSTR_EVAL_ARG_VAR,
  PGF_INSTR_EVAL_FREE_VAR,
  PGF_INSTR_CASE,
  PGF_INSTR_CASE_INT,
  PGF_INSTR_CASE_STR,
  PGF_INSTR_CASE_FLT,
  PGF_INSTR_ALLOC,
  PGF_INSTR_PUT_CONSTR,
  PGF_INSTR_PUT_FUN,
  PGF_INSTR_PUT_CLOSURE,
  PGF_INSTR_PUT_INT,
  PGF_INSTR_PUT_STR,
  PGF_INSTR_PUT_FLT,
  PGF_INSTR_SET_VALUE,
  PGF_INSTR_SET_ARG_VAR,
  PGF_INSTR_SET_FREE_VAR,
  PGF_INSTR_PUSH_VALUE,
  PGF_INSTR_PUSH_ARG_VAR,
  PGF_INSTR_PUSH_FREE_VAR,
  PGF_INSTR_TAIL_CALL,
  PGF_INSTR_FAIL,
  PGF_INSTR_RET
} PgfInstruction;

struct PgfPGF {
	uint16_t major_version;
	uint16_t minor_version;
	PgfFlags* gflags;
	PgfAbstr abstract;
	PgfCIdMap* concretes; // |-> PgfConcr*
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

extern GU_DECLARE_TYPE(PgfCncCat, abstract);

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
extern GU_DECLARE_TYPE(PgfPrintNames, GuStringMap);

typedef GuStringMap PgfCncFunOverloadMap;
extern GU_DECLARE_TYPE(PgfCncFunOverloadMap, GuStringMap);

typedef GuMap PgfCncOverloadMap;
extern GU_DECLARE_TYPE(PgfCncOverloadMap, GuMap);

typedef struct PgfItem PgfItem;

typedef GuMap PgfCallbacksMap;
extern GU_DECLARE_TYPE(PgfCallbacksMap, GuMap);

typedef GuVariant PgfSymbol;

typedef enum {
	PGF_SYMBOL_CAT,
	PGF_SYMBOL_LIT,
	PGF_SYMBOL_VAR,
	PGF_SYMBOL_KS,
	PGF_SYMBOL_KP,
	PGF_SYMBOL_BIND,
	PGF_SYMBOL_SOFT_BIND,
	PGF_SYMBOL_NE
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

	GuLength n_forms;
	PgfAlternative forms[]; 
	/**< Variant forms whose choise depends on the following
	 * symbol. */
} PgfSymbolKP;

typedef struct {
} PgfSymbolNE;

typedef struct {
} PgfSymbolBIND;

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
	GuLength n_lins;
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
    GuBuf* pre_sequences;
	PgfCIdMap* cnccats;
	PgfCallbacksMap* callbacks;
	int total_cats;
	
	GuPool* pool;     // if the language is loaded separately then this is the pool
	GuFinalizer fin;  // and this is the finalizer in the pool of the whole grammar
};

extern GU_DECLARE_TYPE(PgfConcr, abstract);


// PgfProduction

typedef GuVariant PgfProduction;

typedef enum {
	PGF_PRODUCTION_APPLY,
	PGF_PRODUCTION_COERCE,
	PGF_PRODUCTION_EXTERN,
	PGF_PRODUCTION_META
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
extern GU_DECLARE_TYPE(PgfProductionSeq, abstract);

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
