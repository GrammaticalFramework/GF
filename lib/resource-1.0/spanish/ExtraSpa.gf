concrete ExtraSpa of ExtraSpaAbs = ExtraRomanceSpa ** 
  open CommonRomance, PhonoSpa, MorphoSpa, ParadigmsSpa, ParamX, ResSpa in {

  lin
    i8fem_Pron =  mkPronoun
      "yo" "me" "me" "mí"
      "mi" "mi" "mis" "mis"
      Fem Sg P1 ;
    these8fem_NP = mkNP ["estas"] Fem Pl ;
    they8fem_Pron = mkPronoun
      "ellas" "las" "les" "ellas"
      "su" "su" "sus" "sus"
      Fem Pl P3 ;
    this8fem_NP = pn2np (mkPN ["esta"] Fem) ;
    those8fem_NP = mkNP ["esas"] Fem Pl ;

    we8fem_Pron = mkPronoun 
      "nosotras" "nos" "nos" "nosotras"
      "nuestro" "nuestra" "nuestros" "nuestras"
      Fem Pl P1 ;
    whoPl8fem_IP = {s = \\c => prepCase c ++ "quién" ; a = aagr Fem Pl} ;
    whoSg8fem_IP = {s = \\c => prepCase c ++ "quién" ; a = aagr Fem Sg} ;

    youSg8fem_Pron = mkPronoun 
      "tu" "te" "te" "tí"
      "tu" "tu" "tus" "tus"
      Fem Sg P2 ;
    youPl8fem_Pron = mkPronoun
      "vosotras" "vos" "vos" "vosotras"
      "vuestro" "vuestra" "vuestros" "vuestras"
      Fem Pl P2 ;
    youPol8fem_Pron = mkPronoun
      "usted" "la" "le" "usted"
      "su" "su" "sus" "sus"
      Fem Sg P3 ;

    youPolPl_Pron = mkPronoun
      "ustedes" "las" "les" "usted"
      "su" "su" "sus" "sus"
      Masc Pl P3 ;
    youPolPl8fem_Pron = mkPronoun
      "ustedes" "las" "les" "usted"
      "su" "su" "sus" "sus"
      Fem Pl P3 ;


}
