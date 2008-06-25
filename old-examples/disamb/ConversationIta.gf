--# -path=.:prelude

concrete ConversationIta of Conversation = open Prelude in {

  lincat 
    Q = {s : Str} ;
    NP = {s : Str ; g : Gen ; n : Num ; p : Pol} ;
    A  = {s : Gen => Num => Str} ;
    Gender = {s : Str ; g : Gen} ;
    Number = {s : Str ; n : Num} ;
    Politeness = {s : Str ; p : Pol} ;

  param
    Num = Sg | Pl ;
    Gen = Masc | Fem ;
    Pol = Fam | Resp ;
  lin
    PredA np a = ss (np.s ++ essere np.n np.p ++ a.s ! np.g ! np.n) ;

    GMasc = ss [] ** {g = Masc} ;
    GFem  = ss [] ** {g = Fem} ; 
    NSg   = ss [] ** {n = Sg} ; 
    NPl   = ss [] ** {n = Pl} ;
    PFamiliar = ss [] ** {p = Fam} ;
    PPolite   = ss [] ** {p = Resp} ;

    You n p g = 
      {g = g.g ; n = n.n ; p = p.p ;
        s = case <n.n, p.p> of {
          <Sg,Fam> => "tu" ; 
          <Sg,Resp> => "Lei" ; 
          <Pl,Fam> => "voi" ; 
          <Pl,Resp> => "Loro"
          } ++ g.s ++ p.s ++ n.s
      } ; 

    Ready = regA "pronto" ;

  oper
    essere : Num -> Pol -> Str = \n,p -> case <n,p> of {
      <Sg,Fam> => "sei" ;
      <Sg,Resp> => "è" ; 
      <Pl,Fam> => "siete" ; 
      <Pl,Resp> => "sono"
      } ;

    regA : Str -> {s : Gen => Num => Str} = \nero ->
      let ner = init nero in {
        s = \\g,n => case <n,g> of {
         <Sg,Fem> => ner + "a" ;
         <Sg,Masc> => nero ; 
         <Pl,Fem> => ner + "e" ; 
         <Pl,Mas> => ner + "i"
         }
      } ;

}
