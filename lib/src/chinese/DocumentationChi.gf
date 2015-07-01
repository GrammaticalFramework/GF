concrete DocumentationChi of Documentation = CatChi ** open
  ResChi,
  HTML 
in {

lincat
  Inflection = {t : Str; s1,s2 : Str} ;
  Document = {s : Str} ;
  Tag = {s : Str} ;

lin
  InflectionN, InflectionN2, InflectionN3 = \noun -> {
    t  = "n" ;
    s1 = heading1 "Noun" ;
    s2 = noun.s ++ "c." ++ noun.c ;
    } ;

  InflectionA, InflectionA2 = \adj -> {
    t  = "a" ;
    s1 = heading1 "Adjective" ;
    s2 = adj.s
    } ;
    
  InflectionAdv adv = {
    t  = "adv" ;
    s1 = heading1 "Adverb" ;
    s2 = paragraph adv.s
    } ;

  InflectionPrep p = {
    t  = "prep" ;
    s1 = heading1 "Preposition" ;
    s2 = paragraph (p.prepPre ++ p.prepPost)
    } ;

  InflectionV = \verb -> {
    t  = "v" ;
    s1 = heading1 "Verb" ++
         paragraph (pp "subject" ++ verb.s) ;
    s2 = inflVerb verb
    } ;

  InflectionV2 = \verb -> {
    t  = "v" ;
    s1 = heading1 "Verb" ++
         paragraph (pp "subject" ++ verb.s ++ verb.c2.prepPre ++ pp "object" ++ verb.c2.prepPost ++ verb.part) ;
    s2 = inflVerb verb
    } ;

  InflectionV3 = \verb -> {
    t  = "v" ;
    s1 = heading1 "Verb" ++
         paragraph (pp "subject" ++ verb.s ++ verb.c2.prepPre ++ pp "arg1" ++ verb.c2.prepPost ++ verb.c3.prepPre ++ pp "arg2" ++ verb.c3.prepPre ++ verb.part) ;
    s2 = inflVerb verb
    } ;

  InflectionV2V = \verb -> {
    t  = "v" ;
    s1 = heading1 "Verb" ++
         paragraph (pp "subject" ++ verb.s ++ verb.c2.prepPre ++ pp "object" ++ verb.c2.prepPost ++ pp "verb" ++ verb.part) ;
    s2 = inflVerb verb
    } ;

  InflectionV2S = \verb -> {
    t  = "v" ;
    s1 = heading1 "Verb" ++
         paragraph (pp "subject" ++ verb.s ++ verb.c2.prepPre ++ pp "object" ++ verb.c2.prepPost ++ pp "sentence" ++ verb.part) ;
    s2 = inflVerb verb
    } ;

  InflectionV2Q = \verb -> {
    t  = "v" ;
    s1 = heading1 "Verb" ++
         paragraph (pp "subject" ++ verb.s ++ verb.c2.prepPre ++ pp "object" ++ verb.c2.prepPost ++ pp "question" ++ verb.part) ;
    s2 = inflVerb verb
    } ;

  InflectionV2A = \verb -> {
    t  = "v" ;
    s1 = heading1 "Verb" ++
         paragraph (pp "subject" ++ verb.s ++ verb.c2.prepPre ++ pp "object" ++ verb.c2.prepPost ++ pp "adjective" ++ verb.part) ;
    s2 = inflVerb verb
    } ;

  InflectionVV = \verb -> {
    t  = "v" ;
    s1 = heading1 "Verb" ++
         paragraph (pp "subject" ++ verb.s ++ pp "verb") ;
    s2 = inflVerb verb
    } ;

  InflectionVS = \verb -> {
    t  = "v" ;
    s1 = heading1 "Verb" ++
         paragraph (pp "subject" ++ verb.s ++ pp "sentence") ;
    s2 = inflVerb verb
    } ;

  InflectionVQ = \verb -> {
    t  = "v" ;
    s1 = heading1 "Verb" ++
         paragraph (pp "subject" ++ verb.s ++ pp "question") ;
    s2 = inflVerb verb
    } ;

  InflectionVA = \verb -> {
    t  = "v" ;
    s1 = heading1 "Verb" ++
         paragraph (pp "subject" ++ verb.s ++ pp "adjective") ;
    s2 = inflVerb verb
    } ;

oper
  inflVerb : Verb -> Str = \verb ->
    let vtbl = useVerb verb
    in frameTable (
         tr (th "" ++ th "pos" ++ th "neg") ++
         tr (th ""      ++ td (vtbl ! Pos ! APlain) ++ td (vtbl ! Neg ! APlain)) ++
         tr (th "perf"  ++ td (vtbl ! Pos ! APerf) ++ td (vtbl ! Neg ! APerf)) ++
         tr (th "stat"  ++ td (vtbl ! Pos ! ADurStat) ++ td (vtbl ! Neg ! ADurStat)) ++
         tr (th "progr" ++ td (vtbl ! Pos ! ADurProg) ++ td (vtbl ! Neg ! ADurProg)) ++
         tr (th "exper" ++ td (vtbl ! Pos ! AExper) ++ td (vtbl ! Neg ! AExper))) ;

  pp : Str -> Str = \s -> "&lt;"+s+"&gt;" ;

lin
  MkDocument b i e = {s=i.s1 ++ "<p style=\"font-size:20px\">"++b.s++"</p>" ++ i.s2 ++ paragraph e.s} ;
  MkTag i = {s=i.t} ;

}
