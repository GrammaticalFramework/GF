incomplete concrete SimpleI of Simple = 
  open Predef, Prelude, SimpleAux, Categories, Rules, Structural, Verbphrase in {

lincat

  Sentence = {s : SentenceForm => Str} ;

lin
  PAffirm sent = ss (sent.s ! SAffirm) ** {lock_Phr = <>} ;
  PNegate sent = ss (sent.s ! SNegate)  ** {lock_Phr = <>} ;
  PQuestion sent =  ss (sent.s ! SQuestion)  ** {lock_Phr = <>} ;
  PCommand = ImperOne ;

  SVerb np v = {s = table {
    SAffirm => toStr S (UseCl (PosTP TPresent ASimul) (PredVP np (UseV v))) ;
    SNegate => toStr S (UseCl (NegTP TPresent ASimul) (PredVP np (UseV v))) ;
    SQuestion => toStr QS (UseQCl (PosTP TPresent ASimul) (QuestCl (PredVP np
    (UseV v))))
    }
  } ;

  STransVerb np tv obj = {s = table {
    SAffirm => toStr S (UseCl (PosTP TPresent ASimul) (PredVP np (ComplV2 tv obj))) ; 
    SNegate => toStr S (UseCl (PosTP TPresent ASimul) (PredVP np (ComplV2 tv obj))) ; 
    SQuestion => 
      toStr QS (UseQCl (PosTP TPresent ASimul) (QuestCl (PredVP np (ComplV2 tv obj))))
    }
  } ;

  SAdjective np ap = {s = table {
    SAffirm => toStr S (UseCl (PosTP TPresent ASimul) (PredVP np (PredAP ap))) ;
    SNegate => toStr S (UseCl (NegTP TPresent ASimul) (PredVP np (PredAP ap))) ;
    SQuestion => toStr QS (UseQCl (PosTP TPresent ASimul) (QuestCl (PredVP np
    (PredAP ap))))
    }
  } ;

  SAdverb np ap = {s = table {
    SAffirm => toStr S (UseCl (PosTP TPresent ASimul) (PredVP np (PredAdv ap))) ;
    SNegate => toStr S (UseCl (NegTP TPresent ASimul) (PredVP np (PredAdv ap))) ;
    SQuestion => toStr QS (UseQCl (PosTP TPresent ASimul) (QuestCl (PredVP np
    (PredAdv ap))))
    }
  } ;

  SModified s a = {s = \\f => s.s ! f ++ a.s ; lock_S = <>} ; ---

  PIntV ip v = 
    QuestPhrase (UseQCl (PosTP TPresent ASimul) (IntVP ip (UseV v))) ;
  PIntSubjV2 ip v np = 
    QuestPhrase (UseQCl (PosTP TPresent ASimul) (IntVP ip (ComplV2 v np))) ;
  PIntObjV2 ip np v = 
    QuestPhrase (UseQCl (PosTP TPresent ASimul) (IntSlash ip (SlashV2 np v))) ;
  PIntAP ip v = 
    QuestPhrase (UseQCl (PosTP TPresent ASimul) (IntVP ip (PredAP v))) ;
  PIntAdv ip v = 
    QuestPhrase (UseQCl (PosTP TPresent ASimul) (IntVP ip (PredAdv v))) ;

  NPDef   = DefOneNP ;
  NPIndef = IndefOneNP ;
  NPGroup = IndefNumNP NoNum ;
  NPMass  = MassNP ;
  NPName  = UsePN ;

  NSimple = UseN ;
  NModified = ModAP ;

  ASimple = PositADeg ;
  AVery a = AdvAP very_Adv (PositADeg a) ;

  AdvPrep p np = AdvPP (PrepNP p np) ;

}
