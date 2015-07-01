--# -path=.:../abstract:../common

incomplete concrete DocumentationDutFunctor of Documentation = CatDut ** open 
  Terminology,  -- the interface that generates different documentation languages
  ResDut,
  ParadigmsDut,
  (G = GrammarDut),
  (S = SyntaxDut),
  (L = LexiconDut),
  Prelude,
  HTML
in {


lincat
  Inflection = {t : Str; s1,s2 : Str} ;
  Document = {s : Str} ;
  Tag = {s : Str} ;

oper
  heading : N -> Str = \n -> (nounHeading n).s ;

lin
  InflectionN, InflectionN2, InflectionN3 = \noun -> {
    t  = "s" ;
    s1 = heading1 (heading noun_Category ++ 
                   case noun.g of {
                     Utr    => "("+heading uter_Parameter+")" ; 
                     Neutr  => "("+heading neuter_Parameter+")"
                   }) ;
    s2 = frameTable ( 
           tr (th "" ++ th (heading singular_Parameter)            ++ th (heading plural_Parameter)   ) ++
           tr (th (heading nominative_Parameter) ++ td (noun.s ! NF Sg Nom) ++ td (noun.s ! NF Pl Nom)) ++
           tr (th (heading genitive_Parameter)   ++ td (noun.s ! NF Sg Gen) ++ td (noun.s ! NF Pl Gen))
           )
    } ;

  InflectionA, InflectionA2 = \adj ->
    let
      gforms : AForm -> Str = \a ->
        td (adj.s ! Posit  ! a) ++
        td (adj.s ! Compar ! a) ++
        case a of {
          AGen => td "-" ;    -- superlative partitive not used
          _ => td (adj.s ! Superl ! a)
          } ;
      dtable : Str = 
        frameTable ( 
          tr (th []  ++ th (heading positive_Parameter) ++ th (heading comparative_Parameter) ++ 
                        th (heading superlative_Parameter)) ++
          tr (th (heading predicative_Parameter) ++ gforms APred) ++
          tr (th (heading attributive_Parameter) ++ gforms AAttr) ++
          tr (th (heading partitive_Parameter)   ++ gforms AGen)
          )
    in { t  = "a" ;
         s1 = heading1 (nounHeading adjective_Category).s ;
         s2 = dtable
       } ;

  InflectionAdv adv = {
    t  = "adv" ;
    s1 = heading1 (heading preposition_Category) ;
    s2 = paragraph adv.s
    } ;

  InflectionPrep p = {
    t  = "prep" ;
    s1 = heading1 (heading preposition_Category) ;
    s2 = paragraph (S.mkAdv (lin Prep p) (S.mkNP S.a_Det L.computer_N)).s
    } ;

  InflectionV v = {
    t  = "v" ;
    s1 = heading1 (heading verb_Category) ++  
         paragraph (verbExample (S.mkCl S.she_NP v)) ;
    s2 = inflVerb v
    } ;

  InflectionV2 v = {
    t  = "v" ;
    s1 = heading1 (heading verb_Category) ++  
         paragraph (verbExample (S.mkCl S.she_NP v S.something_NP)) ;
    s2 = inflVerb v
    } ;

  InflectionV3 v = {
    t  = "v" ;
    s1 = heading1 (heading verb_Category) ++  
         paragraph (verbExample (S.mkCl S.she_NP v S.something_NP S.something_NP)) ;
    s2 = inflVerb v
    } ;

  InflectionV2V v = {
    t  = "v" ;
    s1 = heading1 (heading verb_Category) ++
         paragraph (verbExample (S.mkCl S.she_NP (lin V2V v) S.we_NP (S.mkVP (L.sleep_V)))) ;
    s2 = inflVerb v
    } ;

  InflectionV2S v = {
    t  = "v" ;
    s1 = heading1 (heading verb_Category) ;
    s2 = inflVerb v
    } ;

  InflectionV2Q v = {
    t  = "v" ;
    s1 = heading1 (heading verb_Category) ;
    s2 = inflVerb v
    } ;

  InflectionV2A v = {
    t  = "v" ;
    s1 = heading1 (heading verb_Category) ;
    s2 = inflVerb v
    } ;

  InflectionVV v = {
    t  = "v" ;
    s1 = heading1 (heading verb_Category) ++  
         paragraph (verbExample (S.mkCl S.she_NP (lin VV v) (S.mkVP (L.sleep_V)))) ;
    s2 = inflVerb v
    } ;

  InflectionVS v = {
    t  = "v" ;
    s1 = heading1 (heading verb_Category) ;
    s2 = inflVerb v
    } ;

  InflectionVQ v = {
    t  = "v" ;
    s1 = heading1 (heading verb_Category) ;
    s2 = inflVerb v
    } ;

  InflectionVA v = {
    t  = "v" ;
    s1 = heading1 (heading verb_Category) ;
    s2 = inflVerb v
    } ;

  MkDocument b i e = ss (i.s1 ++ "<p style=\"font-size:20px\">"++b.s++"</p>" ++ i.s2 ++ paragraph e.s) ;  -- explanation appended in a new paragraph
  MkTag i = ss i.t ;

oper 
  verbExample : CatDut.Cl -> Str = \cl ->
     (S.mkUtt cl).s 
     ++ ";" ++ (S.mkUtt (S.mkS S.anteriorAnt cl)).s  --# notpresent
     ;

  inflVerb : VVerb -> Str = \verb -> 
     let 
       vfin : VForm -> Str = \f ->
         verb.s ! f ++ verb.prefix ; 
       gforms : VForm -> Str = \f -> 
         td (vfin f) ;

     in frameTable (
          tr (th "" ++ th (heading present_Parameter) ++  th (heading past_Parameter)) ++  
          tr (th "Sg.1"  ++ gforms VPresSg1  
             ++ intagAttr "td" "rowspan=3" (vfin VPastSg) --# notpresent
             ) ++
          tr (th "Sg.2"  ++ gforms VPresSg2) ++
          tr (th "Sg.3"  ++ gforms VPresSg3) ++
          tr (th "Pl"    ++ gforms VPresPl   
             ++ td (vfin VPastPl)  --# notpresent
          )) ++
        frameTable (
          tr (th (heading imperative_Parameter ++ heading singular_Parameter) ++ td (vfin VImp2 ++ Predef.BIND ++ "," ++ vfin VImp3)) ++
          tr (th (heading imperative_Parameter ++ heading plural_Parameter)  ++ td (vfin (VImpPl))) ++
          tr (th (heading infinitive_Parameter)            ++ td (verb.s ! VInf)) ++
          tr (th (heading perfect_Parameter ++ heading participle_Parameter) ++ td (verb.s ! VPerf)) ++
          tr (th (heading imperfect_Parameter ++ heading participle_Parameter) ++ td (verb.s ! VPresPart)) ++
          tr (th (heading gerund_Parameter)            ++ td (verb.s ! VGer)) ++
          tr (th (heading aux_verb_Parameter)       ++ td (case verb.aux of {VHebben => "hebben" ; VZijn => "zijn"}))
        ) ;

}
