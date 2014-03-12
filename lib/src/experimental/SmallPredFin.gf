--# -path=.:../finnish/stemmed:../finnish:../api:../translator:../../../examples/phrasebook:alltenses

concrete SmallPredFin of SmallPred = 
  RGLBaseFin  - [Pol,Tense],

  NDPredFin [
    Ant,NP,Utt,IP,IAdv,IComp,Conj,
    PrV_none, PrV_np , PrV_v , PrV_s , PrV_q , PrV_a , PrV_n ,
             PrV_np_np , PrV_np_v , PrV_np_s , PrV_np_q , PrV_np_a , PrV_np_n ,

    Tense ,
    Pol ,
  TPres, TPast, TFut, TCond,
  PPos, PNeg,
  ASimul, AAnter,
  PrAdv_none , 
  PrS,
  PrAP_none , 
  PrCN_none,
  UttPrS

   ],

NDLiftFin [
  CN,AP,V,V2,VV,VS,VA,VQ,V2V,V2S,V2Q,V2A,V3,
    PrV_none, PrV_np , PrV_v , PrV_s , PrV_q , PrV_a , PrV_n ,
             PrV_np_np , PrV_np_v , PrV_np_s , PrV_np_q , PrV_np_a , PrV_np_n ,

  LiftV,
  LiftV2,
  LiftVS,
  LiftVQ,
  LiftVV,
  LiftVA,
  LiftVN,

  LiftV3,
  LiftV2S,
  LiftV2Q,
  LiftV2V,
  LiftV2A,
  LiftV2N,

  LiftAP,
  LiftCN,

  LiftAdv,
  LiftAdV
],

ChunkFin [
  Chunks,
  Chunk,

  OneChunk,
  PlusChunk,

  ChunkPhr,

  AP_Chunk,
  AdA_Chunk,
  Adv_Chunk,
  AdV_Chunk,
  AdN_Chunk,
  CN_Pl_Chunk,
  CN_Sg_Chunk,
  CN_Pl_Gen_Chunk,
  CN_Sg_Gen_Chunk,
  Conj_Chunk,
  IAdv_Chunk,
  IP_Chunk,
  NP_Nom_Chunk,
  NP_Acc_Chunk,
  NP_Gen_Chunk,
  Numeral_Nom_Chunk,
  Numeral_Gen_Chunk,
  Ord_Nom_Chunk,
  Ord_Gen_Chunk,
  Predet_Chunk,
  Prep_Chunk,
  RP_Nom_Chunk,
  RP_Gen_Chunk,
  RP_Acc_Chunk,
  Subj_Chunk,

  V_none_prespart_Chunk,  V_none_pastpart_Chunk,
  V_np_prespart_Chunk,  V_np_pastpart_Chunk,
  V_s_prespart_Chunk,  V_s_pastpart_Chunk,
  V_v_prespart_Chunk,  V_v_pastpart_Chunk,
  V_q_prespart_Chunk,  V_q_pastpart_Chunk,
  V_a_prespart_Chunk,  V_a_pastpart_Chunk,

  V_np_np_prespart_Chunk,  V_np_np_pastpart_Chunk,
  V_np_s_prespart_Chunk,  V_np_s_pastpart_Chunk,
  V_np_v_prespart_Chunk,  V_np_v_pastpart_Chunk,
  V_np_q_prespart_Chunk,  V_np_q_pastpart_Chunk,
  V_np_a_prespart_Chunk,  V_np_a_pastpart_Chunk,

  refl_SgP1_Chunk,
  refl_SgP2_Chunk,
  refl_SgP3_Chunk,
  refl_PlP1_Chunk,
  refl_PlP2_Chunk,
  refl_PlP3_Chunk, 
  neg_Chunk, 
  copula_Chunk, 
  copula_neg_Chunk, 
  copula_inf_Chunk, 
  past_copula_Chunk, 
  past_copula_neg_Chunk, 
  future_Chunk, 
  future_neg_Chunk, 
  cond_Chunk, 
  cond_neg_Chunk, 
  perfect_Chunk, 
  perfect_neg_Chunk, 
  past_perfect_Chunk, 
  past_perfect_neg_Chunk


]

   ** open (P=PredFin), PredInstanceFin in {

lincat
    PrVP_none , PrVP_np , PrVP_v , PrVP_s , PrVP_q , PrVP_a , PrVP_n ,
             PrVP_np_np , PrVP_np_v , PrVP_np_s , PrVP_np_q , PrVP_np_a , PrVP_np_n
     = {
       v : VAgr => Str ; 
       inf : VVType => Str ;
       qq : VAgr => Str * Str ;
       ko : Str ;
       } ;

    PrCl_none
     = {s : Str ; q : Str} ;
    PrQCl_none 
     = {s : Str} ;

lin
  UseV_none,
  UseV_np,
  UseV_v,
  UseV_s,
  UseV_a,
  UseV_q,
  UseV_n,
  UseV_np_np,
  UseV_np_v,
  UseV_np_s,
  UseV_np_a,
  UseV_np_q,
  UseV_np_n
    = \a,t,p,v -> mkVP (P.UseV P.aNone a t p v) ;

oper
  mkVP : PrVerbPhrase -> SmallPredFin.PrVP_none = \vp ->
      lin PrVP_none {
       v = \\a =>
          let
              vv = vp.v ! a ; 
              vpa = vagr2agr a ;
          in 
          vv.fin ++ vp.adV ++ vv.inf ++ vp.adj ! vpa ++ 
          vp.obj1 ! vpa ++ vp.obj2 ! vpa ++ vp.adv ++ vp.ext  ;
       inf = \\vt => infVP vt defaultAgr vp ;
       qq = \\a =>
          let
              vv = vp.v ! a ; 
              vpa = vagr2agr a ;
          in 
          <vv.fin, vp.adV ++ vv.inf ++ vp.adj ! vpa ++ 
           vp.obj1 ! vpa ++ vp.obj2 ! vpa ++ vp.adv ++ vp.ext>  ;
       ko = Predef.BIND ++ case vp.h of {Back => "ko" ; Front => "kö"} 

     } ;

lin
  UseAdv_none = \a,t,p,v -> mkVP (P.UseAdv P.aNone a t p v) ;
  UseCN_none  = \a,t,p,v -> mkVP (P.UseCN P.aNone a t p v) ;
  UseNP_none  = \a,t,p,v -> mkVP (P.UseNP a t p v) ;

  QuestCl_none cl = {s = cl.q} ;

  UseCl_none cl = lin PrS {s = cl.s} ;
  UseQCl_none cl = lin PrS cl ;

  PredVP_none, PredVP_np, PredVP_v, PredVP_a, PredVP_q, PredVP_s,
  PredVP_np_np, PredVP_np_v, PredVP_np_a, PredVP_np_q, PredVP_np_s
   = \np, vp -> 
     {
     s = appSubjCase np ++ vp.v ! (agr2vagr np.a) ;
     q = let qq = vp.qq ! (agr2vagr np.a) in qq.p1 ++ vp.ko ++ appSubjCase np ++ qq.p2 
     } ;

  Pred2VP_none, Pred2VP_np, Pred2VP_v, Pred2VP_a, Pred2VP_q, Pred2VP_s,
  Pred2VP_np_np, Pred2VP_np_v, Pred2VP_np_a, Pred2VP_np_q, Pred2VP_np_s
   = \s,v,o -> 
      {
      s = appSubjCase s ++ v.v ! (agr2vagr s.a) ++ appObjCase o ;
      q = let qq = v.qq ! (agr2vagr s.a) in qq.p1 ++ v.ko ++ appSubjCase s ++ qq.p2 ++ appObjCase o ; 
      } ;

  PredAP_none
   = \a, t, p, np, ap -> 
     let cl = P.PredVP P.aNone np (P.UseAP P.aNone a t p ap) in {
       s = declCl cl ;
       q = questCl (P.QuestCl P.aNone cl) ;
       } ;

  Cl_Chunk cl = cl ;
  QCl_Chunk cl = cl ;

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
    {s = vp.v ! defaultAgr} ;

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
   = \vp -> {s = vp.inf ! vvInfinitive} ;

   }
