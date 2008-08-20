incomplete concrete PeaceCatI of PeaceCat = 
  open Lang, PeaceRes, Prelude in {

  lincat
    N = N; A = A; V = V; V2 = V2; V3 = V3; Pron = Pron;
    Card = Card ; Art = Art ; --a
    IP = IP; IAdv = IAdv;
    Adv = Adv; NP = NP; CN = CN; Imp = Imp; Det = Det; Num = Num;

    MassN = N ;
    Phrase = { s : Str; p : Punct } ;
    PhraseWritten = { s : Str } ;
    PhraseSpoken = { s : Str } ;

    Sent = {s : SForm => Str} ; 
    Quest = { s : Str } ;
    MassCN = CN ;

  lin 
    Written x = mkWritten x.s x.p ;
    Spoken x = { s = x.s } ;

  oper
    mkWritten : Str -> Punct -> { s : Str } ;
    mkWritten x p = case p of {
      FullStop => { s = x ++ "." } ; --TFullStop (ss s) TEmpty ;
      QuestMark => { s = x ++ "?" } ; --TQuestMark (ss s) TEmpty ;
      ExclMark => { s = x ++ "!" } --TExclMark (ss s) TEmpty 
    } ;

}
