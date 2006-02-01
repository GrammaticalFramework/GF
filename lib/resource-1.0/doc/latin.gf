--1 A Latin grammar to illustrate some main dependencies
--
-- All implementations of the resource API have so far been variations
-- and extensions of this. The most notable regularities are
-- - which types of features each category has
-- - how inherent features are inherited and passed to parameters
-- 
--


cat
  Cl ;  -- clause
  VP ;  -- verb phrase
  V2 ;  -- two-place verb
  NP ;  -- noun phrase
  CN ;  -- common noun
  Det ; -- determiner
  AP ;  -- adjectival phrase

fun
  PredVP  : NP  -> VP -> Cl ;  -- predication
  ComplV2 : V2  -> NP -> VP ;  -- complementization
  DetCN   : Det -> CN -> NP ;  -- determination
  ModCN   : AP  -> CN -> CN ;  -- modification

param
  Number   = Sg | Pl ;
  Person   = P1 | P2 | P3 ;
  Tense    = Pres | Past ;
  Polarity = Pos | Neg ;
  Case     = Nom | Acc | Dat ;
  Gender   = Masc | Fem | Neutr ;

oper
  Agr = {g : Gender ; n : Number ; p : Person} ; -- agreement features

lincat
  Cl = {
    s : Tense => Polarity => Str
    } ;
  VP  = {
    verb  : Tense => Polarity => Agr => Str ; 
    neg   : Polarity => Str ;                  -- negation
    compl : Agr => Str                         -- complement
    } ;
  V2 = {
    s : Tense  => Number => Person => Str ; 
    c : Case                                   -- complement case
    } ;
  NP = {
    s : Case => Str ; 
    a : Agr                                    -- agreement features
    } ;
  CN = {
    s : Number => Case => Str ; 
    g : Gender
    } ;
  Det = {
    s : Gender => Case => Str ; 
    n : Number
    } ;
  AP = {
    s : Gender => Number => Case => Str
    } ;

lin
  PredVP np vp = {
    s = \\t,p => 
      let
        agr = np.a ;
        subject = np.s ! Nom ;
        object  = vp.compl ! agr ;
        verb    = vp.neg ! p ++ vp.verb ! t ! p ! agr  
      in                      
      subject ++ object ++ verb
    } ;

  ComplV2 v np = {
    verb  = \\t,p,a => v.s ! t ! a.n ! a.p ;
    compl = \\_ => np.s ! v.c ;
    neg   = table {Pos => [] ; Neg => "non"}
    } ;

  DetCN det cn = 
    let 
      g = cn.g ; 
      n = det.n
    in {
      s = \\c => det.s ! g ! c ++ cn.s ! n ! c ;
      a = {g = g ; n = n ; p = P3}
      } ;

  ModCN ap cn = 
    let 
      g = cn.g 
    in {
      s = \\n,c => cn.s ! n ! c ++ ap.s ! g ! n ! c ;
      g = g
      } ;

-- lexicon to test

fun
  ego_NP : NP ;
  omnis_Det : Det ;
  defPl_Det : Det ;

  amare_V2 : V2 ;
  licere_V2 : V2 ;
  puella_CN : CN ;
  servus_CN : CN ;
  habilis_AP : AP ;

lin
  ego_NP = {
    s = table Case ["ego" ; "me" ; "mihi"] ; 
    a = {g = Fem ; n = Sg ; p = P1}
    } ;

  omnis_Det = {
    s = table {
      Masc | Fem => table Case ["omnis" ; "omnem" ; "omni"] ;
      _          => table Case ["omne"  ; "omne"  ; "omni"]
      } ;
    n = Sg
    } ;

  defPl_Det = {
    s = \\_,_ => [] ;
    n = Pl
    } ;

  amare_V2 = {
    s = \\t,n,p => table (Tense * Number * Person) [
      "amo"    ; "amas"   ; "amat"   ; "amamus"   ; "amatis"   ; "amant" ;
      "amabam" ; "amabas" ; "amabat" ; "amabamus" ; "amabatis" ; "amabant"
      ] ! <t,n,p> ;
    c = Acc
    } ;

  licere_V2 = {
    s = \\t,n,p => table (Tense * Number * Person) [
      "liceo"   ; "lices"   ; "licet"   ; "licemus"   ; "licetis"   ; "licent" ;
      "licebam" ; "licebas" ; "licebat" ; "licebamus" ; "licebatis" ; "licebant"
      ] ! <t,n,p> ;
    c = Dat
    } ;

  puella_CN = {
    s = \\n,c => table (Number * Case) [
      "puella"  ; "puellam" ; "puellae" ;
      "puellae" ; "puellas" ; "puellis"
      ] ! <n,c> ;
    g = Fem
    } ;

  servus_CN = {
    s = \\n,c => table (Number * Case) [
      "servus" ; "servum"  ; "servo" ;
      "servi"  ; "servos"  ; "servis"
      ] ! <n,c> ;
    g = Masc
    } ;

  habilis_AP = {
    s = table {
      Masc | Fem => \\n,c => table (Number * Case) [
        "habilis" ; "habilem" ; "habili" ; "habiles" ; "habiles" ; "habilibus"
        ] ! <n,c> ;
      _ => \\n,c => table (Number * Case) [
        "habile" ; "habile" ; "habili" ; "habilia" ; "habilia" ; "habilibus"
        ] ! <n,c>
      }
    } ;

