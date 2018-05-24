-- the Extra* modules are to be deprecated in favour of the Extend*
-- module.
concrete ExtraPor of ExtraPorAbs = ExtraRomancePor **
  open CommonRomance, PhonoPor, MorphoPor, ParadigmsPor, ParamX, ResPor, BeschPor, (B = IrregBeschPor), (E = ExtendPor),
  Prelude in {
  flags coding=utf8 ;

  lin
    --- Prons
    i8fem_Pron = E.iFem_Pron ;
    youSg8fem_Pron = E.youFem_Pron ;
    we8fem_Pron = E.weFem_Pron ;
    youPl8fem_Pron = E.youPlFem_Pron ;
    youPolPl_Pron = E.youPolPl_Pron ;
    youPol8fem_Pron = E.youPolFem_Pron ;
    youPolPl8fem_Pron = E.youPolPlFem_Pron ;
    they8fem_Pron = E.theyFem_Pron ;


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
    PassVPSlash_ser = E.PassVPSlash ;

    ExistsNP = E.ExistsNP ;

    UseComp_estar comp = insertComplement comp.s (predV B.estar_V) ;

}
