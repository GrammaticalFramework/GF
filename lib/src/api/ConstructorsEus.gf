--# -path=.:alltenses:prelude

resource ConstructorsEus = Constructors with (Grammar = GrammarEus) ** open MissingEus in {} ;
