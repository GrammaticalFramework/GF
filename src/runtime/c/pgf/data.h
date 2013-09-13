#ifndef PGF_DATA_H_
#define PGF_DATA_H_

#include <gu/list.h>
#include <gu/variant.h>
#include <gu/map.h>
#include <gu/string.h>
#include <gu/type.h>
#include <gu/seq.h>
#include <pgf/pgf.h>

typedef struct PgfCCat PgfCCat;
extern GU_DECLARE_TYPE(PgfCCat, abstract);

typedef GuList(PgfCCat*) PgfCCats;

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
	PgfEquations defns; // maybe null
	PgfExprProb ep;
	void* predicate;
} PgfAbsFun;

extern GU_DECLARE_TYPE(PgfAbsFun, abstract);

typedef GuMap PgfMetaChildMap;
extern GU_DECLARE_TYPE(PgfMetaChildMap, GuMap);

typedef struct {
	PgfCId name;
	PgfHypos context;

	prob_t meta_prob;
	prob_t meta_token_prob;
	PgfMetaChildMap* meta_child_probs;

	void* predicate;
} PgfAbsCat;

extern GU_DECLARE_TYPE(PgfAbsCat, abstract);

typedef struct {
	PgfCId name;
	PgfFlags* aflags;
	PgfCIdMap* funs; // |-> PgfAbsFun*
	PgfCIdMap* cats; // |-> PgfAbsCat*
} PgfAbstr;

struct PgfPGF {
	uint16_t major_version;
	uint16_t minor_version;
	PgfFlags* gflags;
	PgfAbstr abstract;
	PgfCIdMap* concretes; // |-> PgfConcr*
	GuPool* pool;
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

bool
pgf_tokens_equal(PgfTokens t1, PgfTokens t2);

typedef GuList(GuString) GuStringL;

typedef struct {
	PgfTokens form;
	/**< The form of this variant as a list of tokens. */

	GuStringL* prefixes;
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

typedef GuMap PgfProductionIdx;
extern GU_DECLARE_TYPE(PgfProductionIdx, GuMap);

typedef GuMap PgfLeftcornerTokIdx;
extern GU_DECLARE_TYPE(PgfLeftcornerTokIdx, GuMap);

typedef struct PgfItem PgfItem;

typedef struct {
	bool (*match)(PgfConcr* concr, PgfItem* item, PgfToken tok,
	              PgfExprProb** out_ep, GuPool *pool);
} PgfLiteralCallback;

typedef GuMap PgfCallbacksMap;
extern GU_DECLARE_TYPE(PgfCallbacksMap, GuMap);

typedef struct GuVariant PgfSymbol;

typedef enum {
	PGF_SYMBOL_CAT,
	PGF_SYMBOL_LIT,
	PGF_SYMBOL_VAR,
	PGF_SYMBOL_KS,
	PGF_SYMBOL_KP,
	PGF_SYMBOL_NE
} PgfSymbolTag;

typedef struct {
	int d;
	int r;
} PgfSymbolIdx;

typedef PgfSymbolIdx PgfSymbolCat, PgfSymbolLit, PgfSymbolVar;

typedef struct {
	PgfTokens tokens;
} PgfSymbolKS;

typedef struct PgfSymbolKP
/** A prefix-dependent symbol. The form that this symbol takes
 * depends on the form of a prefix of the following symbol. */
{
	PgfTokens default_form; 
	/**< Default form that this symbol takes if none of of the
	 * variant forms is triggered. */

	GuLength n_forms;
	PgfAlternative forms[]; 
	/**< Variant forms whose choise depends on the following
	 * symbol. */
} PgfSymbolKP;

typedef struct {
} PgfSymbolNE;

typedef GuSeq PgfSequence; // -> PgfSymbol
typedef GuList(PgfSequence) PgfSequences;

typedef struct {
	PgfAbsFun* absfun;
	PgfExprProb *ep;
    int funid;
	GuLength n_lins;
	PgfSequence lins[];
} PgfCncFun;

typedef GuList(PgfCncFun*) PgfCncFuns; 

struct PgfConcr {
	PgfCId name;
	PgfFlags* cflags;
	PgfPrintNames* printnames;
    GuMap* ccats;
	PgfCncFunOverloadMap* fun_indices;
	PgfCncOverloadMap* coerce_idx;
	PgfProductionIdx* epsilon_idx;
	PgfLeftcornerTokIdx* leftcorner_tok_idx;
    PgfCncFuns* cncfuns;
    PgfSequences* sequences;
	PgfCIdMap* cnccats;
	PgfCallbacksMap* callbacks;
	int total_cats;
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
	PgfPArgs args;
} PgfProductionApply;

typedef struct PgfProductionCoerce
/** A coercion. This production is a logical union of the coercions of
 * another FId. This allows common subsets of productions to be
 * shared. */
{
	PgfCCat* coerce;
} PgfProductionCoerce;

typedef struct {
	PgfLiteralCallback *callback;
	PgfExprProb *ep;
    GuSeq lins;
} PgfProductionExtern;

typedef struct {
	PgfExprProb *ep;
	PgfPArgs args;
} PgfProductionMeta;

typedef GuSeq PgfProductionSeq;			      
extern GU_DECLARE_TYPE(PgfProductionSeq, GuSeq);

struct PgfCCat {
	PgfCncCat* cnccat;
	PgfCncFuns* lindefs;
	size_t n_synprods;
	PgfProductionSeq prods;
	float viterbi_prob;
	int fid;
	PgfItemConts* conts;
	struct PgfAnswers* answers;
};

#endif
