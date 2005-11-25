resource ResEng = ParamX ** {

  param

    Case   = Nom | Acc | Gen ;

    VForm = VInf | VPres | VPast | VPPart | VPresPart ;

    Ord = ODir | OQuest ;

  oper
    Agr = {n : Number ; p : Person} ;

    agrP3 : Number -> {a : Agr} = \n -> {a = {n = n ; p = P3}} ;

    
    regN : Str -> {s : Number => Case => Str} = \car -> {
      s = table {
        Sg => table {
          Gen => car + "'s" ;
          _ => car
          } ;
        Pl => table {
          Gen => car + "s'" ;
          _ => car + "s"
          }
        }
      } ;

    regV : Str -> {s : VForm => Str} = \walk -> {
      s = table {
        VInf  => walk ;
        VPres => walk + "s" ;
        VPast | VPPart => walk + "ed" ;
        VPresPart => walk + "ing"
        }
      } ;

    mkIP : (i,me,my : Str) -> Number -> {s : Case => Str ; n : Number} =
     \i,me,my,n -> let who = mkNP i me my n P3 in {s = who.s ; n = n} ;

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
    s  : Tense => Anteriority => Polarity => Ord => Agr => {fin, inf : Str} ; 
    s2 : Agr => Str
    } ;

  predV : Verb -> VP = \verb -> {
    s = \\t,ant,b,ord,agr => 
      let 
        inf  = verb.s ! VInf ;
        fin  = presVerb verb agr ;
        past = verb.s ! VPast ;
        part = verb.s ! VPPart ;
        vf : Str -> Str -> {fin, inf : Str} = \x,y -> 
          {fin = x ; inf = y} ;
      in
      case <t,ant,b,ord> of {
        <Pres,Simul,Pos,ODir>   => vf fin          [] ;
        <Pres,Simul,Pos,OQuest> => vf (does agr)   inf ;
        <Pres,Simul,Neg,_>      => vf (doesnt agr) inf ;
        <Pres,Anter,Pos,_>      => vf (have agr)   part ;
        <Pres,Anter,Neg,_>      => vf (havent agr) part ;
        <Past,Simul,Pos,ODir>   => vf past         [] ;
        <Past,Simul,Pos,OQuest> => vf "did"        inf ;
        <Past,Simul,Neg,_>      => vf "didn't"     inf ;
        <Past,Anter,Pos,_>      => vf "had"        part ;
        <Past,Anter,Neg,_>      => vf "hadn't"     part ;
        <Fut, Simul,Pos,_>      => vf "will"       inf ;
        <Fut, Simul,Neg,_>      => vf "won't"      inf ;
        <Fut, Anter,Pos,_>      => vf "will"       ("have" ++ part) ;
        <Fut, Anter,Neg,_>      => vf "won't"      ("have" ++ part) ;
        <Cond,Simul,Pos,_>      => vf "would"      inf ;
        <Cond,Simul,Neg,_>      => vf "wouldn't"   inf ;
        <Cond,Anter,Pos,_>      => vf "would"      ("have" ++ part) ;
        <Cond,Anter,Neg,_>      => vf "wouldn't"   ("have" ++ part)
        } ;
  s2 = \\_ => []
  } ;

  predAux : Aux -> VP = \verb -> {
    s = \\t,ant,b,ord,agr => 
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
        <Pres,Anter,Pos,_>      => vf (have agr)   part ;
        <Pres,Anter,Neg,_>      => vf (havent agr) part ;
        <Past,Simul,_,   _>      => vf fin          [] ;
        <Past,Anter,Pos,_>      => vf "had"        part ;
        <Past,Anter,Neg,_>      => vf "hadn't"     part ;
        <Fut, Simul,Pos,_>      => vf "will"       inf ;
        <Fut, Simul,Neg,_>      => vf "won't"      inf ;
        <Fut, Anter,Pos,_>      => vf "will"       ("have" ++ part) ;
        <Fut, Anter,Neg,_>      => vf "won't"      ("have" ++ part) ;
        <Cond,Simul,Pos,_>      => vf "would"      inf ;
        <Cond,Simul,Neg,_>      => vf "wouldn't"   inf ;
        <Cond,Anter,Pos,_>      => vf "would"      ("have" ++ part) ;
        <Cond,Anter,Neg,_>      => vf "wouldn't"   ("have" ++ part)
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
    (vp.s ! Fut ! Simul ! Neg ! ODir ! a).inf ++ vp.s2 ! a ;

  agrVerb : Str -> Str -> Agr -> Str = \has,have,agr -> 
    case agr of {
      {n = Sg ; p = P3} => has ;
      _                 => have
      } ;

  have   = agrVerb "has"     "have" ;
  havent = agrVerb "hasn't"  "haven't" ;
  does   = agrVerb "does"    "do" ;
  doesnt = agrVerb "doesn't" "don't" ;

  Aux = {pres,past : Polarity => Agr => Str ; inf,ppart : Str} ;

  auxBe : Aux = {
    pres = \\b,a => agrVerb (posneg b "is")  (posneg b "are")  a ;
    past = \\b,a => agrVerb (posneg b "was") (posneg b "were") a ;
    inf  = "be" ;
    ppart = "been"
    } ;

  posneg : Polarity -> Str -> Str = \p,s -> case p of {
    Pos => s ;
    Neg => s + "n't"
    } ;

  conjThat : Str = "that" ;

}
