concrete ExtraPor of ExtraPorAbs = ExtraRomancePor **
  open CommonRomance, PhonoPor, MorphoPor, ParadigmsPor, ParamX, ResPor, BeschPor, (I = IrregPor), (S = StructuralPor),
  Prelude in {
  flags coding=utf8 ;

  lin
    --- Prons
    i8fem_Pron = pronAgr S.i_Pron Fem Sg P1 ;
    youSg8fem_Pron = pronAgr S.youSg_Pron Fem Sg P3 ;
    we8fem_Pron = pronAgr S.we_Pron Fem Pl P1 ;
    youPl8fem_Pron = pronAgr S.youPl_Pron Fem Pl P3 ;
    youPolPl_Pron = S.youPlPol_Pron ;
    youPol8fem_Pron = pronAgr S.youSgPol_Pron Fem Sg P2 ;
    youPolPl8fem_Pron = pronAgr S.youPlPol_Pron Fem Pl P2 ;
    they8fem_Pron = mkPronFrom S.they_Pron "elas" "as" "lhes" "elas" Fem Pl P3 ;


    these8fem_NP = makeNP ["estas"] Fem Pl ;
    this8fem_NP = pn2np (mkPN ["esta"] Fem) ;
    those8fem_NP = makeNP ["essas"] Fem Pl ;

    whoPl8fem_IP = {s = \\c => prepCase c ++ "quem" ; a = aagr Fem Pl} ;
    whoSg8fem_IP = {s = \\c => prepCase c ++ "quem" ; a = aagr Fem Sg} ;

   ImpNeg np vp = lin Utt{
      s = (mkClause (np.s ! Nom).comp np.hasClit False np.a vp).s
          ! DInv ! RPres ! Simul ! RNeg False ! Conjunct
      } ;

   InvQuestCl cl = {
      s = \\t,a,p =>
            let cls = cl.s ! DInv ! t ! a ! p
            in table {
              QDir   => cls ! Indic ;
              QIndir => subjIf ++ cls ! Indic
              }
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

    UseComp_estar comp = insertComplement comp.s (predV I.estar_V) ;

}
