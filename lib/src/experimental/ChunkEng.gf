concrete ChunkEng of Chunk = 
  RGLBaseEng - [Pol,Tense], 
  NDPredEng 

  ** open (PI=PredInstanceEng), ResEng, Prelude in {

lincat
  Chunks = {s : Str} ;
  Chunk = {s : Str};

lin
  OneChunk c = c ;
  PlusChunk c cs = cc2 c cs ;

  ChunkPhr c = ss ("*" ++ c.s) | c ;

lin


  AP_Chunk ap = allAgrSS (\a -> ap.s ! a) ;
  AdA_Chunk ada = ada ;
  Adv_Chunk adv = adv ;
  AdV_Chunk adv = adv ;
  AdN_Chunk adn = adn ;
  Cl_Chunk, Cl_np_Chunk = \cl -> ss (PI.declCl cl) ;
  QCl_Chunk, QCl_np_Chunk = \cl -> ss (PI.questCl cl) ;
  CN_Pl_Chunk cn = ss (cn.s ! Pl ! Nom) ;
  CN_Sg_Chunk cn = ss (cn.s ! Sg ! Nom) ;
  CN_Pl_Gen_Chunk cn = ss (cn.s ! Pl ! Gen) ;
  CN_Sg_Gen_Chunk cn = ss (cn.s ! Sg ! Gen) ;
  Conj_Chunk conj = ss conj.s2 ;
  IAdv_Chunk iadv = iadv ; 
  IP_Chunk ip = ss (ip.s ! NCase Nom) ;
  NP_Nom_Chunk np = ss (np.s ! NCase Nom) ;
  NP_Acc_Chunk np = ss (np.s ! NPAcc) ;
  NP_Gen_Chunk np = ss (np.s ! NCase Gen) | ss (np.s ! NPNomPoss) ;
  Numeral_Nom_Chunk num = ss (num.s ! NCard ! Nom) ;
  Numeral_Gen_Chunk num = ss (num.s ! NCard ! Gen) ;
  Ord_Nom_Chunk ord = ss (ord.s ! Nom) ;
  Ord_Gen_Chunk ord = ss (ord.s ! Gen) ;
  Predet_Chunk predet = predet ;
  Prep_Chunk prep = prep ;
  RP_Nom_Chunk rp = ss (rp.s ! RC Neutr (NCase Nom)) ;
  RP_Acc_Chunk rp = ss (rp.s ! RPrep Masc) ; ----
  RP_Gen_Chunk rp = ss (rp.s ! RC Neutr (NCase Gen)) ;
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
    let verb = vp.v ! (PI.VASgP1 | PI.VASgP3 | PI.VAPl) 
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
   = \vp -> allAgrSS (\a -> PI.infVP (VVInf | VVAux) a vp) ;

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

  copula_inf_Chunk = ss "to be" | ss "be" ;


  refl_SgP1_Chunk = ss "myself" ;
  refl_SgP2_Chunk = ss "yourself" ;
  refl_SgP3_Chunk = ss "himself" | ss "herself" | ss "itself" ;
  refl_PlP1_Chunk = ss "ourselves" ;
  refl_PlP2_Chunk = ss "yourselves" ;
  refl_PlP3_Chunk = ss "themselves" ;
  neg_Chunk = ss "not" | ss "doesn't" | ss "don't" ;
  copula_Chunk = ss "is" | ss "are" | ss "am" ;
  copula_neg_Chunk = ss "isn't" | ss "aren't" ;
  past_copula_Chunk = ss "was" | ss "were" ;
  past_copula_neg_Chunk = ss "wasn't" | ss "weren't" ;
  future_Chunk = ss "will" ;
  future_neg_Chunk = ss "won't" ;
  cond_Chunk = ss "would" ;
  cond_neg_Chunk = ss "wouldn't" ;
  perfect_Chunk = ss "has" | ss "have" ;
  perfect_neg_Chunk = ss "hasn't" | ss "haven't" ;
  past_perfect_Chunk = ss "had" ;
  past_perfect_neg_Chunk = ss "hadn't" ;
  

oper
  allAgrSS : (Agr -> Str) -> SS = \f ->
    ss (f (AgP3Sg Masc)) ;
---- | ss (f (AgP3Sg Fem)) | ss (f (AgP3Sg Neutr)) |  
----    ss (f (AgP1 Sg)) | ss (f (AgP1 Pl)) | ss (f (AgP2 Sg)) | ss (f (AgP2 Pl)) |
----    ss (f (AgP3Pl)) ;


}