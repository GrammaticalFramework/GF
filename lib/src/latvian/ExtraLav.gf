--# -path=.:../abstract:../common:../prelude

concrete ExtraLav of ExtraLavAbs = CatLav ** open
  ParadigmsLav,
  ParadigmsPronounsLav,
  VerbLav,
  ResLav,
  Coordination,
  Prelude
  in {

flags
  coding = utf8 ;

lin
  -- NP -> CN -> CN ;
  GenCN np cn = {
    s = \\d,n,c => np.s ! Gen ++ cn.s ! d ! n ! c ;
    g = cn.g
  } ;

  aiz_Prep = mkPrep "aiz" Gen Dat ;
  ap_Prep = mkPrep "ap" Acc Dat ;
  gar_Prep = mkPrep "gar" Acc Dat ;
  kopsh_Prep = mkPrep "kopš" Gen Dat ;
  liidz_Prep = mkPrep "līdz" Dat Dat ;
  pa_Prep = mkPrep "pa" Acc Dat ;
  --par_Prep = mkPrep "par" Acc Dat ;
  paar_Prep = mkPrep "pār" Acc Dat ;
  pie_Prep = mkPrep "pie" Gen Dat ;
  pret_Prep = mkPrep "pret" Acc Dat ;
  
  i8fem_Pron = mkPronoun_I Fem ;
  we8fem_Pron = mkPronoun_We Fem ;

  youSg8fem_Pron = mkPronoun_You_Sg Fem ;
  youPol8fem_Pron = mkPronoun_You_Pol Fem ;
  youPl8fem_Pron = mkPronoun_You_Pl Fem ;

  they8fem_Pron = mkPronoun_They Fem ;
  it8fem_Pron = mkPronoun_It_Sg Fem ;

  {-empty_Det num def neg = \num,def,neg -> {
    s = \\_,_ => [] ;
    n = num ;
    d = def ;
    isNeg = neg
  } ;-}

  -- Zemāk esošās f-cijas nav ExtraLavAbs, tās ir abstract/Extra.gf

  GenNP np = {
    s = \\_,_,_ => np.s ! Gen ;
    d = Def ;
    isNeg = np.isNeg
  } ;

  --ICompAP ap = {s = \\g,n => "cik" ++ ap.s ! Indef ! g ! n ! Nom } ;

  IAdvAdv adv = {s = "cik" ++ adv.s} ;

  have_V3 = mkV3 (mkV "būt") nom_Prep dat_Prep Dat ;

  -- for VP conjunction

  lincat
    VPS   = {s : Agr => Str} ;
    [VPS] = {s1,s2 : Agr => Str} ;

  lin
    BaseVPS = twoTable Agr ;
    ConsVPS = consrTable Agr comma ;

    -- NP -> VPS -> S
    -- NP = { s : Case => Str ; a : Agr ; isNeg : Bool } ;
    PredVPS np vps = {s = np.s ! Nom ++ vps.s ! np.a} ; -- TODO: vps.s ! np.a ! np.isNeg

    -- Temp -> Pol -> VP -> VPS
    MkVPS temp pol vp = {
      s = \\subjAgr =>
        -- VP = { v : Verb ; compl : Agr => Str ; agr : ClAgr ; objNeg : Bool } ;
        -- Verb = { s : Polarity => VerbForm => Str } ;
        -- TODO: other VerbForm-s (moods)
        -- TODO: subj-dependent double negation
        -- TODO: subj/obj isNeg jāpārceļ uz Agr (?)
        --let verb = vp.v.s ! pol.p ! Indicative (fromAgr agr).pers (fromAgr agr).num temp.t in
        temp.s ++ buildVerb vp.v (Ind temp.a temp.t) pol.p subjAgr False vp.objNeg ++ vp.compl ! subjAgr
      } ;
    
    -- Conj -> [VPS] -> VPS
    ConjVPS = conjunctDistrTable Agr ;
}
