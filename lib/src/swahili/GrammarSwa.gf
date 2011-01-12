--# -path=.:../abstract:../common:prelude

concrete GrammarSwa of Grammar =NounSwa , AdjectiveSwa , StructuralSwa ,VerbSwa , SentenceSwa , AdverbSwa
  
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
