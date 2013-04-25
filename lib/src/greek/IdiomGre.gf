concrete IdiomGre of Idiom = CatGre ** open Prelude,BeschGre, ResGre in {

  flags coding=utf8 ;

  lin

    ImpersCl vp = predVP [] (Ag Neut Sg P3) vp ;   
    GenericCl vp = predVP "κάποιος" (Ag Neut Sg P3) vp ;


    CleftNP np rs = predVP [] (np.a)
    (insertComplement (\\_ => rs.s ! Ind ! np.a)
        (insertComplement (\\_ => (np.s ! rs.c).comp) (predV copula))) ;
   
    CleftAdv ad s = predVP []  (agrP3 Masc Sg) 
      (insertComplement (\\_ => "που" ++ s.s ! Ind)
        (insertComplement (\\_ => ad.s) (predV copula))) ;

    ExistNP np = 
    predVP [] (np.a)
      (insertComplement (\\_ => (np.s ! Nom).comp) (predV Exist)) ;

  
    ExistIP ip = {
      s = \\t,a,p => 
        let 
          cls = (predVP [] (agrP3 Neut ip.n) (predV Exist)).s ! Inv ! t ! a ! p ! Ind ;
          who = ip.s ! Neut ! Acc 
        in table {
          QDir   => who ++ cls  ;
          QIndir => who ++ cls 
          }
        } ;

        

    ProgrVP vp = {
      v =  vp.v;   
      clit = vp.clit ;
      clit2 = vp.clit2 ;
      comp = \\a => vp.comp ! a;
      isNeg=False;
      voice = vp.voice ;
      aspect = Imperf
      } ; 


    ImpPl1 vp = {s = (predVP [] (Ag Masc Pl P1) vp).s ! Main !  TPres ! Simul ! Pos !Hortative } ;

    ImpP3 np vp = {s = (predVP (np.s ! Nom).comp  np.a vp).s ! Inv ! TPres ! Simul ! Pos !Hortative } ;

    

}

