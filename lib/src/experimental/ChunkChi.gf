concrete ChunkChi of Chunk = 
  RGLBaseChi - [Pol,Tense,Ant], 
  NDPredChi 

  ** open (PI=PredInstanceChi), ResChi, Prelude in {

lincat
  Chunks = {s : Str} ;
  Chunk = {s : Str};

lin
  OneChunk c = c ;
  PlusChunk c cs = cc2 c cs ;

  ChunkPhr c = ss ("*" ++ c.s) | c ;

lin


  AP_Chunk ap = ap ;
  AdA_Chunk ada = ada ;
  Adv_Chunk adv = adv ;
  AdV_Chunk adv = adv ;
  AdN_Chunk adn = adn ;
  Cl_Chunk, Cl_np_Chunk = \cl -> ss (PI.declCl cl) ;
  QCl_Chunk, QCl_np_Chunk = \cl -> ss (PI.questCl cl) ;
  CN_Pl_Chunk cn = cn ;
  CN_Sg_Chunk cn = cn ;
  CN_Pl_Gen_Chunk cn = ss (cn.s ++ de_s) ;
  CN_Sg_Gen_Chunk cn = ss (cn.s ++ de_s) ;
  Conj_Chunk conj = ss (conj.s ! CSent).s2 ;
  IAdv_Chunk iadv = iadv ; 
  IP_Chunk ip = ip ;
  NP_Nom_Chunk np = np ;
  NP_Acc_Chunk np = np ;
  NP_Gen_Chunk np = ss (np.s ++ de_s) ;
  Numeral_Nom_Chunk num = ss (num.s ++ ge_s) ;
  Numeral_Gen_Chunk num = ss (num.s ++ ge_s ++ de_s) ;
  Ord_Nom_Chunk ord = ord ;
  Ord_Gen_Chunk ord = ord ;
  Predet_Chunk predet = predet ;
  Prep_Chunk prep = ss (prep.prepPre ++ prep.prepPost) ;
  RP_Nom_Chunk rp = rp ;
  RP_Acc_Chunk rp = rp ;
  RP_Gen_Chunk rp = ss (rp.s ++ de_s) ;
  Subj_Chunk subj = ss (subj.prePart ++ subj.sufPart) ;

  VP_none_Chunk, 
  VP_np_Chunk, 
  VP_s_Chunk, 
  VP_v_Chunk,
  VP_a_Chunk,
  VP_q_Chunk,
  VP_np_np_Chunk, 
  VP_np_s_Chunk, 
  VP_np_a_Chunk,
  VP_np_q_Chunk,
  VP_np_v_Chunk 
  = \vp -> 
    let verb = vp.v ! PI.UUnit
    in ss (
    verb.p1 ++ vp.adV ++ vp.adv ++ verb.p2 ++ verb.p3 ++ vp.part ++
    vp.adj ! PI.UUnit ++ vp.obj1.p1 ! PI.UUnit ++ vp.obj2.p1 ! PI.UUnit ++ vp.ext
    ) ;

  VP_none_inf_Chunk, 
  VP_np_inf_Chunk, 
  VP_s_inf_Chunk, 
  VP_a_inf_Chunk, 
  VP_q_inf_Chunk, 
  VP_v_inf_Chunk,
  VP_np_np_inf_Chunk, 
  VP_np_s_inf_Chunk, 
  VP_np_a_inf_Chunk, 
  VP_np_q_inf_Chunk, 
  VP_np_v_inf_Chunk 
    = \vp -> ss (PI.infVP PI.UUnit PI.UUnit vp) ;

  V_none_prespart_Chunk,
  V_np_prespart_Chunk,
  V_s_prespart_Chunk,
  V_a_prespart_Chunk,
  V_q_prespart_Chunk,
  V_v_prespart_Chunk,
  V_np_np_prespart_Chunk,
  V_np_s_prespart_Chunk,
  V_np_a_prespart_Chunk,
  V_np_q_prespart_Chunk,
  V_np_v_prespart_Chunk 
    = \v -> ss (PI.vPresPart v PI.defaultAgr) ;

  V_none_pastpart_Chunk,
  V_np_pastpart_Chunk,
  V_s_pastpart_Chunk,
  V_a_pastpart_Chunk,
  V_q_pastpart_Chunk,
  V_v_pastpart_Chunk,
  V_np_np_pastpart_Chunk,
  V_np_s_pastpart_Chunk,
  V_np_a_pastpart_Chunk,
  V_np_q_pastpart_Chunk,
  V_np_v_pastpart_Chunk 
    = \v -> ss (PI.vPastPart v PI.defaultAgr) ;

  copula_inf_Chunk = ss "att vara" | ss "vara" ;

  refl_SgP1_Chunk = ss reflPron ;
  refl_SgP2_Chunk = ss reflPron ;
  refl_SgP3_Chunk = ss reflPron ;
  refl_PlP1_Chunk = ss reflPron ;
  refl_PlP2_Chunk = ss reflPron ;
  refl_PlP3_Chunk = ss reflPron ;
  neg_Chunk = ss neg_s ;
  copula_Chunk = ss copula_s ;
  copula_neg_Chunk = ss (neg_s ++ copula_s) ;
  past_copula_Chunk = ss "了" ;
  past_copula_neg_Chunk = ss (neg_s ++ copula_s ++ "了") ;
  future_Chunk = ss copula_s ; ----
  future_neg_Chunk = ss (neg_s ++ copula_s) ;
  cond_Chunk = ss copula_s ; ----
  cond_neg_Chunk = ss (neg_s ++ copula_s) ;
  perfect_Chunk = ss "了" ;
  perfect_neg_Chunk = ss (neg_s ++ copula_s ++ "了") ;
  past_perfect_Chunk = ss "了" ;
  past_perfect_neg_Chunk = ss (neg_s ++ copula_s ++ "了") ;
  

}