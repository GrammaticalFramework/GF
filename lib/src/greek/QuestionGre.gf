concrete QuestionGre of Question = CatGre ** open ResGre, Prelude in {

  flags coding= utf8 ;

  lin


   QuestCl cl = {
      s = \\t,a,p => 
            let cls = cl.s ! Main !  t ! a ! p !Ind ;
            in table {
              QDir   => cls  ;
              QIndir => "αν" ++ cls 
              }
            } ;

  
    QuestVP qp vp = {
      s = \\t,a,p => 
            let cl = (predVP (qp.s ! qp.a.g ! Nom) (Ag qp.a.g qp.n P3 ) vp).s ! Main! t ! a! p! Ind
            in table {
              QDir   => cl  ;
              QIndir => cl 
              }
           } ;

    QuestIComp icomp np = { 
      s = \\t,a,p => 
        let 
          vp  = predV copula;
          cl = (predVP (np.s ! Nom).comp  np.a vp).s ! Inv ! t ! a ! p! Ind ;
          why = icomp.s  
        in table {
            QDir   => why ++ cl  ;
            QIndir => why ++ cl 
            }
        } ;




     QuestSlash ip slash = { 
      s = \\t,a,p => 
            let
            agr = Ag ip.a.g ip.n P3 ;
              cls = slash.s  !  ip.a !  Inv !  t ! a ! p!  Ind ++ slash.n3 !agr;
              who =  slash.c2.s ++ ip.s ! Masc ! slash.c2.c      
           in table {
              QDir   => who ++ cls  ;
              QIndir => who ++ cls 
              }
          } ;
   

    QuestIAdv iadv cl = {
      s = \\t,a,p => 
          let 
            cls = cl.s ! Inv  ! t ! a ! p!Ind ; 
            why = iadv.s  
          in table {
              QDir   => why ++ cls  ;
              QIndir => why ++ cls 
              }
          } ;



     CompIAdv a = a ;

  
     CompIP ip = {s =  ip.s !Masc !  Nom} ;

     PrepIP p ip = {
      s = p.s ++ ip.s! Masc ! p.c     
      } ;


      AdvIP ip adv = {
        s = \\g,c => ip.s  ! g! c ++ adv.s ;
        n = ip.n;
        a = ip.a
      } ;
 


      AdvIAdv i a = {s = i.s ++ a.s} ;


      IdetCN idet cn = 
        let
          g= cn.g ;
          n = idet.n;
          a = aagr g n
        in {
            s = \\g,c => idet.s ! cn.g !  c ++ cn.s ! n ! c ;
            n = n ;
            a = a 
        } ;


      IdetQuant idet num = 
        let 
           n = num.n
        in {
          s = \\g,c => idet.s ! n! g ! c ++ num.s !g !c; 
          n = n
        } ;

  
      IdetIP idet = 
        let 
          g = Neut ; 
          n = idet.n ;
          a = aagr g n
        in {
          s = idet.s ;
          n = n ;
          a =a 
      } ;

  
  
  lincat 
    QVP = ResGre.VP ;
  lin
    ComplSlashIP vp ip = insertObject vp.c2 {s = \\c => {
        comp = ip.s ! Masc ! c  ;  
        c1 = [] ; 
        c2 = [] ;
       isClit = False
        } ;a = Ag Masc ip.n  P3;isNeg= False } vp ;


    AdvQVP vp adv = insertAdv adv.s vp ;

    AddAdvQVP vp adv = insertAdv adv.s vp ;

    QuestQVP qp vp = { 
      s = \\t,a,p => 
        let
          cl = (predVP (qp.s ! qp.a.g ! Nom) (Ag qp.a.g qp.n P3 ) vp).s ! Main! t ! a! p! Ind
         in table {
              QDir   => cl  ;
              QIndir => cl 
              }
      } ;  
   



}
