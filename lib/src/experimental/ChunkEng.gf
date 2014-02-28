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

----  ChunkPhr c = c ;

lin


  AP_Chunk ap = allAgrSS (\a -> ap.s ! a) ;
  AdA_Chunk ada = ada ;
  Adv_Chunk adv = adv ;
  AdV_Chunk adv = adv ;
  AdN_Chunk adn = adn ;
  CN_Pl_Chunk cn = ss (cn.s ! Pl ! Nom) ;
  CN_Sg_Chunk cn = ss (cn.s ! Sg ! Nom) ;
  CN_Pl_Gen_Chunk cn = ss (cn.s ! Pl ! Gen) ;
  CN_Sg_Gen_Chunk cn = ss (cn.s ! Sg ! Gen) ;
  Conj_Chunk conj = ss conj.s2 ;
  IAdv_Chunk iadv = iadv ; 
  IP_Chunk ip = ss (ip.s ! NCase Nom) ;
  NP_Chunk np = ss (np.s ! NCase Nom) | ss (np.s ! NPAcc) ;
  NP_Gen_Chunk np = ss (np.s ! NCase Gen) | ss (np.s ! NPNomPoss) ;
  Numeral_Chunk num = ss (num.s ! NCard ! Nom) | ss (num.s ! NCard ! Gen) ;
  Ord_Chunk ord = ss (ord.s ! Nom) | ss (ord.s ! Gen) ;
  Predet_Chunk predet = predet ;
  Prep_Chunk prep = prep ;
  RP_Chunk rp = ss (rp.s ! RC Neutr (NCase Nom)) | ss (rp.s ! RPrep Masc) ; ----
  Subj_Chunk subj = subj ;
  VP_none_Chunk, VP_np_Chunk, VP_s_Chunk = \vp -> 
    let verb = vp.v ! (PI.VASgP1 | PI.VASgP3 | PI.VAPl) 
    in
    allAgrSS (\a -> 
      verb.p1 ++ verb.p2 ++ vp.adV ++ verb.p3 ++ vp.part ++
      vp.adj ! a ++ vp.c1 ++ vp.obj1.p1 ! a ++ vp.c2 ++ vp.obj2.p1 ! a ++ vp.adv ++ vp.ext
      ) ;
  neg_Chunk = ss "not" | ss "doesn't" | ss "don't" ;
  copula_Chunk = ss "is" | ss "are" | ss "am" ;
  past_copula_Chunk = ss "was" | ss "were" ;
  future_Chunk = ss "will" ;
  cond_Chunk = ss "would" ;
  perfect_Chunk = ss "has" | ss "have" ;
  past_perfect_Chunk = ss "had" ;
  

oper
  allAgrSS : (Agr -> Str) -> SS = \f ->
    ss (f (AgP3Sg Masc)) ;
---- | ss (f (AgP3Sg Fem)) | ss (f (AgP3Sg Neutr)) |  
----    ss (f (AgP1 Sg)) | ss (f (AgP1 Pl)) | ss (f (AgP2 Sg)) | ss (f (AgP2 Pl)) |
----    ss (f (AgP3Pl)) ;


}