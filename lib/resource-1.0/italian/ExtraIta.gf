concrete ExtraIta of ExtraItaAbs = ExtraRomanceIta ** 
  open CommonRomance, ParadigmsIta, PhonoIta, MorphoIta, ParamX, ResIta in {

  lin
    i8fem_Pron = mkPronoun
      "io" "mi" "mi" "me" "me" "mio" "mia" "miei" "mie"
      Fem Sg P1 ;
    these8fem_NP = mkNP ["queste"] Fem Pl ;
    they8fem_Pron = mkPronoun
      "loro" "loro" "li" "glie" "loro" "loro" "loro" "loro" "loro" 
      Fem Pl P3 ;
    this8fem_NP = pn2np (mkPN ["questa"] Fem) ;
    those8fem_NP = mkNP ["quelle"] Fem Pl ;
    we8fem_Pron = 
      mkPronoun "noi" "ci" "ci" "ce" "noi" "nostro" "nostra" "nostri" "nostre"
      Fem Pl P1 ;
    whoPl8fem_IP = {s = \\c => prepCase c ++ "chi" ; a = aagr Fem Pl} ;
    whoSg8fem_IP = {s = \\c => prepCase c ++ "chi" ; a = aagr Fem Sg} ;

    youSg8fem_Pron = mkPronoun 
      "tu" "ti" "ti" "te" "te" "tuo" "tua" "tuoi" "tue"
      Fem Sg P2 ;
    youPl8fem_Pron =
      mkPronoun
        "voi" "vi" "vi" "ve" "voi" "vostro" "vostra" "vostri" "vostre"
        Fem Pl P2 ;
    youPol8fem_Pron =
      mkPronoun
        "Lei" "La" "Le" "Glie" "Lei" "Suo" "Sua" "Suoi" "Sue"
        Fem Sg P3 ;

    youPolPl_Pron = mkPronoun
      "Loro" "Loro" "Li" "Glie" "Loro" "Loro" "Loro" "Loro" "Loro" 
      Masc Pl P3 ;
    youPolPl8fem_Pron = mkPronoun
      "Loro" "Loro" "Li" "Glie" "Loro" "Loro" "Loro" "Loro" "Loro" 
      Fem Pl P3 ;

}
