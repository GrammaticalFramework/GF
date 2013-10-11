concrete SentencesChi of Sentences = NumeralChi ** SentencesI - [APlace,ThePlace]
  with 
  (Syntax = SyntaxChi),
  (Symbolic = SymbolicChi),
  (Lexicon = LexiconChi) ** open SyntaxChi in {

flags coding=utf8 ;

lin
  ThePlace kind =
    let name : NP = lin NP (Syntax.mkNP theSg_Det kind.name) in {
      name = lin NP name ;
      at = mkAdv kind.at (lin NP name) ;
      to = mkAdv kind.to (lin NP name)
    } ;
  APlace kind =
    let name : NP = lin NP (Syntax.mkNP aSg_Det kind.name) in {
      name = lin NP name ;
      at = mkAdv kind.at (lin NP name) ;
      to = mkAdv kind.to (lin NP name)
    } ;

}
