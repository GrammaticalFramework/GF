concrete SmallPredFre of SmallPred = 
  RGLBaseFre ** 

  open ResFre, CommonRomance, (S = SyntaxFre), (P = ParadigmsFre), PhonoFre, Prelude in {

--  NDPredFre [
lincat    
  PrV_none, PrV_np , PrV_v , PrV_s , PrV_q , PrV_a , PrV_n ,
          PrV_np_np , PrV_np_v , PrV_np_s , PrV_np_q , PrV_np_a , PrV_np_n 
  = {s : VF => Str ; c2 : Compl ; vtyp : VType} ;
  PrAdv_none = S.Adv ;
  PrS = {s : Str} ;
  PrAP_none = S.AP ;
  PrCN_none = S.CN ;


lincat
    PrVP_none , PrVP_np , PrVP_v , PrVP_s , PrVP_q , PrVP_a , PrVP_n ,
             PrVP_np_np , PrVP_np_v , PrVP_np_s , PrVP_np_q , PrVP_np_a , PrVP_np_n
     = {
       v : Agr => Str ;  
       inf : Str ;
       c2 : Compl ;
       ne : Str ; -- empty in Pos, "ne" in Neg
       } ;

    PrCl_none
     = {s : Str} ;
    PrQCl_none 
     = {s : Str} ;

lin
  UttPrS s = s ;

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
    = \a,t,p,v -> mkVP (t.s ++ a.s ++ p.s) t.t a.a p.p v [] ;

oper
  mkVP : Str -> RTense -> Anteriority -> RPolarity -> PrV_none -> Str -> PrVP_none = \atp,tense,ant,pol,verb,obj ->
    let 
      oldvp : ResFre.VP =
        predV verb ;
      clause : Agr -> {s : Direct => RTense => Anteriority => RPolarity => Mood => Str} = \agr ->
        mkClause atp False False agr oldvp ;
      nepas : Str * Str = case pol of {RPos => <[],[]> ; _ => <elisNe, "pas">} ;
    in 
    lin PrVP_none {
       v : Agr => Str = \\agr => (clause agr).s ! DDir ! tense ! ant ! RPos ! Indic ++ nepas.p2 ++ obj ;
       inf : Str = verb.s ! VInfin False ++ obj ;  ---- ant,pol
       c2 : Compl = verb.c2 ;
       ne : Str = nepas.p1 ; 
    } ;

lin
  UseAdv_none a t p adv = mkVP (t.s ++ a.s ++ p.s) t.t a.a p.p (copula ** {c2 = P.accusative}) adv.s ;

  UseCN_none a t p cn = mkVP (t.s ++ a.s ++ p.s) t.t a.a p.p (copula ** {c2 = P.accusative}) (cn.s ! Sg) ;

  UseNP_none a t p np = mkVP (t.s ++ a.s ++ p.s) t.t a.a p.p (copula ** {c2 = P.accusative}) ((np.s ! Nom).comp) ;


lin
  QuestCl_none cl = {s = "est-ce" ++ elisQue ++ cl.s} ;

  UseCl_none cl = cl ;
  UseQCl_none cl = cl ;

  PredVP_none, PredVP_np, PredVP_v, PredVP_a, PredVP_q, PredVP_s,
  PredVP_np_np, PredVP_np_v, PredVP_np_a, PredVP_np_q, PredVP_np_s
   = \np, vp -> {
     s = (np.s ! Nom).comp ++ vp.ne ++ vp.v ! np.a ;
     } ;

  Pred2VP_none, Pred2VP_np, Pred2VP_v, Pred2VP_a, Pred2VP_q, Pred2VP_s,
  Pred2VP_np_np, Pred2VP_np_v, Pred2VP_np_a, Pred2VP_np_q, Pred2VP_np_s
   = \s,v,o -> 
      let obj = o.s ! v.c2.c in 
      {
        s = (s.s ! Nom).comp ++ v.ne ++ obj.c1 ++ obj.c2 ++ v.v ! s.a ++ v.c2.s ++ obj.comp ;
      } ;


  PredAP_none
   = \a, t, p, np, ap -> 
     let verb = mkVP (t.s ++ a.s ++ p.s) t.t a.a p.p (lin PrV_none (copula ** {c2 = P.accusative})) [] in
     {
      s = (np.s ! Nom).comp ++ verb.ne ++ verb.v ! np.a ++  ap.s ! AF np.a.g np.a.n ;
     } ;



-- NDLiftFre [

  LiftV,
  LiftVS,
  LiftVQ,
  LiftVV,
  LiftVA,
  LiftVN
    = \v -> v ** {c2 = P.accusative} ;

  LiftV2,
  LiftV3,
  LiftV2S,
  LiftV2Q,
  LiftV2V,
  LiftV2A,
  LiftV2N
   = \v -> v ;

  LiftAP ap = ap ;
  LiftCN cn = cn ;

  LiftAdv adv = adv ; 
  LiftAdV adv = adv ;

-- ChunkFre [

lincat
  Chunks = {s : Str} ;
  Chunk = {s : Str};

lin
  OneChunk c = c ;
  PlusChunk c cs = cc2 c cs ;

  ChunkPhr c = ss ("*" ++ c.s) | c ;

oper
  defaultAAgr = {n = Sg ; g = Masc} ;

lin


  AP_Chunk ap = ss (ap.s ! AF Masc Sg) ;
  AdA_Chunk ada = ada ;
  Adv_Chunk adv = adv ;
  AdV_Chunk adv = adv ;
  AdN_Chunk adn = adn ;
  Cl_Chunk cl = cl ;
  QCl_Chunk cl = cl ;
  CN_Pl_Chunk cn = ss (cn.s ! Pl) ;
  CN_Sg_Chunk cn = ss (cn.s ! Sg) ;
  CN_Pl_Gen_Chunk cn = ss (elisDe ++ cn.s ! Pl) ;
  CN_Sg_Gen_Chunk cn = ss (elisDe ++ cn.s ! Sg) ;
  Conj_Chunk conj = ss conj.s2 ;
  IAdv_Chunk iadv = iadv ; 
  IP_Chunk ip = ss (ip.s ! Nom) ;
  NP_Nom_Chunk np = ss ((np.s ! Nom).ton) ;
  NP_Acc_Chunk np = ss (np.s ! Acc).ton ;
  NP_Gen_Chunk np = ss (np.s ! genitive).ton ;
  Numeral_Nom_Chunk num = ss (num.s ! NCard Masc) ;
  Numeral_Gen_Chunk num = ss (elisDe ++ num.s ! NCard Masc) ;
----  Ord_Nom_Chunk ord = ss (ord.s ! defaultAAgr) ;
----  Ord_Gen_Chunk ord = ss (elisDe ++ ord.s ! defaultAAgr) ;
----  Predet_Chunk predet = ss (predet.s ! defaultAAgr ! Nom) ;
  Prep_Chunk prep = prep ; ----
----  RP_Nom_Chunk rp = ss (rp.s ! False ! defaultAAgr ! Nom) ;
----  RP_Acc_Chunk rp = ss (rp.s ! False ! defaultAAgr ! Acc) ;
----  RP_Gen_Chunk rp = ss (rp.s ! False ! defaultAAgr ! genitive) ;
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
  = \vp -> ss (vp.ne ++ vp.v ! {g = Masc ; n = Sg ; p = P3}) ;

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
    = \vp -> ss vp.inf ;

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
    = \v -> ss (v.s ! VGer) ;

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
    = \v -> ss (v.s ! VPart Masc Sg) ;

  copula_inf_Chunk = ss "ètre" ;

  refl_SgP1_Chunk = ss "moi-même" ;
  refl_SgP2_Chunk = ss "toi-même" ;
  refl_SgP3_Chunk = ss "lui-même" ;
  refl_PlP1_Chunk = ss "nous-mêmes" ;
  refl_PlP2_Chunk = ss "vous-mêmes" ;
  refl_PlP3_Chunk = ss "eux-mêmes" ;
  neg_Chunk = ss "non" ;
  copula_Chunk = ss "est" ;
  copula_neg_Chunk = ss "n'est pas" ;
  past_copula_Chunk = ss "était" ;
  past_copula_neg_Chunk = ss "n'était pas" ;
  future_Chunk = ss "va"  ;
  future_neg_Chunk = ss "ne va pas" ;
  cond_Chunk = ss "ferait" ; ----
  cond_neg_Chunk = ss "ne ferait pas" ; ----
  perfect_Chunk = ss "a" ;
  perfect_neg_Chunk = ss "n'a pas" ;
  past_perfect_Chunk = ss "avait" ;
  past_perfect_neg_Chunk = ss "n'avait pas" ;
  
}