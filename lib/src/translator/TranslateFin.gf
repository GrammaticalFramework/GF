--# -path=.:../finnish/stemmed:../finnish:../abstract:../common:../finnish/kotus:../api

concrete TranslateFin of Translate = 
  TenseX,  ---- TODO add potential forms 
  CatFin,
  NounFin - [
    PPartNP,
    UsePron, PossPron  -- Fin specific: replaced by variants with prodrop
    ],
  AdjectiveFin,
  NumeralFin,
  SymbolFin [PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP],
  ConjunctionFin,
  VerbFin - [
    SlashV2V, PassV2, UseCopula, ComplVV,
             VPSlashPrep -- with empty prepositions, a cyclic rule that leads to overgeneration
    ],  
  AdverbFin,
  PhraseFin,
  SentenceFin,
  QuestionFin,
  RelativeFin,
  IdiomFin [NP, VP, Tense, Cl, ProgrVP, ExistNP, SelfAdvVP, SelfAdVVP, SelfNP],
  ConstructionFin,
  DocumentationFin,
-- ExtensionsFin,  
  DictionaryFin 
** 
open MorphoFin, ResFin, ParadigmsFin, SyntaxFin, StemFin, (E = ExtraFin), (G = GrammarFin), Prelude in {

flags literal=Symb ; coding = utf8 ;

-- the overrides -----
lin

 UsePron p = G.UsePron (E.ProDrop p) | G.UsePron p ;
 PossPron p = E.ProDropPoss p | G.PossPron p ;
}

