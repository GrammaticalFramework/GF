--# -path=.:../abstract:../common:../prelude

concrete ExtraLav of ExtraLavAbs = CatLav ** open
  ParadigmsLav,
  ParadigmsPronounsLav,
  VerbLav,
  ResLav,
  Coordination
in {

flags coding = utf8 ;

lin
  -- NP -> CN -> CN
  GenCN np cn = {
    s = \\d,n,c => np.s ! Gen ++ cn.s ! d ! n ! c ;
    gend = cn.gend
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

  have_V3 = mkV3 (mkV "būt" Dat) nom_Prep dat_Prep ;

  {-
  empty_Det num def pol = \num,def,pol -> {
    s = \\_,_ => [] ;
    n = num ;
    d = def ;
    pol = pol
  } ;
  -}

  -- Zemāk esošās f-cijas nav ExtraLavAbs, tās ir abstract/Extra.gf

  -- NP -> Quant
  GenNP np = {
    s = \\_,_,_ => np.s ! Gen ;
    defin = Def ;
    pol = np.pol
  } ;

  --ICompAP ap = { s = \\g,n => "cik" ++ ap.s ! Indef ! g ! n ! Nom } ;

  IAdvAdv adv = { s = "cik" ++ adv.s } ;

  -- VP conjunction:

  lincat
    VPS = { s : AgrAgr => Str } ;
    [VPS] = { s1,s2 : AgrAgr => Str } ;

  lin
    BaseVPS = twoTable AgrAgr ;
    ConsVPS = consrTable AgrAgr comma ;

    -- NP -> VPS -> S
    PredVPS np vps = { s = np.s ! Nom ++ vps.s ! { agr = np.agr ; pol = np.pol } } ;

    -- Temp -> Pol -> VP -> VPS
    MkVPS temp pol vp = {
      s = \\agrAgr =>
        temp.s ++
        -- TODO: verb moods other than Ind
        buildVerb vp.v (Ind temp.a temp.t) pol.p agrAgr.agr agrAgr.pol vp.rightPol ++
        vp.compl ! agrAgr.agr
      } ;
    
    -- Conj -> [VPS] -> VPS
    ConjVPS = conjunctDistrTable AgrAgr ;

  oper AgrAgr : Type = { agr : Agreement ; pol : Polarity } ;

}
