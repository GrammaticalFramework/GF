#ifndef PGF_PARSER_H_
#define PGF_PARSER_H_

#include <gu/enum.h>
#include <pgf/data.h>
#include <pgf/expr.h>

/// Parsing
/** @file
 *
 *  @todo Querying the parser for expected continuations
 *
 *  @todo Literals and custom categories
 *  
 *  @todo HOAS, dependent types...
 */

typedef struct PgfParse PgfParse;

/** @}
 * 
 * @name Parsing a sentence
 *
 * The progress of parsing is controlled by the client code. Firstly, the
 * parsing of a sentence is initiated with #pgf_parser_parse. This returns an
 * initial #PgfParse object, which represents the state of the parsing. A new
 * parse state is obtained by feeding a token with #pgf_parse_token. The old
 * parse state is unaffected by this, so backtracking - and even branching -
 * can be accomplished by retaining the earlier #PgfParse objects.
 *
 * @{
 */

/// Begin parsing
PgfParse*
pgf_parser_parse(PgfConcr* concr, PgfCId cat, size_t lin_idx, GuPool* pool);
/**<
 * @param parser The parser to use
 *
 * @param cat The identifier of the abstract category to parse
 *
 * @param lin_idx The index of the field of the concrete category to parse
 *
 * @pool
 *
 * @return An initial parsing state.
*/


/// Feed a token to the parser
PgfParse*
pgf_parse_token(PgfParse* parse, PgfToken tok, bool robust, GuPool* pool);
/**<
 * @param parse The current parse state
 *
 * @param tok The token to feed
 *
 * @pool
 *
 * @return A new parse state obtained by feeding \p tok as an input to \p
 * parse, or \c NULL if the token was unexpected.
 *
 * @note The new parse state partially depends on the old one, so it doesn't
 * make sense to use a \p pool argument with a longer lifetime than that of
 * the pool used to create \parse.
 */

void
pgf_parser_add_literal(PgfConcr *concr, PgfCId cat,
                       PgfLiteralCallback* callback);

/** @}
 * @name Retrieving abstract syntax trees
 *
 * After the desired tokens have been fed to the parser, the resulting parse
 * state can be queried for completed results. The #pgf_parse_result function
 * returns an enumeration (#GuEnum) of possible abstract syntax trees whose
 * linearization is the sequence of tokens fed so far.
 *
 * @{
 */


/// An enumeration of #PgfExpr elements.
typedef GuEnum PgfExprEnum;


/// Retrieve the current parses from the parse state.
PgfExprEnum*
pgf_parse_result(PgfParse* parse, GuPool* pool);
/**<
 * @param parse A parse state
 *
 * @pool
 * 
 * @return An enumeration of #PgfExpr elements representing the abstract
 * syntax trees that would linearize to the sequence of tokens fed to produce
 * \p parse. The enumeration may yield zero, one or more abstract syntax
 * trees, depending on whether the parse was unsuccesful, unambiguously
 * succesful, or ambiguously successful.
 */

PgfExpr
pgf_parse_best_result(PgfParse* parse, GuPool* pool);


int
pgf_item_lin_idx(PgfItem* item);

void
pgf_item_sequence(PgfItem* item, 
                  int* lin_idx, PgfSequence* seq,
                  GuPool* pool);

int
pgf_item_sequence_length(PgfItem* item);

/** @} */

#endif // PGF_PARSER_H_
