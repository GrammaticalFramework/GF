#ifndef PGF_GRAPHVIZ_H_
#define PGF_GRAPHVIZ_H_

void
pgf_graphviz_abstract_tree(PgfPGF* pgf, PgfExpr expr, GuWriter* wtr, GuExn* err);

void
pgf_graphviz_parse_tree(PgfConcr* concr, PgfExpr expr, GuWriter* wtr, GuExn* err);

#endif
