concrete ExtraSpa of ExtraSpaAbs = ExtraRomanceSpa ** 
  open CommonRomance, PhonoSpa, MorphoSpa, ParadigmsSpa, ParamX, ResSpa, BeschSpa,
  Prelude in {
  
  lin
    i8fem_Pron =  mkPronoun
      "yo" "me" "me" "mí"
      "mi" "mi" "mis" "mis"
      Fem Sg P1 ;
    these8fem_NP = makeNP ["estas"] Fem Pl ;
    they8fem_Pron = mkPronoun
      "ellas" "las" "les" "ellas"
      "su" "su" "sus" "sus"
      Fem Pl P3 ;
    this8fem_NP = pn2np (mkPN ["esta"] Fem) ;
    those8fem_NP = makeNP ["esas"] Fem Pl ;

    we8fem_Pron = mkPronoun 
      "nosotras" "nos" "nos" "nosotras"
      "nuestro" "nuestra" "nuestros" "nuestras"
      Fem Pl P1 ;
    whoPl8fem_IP = {s = \\c => prepCase c ++ "quién" ; a = aagr Fem Pl} ;
    whoSg8fem_IP = {s = \\c => prepCase c ++ "quién" ; a = aagr Fem Sg} ;

    youSg8fem_Pron = mkPronoun 
      "tú" "te" "te" "ti"
      "tu" "tu" "tus" "tus"
      Fem Sg P2 ;
    youPl8fem_Pron = mkPronoun
      "vosotras" "os" "os" "vosotras"
      "vuestro" "vuestra" "vuestros" "vuestras"
      Fem Pl P2 ;
    youPol8fem_Pron = mkPronoun
      "usted" "la" "le" "usted"
      "su" "su" "sus" "sus"
      Fem Sg P3 ;

    youPolPl_Pron = mkPronoun
      "ustedes" "los" "les" "usted"
      "su" "su" "sus" "sus"
      Masc Pl P3 ;
    youPolPl8fem_Pron = mkPronoun
      "ustedes" "las" "les" "usted"
      "su" "su" "sus" "sus"
      Fem Pl P3 ;

   --IL 2012-10-12
   ImpNeg np vp = lin Utt{ 
      s = (mkClause (np.s ! Nom).comp np.hasClit False np.a vp).s 
          ! DInv ! RPres ! Simul ! RNeg False ! Conjunct
      } ;

    -- ExtraRomance.PassVPSlash uses estar 
    PassVPSlash_ser vps = 
      let auxvp = predV copula
      in
      insertComplement (\\a => let agr = complAgr a in vps.s.s ! VPart agr.g agr.n) {
        s = auxvp.s ;
        agr = auxvp.agr ;
        neg = vps.neg ;
        clit1 = vps.clit1 ;
        clit2 = vps.clit2 ;
        clit3 = vps.clit3 ;
        isNeg = vps.isNeg ;
        comp  = vps.comp ;
        ext   = vps.ext
        } ;

    ExistsNP np = 
      mkClause [] True False np.a (insertComplement (\\_ => (np.s ! Nom).ton) (predV (mkV "existir"))) ;

}
