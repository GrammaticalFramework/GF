concrete RelativeGre of Relative = CatGre ** open Prelude, ResGre in {

  flags coding= utf8;

  lin

                         

 

    RelCl cl = {
      s = \\ag,t,a,p,_ =>"ώστε"   ++  cl.s ! Main ! t ! a ! p ! Ind ;
      c = Nom
      } ;

    RelVP rp vp = case rp.hasAgr of {
     True => {s = \\ag,t,a,p,m =>
       (predVP
                    (rp.s !  False!   complAgr ag ! Nom )
                   (Ag rp.a.g rp.a.n P3) 
                   vp).s ! Main !t !a! p! m ; c = Nom } ;
        False => {s = \\ag,t,a,p,m =>
         (predVP
                    (rp.s ! True!   complAgr ag ! Nom) 
                    ag
                   vp).s! Main !t! a! p! m ; c = Nom
        }
     } ;


 
    RelSlash rp slash = {
      s = \\ag,t,a,p,m => 
          let aag = complAgr ag ;
          agr = Ag rp.a.g rp.a.n P3 ;
          in
              slash.c2.s ++  rp.s ! False ! aag ! slash.c2.c ++ 
              slash.s ! aag ! Main ! t ! a ! p ! m ++ slash.n3 ! agr ;    
        c = Acc
      } ;


    FunRP p np rp = {
        s = \\_,a,c => (np.s ! c).comp ++ p.s ++ rp.s ! False ! a ! p.c ;
        a = complAgr np.a ; 
        hasAgr = True
      } ;


    IdRP = {
      s = relPron ; 
      a = {g = Masc ; n = Sg} ; 
      hasAgr = False
      } ;
} 

