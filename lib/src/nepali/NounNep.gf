concrete NounNep of Noun = CatNep ** open ResNep, Prelude in {

  flags optimize = all_subs ;
  flags coding=utf8 ;

  lin
 
    DetCN det cn = {
      s = \\c => detcn2NP det cn c det.n  ;
      a = toAgr det.n cn.h cn.g ;
      t = cn.t 
      } ;

    UsePN pn = {s = \\c => toNP pn.s c ; a = toAgr Sg pn.h pn.g ; t = pn.t } ;
    
    UsePron p = {s = \\c => np2pronCase p.s c p.a ; a = p.a ; t = Living } ;

    PredetNP pred np = {
      s = \\c => pred.s ++ np.s ! c ;
      a = np.a ;
      t = np.t 
      } ;

    -- Neds to change this, 
    -- needs to check for root ending case, now works for root2 cases only
    PPartNP np v2 = {
      s = \\c => case (fromAgr np.a).n of {
          Sg =>  case (fromAgr np.a).g of {
                  Masc => np.s ! c ++ v2.s ! Root ++ eko ;
                  Fem  => np.s ! c ++ v2.s ! Root ++ eki 
                } ; 
          Pl =>  np.s ! c ++ v2.s ! Root ++ eka
         } ;
      a = np.a ;
      t = np.t 
      } ;
    
    RelNP np rs = {
	  s = \\c => np.s ! c  ++ "," ++ rs.s ! np.a ;
      a = np.a ;
      t = np.t 
      } ;

    AdvNP np adv = {
      s = \\c => np.s ! c ++ adv.s ; 
      a = np.a ;
      t = np.t
      } ;

    DetNP det = {
      s = \\c => det2NP det c ; -- case
      a = agrP3 Masc Sg ;
      t = NonLiving 
      } ;
    
    -- ?? quant
    DetQuantOrd quant num ord = {
      s = \\n,g => quant.s ! n ! g ++ ord.s ++ num.s ; 
      n = num.n
      } ;

    DetQuant quant num = {
      s = \\n,g => quant.s ! num.n ! g ++ num.s;
	  n = num.n
      } ;
      
    NumSg = {s = []; n = Sg} ;
    NumPl = {s = []; n = Pl} ;

    NumCard n = n ** {hasCard = True} ;

    PossPron p = {s = \\_,_ => p.ps } ;
    
    NumDigits n = {s = n.s ! NCard ; n = n.n} ;
    OrdDigits n = {s = n.s ! NOrd  ; n = n.n} ;

    NumNumeral numeral = {s = numeral.s ! NCard; n = numeral.n} ;
    OrdNumeral numeral = {s = numeral.s ! NOrd ; n = numeral.n} ;

    AdNum adn num = {s = adn.s ++ num.s ; n = num.n} ;

    OrdSuperl a = {s = sbvn ++ a.s ! Sg ! Masc  ; n = Sg} ;

    DetArtSg art cn = {
      s = \\c => art.s ++ toNP (cn.s ! Sg) c ;
      a = Ag cn.g Sg cn.h
      } ;

    DetArtPl art cn = {
      s = \\c => art.s ++ toNP (cn.s ! Pl) c ;
      a = toAgr Pl cn.p cn.g
      } ;

    DefArt = {s = \\_,_ => [] } ;
    
    IndefArt = {s = \\_,_ => [] } ;

    MassNP cn = {
        s = \\c => toNP (cn.s ! Sg) c ; 
        a = toAgr Sg cn.h cn.g ; 
        t = cn.t 
        } ; 

    UseN n = n ;
    
    UseN2 n2 = { s = n2.s  ; g = n2.g ; t = n2.t ; h = n2.h };

    Use2N3 f = {
      s = f.s ;
      g = f.g ;
      t = f.t ;
      h = f.h ;
      c2 = f.c2 ;
      c3 = f.c3
      } ;

    Use3N3 f = {
      s = f.s ;
      g = f.g ;
      t = f.t ;
      h = f.h ;
      c2 = f.c2 ;
      c3 = f.c3
      } ;

    ComplN2 f np = {
       s = \\n,c => np.s ! NPC Nom ++ f.c2 ++ f.s ! n ! c ;
	   g = f.g ;
       t = np.t ;
       --h = x.h 
       h = (fromAgr np.a).p
	   } ;

    ComplN3 f x = {
      s = \\n,c =>  x.s ! NPObj ++ f.c3 ++ f.c4 ++ f.s ! n ! Nom  ;
      g = f.g ;
      t = f.t ;
      h = f.h ;
      c2 = f.c2 ;
      c3 = f.c3
      } ;
    
    AdjCN ap cn = {
      s = \\n,c => ap.s ! n ! cn.g  ++ cn.s ! n ! c ;
      g = cn.g ; 
      t = cn.t ;
      h = cn.h
      } ;

    RelCN cn rs = {
      s = \\n,c => cn.s ! n ! c ++ rs.s ! agrP3 cn.g n ;
      g = cn.g ;
      t = cn.t ;
      h = cn.h
      } ;
    
    AdvCN cn ad = {s = \\n,c => cn.s ! n ! c ++ ad.s  ; g = cn.g ; t = cn.t ; h = cn.h} ;
    --Prelude.glue 
    SentCN cn sc = {s = \\n,c => sc.s ++ "लाइ" ++ cn.s ! n ! c ; g = cn.g ; t = cn.t ; h = cn.h} ;
    -- Changed to fix 'reason to sleep' Bug
    -- SentCN cn sc = {s = \\n,c => cn.s ! n ! c ++ sc.s ; g = cn.g ; t = cn.t ; h = cn.h} ;
    
    ApposCN cn np = {s = \\n,c => cn.s ! n ! Nom ++ np.s ! NPC c ; g = cn.g ; t = cn.t ; h = cn.h} ;

}
