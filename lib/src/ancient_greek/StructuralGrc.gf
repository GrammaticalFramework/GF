--# -path=.:../abstract:prelude:../common

concrete StructuralGrc of Structural = CatGrc ** 
  open ResGrc, (M = MorphoGrc), (P = ParadigmsGrc), Prelude, (N = NounGrc) in 
  {

  flags optimize=all ;

  lin
  above_Prep = P.mkPrep "y(pe'r" Acc ;
  after_Prep = P.mkPrep "meta'" Acc ;
--  all_Predet = ss "all" ;
--  almost_AdA = ss "almost" ;
--  almost_AdN = ss "quasi" ;
  although_Subj = ss "kai'per" ;
  always_AdV = P.mkAdV "a)ei'" ; -- Adv or AdV ??
  and_Conj = sd2 [] "kai'" ** {n = Pl} ;
  because_Subj = ss "a('te" ;  -- ss "w(s*" -- ss "dio'ti"
  before_Prep = P.mkPrep "pro'" Gen ;
  behind_Prep = P.mkPrep "o)'pisven" Gen ;  -- BR 198
  between_Prep = P.mkPrep "metaxy'" Gen ;   -- BR 198
  both7and_DConj = sd2 "kai'" "kai'" ** {n = Pl} ;  -- resp.: te - kai
  but_PConj = ss "de'" ;
  by8agent_Prep = P.mkPrep "y(po'" Gen ; -- TESTWORD
  by8means_Prep = P.mkPrep "dia'" Acc ;
--  can8know_VV, can_VV = {
--    s = table { 
--      VVF VInf => ["be able to"] ;
--      VVF VPres => "can" ;
--      VVF VPPart => ["been able to"] ;
--      VVF VPresPart => ["being able to"] ;
--      VVF VPast => "could" ;      --# notpresent
--      VVPastNeg => "couldn't" ;   --# notpresent
--      VVPresNeg => "can't"
--      } ;
--    isAux = True
--    } ;
  during_Prep = P.mkPrep "e)n" Dat ;
  either7or_DConj = sd2 "h)'" "h)'" ** {n = Sg} ;
--  everybody_NP = regNP "everybody" Sg ;
  every_Det = M.detLikeAdj Sg "pa~s" "panto's" ; -- TODO: Accent in Neutr
--  everything_NP = regNP "everything" Sg ;
  everywhere_Adv = ss "pantacoy~" ;
  few_Det = M.detLikeAdj Pl "o)li'gos" ; -- TODO: check accents
--  first_Ord = ss "first" ; DEPRECATED
  for_Prep = P.mkPrep "pro'" Gen ;
  from_Prep = P.mkPrep "e)x" Gen ;  --  from_Prep = mkPrep "a)po'" Gen ;
  he_Pron = M.mkPron Masc Sg P3 ;
  here_Adv = ss "e)nva'de" ;
  here7to_Adv = ss "e)nva'de" ;
  here7from_Adv = ss "e)nve'nde" ;
  how_IAdv = ss "pw~s*" ;
  how8many_IDet = M.detLikeAdj Pl "po'sos" ; -- BR 73 1
  if_Subj = ss "e(i" ; -- "ea'n"
--  in8front_Prep = mkPrep "coram" Abl ;
  i_Pron = M.mkPron Masc Sg P1 ;
  in_Prep = P.mkPrep "e)n" Dat ;
  it_Pron = M.mkPron Neutr Sg P3 ;
--  less_CAdv = ss "less" ;
  many_Det = lin Det (M.detLikeAdj Pl "pollo's") ; -- Sg exception Nom|Acc polly'(s|n)
--  more_CAdv = ss "more" ;
--  most_Predet = ss "most" ;
  much_Det = let det : Determiner = M.detLikeAdj Sg "pollo's" 
              in { s = \\g,c => case <g,c> of { <Masc,Nom> => "polly's*" ; 
                                                <Masc,Acc> => "polly'n" ;
                                                <Neutr,Nom|Acc> => "polly'" ;
                                                _ => det.s ! g ! c } ;
                   n = det.n } ;
--  must_VV = {
--    s = table {
--      VVF VInf => ["have to"] ;
--      VVF VPres => "must" ;
--      VVF VPPart => ["had to"] ;
--      VVF VPresPart => ["having to"] ;
--      VVF VPast => ["had to"] ;      --# notpresent
--      VVPastNeg => ["hadn't to"] ;      --# notpresent
--      VVPresNeg => "mustn't"
--      } ;
--    isAux = True
--    } ;
  no_Utt = ss (variants{ "oy)'" ;  "pw~s* ga'r ;" ; "oy) dh~ta" }) ;
  on_Prep = P.mkPrep "e)pi'" Dat;
--  one_Quant = mkDeterminer Sg "one" ; -- DEPRECATED
--  only_Predet = ss "tantum" ;
  or_Conj = sd2 [] "h)'" ** {n = Sg} ;
--  otherwise_PConj = ss "otherwise" ;
  part_Prep = P.mkPrep [] Gen ;    -- TODO: postnominal
--  please_Voc = ss "please" ;
  possess_Prep = P.mkPrep [] Gen ; -- TODO: prenominal
--  quite_Adv = ss "quite" ;
  she_Pron = M.mkPron Fem Sg P3 ;
--  so_AdA = ss "sic" ;
  somebody_NP = M.indefPronNP Masc Sg ;
  someSg_Det = M.mkDeterminer2 Sg (cases "tis*" "tina'" "tino's*" "tini'") 
                                (cases "ti" "ti" "tino's*" "tini'") ;
  somePl_Det = M.mkDeterminer2 Pl (cases "tine's*" "tina's*" "tinw~n" "tisi'") 
                                (cases "tina'" "tina'" "tinw~n" "tisi'") ;
  something_NP = M.indefPronNP Neutr Sg ;
  somewhere_Adv = ss "poy" ;
  that_Quant = ekeinos_Quantifier ;  -- TODO correct accents
  that_Subj = ss "o('ti" ; 
  there_Adv = ss "ay)toy~" ;         -- ss "e)ntay~va" ;  ss "e)kei~" 
  there7to_Adv = ss "e)ntay~va" ;    -- ss "ay)to'se" ;   ss "e)kei~se" 
  there7from_Adv = ss "e)ntey~ven" ; -- ss "ay)t'ven" ;   ss "e)kei~ven" 
  therefore_PConj = ss "kai'toi" ;  -- BR 253.24
  they_Pron = M.mkPron Masc Pl P3 ;
  this_Quant = hode_Quantifier ;
  through_Prep = P.mkPrep "dia'" Gen;
  too_AdA = ss "a)'gan" ;
  to_Prep = P.mkPrep "pro's" Acc ;
  under_Prep = P.mkPrep "y(po'" Gen ;
--  very_AdA = ss "valde" ;
  want_VV = P.mkVV (P.mkV "boy'lomai") ;  -- TODO: fut boylh'somai, e)boylh'vhn  -- me'llw
  we_Pron = M.mkPron Masc Pl P1 ;
  whatPl_IP = M.mkIP Pl Neutr ; 
  whatSg_IP = M.mkIP Sg Neutr ; 
  when_IAdv = ss "po'te" ;
  when_Subj = ss "o('te" ;  -- "o(po'te"  "h(ni'ka"  "e)pei'"  "e)peidh'"  "w(s*"  BR 286
  where_IAdv = ss "poy~" ;
  which_IQuant = {s = \\n,g,c => M.iPron ! n ! g ! c} ;
  whoPl_IP = M.mkIP Pl Masc ;
  whoSg_IP = M.mkIP Sg Masc ; 
  why_IAdv = ss "dio'ti" ;
  without_Prep = P.mkPrep "a)'ney" Gen ;
  with_Prep = P.mkPrep "sy'n" Dat ;  -- P.mkPrep "meta'" Gen 
  yes_Utt = ss "nai'" ;
  youSg_Pron = M.mkPron Masc Sg P2 ;
  youPl_Pron = M.mkPron Masc Pl P2 ;
  youPol_Pron = M.mkPron Masc Sg P2 ; -- Is there a polite form in ancient greek?

--   no_Quant : Quant ; 
--   not_Predet : Predet ;
--   if_then_Conj : Conj ;
--   at_least_AdN : AdN ;
--   at_most_AdN : AdN ;
--   nobody_NP : NP ;  -- "oy)dei's*"  BR 73 1
  nobody_NP = quantNP oydeis_Quantifier mhdeis_Quantifier Masc Sg ;
  nothing_NP = quantNP oydeis_Quantifier mhdeis_Quantifier Neutr Sg ; -- "oy)de'n"
  except_Prep = P.mkPrep "a)'ney" Gen ;

--   as_CAdv : CAdv ;

--   have_V2 : V2 ;
--   have_V3 : V3 ;
--   have_not_V3 : V3; 

  lin language_title_Utt = ss "ancientgreek" ;

  oper 
    quantNP : Quantifier -> Quantifier -> Gender -> Number -> NP = \p,q,g,n -> 
      lin NP { s = \\c => p.s ! n ! g ! c ;
        isPron = False ;
        e = \\c => q.s ! n ! g ! c ;
        a = Ag g n P3 } ;
}

