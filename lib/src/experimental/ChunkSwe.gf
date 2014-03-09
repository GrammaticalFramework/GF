concrete ChunkSwe of Chunk = 
  RGLBaseSwe - [Pol,Tense], 
  NDPredSwe 

  ** open (PI=PredInstanceSwe), CommonScand, ResSwe, Prelude in {

lincat
  Chunks = {s : Str} ;
  Chunk = {s : Str};

lin
  OneChunk c = c ;
  PlusChunk c cs = cc2 c cs ;

  ChunkPhr c = ss ("*" ++ c.s) | c ;

lin


  AP_Chunk ap = ss (ap.s ! (Strong (GSg Utr))) ; ---- other agr
  AdA_Chunk ada = ada ;
  Adv_Chunk adv = adv ;
  AdV_Chunk adv = adv ;
  AdN_Chunk adn = adn ;
  Cl_Chunk, Cl_np_Chunk = \cl -> ss (PI.declCl cl) ;
  QCl_Chunk, QCl_np_Chunk = \cl -> ss (PI.questCl cl) ;
  CN_Pl_Chunk cn = ss (cn.s ! Pl ! DIndef ! Nom) ;
  CN_Sg_Chunk cn = ss (cn.s ! Sg ! DIndef ! Nom) ;
  CN_Pl_Gen_Chunk cn = ss (cn.s ! Pl ! DIndef ! Gen) ;
  CN_Sg_Gen_Chunk cn = ss (cn.s ! Sg ! DIndef ! Gen) ;
  Conj_Chunk conj = ss conj.s2 ;
  IAdv_Chunk iadv = iadv ; 
  IP_Chunk ip = ss (ip.s ! NPNom) ;
  NP_Nom_Chunk np = ss (np.s ! NPNom) ;
  NP_Acc_Chunk np = ss (np.s ! NPAcc) ;
  NP_Gen_Chunk np = ss (np.s ! NPPoss (GSg Utr) Nom) ;
  Numeral_Nom_Chunk num = ss (num.s ! NCard Utr) ;
  Numeral_Gen_Chunk num = ss (num.s ! NCard Utr) ;
  Ord_Nom_Chunk ord = ord ;
  Ord_Gen_Chunk ord = ord ;
  Predet_Chunk predet = ss (predet.s ! Utr ! Sg) ;
  Prep_Chunk prep = prep ;
  RP_Nom_Chunk rp = ss (rp.s ! Utr ! Sg ! RNom) ;
  RP_Acc_Chunk rp = ss (rp.s ! Utr ! Sg ! RNom) ;
  RP_Gen_Chunk rp = ss (rp.s ! Utr ! Sg ! RGen) ;
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
    let verb = vp.v ! PI.UUnit
    in
    allAgrSS (\a -> 
      verb.p1 ++ verb.p2 ++ vp.adV ++ verb.p3 ++ vp.part ++
      vp.adj ! a ++ vp.c1 ++ vp.obj1.p1 ! a ++ vp.c2 ++ vp.obj2.p1 ! a ++ vp.adv ++ vp.ext
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
    = \vp -> allAgrSS (\a -> PI.infVP PI.UUnit a vp) ;

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

  refl_SgP1_Chunk = ss "mig själv" ;
  refl_SgP2_Chunk = ss "dig själv" ;
  refl_SgP3_Chunk = ss "sig själv" ;
  refl_PlP1_Chunk = ss "oss själva" ;
  refl_PlP2_Chunk = ss "er själva" ;
  refl_PlP3_Chunk = ss "sig själva" ;
  neg_Chunk = ss "inte" ;
  copula_Chunk = ss "är" ;
  copula_neg_Chunk = ss "är inte" ;
  past_copula_Chunk = ss "var" ;
  past_copula_neg_Chunk = ss "var inte" ;
  future_Chunk = ss "ska" | ss "skall" ;
  future_neg_Chunk = ss "ska inte" | ss "skall inte" ;
  cond_Chunk = ss "skulle" ;
  cond_neg_Chunk = ss "skulle inte" ;
  perfect_Chunk = ss "har" ;
  perfect_neg_Chunk = ss "har inte" ;
  past_perfect_Chunk = ss "hade" ;
  past_perfect_neg_Chunk = ss "hade inte" ;
  

oper
  allAgrSS : (Agr -> Str) -> SS = \f ->
    ss (f PI.defaultAgr) ;
---- | ss (f (AgP3Sg Fem)) | ss (f (AgP3Sg Neutr)) |  
----    ss (f (AgP1 Sg)) | ss (f (AgP1 Pl)) | ss (f (AgP2 Sg)) | ss (f (AgP2 Pl)) |
----    ss (f (AgP3Pl)) ;


}