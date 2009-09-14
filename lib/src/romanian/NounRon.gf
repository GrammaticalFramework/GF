concrete NounRon of Noun =
   CatRon ** open ResRon,Prelude in {

  flags optimize=all_subs ;

  lin
    DetCN det cn = 
      let 
        n = det.n;
        gg = agrGender cn.g n ;
        ag = agrP3 gg n ;
        hr = andB (getClit cn.a) det.hasRef ;
        st= if_then_else Species det.isDef Def Indef;
        rs = if_then_else Species det.hasRef Def Indef
      in 
       {s = \\c => case c of
                   {Vo =>
                   {comp = det.s ! gg ! No ++ det.size ++ cn.s ! n ! st ! ANomAcc ++ det.post ! gg ! No  ;
                    clit = \\cs => if_then_Str hr ((genCliticsCase ag c).s ! cs) [] };
                    _ => {comp = det.s ! gg ! c ++ det.size ++ cn.s ! n ! st ! (convCase c) ++ det.post ! gg ! c  ;
                    clit = \\cs => if_then_Str hr ((genCliticsCase ag c).s ! cs) [] }
                   };
        a = ag ;
        hasClit = hr ;
        hasRef = hr ;
        isPronoun = False ;
        indForm = det.s ! gg ! No ++ det.size ++cn.s ! n ! rs ! ANomAcc 
             
        } ;

    UsePN pn = let 
        g = pn.g ;
        n = pn.n ;
        ag = agrP3 g n ;
        hc = getClit pn.a 
      in {
        s = \\c =>  {comp = pn.s ! c ;
                      clit = \\cs => if_then_Str hc ((genCliticsCase ag c).s ! cs) [] } ;
                   
        a = ag;
        hasClit = hc ;
        hasRef = hc ;
        isPronoun = False ;
        indForm = pn.s ! No
        } ;

   UsePron p = {s = \\c =>{comp = p.s ! c ;
                           clit = (genCliticsCase p.a c).s } ;
                hasClit = True;
                hasRef = True ;
                isPronoun = True ;
                a = p.a;
                indForm = p.s ! Ac
               };



    PredetNP pred np = 
       {s = \\c => {comp = pred.s ! aagr (np.a.g) (np.a.n) ! (convCase c) ++ (np.s ! pred.c).comp  ; 
                    clit = (np.s ! c).clit };
        a = np.a ;
        hasClit = np.hasClit ;
        hasRef = False ;
        isPronoun = False ;
        indForm = pred.s ! aagr (np.a.g) (np.a.n) ! ANomAcc ++ (np.s ! pred.c).comp
   } ;


    PPartNP np v2 = 
     heavyNP {
      s = \\c => (np.s ! c).comp ++ v2.s ! PPasse np.a.g np.a.n Indef (convCase c);
      a = np.a ;
      hasClit = np.hasClit;
      ss = (np.s ! No).comp ++ v2.s ! PPasse np.a.g np.a.n Indef ANomAcc
      } ;

    RelNP np rs = heavyNP {
      s = \\c => (np.s ! c).comp ++ rs.s ! Indic ! np.a ;
      a = np.a ;
      hasClit = False ;
      ss = (np.s ! No).comp ++ rs.s ! Indic ! np.a  
     } ;

    AdvNP np adv = heavyNP {
      s = \\c => (np.s ! c).comp ++ adv.s ;
      a = np.a ;
      hasClit = False;
      ss = (np.s ! No).comp ++adv.s ;
      } ;

    DetQuantOrd quant num ord = let n = num.n                                       
in {
      s = \\g,c => let s1 = if_then_Str quant.isDef (ord.s ! n ! g ! c) (ord.s ! n ! g ! No);
                       s2 = if_then_Str quant.isPost "" (quant.s ! num.isNum ! n ! g  ! (convCase c) ) 
                  
                    in 
                    s2 ++ s1 ++ num.s ! g  ;
      sp = \\g,c => let 
                        s1 = if_then_Str quant.isDef (ord.s ! n ! g ! c) (ord.s ! n ! g ! No) ;
                        s3 = if_then_Str quant.isPost (s1 ++ num.sp ! g ++ quant.sp ! n ! g ! ANomAcc) (quant.sp ! n ! g ! (convCase c) ++ s1 ++ num.sp ! g) 
                        
                      in   
                      s3 ; 
      post = \\g,c => let s2 = if_then_Str quant.isPost (quant.s ! num.isNum ! n ! g  ! (convCase c)) ""     
                      in  
                      s2    ;
      n = num.n ;
      isDef = False;
      size = num.size;
      hasRef = quant.hasRef 

      } ;

    DetQuant quant num = let n = num.n ;
                             needDem = andB quant.isDef num.isNum                                     
        in {
      s  = \\g,c => let s1 = if_then_Str quant.isPost "" (quant.s ! num.isNum ! n ! g ! (convCase c)) ; 
                        s2 = if_then_Str needDem (artDem g n (convCase c)) ""   
                           in s2 ++ s1 ++ num.s ! g ;
      sp = \\g,c => let s1 = if_then_Str needDem (artDem g n (convCase c)) "" ;
                        s2 = if_then_Str quant.isPost (s1 ++ num.sp ! g ++ quant.sp ! n ! g ! ANomAcc) (s1 ++ quant.sp ! n ! g ! (convCase c) ++ num.sp ! g)
                      in s2 ;
        
      post = \\g,c => if_then_Str quant.isPost (quant.s ! num.isNum ! n ! g ! (convCase c)) "" ;
      n = num.n ;
      isDef = case num.isNum of 
                {True => False ;
                 _    => quant.isDef };
      size = num.size ;
      hasRef = quant.hasRef
      } ;

-- consider fixing for possesive pronouns !
    DetNP det = 
      let 
        g = Masc ;  
        n = det.n
      in heavyNP {
        s = \\c => det.sp ! g ! c ;
        a = agrP3 g n ;
        hasClit = True ;
        ss = det.sp ! g ! No   
       } ;

-- assume that it refers to people

    PossPron p = {
      s = \\_,n,g,c =>  p.poss ! n ! g ; 
      sp = \\ n,g,c => artPos g n c ++ p.poss ! n ! g ; 
      isDef = True ;
      isPost = True ;
      hasRef = True
      } ;




    NumSg = {s = \\_ => [] ; sp = \\_ => [] ; isNum = False ; n = Sg ; size = ""} ;
    NumPl = {s = \\_ => [] ; sp = \\_ => [] ; isNum = False ; n = Pl ; size = ""} ;

    NumCard n = {s = n.s ; sp = n.sp ; size = getSize n.size ;
                 isNum = True;  n = getNumber n.size   
                      } ;

    NumDigits nu = {s,sp = \\g => nu.s ! NCard g ;
                    size = nu.n; n = getNumber nu.n };
    OrdDigits nu = {s =  table{Sg => \\g,c => nu.s ! NOrd g ;
                               Pl => \\g,c => []  } ;
                    isPre = True
                    };

    NumNumeral nu = {s = \\g => nu.s ! ANomAcc ! (NCard g) ! Formal ; 
                     sp = \\g => nu.sp ! ANomAcc ! (NCard g) ! Formal ;
                     n = getNumber nu.size ; size = nu.size };

    OrdNumeral nu = {s = table {Sg => \\g,c => nu.s ! (convCase c) ! NOrd g ! Formal;
                                Pl => \\g,c => []
                               };
                     isPre = True} ;

    AdNum adn num = {s = \\a => adn.s ++ num.s ! a ; 
                     sp = \\a => adn.s ++ num.sp ! a ;
                     isNum = num.isNum ; n = num.n; size = num.size} ;

    OrdSuperl adj = {s = \\n,g,c => artDem g n (convCase c) ++ "mai" ++ adj.s ! AF g n Indef (convCase c);
                     isPre = True;
                     };

    DefArt = {
      s = \\b,n,g,c => [] ;  
      sp = \\n,g,c => [] ; 
      isDef = True ;
      isPost = False ;
      hasRef = False 
      } ;

    IndefArt = {
      s = \\b,n,g,c =>  if_then_Str b [] (artUndef g n (convACase c)) ;
      sp = table {Sg => table {Masc => table {AGenDat => "unuia"; AVoc => [] ; _ => "unul" };
                               Fem  => table {AGenDat => "uneia"; AVoc => [] ; _ => "una" }
                               };
                  Pl => table {Masc => table {AGenDat => "unora"; AVoc => "" ; _ => "unii"};
                               Fem  => table {AGenDat => "unora"; AVoc => "" ; _ => "unele"}
                              }  
                  };    
      isDef = False ;
      isPost = False ;
      hasRef = False

      } ;

-- since mass noun phrases are not referential, it's no point keeping track of clitics

    MassNP cn = let 
        g = case cn.g of
             {NFem => Fem ;
              _    => Masc} ;  
        hc = getClit cn.a ;
        n = Sg
      in {
        s = \\c =>   {comp = cn.s ! n ! Indef ! (convCase c); 
                      clit = \\cs => []  } ;
        a = agrP3 g n ;
        hasClit = hc ;
        hasRef = False ;
        isPronoun = False ;
        poss = \\g,n => [] ;
        indForm = cn.s ! n ! Indef ! ANomAcc
        } ;

-- This is based on record subtyping.

    UseN, UseN2 = \noun -> noun ;

    Use2N3 f = f ;

    Use3N3 f = f ** {c2 = f.c3} ;

    ComplN2 f x = {
      s = \\n,sp,c => f.s ! n ! sp ! c ++ appCompl f.c2 x ;
      g = f.g ;
      a = f.a
      } ;

    ComplN3 f x = {
      s = \\n,sp,c => f.s ! n ! sp ! c ++ appCompl f.c2 x ;
      g = f.g ;
      c2 = f.c3;
      a = f.a
      } ;

    AdjCN ap cn = 
      let 
        g = cn.g         
      in {
        s =  case ap.isPre of 
                 {True => \\n => table {Def => \\c => case c of 
                                               {Voc => ap.s ! (AF (agrGender g n) n Def ANomAcc) ++ cn.s ! n ! Indef ! ANomAcc;
                                                _   => ap.s ! (AF (agrGender g n) n Def c) ++ cn.s ! n ! Indef ! c
                                                };
                                        Indef => \\c => case c of 
                                                 {Voc => ap.s ! (AF (agrGender g n) n Indef ANomAcc) ++ cn.s ! n ! Indef ! ANomAcc;
                                                  _   => ap.s ! (AF (agrGender g n) n Indef c) ++ cn.s ! n ! Indef ! c}};
                  False => \\n => table {Def => \\c => case c of 
                                                 {Voc => cn.s ! n ! Indef ! ANomAcc ++ ap.s ! (AF (agrGender g n) n Indef ANomAcc);
                                                  _   => cn.s ! n ! Def ! c ++ ap.s ! (AF (agrGender g n) n Indef c)};
                                         Indef => \\c => case c of 
                                                 {Voc => cn.s ! n ! Indef ! ANomAcc ++ ap.s ! (AF (agrGender g n) n Indef ANomAcc);
                                                  _   => cn.s ! n ! Indef ! c ++ ap.s ! (AF (agrGender g n) n Indef c) }} 
                 };
        g = g ;
        a = cn.a
        } ;


    RelCN cn rs = {
      s = \\n,sp,c => cn.s ! n ! sp ! c ++ rs.s ! Indic ! agrP3 (agrGender cn.g n) n ;
      g = cn.g  ;
      a = cn.a
      } ;

    SentCN  cn sc = let g = cn.g in {
      s = \\n,sp,c => cn.s ! n ! sp ! c ++ sc.s ;
      g = g ;
      a = cn.a
      } ;

    AdvCN  cn sc = let g = cn.g in {
      s = \\n,sp,c => cn.s ! n ! sp ! c ++ sc.s ;
      g = g;
      a = cn.a
      } ;

    ApposCN  cn np = let g = cn.g in {
      s = \\n,sp,c => cn.s ! n ! sp ! c ++ (np.s ! No).comp ;
      g = g;
      a = cn.a
      } ;


}; 



