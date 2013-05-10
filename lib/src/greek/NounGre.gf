concrete NounGre of Noun = CatGre ** open  ResGre, ParadigmsGre, Prelude in {

  flags coding= utf8 ;

  lin


   DetCN det cn = 
      let 
        g = cn.g ;
        n = det.n
      in heavyNPpol det.isNeg {
        s = \\c => det.s ! cn.g ! c ++ cn.s ! det.n ! c ;
        a =Ag cn.g det.n P3 ;
        } ;

    UsePN pn = {   
        s = \\c=> { 
        comp = artDef pn.g  Sg c ++ pn.s ! Sg ! c  ;       
        c1 = [] ; 
        c2 = [] ; 
        isClit = False
        } ;
     a = Ag  pn.g Sg P3;
     isNeg =False;
    } ; 

    UsePron pron = pron ** {isNeg = False} ;


    PredetNP pred np = 
      let agr = complAgr np.a in
      heavyNPpol np.isNeg {
        s = \\c => pred.s !agr.n !  agr.g ! c ++  (np.s ! c).comp;
        a =Ag agr.g agr.n P3 ;
      } ; 


    PPartNP np v2 = 
      let agr = agrFeatures np.a 
      in                                  
        {
        s = \\c => {
        comp =   possCase agr.g agr.n c ++ v2.s ! Participle Posit agr.g agr.n c ++ (np.s ! c).comp   ;
        c1 = [] ;
        c2 = [] ;
        isClit = False
        } ;
     a = np.a ;
     isNeg =False;
    } ;


    AdvNP np adv = {
      s = \\c => {
        comp =  (np.s ! c).comp  ++ adv.s;
        c1 = [] ;
        c2 = [] ;
        isClit = False
        } ;
      a = np.a ;
      isNeg =False;
      } ;


    RelNP np rs = {
      s = \\c => { 
        comp =  (np.s ! c).comp  ++ rs.s! Ind ! np.a ;
        c1 = [] ;
        c2 = [] ;
        isClit = False
        } ;
      a = np.a ;
      isNeg =False;
      } ;

    DetNP det = 
     let 
       g = Neut ;  
       n = det.n
     in heavyNP {
       s = det.sp ! g ;
       a = agrP3 g n ;
      isClit = False
      } ;


    DetQuant quant num = {  
      s  = \\g,c => quant.s ! num.isNum ! g ! num.n  ! c ++ num.s ! g !c; 
      sp = \\g,c => case num.isNum of {
          True  => quant.s ! True ! g! num.n  ! c ++ num.s ! g !c; 
          False => quant.sp !g ! num.n ! c ++ num.s ! g!c
          } ; 
      n  = num.n ;
      isNeg = quant.isNeg
       } ;

     DetQuantOrd quant num ord = {
       s,sp = \\g,c => quant.s ! num.isNum ! g ! num.n  ! c ++ num.s ! g !c++ 
                   ord.s ! Posit ! g ! num.n  !c; 
       n  = num.n ;
       isNeg = quant.isNeg
        } ;

    NumPl = {s = \\g,c => []; n = Pl ; isNum = False} ; 

    NumSg = {s = \\g,c => []; n = Sg ; isNum = False} ; 

    NumCard n = n ** {isNum = True} ;

    NumNumeral numeral = {s = \\g,c => numeral.s ! NCard g c; n = numeral.n } ;

    NumDigits numeral = {s = \\g,c => numeral.s ! NCard g c; n = numeral.n } ;

    AdNum adn num = {s = \\g,c => adn.s ++ num.s!g!c; n = num.n } ;

    OrdNumeral numeral = {s = \\_,g,n,c=> numeral.s !  NOrd g n c ;
      adv= table { Posit => " " ; Compar =>  " " ; Superl =>  " "}
    } ;

    
    OrdDigits numeral = {s = \\_,g,n,c=> numeral.s !  NOrd g n c ; 
      adv= table { Posit => " " ; Compar =>  " " ; Superl =>  " "}
    } ;

    OrdSuperl a = {s = \\d,g,n,c=>  a.s ! Superl ! g ! n ! c ;
      adv= a.adv
    } ;


    DefArt = {
      s = \\_,g,n,c => artDef g n c ;
      sp = \\g,n,c => artDef g n c ;
      isNeg =False ;
      } ;

     IndefArt = {
     s = \\_,g,n,c => artIndef g n c ;
     sp = \\g,n,c => artIndef g n c ;
     isNeg =False ;
     } ;



    MassNP cn =      
     let   
        g = cn.g ;
        n = Sg
      in heavyNP {
       s = \\c => cn.s ! n ! c ;
        c1 = []; 
        c2 = [];
        isClit = False ;
        a = agrP3 g n ;
        isNeg =False;
       } ;


     PossPron pron = {
        s = \\_,g,n,c =>possCase g n c ++ (regAdj "δικός").s !Posit! g !n !c ++  pron.poss ;  
        sp = \\ g,n,c =>possCase g n c ++ (regAdj "δικός").s !Posit! g !n !c ++   pron.poss;
        isNeg = False;
      } ;


      UseN n = n;


     ComplN2 f x = {
        s = \\n,c => f.s ! n ! c++ appCompl f.c2 x ;
        g = f.g ;
      } ;

     ComplN3 f x = {
        s = \\n,c => f.s ! n ! c++  appCompl f.c2 x ;
        g = f.g ;
        c2 = f.c3
      } ;

      UseN2 n = n ;

      Use2N3 f = f ;

      Use3N3 f = f ** {c2 = f.c3} ;


      AdjCN ap cn = {
          s = \\n,c => ap.s ! Posit ! cn.g ! n ! c ++ cn.s ! n ! c ;
          g = cn.g
        } ;

   

      RelCN cn rs = 
        let 
          g = cn.g ;
        in {
            s = \\n,c => cn.s ! n ! c ++"," ++  rs.s ! Ind ! agrP3 g n ; 
            g = g
        } ;


      AdvCN cn ad = {s = \\n,c => cn.s ! n ! c ++ ad.s ; g = cn.g} ;  

      SentCN cn sc = {s = \\n,c => cn.s ! n ! c ++ sc.s ; g = cn.g} ;  

    
      ApposCN  cn np = 
        let g = cn.g 
        in {
          s = \\n,c =>cn.s ! n ! c ++ (np.s ! c).comp ;
          g = g
      } ;
    
      
      PossNP  cn np = 
        let g = cn.g 
        in {
          s = \\n,c => cn.s ! n !c ++ (np.s ! Gen).c1 ;
          g = g
      } ;

     
     PartNP  cn np = 
      let g = cn.g 
      in {
          s = \\n,c => cn.s ! n !c ++ (np.s ! Nom).comp ;
          g = g
      } ;
  
   
    CountNP det np =
     let agr = complAgr np.a 
     in {
       s = \\c => {
       comp = det.s ! agr.g ! c ++ "από" ++ (np.s ! CPrep PNul).comp ;  
       c1 = [] ; 
       c2 = [] ;
       isClit = False
        } ;
     a = Ag agr.g det.n P3;
     isNeg =False;
      } ;
      


}