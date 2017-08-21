concrete ChunkJpn of Chunk = CatJpn, ExtensionsJpn [VPS,VPI] ** 
  ChunkFunctor[Chunk, Chunks, OneChunk, PlusChunk, ChunkPhr,
               AdA_Chunk, AdV_Chunk, AdN_Chunk, PConj_Chunk, Symb_Chunk,
               fullstop_Chunk, exclmark_Chunk, questmark_Chunk, comma_Chunk,
               colon_Chunk, semicolon_Chunk, quote_Chunk, lpar_Chunk,
               rpar_Chunk, dash_Chunk, sbSS]
     with (Syntax = SyntaxJpn), (Extensions = ExtensionsJpn) **
  open 
    SyntaxJpn, (E = ExtensionsJpn), Prelude, 
    ResJpn, (P = ParadigmsJpn) in {

flags coding = utf8 ;

lincat

  VC = {s : Speaker => Style => TTense => Polarity => Str ; 
        a_stem, i_stem : Speaker => Str ; 
        te, ba : Speaker => Polarity => Str} ;

lin

  AP_Chunk ap = {s = (mkUtt ap).s ! Wa ! Resp} ;
  Adv_Chunk adv = {s = adv.s ! Resp} ;
  S_Chunk s = {s = s.s ! Wa ! Resp} ;
  SSlash_Chunk sslash = {s = sslash.s ! Resp} ;
  QS_Chunk qs = {s = qs.s ! Wa ! Resp} ;
  CN_Pl_Chunk cn = {s = cn.prepositive ! Resp ++ cn.object ! Resp ++ cn.s ! Pl ! Resp} ;
  CN_Sg_Chunk cn = {s = cn.prepositive ! Resp ++ cn.object ! Resp ++ cn.s ! Sg ! Resp} ;
  CN_Pl_Gen_Chunk = CN_Pl_Chunk ;
  CN_Sg_Gen_Chunk = CN_Sg_Chunk ;
  Conj_Chunk conj = {s = conj.s} ;
  Det_Chunk det = {s = det.quant ! Resp ++ det.num ++ det.postpositive} ; 
  IAdv_Chunk iadv = {s = iadv.s ! Resp} ;
  IP_Chunk ip = {s = ip.s_subj ! Resp} ;
  NP_Nom_Chunk np = {s = (mkUtt np).s ! Wa ! Resp} ;
  NP_Acc_Chunk, NP_Gen_Chunk = NP_Nom_Chunk ;
  Numeral_Nom_Chunk num = {s = num.s} ;
  Numeral_Gen_Chunk = Numeral_Nom_Chunk ;
  Ord_Nom_Chunk ord = {s = ord.attr} ;
  Ord_Gen_Chunk = Ord_Nom_Chunk ;
  Predet_Chunk predet = {s = predet.s} ;
  Prep_Chunk prep = {s = prep.s} ;
  RP_Nom_Chunk rp = {s = rp.s ! Resp} ;
  RP_Gen_Chunk, RP_Acc_Chunk = RP_Nom_Chunk ;
  Subj_Chunk subj = {s = subj.s} ;
  VPS_Chunk vps = {s = vps.prepositive ! Resp ++ vps.obj ! Resp ++ vps. prep ++
                       vps.verb ! SomeoneElse ! Inanim ! Resp} ;
  VPI_Chunk vpi = {s = vpi.prepositive ! Resp ++ vpi.obj ! Resp ++ vpi. prep ++
                       vpi.verb ! SomeoneElse ! Inanim } ;
  refl_SgP1_Chunk, refl_SgP2_Chunk, refl_SgP3_Chunk,
  refl_PlP1_Chunk, refl_PlP2_Chunk, refl_PlP3_Chunk = ss "自分" | ss "自分自身" ; -- "jibun" | "jibunjishin"
  neg_Chunk = ss "ない" | ss "しない" | ss "ではない" | ss "ません" | ss "ないで" ;
  copula_Chunk, future_Chunk = ss "です" | ss "だ" ;
  copula_neg_Chunk, future_neg_Chunk = ss "ではない" | ss "ではありません" ;
  copula_inf_Chunk = ss "です" | ss "だ" ;
  past_copula_Chunk = ss "でした" | ss "だった" ;
  past_copula_neg_Chunk = ss "ではありませんでした" | ss "ではなかった" ;
  cond_Chunk = copula_Chunk ;  -- no "would" in Japanese
  cond_neg_Chunk = copula_neg_Chunk ;
  perfect_Chunk = past_copula_Chunk ** (ss "てしまった" | ss "ちゃった" | ss "でしまった" | 
                                        ss "じゃった" | ss "ことがある" | ss "ことがあります") ;
  perfect_neg_Chunk = past_copula_neg_Chunk ** (ss "てしまわない" | ss "でしまわない" | 
                                        ss "ことがありません" | ss "ことがない") ;
  past_perfect_Chunk = perfect_Chunk ;
  past_perfect_neg_Chunk = perfect_neg_Chunk ;

  V2_V v2 = lin VC {
    s = \\sp => v2.s ; 
    a_stem = \\sp => v2.a_stem ;
    i_stem = \\sp => v2.i_stem ;
    te = \\sp => v2.te ;
    ba = \\sp => v2.ba 
    } ;
  
  VA_V va = lin VC {
    s = \\sp => va.s ; 
    a_stem = \\sp => va.a_stem ;
    i_stem = \\sp => va.i_stem ;
    te = \\sp => va.te ;
    ba = \\sp => va.ba 
    } ;

  VQ_V, VS_V = V2_V ;

  VV_V vv = lin VC {
    s = vv.s ; 
    a_stem = vv.a_stem ;
    i_stem = vv.i_stem ;
    te = vv.te ;
    ba = vv.ba
    } ;

  V3_V v3 = lin VC {
    s = v3.s ; 
    a_stem = v3.a_stem ;
    i_stem = v3.i_stem ;
    te = v3.te ;
    ba = v3.ba
    } ;

  V2A_V v2a = lin VC {
    s = \\sp => v2a.s ; 
    a_stem = \\sp => v2a.a_stem ;
    i_stem = \\sp => v2a.i_stem ;
    te = \\sp => v2a.te ;
    ba = \\sp => v2a.ba 
    } ;

  V2Q_V, V2S_V, V2V_V = V2A_V ;

  UseVC t p vc = lin VPS {
      verb = \\sp,a,st => case t.a of {
        Simul => vc.s ! sp ! st ! t.t ! p.b ;
        Anter => case t.t of {
          TFut => vc.s ! sp ! st ! TPres ! p.b ;
          _    => vc.s ! sp ! st ! TPast ! p.b 
          }
        } ;
      a_stem = \\sp,a,st => vc.a_stem ! sp ;
      i_stem = \\sp,a,st => vc.i_stem ! sp ;
      te = \\sp,a,st =>  vc.te ! sp ! p.b ;
      ba = \\sp,a,st =>  vc.ba ! sp ! p.b ;
      prep = "" ;
      obj = \\st => "" ;
      prepositive = \\st => ""
      } ;

} 

{-

emptyNP : NP = lin NP {s = \\st => "" ; 
                         prepositive = \\st => "" ;
                         needPart = False ;
                         changePolar = False ;
                         meaning = SomeoneElse ; 
                         anim = Inanim} ;

lin
  NP_Acc_Chunk np = np ;
  NP_Gen_Chunk np = ss (np.s ++ de_s) ;

  VPI_Chunk vpi = vpi ;
-}
