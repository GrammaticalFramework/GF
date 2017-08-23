--# -path=alltenses:../common:../abstract

concrete ExtendSpa of Extend =
  CatSpa ** ExtendFunctor -
   [
   iFem_Pron, youFem_Pron, weFem_Pron, youPlFem_Pron, theyFem_Pron, youPolFem_Pron, youPolPl_Pron, youPolPlFem_Pron,
   ProDrop
   ]                   -- put the names of your own definitions here
  with
    (Grammar = GrammarSpa) **
  open
    GrammarSpa,
    ResSpa,
    MorphoSpa,
    Coordination,
    Prelude,
    ParadigmsSpa in {
    -- put your own definitions here

  lin
    iFem_Pron =  mkPronoun
      "yo" "me" "me" "mí"
      "mi" "mi" "mis" "mis"
      Fem Sg P1 ;
    theyFem_Pron = mkPronoun
      "ellas" "las" "les" "ellas"
      "su" "su" "sus" "sus"
      Fem Pl P3 ;

    weFem_Pron = mkPronoun 
      "nosotras" "nos" "nos" "nosotras"
      "nuestro" "nuestra" "nuestros" "nuestras"
      Fem Pl P1 ;

    youFem_Pron = mkPronoun 
      "tú" "te" "te" "ti"
      "tu" "tu" "tus" "tus"
      Fem Sg P2 ;
    youPlFem_Pron = mkPronoun
      "vosotras" "os" "os" "vosotras"
      "vuestro" "vuestra" "vuestros" "vuestras"
      Fem Pl P2 ;
    youPolFem_Pron = mkPronoun
      "usted" "la" "le" "usted"
      "su" "su" "sus" "sus"
      Fem Sg P3 ;

    youPolPl_Pron = mkPronoun
      "ustedes" "los" "les" "usted"
      "su" "su" "sus" "sus"
      Masc Pl P3 ;
    youPolPlFem_Pron = mkPronoun
      "ustedes" "las" "les" "usted"
      "su" "su" "sus" "sus"
      Fem Pl P3 ;

    ProDrop p = {
      s = table {
        Nom => let pn = p.s ! Nom in {c1 = pn.c1 ; c2 = pn.c2 ; comp = [] ; ton = pn.ton} ; 
        c => p.s ! c
        } ;
      a = p.a ;
      poss = p.poss ;
      hasClit = p.hasClit ;
      isPol = p.isPol ;
      isNeg = False
      } ;


    }