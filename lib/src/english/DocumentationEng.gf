--# -path=.:../abstract:../common
concrete DocumentationEng of Documentation = CatEng ** open
  ResEng,
  HTML in {

lincat
  Inflection = {t : Str; s1,s2 : Str} ;
  Definition = {s : Str} ;
  Document = {s : Str} ;
  Tag      = {s : Str} ;

lin
  InflectionN, InflectionN2, InflectionN3 = \noun -> {
    t  = "n" ;
    s1 = heading1 ("Noun" ++ case noun.g of {
                               Neutr => "";
                               Masc  => "(masc)";
                               Fem   => "(fem)"
                             }) ;
    s2 = frameTable (
           tr (th ""   ++ th "nom"               ++ th "gen") ++
           tr (th "sg" ++ td (noun.s ! Sg ! Nom) ++ td (noun.s ! Sg ! Gen)) ++
           tr (th "pl" ++ td (noun.s ! Pl ! Nom) ++ td (noun.s ! Pl ! Gen))
         )
    } ;

  InflectionA, InflectionA2 = \adj -> {
    t  = "a" ;
    s1 = heading1 "Adjective" ;
    s2 = frameTable (
           tr (th ""       ++ th "nom" ++ th "gen") ++
           tr (th "posit"  ++ td (adj.s ! AAdj Posit  Nom) ++ td (adj.s ! AAdj Posit  Gen)) ++
           tr (th "compar" ++ td (adj.s ! AAdj Compar Nom) ++ td (adj.s ! AAdj Compar Gen)) ++
           tr (th "superl" ++ td (adj.s ! AAdj Superl Nom) ++ td (adj.s ! AAdj Superl Gen))
         ) ++
         heading1 "Adverb" ++
         paragraph (adj.s ! AAdv)
    } ;

  InflectionAdv = \adv -> {
    t = "adv" ;
    s1= heading1 "Adverb" ;
    s2= paragraph (adv.s) ;
    s3= ""
    } ;

  InflectionPrep = \prep -> {
    t = "prep" ;
    s1= heading1 "Preposition" ;
    s2= paragraph (prep.s) ;
    s3= ""
    } ;

  InflectionV v = {
    t = "v" ;
    s1= heading1 "Verb" ++
        paragraph (pp "subject" ++ v.s ! VInf ++ v.p) ;
    s2= inflVerb v
    } ;

  InflectionV2 v = {
    t = "v" ;
    s1= heading1 "Verb" ++
        paragraph (pp "subject" ++
                   v.s ! VInf ++ v.p ++ v.c2 ++
                   pp "object") ;
    s2= inflVerb v
    } ;

  InflectionV3 v = {
    t = "v" ;
    s1= heading1 "Verb" ++ 
        paragraph (pp "subject" ++
                   v.s ! VInf ++ v.p ++
                   v.c2 ++ pp "arg1" ++
                   v.c3 ++ pp "arg2") ;
    s2= inflVerb v
    } ;

  InflectionV2V v = {
    t = "v" ;
    s1= heading1 "Verb" ++ 
        paragraph (pp "subject" ++
                   v.s ! VInf ++ v.p ++
                   v.c2 ++ pp "object" ++
                   v.c3 ++ case v.typ of {
                             VVAux => pp "verb" ;
                             VVInf => "to" ++ pp "verb" ;
                             VVPresPart => pp "verb+ing"
                           }) ;
    s2= inflVerb v
    } ;

  InflectionV2S v = {
    t = "v" ;
    s1= heading1 "Verb" ++ 
        paragraph (pp "subject" ++
                   v.s ! VInf ++ v.p ++
                   v.c2 ++ pp "object" ++
                   "that" ++ pp "sentence") ;
    s2= inflVerb v
    } ;

  InflectionV2Q v = {
    t = "v" ;
    s1= heading1 "Verb" ++ 
        paragraph (pp "subject" ++
                   v.s ! VInf ++ v.p ++
                   pp "question") ;
    s2= inflVerb v
    } ;

  InflectionV2A v = {
    t = "v" ;
    s1= heading1 "Verb" ++ 
        paragraph (pp "subject" ++
                   v.s ! VInf ++ v.p ++
                   v.c2 ++ pp "object" ++
                   pp "adjective") ;
    s2= inflVerb v
    } ;

  InflectionVV v = {
    t = "v" ;
    s1= heading1 "Verb" ++ 
        paragraph (pp "subject" ++
                   v.s ! VVF VInf ++ v.p ++
                   case v.typ of {
                     VVAux => pp "verb" ;
                     VVInf => "to" ++ pp "verb" ;
                     VVPresPart => pp "verb+ing"
                   }) ;
    s2= frameTable (
          tr (th "infitive"      ++ td (v.s ! VVF VInf)) ++
          tr (th "present"       ++ td (v.s ! VVF VPres ++ "&#160;" ++ v.s ! VVPresNeg)) ++
          tr (th "past"          ++ td (v.s ! VVF VPast ++ "&#160;" ++ v.s ! VVPastNeg)) ++ --# notpresent
          tr (th "past part."    ++ td (v.s ! VVF VPPart)) ++
          tr (th "present part." ++ td (v.s ! VVF VPresPart))
        )
    } ;

  InflectionVS v = {
    t = "v" ;
    s1= heading1 "Verb" ++ 
        paragraph (pp "subject" ++
                   v.s ! VInf ++ v.p ++
                   "that" ++ pp "sentence") ;
    s2= inflVerb v
    } ;

  InflectionVQ v = {
    t = "v" ;
    s1= heading1 "Verb" ++ 
        paragraph (pp "subject" ++
                   v.s ! VInf ++ v.p ++
                   pp "question") ;
    s2= inflVerb v
    } ;

  InflectionVA v = {
    t = "v" ;
    s1= heading1 "Verb" ++ 
        paragraph (pp "subject" ++
                   v.s ! VInf ++ v.p ++
                   pp "adjective") ;
    s2= inflVerb v
    } ;

oper
  inflVerb : Verb -> Str = \verb ->
    frameTable (
      tr (th "infitive"      ++ td (verb.s ! VInf)) ++
      tr (th "present"       ++ td (verb.s ! VPres)) ++
      tr (th "past"          ++ td (verb.s ! VPast)) ++ --# notpresent
      tr (th "past part."    ++ td (verb.s ! VPPart)) ++
      tr (th "present part." ++ td (verb.s ! VPresPart))
    ) ;

  pp : Str -> Str = \s -> "&lt;"+s+"&gt;";

lin
  NoDefinition   t     = {s=t.s};
  MkDefinition   t d   = {s="<p><b>Definition:</b>"++t.s++d.s++"</p>"};
  MkDefinitionEx t d e = {s="<p><b>Definition:</b>"++t.s++d.s++"</p><p><b>Example:</b>"++e.s++"</p>"};

lin
  MkDocument d i e = {s = i.s1 ++ d.s ++ i.s2 ++ paragraph e.s} ;
  MkTag i = {s = i.t} ;

}
