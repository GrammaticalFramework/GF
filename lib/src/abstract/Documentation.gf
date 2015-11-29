abstract Documentation = Cat ** {

-- Generating documentation for the library, for instance, inflection tables
-- AR 12/12/2013 under LGPL/BSD

cat
  Inflection ;     -- inflection table
  Definition ;
  Document ;
  Tag ;

fun
  InflectionN   : N -> Inflection ;
  InflectionN2  : N2 -> Inflection ;
  InflectionN3  : N3 -> Inflection ;
  InflectionA   : A -> Inflection ;
  InflectionA2  : A2 -> Inflection ;
  InflectionV   : V -> Inflection ;
  InflectionV2  : V2 -> Inflection ;
  InflectionVV  : VV -> Inflection ;
  InflectionVS  : VS -> Inflection ;
  InflectionVQ  : VQ -> Inflection ;
  InflectionVA  : VA -> Inflection ;
  InflectionV3  : V3 -> Inflection ;
  InflectionV2V : V2V -> Inflection ;
  InflectionV2S : V2S -> Inflection ;
  InflectionV2Q : V2Q -> Inflection ;
  InflectionV2A : V2A -> Inflection ;
  InflectionAdv : Adv -> Inflection ;
  InflectionPrep : Prep -> Inflection ;

fun
  NoDefinition   : String -> Definition ;
  MkDefinition   : String -> String -> Definition ;
  MkDefinitionEx : String -> String -> String -> Definition ;

fun
  MkDocument : Definition -> Inflection -> String -> Document ;
  MkTag : Inflection -> Tag ;

}
