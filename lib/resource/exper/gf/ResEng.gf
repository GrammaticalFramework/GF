resource ResEng = {

  param
    Number = Sg | Pl ;
    Person = P1 | P2 | P3 ;
    Case   = Nom | Acc | Gen ;

    Anteriority = Simul | Anter ;
    Tense = Pres | Past | Fut | Cond ;
    Pol = PPos | PNeg ;
    Ord = ODir | OQuest ;

    VForm = VInf | VPres | VPast | VPPart | VPresPart ;

  oper
    Agr = {n : Number ; p : Person} ;

    regV : Str -> {s : VForm => Str} = \walk -> {
      s = table {
        VInf  => walk ;
        VPres => walk + "s" ;
        VPast | VPPart => walk + "ed" ;
        VPresPart => walk + "ing"
        }
      } ;

   mkNP : (i,me,my : Str) -> Number -> Person -> {s : Case => Str ; a : Agr} =
     \i,me,my,n,p -> {
     s = table {
       Nom => i ;
       Acc => me ;
       Gen => my
       } ;
     a = {
       n = n ;
       p = p
       }
     } ;

  Verb : Type = {
    s : VForm => Str
    } ;

  VP : Type = {
    s  : Tense => Anteriority => Ord => Pol => Agr => {fin, inf : Str} ; 
    s2 : Agr => Str
    } ;

  predV : Verb -> VP = \verb -> {
    s = \\t,ant,ord,b,agr => 
      let 
        inf  = verb.s ! VInf ;
        fin  = presVerb verb agr ;
        past = verb.s ! VPast ;
        part = verb.s ! VPPart ;
        vf : Str -> Str -> {fin, inf : Str} = \x,y -> 
          {fin = x ; inf = y} ;
      in
      case <t,ant,b,ord> of {
        <Pres,Simul,PPos,ODir>   => vf fin          [] ;
        <Pres,Simul,PPos,OQuest> => vf (does agr)   inf ;
        <Pres,Simul,PNeg,_>      => vf (doesnt agr) inf ;
        <Pres,Anter,PPos,_>      => vf (have agr)   part ;
        <Pres,Anter,PNeg,_>      => vf (havent agr) part ;
        <Past,Simul,PPos,ODir>   => vf past         [] ;
        <Past,Simul,PPos,OQuest> => vf "did"        inf ;
        <Past,Simul,PNeg,_>      => vf "didn't"     inf ;
        <Past,Anter,PPos,_>      => vf "had"        part ;
        <Past,Anter,PNeg,_>      => vf "hadn't"     part ;
        <Fut, Simul,PPos,_>      => vf "will"       inf ;
        <Fut, Simul,PNeg,_>      => vf "won't"      inf ;
        <Fut, Anter,PPos,_>      => vf "will"       ("have" ++ part) ;
        <Fut, Anter,PNeg,_>      => vf "won't"      ("have" ++ part) ;
        <Cond,Simul,PPos,_>      => vf "would"      inf ;
        <Cond,Simul,PNeg,_>      => vf "wouldn't"   inf ;
        <Cond,Anter,PPos,_>      => vf "would"      ("have" ++ part) ;
        <Cond,Anter,PNeg,_>      => vf "wouldn't"   ("have" ++ part)
        } ;
  s2 = \\_ => []
  } ;

  predAux : Aux -> VP = \verb -> {
    s = \\t,ant,ord,b,agr => 
      let 
        inf  = verb.inf ;
        fin  = verb.pres ! b ! agr ;
        past = verb.past ! b ! agr ;
        part = verb.ppart ;
        vf : Str -> Str -> {fin, inf : Str} = \x,y -> 
          {fin = x ; inf = y} ;
      in
      case <t,ant,b,ord> of {
        <Pres,Simul,_,   _>      => vf fin          [] ;
        <Pres,Anter,PPos,_>      => vf (have agr)   part ;
        <Pres,Anter,PNeg,_>      => vf (havent agr) part ;
        <Past,Simul,_,   _>      => vf fin          [] ;
        <Past,Anter,PPos,_>      => vf "had"        part ;
        <Past,Anter,PNeg,_>      => vf "hadn't"     part ;
        <Fut, Simul,PPos,_>      => vf "will"       inf ;
        <Fut, Simul,PNeg,_>      => vf "won't"      inf ;
        <Fut, Anter,PPos,_>      => vf "will"       ("have" ++ part) ;
        <Fut, Anter,PNeg,_>      => vf "won't"      ("have" ++ part) ;
        <Cond,Simul,PPos,_>      => vf "would"      inf ;
        <Cond,Simul,PNeg,_>      => vf "wouldn't"   inf ;
        <Cond,Anter,PPos,_>      => vf "would"      ("have" ++ part) ;
        <Cond,Anter,PNeg,_>      => vf "wouldn't"   ("have" ++ part)
        } ;
  s2 = \\_ => []
  } ;

  insertObj : (Agr => Str) -> VP -> VP = \obj,vp -> {
    s = vp.s ;
    s2 = \\a => vp.s2 ! a ++ obj ! a
    } ;

  presVerb : {s : VForm => Str} -> Agr -> Str = \verb -> 
    agrVerb (verb.s ! VPres) (verb.s ! VInf) ;

  infVP : VP -> Agr -> Str = \vp,a -> 
    (vp.s ! Fut ! Simul ! ODir ! PNeg ! a).inf ++ vp.s2 ! a ;

  agrVerb : Str -> Str -> Agr -> Str = \has,have,agr -> 
    case agr of {
      {n = Sg ; p = P3} => has ;
      _                 => have
      } ;

  have   = agrVerb "has"     "have" ;
  havent = agrVerb "hasn't"  "haven't" ;
  does   = agrVerb "does"    "do" ;
  doesnt = agrVerb "doesn't" "don't" ;

  Aux = {pres,past : Pol => Agr => Str ; inf,ppart : Str} ;

  auxBe : Aux = {
    pres = \\b,a => agrVerb (posneg b "is")  (posneg b "are")  a ;
    past = \\b,a => agrVerb (posneg b "was") (posneg b "were") a ;
    inf  = "be" ;
    ppart = "been"
    } ;

  posneg : Pol -> Str -> Str = \p,s -> case p of {
    PPos => s ;
    PNeg => s + "n't"
    } ;

}
