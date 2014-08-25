--# -path=.:../romance:../common:../abstract

resource MakeStructuralFre = open CatFre, (P = ParadigmsFre), MorphoFre, Prelude in {

oper 
  mkConj : Str -> Str -> Number -> Conj = \x,y,n -> 
    {s1 = x ; s2 = y ; n = n ; lock_Conj = <>} ;
  mkSubj : Str -> Subj = \x -> 
    {s = x ; m = Indic ; lock_Subj = <>} ;
  mkSubjSubj : Str -> Subj = \x -> 
    {s = x ; m = Conjunct ; lock_Subj = <>} ;

  mkQuant : (_,_,_,_ : Str) -> Quant = \sm,sf,pm,pf -> 
    let aucun : ParadigmsFre.Number => ParadigmsFre.Gender => Case => Str = table {
      Sg => \\g,c => prepCase c ++ genForms sm sf ! g ;
      Pl => \\g,c => prepCase c ++ genForms pm pf ! g 
      }
    in lin Quant {
    s = \\_ => aucun ;
    sp = aucun ;
    s2 = [] ;
    isNeg = False
    } ;

  mkIQuant : Str -> IQuant = \s ->
    {s = \\_,_,c => prepCase c ++ s ; lock_IQuant = <>} ;

  mkPredet : Str -> Str -> Prep -> Bool -> Predet = \m,f,c,p -> lin Predet {
    s = \\g,k => prepCase k ++ case g.g of {Masc => m ; Fem => f} ; 
    c = c.c ; 
    a = if_then_else PAgr p (PAg Sg) PNoAg ---- e,g, "chacun de"; other possibilities?
    } ;


}
