--# -path=.:../finnish/stemmed:../finnish:../api:../translator:alltenses

concrete ChunkFin of Chunk = 
  RGLBaseFin - [Pol,Tense], 
  NDPredFin 

  ** open (PI=PredInstanceFin), ResFin, StemFin, Prelude in {

lincat
  Chunks = {s : Str} ;
  Chunk = {s : Str};

lin
  OneChunk c = c ;
  PlusChunk c cs = cc2 c cs ;

  ChunkPhr c = ss ("*" ++ c.s) | c ;

lin


  AP_Chunk ap = ss (ap.s ! True ! NCase Sg Nom) ; ---- other agr
  AdA_Chunk ada = ada ;
  Adv_Chunk adv = adv ;
  AdV_Chunk adv = adv ;
  AdN_Chunk adn = adn ;
  Cl_Chunk, Cl_np_Chunk = \cl -> ss (PI.declCl cl) ;
  QCl_Chunk, QCl_np_Chunk = \cl -> ss (PI.questCl cl) ;
  CN_Pl_Chunk cn = ss (cn.s ! NCase Pl Nom) ;
  CN_Sg_Chunk cn = ss (cn.s ! NCase Sg Nom) ;
  CN_Pl_Gen_Chunk cn = ss (cn.s ! NCase Pl Gen) ;
  CN_Sg_Gen_Chunk cn = ss (cn.s ! NCase Sg Gen) ;
  Conj_Chunk conj = ss conj.s2 ;
  IAdv_Chunk iadv = iadv ; 
  IP_Chunk ip = ss (ip.s ! NPCase Nom) ;
  NP_Nom_Chunk np = ss (np.s ! NPCase Nom) ;
  NP_Acc_Chunk np = ss (np.s ! NPAcc) ;
  NP_Gen_Chunk np = ss (np.s ! NPCase Gen) ;
  Numeral_Nom_Chunk num = ss (num.s ! NCard (NCase Sg Nom)) ;
  Numeral_Gen_Chunk num = ss (num.s ! NCard (NCase Sg Gen)) ;
  Ord_Nom_Chunk ord = ss (ord.s ! NCase Sg Nom) ;
  Ord_Gen_Chunk ord = ss (ord.s ! NCase Sg Gen) ;
  Predet_Chunk predet = ss (predet.s ! Sg ! NPCase Nom) ;
  Prep_Chunk prep = ss (prep.s.p1 ++ prep.s.p2) ;
  RP_Nom_Chunk rp = ss (rp.s ! Sg ! NPCase Nom) ;
  RP_Acc_Chunk rp = ss (rp.s ! Sg ! NPAcc) ;
  RP_Gen_Chunk rp = ss (rp.s ! Sg ! NPCase Gen) ;
  Subj_Chunk subj = subj ;

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
    let verb = vp.v ! PI.defaultAgr ;
    in
    allAgrSS (\a -> 
      verb.fin ++ vp.adV ++ verb.inf ++
      vp.adj ! a ++ vp.obj1 ! a ++ vp.obj2 ! a ++ vp.adv ++ vp.ext
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
    = \vp -> allAgrSS (\a -> PI.infVP PI.vvInfinitive a vp) ;

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

  copula_inf_Chunk = ss "olla" ;

  refl_SgP1_Chunk = ss "itseni" ;
  refl_SgP2_Chunk = ss "itsesi" ;
  refl_SgP3_Chunk = ss "itse" ;
  refl_PlP1_Chunk = ss "itsemme" ;
  refl_PlP2_Chunk = ss "itsenne" ;
  refl_PlP3_Chunk = ss "itsensä" ;
  neg_Chunk = ss "ei" ;
  copula_Chunk = ss "on" ;
  copula_neg_Chunk = ss "ei ole" ;
  past_copula_Chunk = ss "oli" ;
  past_copula_neg_Chunk = ss "ei ollut" ;
  future_Chunk = ss "tulee" ;
  future_neg_Chunk = ss "ei tule" ;
  cond_Chunk = ss "olisi" ;
  cond_neg_Chunk = ss "ei olisi" ;
  perfect_Chunk = ss "on" ;
  perfect_neg_Chunk = ss "ei ole" ;
  past_perfect_Chunk = ss "oli" ;
  past_perfect_neg_Chunk = ss "ei ollut" ;
  

oper
  allAgrSS : (Agr -> Str) -> SS = \f ->
    ss (f PI.defaultAgr) ;
---- | ss (f (AgP3Sg Fem)) | ss (f (AgP3Sg Neutr)) |  
----    ss (f (AgP1 Sg)) | ss (f (AgP1 Pl)) | ss (f (AgP2 Sg)) | ss (f (AgP2 Pl)) |
----    ss (f (AgP3Pl)) ;


}