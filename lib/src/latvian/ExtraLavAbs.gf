--# -path=.:../abstract:../common:../prelude

abstract ExtraLavAbs = Extra **
--open ResLav, Prelude in
{

  fun
    GenCN : NP -> CN -> CN ;

    aiz_Prep : Prep ;
    ap_Prep : Prep ;
    gar_Prep : Prep ;
    kopsh_Prep : Prep ;
    liidz_Prep : Prep ;
    pa_Prep : Prep ;
    --par_Prep : Prep ;
    paar_Prep : Prep ;
    pie_Prep : Prep ;
    pret_Prep : Prep ;

    i8fem_Pron : Pron ;
    we8fem_Pron : Pron ;
    youSg8fem_Pron : Pron ;
    youPol8fem_Pron : Pron ;
    youPl8fem_Pron : Pron ;
    they8fem_Pron : Pron ;
    it8fem_Pron : Pron ;

    --empty_Det : Number -> Definiteness -> Bool -> Det ;

    have_V3 : V3 ;
}
