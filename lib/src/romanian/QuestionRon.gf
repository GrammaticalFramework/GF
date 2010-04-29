concrete QuestionRon of Question = 
  CatRon ** open ResRon, Prelude in {

  flags optimize=all_subs ;

  lin

    QuestCl cl = {
      s = \\t,a,p => 
            let cls = cl.s ! DDir ! t ! a ! p  
            in table {
              QDir   => cls ! Indic ;
              QIndir => "dacã" ++ cls ! Indic
              }
      } ;
 -- doesn't have clitics since it's subject of the phrase

    QuestVP qp vp = {
      s = \\t,a,b,_ => 
        let
          cl = mkClause (qp.s ! No) False (agrP3 qp.a.g qp.a.n) vp  
        in
        cl.s ! DDir ! t ! a ! b ! Indic
      } ;   

    QuestSlash ip slash = {
      s = \\t,a,p => 
            let 
              cls : Direct -> Str = 
                    \d -> slash.s ! False ! ip.a ! d ! t ! a ! p ! Indic ;
                          prep = if_then_Str ip.hasRef slash.c2.prepDir "" ;
                          who  = prep ++ slash.c2.s ++ ip.s ! slash.c2.c
            in table {
              QDir   => who ++ cls DInv ;
              QIndir => who ++ cls DDir
              }
      } ;

    QuestIAdv iadv cl = {
      s = \\t,a,p,q => 
            let 
              ord = case q of {
                QDir   => DInv ;
                QIndir => DDir
              } ;
              cls = cl.s ! ord ! t ! a ! p ! Indic ;
              why = iadv.s
            in why ++ cls
      } ;

    QuestIComp icomp np = {
      s = \\t,a,p,_ => 
            let 
              vp  = predV copula ;
              cls = (mkClause (np.s ! No).comp np.isPol np.a vp).s ! 
                       DInv ! t ! a ! p ! Indic ;
              why = icomp.s ! {g = np.a.g ; n = np.a.n}
            in why ++ cls
      } ;

    PrepIP p ip = {
      s = p.s ++ ip.s ! p.c
      } ;

    AdvIP ip adv = {
      s = \\c => ip.s ! c ++ adv.s ;
      a = ip.a;
      hasRef = ip.hasRef
      } ;

    IdetCN idet cn = 
      let 
        
        n = idet.n ;
        g = agrGender cn.g n;
        a = aagr g n
      in {
      s = \\c => idet.s ! g ! (convCase c) ++ cn.s ! n ! Indef ! (convCase c); 
      a = a;
      hasRef = getClit cn.a

      } ;

    IdetIP idet = 
      let 
        g = Masc ; 
        n = idet.n ;
        a = aagr g n
      in {
      s = \\c => idet.s ! g ! (convCase c) ; 
      a = a ;
      hasRef = True
      } ;

    IdetQuant idet num = 
      let 
        n = num.n ;
      in {
      s = \\g,c => idet.s ! n ! g ! c ++ num.s ! g ;
      n = n
      } ;

    AdvIAdv i a = {s = i.s ++ a.s} ;

    CompIAdv a = {s = \\_  => a.s} ;

    CompIP p = {s = \\_  => p.s ! No} ;


}
