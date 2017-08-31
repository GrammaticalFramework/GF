#ifndef PGF_GRAPHVIZ_H_
#define PGF_GRAPHVIZ_H_

typedef struct {
	int noLeaves;
	int noFun;
	int noCat;
	int noDep;
    GuString nodeFont;
    GuString leafFont;
	GuString nodeColor;
	GuString leafColor;
    GuString nodeEdgeStyle;
    GuString leafEdgeStyle;
} PgfGraphvizOptions;

extern PgfGraphvizOptions pgf_default_graphviz_options[1];

PGF_API_DECL void
pgf_graphviz_abstract_tree(PgfPGF* pgf, PgfExpr expr, PgfGraphvizOptions* opts, GuOut* out, GuExn* err);

PGF_API_DECL void
pgf_graphviz_parse_tree(PgfConcr* concr, PgfExpr expr, PgfGraphvizOptions* opts, GuOut* out, GuExn* err);

#endif
