incomplete concrete ChunkFunctor of Chunk = Cat, Symbol [Symb], Extensions [VPS,VPI] ** 
  open 
    Syntax, Extensions, 
    Prelude in {

lincat
  Chunks = {s : Str} ;
  Chunk = {s : Str};

  VC = V ;

lin
  OneChunk c = c ;
  PlusChunk c cs = cc2 c cs ;

  ChunkPhr c = ss ("*" ++ c.s) | c ;

lin
  AP_Chunk ap = mkUtt ap ;
  AdA_Chunk ada = ada ;
  Adv_Chunk adv = adv ;
  AdV_Chunk adv = adv ;
  AdN_Chunk adn = adn ;
  S_Chunk s = mkUtt s ;
  SSlash_Chunk s = mkUtt <lin S s : S> ;
  QS_Chunk qs = mkUtt qs ;
  CN_Pl_Chunk cn = mkUtt (Syntax.mkNP aPl_Det cn) ;
  CN_Sg_Chunk cn = mkUtt cn ;
----  CN_Pl_Gen_Chunk cn = ss (cn.s ! Pl ! Gen) ;
----  CN_Sg_Gen_Chunk cn = ss (cn.s ! Sg ! Gen) ;
  Conj_Chunk conj = ss conj.s2 ; ----
  Det_Chunk det = mkUtt (Syntax.mkNP det) ;
  IAdv_Chunk iadv = iadv ; 
  IP_Chunk ip = mkUtt ip ;
  NP_Nom_Chunk np = mkUtt np ;
----  NP_Acc_Chunk np = ss (np.s ! NPAcc) ;
----  NP_Gen_Chunk np = ss (np.s ! NCase Gen) | ss (np.s ! NPNomPoss) ;
  Numeral_Nom_Chunk num = mkUtt (Syntax.mkNP (Syntax.mkDet num)) ;
----  Numeral_Gen_Chunk num = ss (num.s ! NCard ! Gen) ;
----  Ord_Nom_Chunk ord = ss (ord.s ! Nom) ;
----  Ord_Gen_Chunk ord = ss (ord.s ! Gen) ;
  Predet_Chunk predet = mkUtt (Syntax.mkNP predet emptyNP) ;
  Prep_Chunk prep = mkAdv prep emptyNP ; ----
----  RP_Nom_Chunk rp = ss (rp.s ! RC Neutr (NCase Nom)) ;
----  RP_Acc_Chunk rp = ss (rp.s ! RPrep Masc) ; ----
----  RP_Gen_Chunk rp = ss (rp.s ! RC Neutr (NCase Gen)) ;
  Subj_Chunk subj = subj ;
---  PConj_Chunk pconj = pconj ;

  VPS_Chunk vps = mkUtt (E.PredVPS emptyNP vps) ;
--  VPI_Chunk    : VPI -> Chunk ;


  V2_V, 
  VA_V,  
  VQ_V,   
  VS_V,
----  VV_V,
  V3_V,
  V2A_V,
  V2Q_V,
  V2S_V,
  V2V_V
    = \v -> <lin V v : V> ;

  UseVC t p vc = E.MkVPS t p (mkVP vc) ;

  Symb_Chunk s = lin Utt s ;

  fullstop_Chunk = sbSS "." ;
  exclmark_Chunk = sbSS "!" ;
  questmark_Chunk = sbSS "?" ;
  comma_Chunk = sbSS "," ;
  colon_Chunk = sbSS ":" ;
  semicolon_Chunk = sbSS ";" ;
  quote_Chunk = variants {sbSS "\"" ; ss ("\"" ++ SOFT_BIND) } ;
  lpar_Chunk = ss ("(" ++ SOFT_BIND) ;
  rpar_Chunk = sbSS ")" ;
  dash_Chunk = sbSS "-" ;

oper
  emptyNP : NP = Syntax.mkNP (P.mkPN []) ;

  sbSS : Str -> SS = \s -> ss (SOFT_BIND ++ s) ;
}