/* 
 * Copyright 2010 University of Helsinki.
 *   
 * This file is part of libpgf.
 * 
 * Libpgf is free software: you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the
 * Free Software Foundation, either version 3 of the License, or (at your
 * option) any later version.
 * 
 * Libpgf is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public
 * License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with libpgf. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef PGF_DATA_H_
#define PGF_DATA_H_

#include <gu/list.h>
#include <gu/variant.h>
#include <gu/map.h>
#include <gu/string.h>
#include <gu/type.h>
#include <gu/seq.h>
#include <pgf/pgf.h>
#include <pgf/expr.h>

typedef struct PgfCCat PgfCCat;
typedef PgfCCat* PgfCCatId;
extern GU_DECLARE_TYPE(PgfCCat, struct);
extern GU_DECLARE_TYPE(PgfCCatId, shared);
typedef GuList(PgfCCatId) PgfCCatIds;
extern GU_DECLARE_TYPE(PgfCCatIds, GuList);
typedef GuSeq PgfCCatSeq;
extern GU_DECLARE_TYPE(PgfCCatSeq, GuSeq);

typedef struct PgfAbstr PgfAbstr;
extern GU_DECLARE_TYPE(PgfAbstr, struct);

typedef struct PgfFunDecl PgfFunDecl;

typedef int PgfLength;
typedef struct GuVariant PgfSymbol;
typedef struct PgfAlternative PgfAlternative;
typedef struct PgfCncFun PgfCncFun;


typedef GuSeq PgfSequence; // -> PgfSymbol

typedef PgfCncFun* PgfFunId; // key to PgfCncFuns
extern GU_DECLARE_TYPE(PgfFunId, shared);
typedef GuList(PgfCncFun*) PgfCncFuns; 
extern GU_DECLARE_TYPE(PgfCncFuns, GuList);
typedef GuList(PgfFunId) PgfFunIds; 
extern GU_DECLARE_TYPE(PgfFunIds, GuList);
// typedef GuStringMap PgfCIdMap; // PgfCId -> ?
#define PgfCIdMap GuStringMap			 
typedef PgfCIdMap PgfFlags; // PgfCId -> PgfLiteral
extern GU_DECLARE_TYPE(PgfFlags, GuMap);

extern GU_DECLARE_TYPE(PgfType, struct);
typedef GuVariant PgfProduction;
typedef GuList(PgfProduction) PgfProductions;
extern GU_DECLARE_TYPE(PgfProductions, GuList);
typedef GuSeq PgfProductionSeq;			      
extern GU_DECLARE_TYPE(PgfProductionSeq, GuSeq);

typedef struct PgfCatFun PgfCatFun;
typedef struct PgfCncCat PgfCncCat;
extern GU_DECLARE_TYPE(PgfCncCat, struct);
typedef GuVariant PgfPatt;

typedef GuList(GuString) GuStringL;
extern GU_DECLARE_TYPE(GuStringL, GuList);
typedef GuSeq PgfTokens;  // -> PgfToken
extern GU_DECLARE_TYPE(PgfTokens, GuSeq);

bool
pgf_tokens_equal(PgfTokens t1, PgfTokens t2);



typedef PgfExpr PgfTree;

typedef struct PgfEquation PgfEquation;
typedef GuSeq PgfEquations;
typedef PgfEquations PgfEquationsM; // can be null
extern GU_DECLARE_TYPE(PgfEquationsM, GuSeq);

typedef struct PgfCat PgfCat;
extern GU_DECLARE_TYPE(PgfCat, struct);

typedef PgfSequence PgfSeqId; // shared reference

extern GU_DECLARE_TYPE(PgfSeqId, typedef);

typedef GuList(PgfSequence) PgfSequences;

extern GU_DECLARE_TYPE(PgfSequences, GuList);




struct PgfAbstr {
	PgfFlags* aflags;
	PgfCIdMap* funs; // |-> PgfFunDecl*
	PgfCIdMap* cats; // |-> PgfCat*
};

struct PgfPGF {
	uint16_t major_version;
	uint16_t minor_version;
	PgfFlags* gflags;
	PgfCId absname;
	PgfAbstr abstract;
	PgfCIdMap* concretes; // |-> PgfConcr*
	GuPool* pool;
};

extern GU_DECLARE_TYPE(PgfPGF, struct);

typedef struct {
	float prob;
	PgfExpr expr;
} PgfExprProb;

extern GU_DECLARE_TYPE(PgfExprProb, struct);

struct PgfFunDecl {
	PgfType* type;
	int arity;
	PgfEquationsM defns; // maybe null
	PgfExprProb ep;
};

extern GU_DECLARE_TYPE(PgfFunDecl, struct);

struct PgfCatFun {
	double prob;
	PgfCId fun;
};

typedef GuMap PgfMetaChildMap;
extern GU_DECLARE_TYPE(PgfMetaChildMap, GuMap);

struct PgfCat {
	// TODO: Add cid here
	PgfHypos context;

	float meta_prob;
	float meta_token_prob;
	PgfMetaChildMap* meta_child_probs;

	GuLength n_functions;
	PgfCatFun functions[]; // XXX: resolve to PgfFunDecl*?
};


struct PgfCncCat {
	PgfCat *abscat;
	PgfCCatIds* cats;

	size_t n_lins;
	GuString labels[];
	/**< Labels for tuples. All nested tuples, records and tables
	 * in the GF linearization types are flattened into a single
	 * tuple in the corresponding PGF concrete category. This
	 * field holds the labels that indicate which GF field or
	 * parameter (or their combination) each tuple element
	 * represents. */
};

struct PgfCncFun {
	PgfCId name;
	PgfExprProb *ep;
    int funid;
	GuLength n_lins;
	PgfSeqId lins[];
};

struct PgfAlternative {
	PgfTokens form;
	/**< The form of this variant as a list of tokens. */

	GuStringL* prefixes;
	/**< The prefixes of the following symbol that trigger this
	 * form. */
};

struct PgfCCat {
	PgfCncCat* cnccat;
	PgfFunIds* lindefs;
	size_t n_synprods;
	PgfProductionSeq prods;
	float viterbi_prob;
	int fid;
};

extern PgfCCat pgf_ccat_string, pgf_ccat_int, pgf_ccat_float, pgf_ccat_var;

typedef PgfCIdMap PgfPrintNames;
extern GU_DECLARE_TYPE(PgfPrintNames, GuStringMap);

typedef GuStringMap PgfFunIndices;
extern GU_DECLARE_TYPE(PgfFunIndices, GuStringMap);

typedef GuMap PgfCoerceIdx;
extern GU_DECLARE_TYPE(PgfCoerceIdx, GuMap);

typedef GuStringMap PgfTransitions;
extern GU_DECLARE_TYPE(PgfTransitions, GuStringMap);

typedef GuMap PgfEpsilonIdx;
extern GU_DECLARE_TYPE(PgfEpsilonIdx, GuMap);

typedef struct PgfLiteralCallback PgfLiteralCallback;
extern GU_DECLARE_TYPE(PgfLiteralCallback, struct);

typedef struct PgfItem PgfItem;

struct PgfLiteralCallback {
	bool (*match)(PgfConcr* concr, PgfItem* item, PgfToken tok,
	              PgfExprProb** out_ep, GuPool *pool);
};

typedef GuMap PgfCallbacksMap;
extern GU_DECLARE_TYPE(PgfCallbacksMap, GuMap);

struct PgfConcr {
	PgfFlags* cflags;
	PgfPrintNames* printnames;
    GuMap* ccats;
	PgfFunIndices* fun_indices;
	PgfCoerceIdx* coerce_idx;
	PgfTransitions* lexicon_idx;
	PgfEpsilonIdx* epsilon_idx;
    PgfCncFuns* cncfuns;
    PgfSequences* sequences;
	PgfCIdMap* cnccats;
	PgfCallbacksMap* callbacks;
	int total_cats;
    int max_fid;
    int item_quota;
};

extern GU_DECLARE_TYPE(PgfConcr, struct);

typedef enum {
	PGF_SYMBOL_CAT,
	PGF_SYMBOL_LIT,
	PGF_SYMBOL_VAR,
	PGF_SYMBOL_KS,
	PGF_SYMBOL_KP
} PgfSymbolTag;

typedef struct PgfSymbolIdx PgfSymbolIdx;

struct PgfSymbolIdx {
	int d;
	int r;
};

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




// PgfProduction

typedef enum {
	PGF_PRODUCTION_APPLY,
	PGF_PRODUCTION_COERCE,
	PGF_PRODUCTION_EXTERN,
	PGF_PRODUCTION_META
} PgfProductionTag;

typedef struct PgfPArg PgfPArg;

struct PgfPArg {
	PgfCCatId ccat;
	PgfCCatIds* hypos;
};

extern GU_DECLARE_TYPE(PgfPArg, struct);

typedef GuSeq PgfPArgs;

extern GU_DECLARE_TYPE(PgfPArgs, GuSeq);

typedef struct {
	PgfFunId fun; 
	PgfPArgs args;
} PgfProductionApply;

typedef struct PgfProductionCoerce
/** A coercion. This production is a logical union of the coercions of
 * another FId. This allows common subsets of productions to be
 * shared. */
{
	PgfCCatId coerce;
} PgfProductionCoerce;

typedef struct {
	PgfLiteralCallback *callback;
	PgfExprProb *ep;
    GuSeq lins;
} PgfProductionExtern;

typedef struct {
	PgfExprProb *ep;
	GuSeq lins; 
	PgfPArgs args;
} PgfProductionMeta;

extern GU_DECLARE_TYPE(PgfPatt, GuVariant);

extern GU_DECLARE_TYPE(PgfProduction, GuVariant);
extern GU_DECLARE_TYPE(PgfBindType, enum);
extern GU_DECLARE_TYPE(PgfLiteral, GuVariant);


// PgfPatt

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
	PgfLiteral* lit;
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

struct PgfEquation {
	PgfExpr body;
	GuLength n_patts;
	PgfPatt patts[];
};



#endif /* PGF_PRIVATE_H_ */
