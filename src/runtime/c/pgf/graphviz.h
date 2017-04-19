#ifndef PGF_GRAPHVIZ_H_
#define PGF_GRAPHVIZ_H_

PGF_API_DECL void
pgf_graphviz_abstract_tree(PgfPGF* pgf, PgfExpr expr, GuOut* out, GuExn* err);

PGF_API_DECL void
pgf_graphviz_parse_tree(PgfConcr* concr, PgfExpr expr, GuOut* out, GuExn* err);

#endif
