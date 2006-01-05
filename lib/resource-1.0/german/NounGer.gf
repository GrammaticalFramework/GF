concrete NounGer of Noun = CatGer ** open ResGer, Prelude in {

  flags optimize=all_subs ;

  lin
    DetCN det cn = {
      s = \\c => det.s ! cn.g ! c ++ cn.s ! adjfCase c ! det.n ! c ;
      a = agrP3 det.n ;
      isPron = False
      } 
     where {
       adjfCase : Case -> Adjf = \c -> case <det.a,c> of {
         <Strong, Nom|Acc> => Strong ;
         _ => Weak
         }
       } ;      

    UsePN pn = pn ** {a = agrP3 Sg} ;
    UsePron pron = {
      s = \\c => pron.s ! NPCase c ;
      a = pron.a
      } ;

    MkDet pred quant num ord = 
      let 
        n = quant.n ;
        a = quant.a
      in {
        s = \\g,c => pred.s ! n ! g ! c ++ quant.s ! g ! c ++ 
                     num.s ! g ! c ++ ord.s ! a ! g ! c ;
        n = n ;
        a = a
        } ;

    PossPronSg p = {
      s = \\g,c => p.s ! NPPoss (gennum g Sg) c ;
      n = Sg ;
      a = Strong
      } ;

    PossPronPl p = {
      s = \\g,c => p.s ! NPPoss (gennum g Pl) c ;
      n = Pl ;
      a = Weak
      } ;

    NoPredet = {s = \\_,_,_ => []} ; 
    NoNum = {s = \\_,_ => []} ; 
    NoOrd = {s = \\_,_,_ => []} ;

    NumInt n = {s = \\_,_ => n.s} ;

--
--    NumNumeral numeral = {s = numeral.s ! NCard} ;
--    OrdNumeral numeral = {s = numeral.s ! NOrd} ;
--
--    AdNum adn num = {s = adn.s ++ num.s} ;
--
--    OrdSuperl a = {s = a.s ! AAdj Superl} ;

    DefSg = {
      s = \\g,c => artDef ! GSg g ! c ; 
      n = Sg ;
      a = Weak
      } ;
    DefPl = {
      s = \\_,c => artDef ! GPl ! c ; 
      n = Pl ;
      a = Weak
      } ;

    IndefSg = {
      s = \\g,c => "ein" + pronEnding ! GSg g ! c ;  
      n = Sg ;
      a = Strong
      } ;
    IndefPl = {
      s = \\_,_ => [] ; 
      n = Pl ;
      a = Strong
      } ;
--
--    ComplN2 f x = {s = \\n,c => f.s ! n ! Nom ++ f.c2 ++ x.s ! c} ;
--    ComplN3 f x = {s = \\n,c => f.s ! n ! Nom ++ f.c2 ++ x.s ! c ; c2 = f.c3} ;

    AdjCN ap cn = 
      let 
        g = cn.g 
      in {
        s = \\a,n,c => 
               preOrPost ap.isPre
                 (ap.s ! agrAdj g a n c)
                 (cn.s ! a ! n ! c) ;
        g = g
        } ;

--    RelCN cn rs = {s = \\n,c => cn.s ! n ! c ++ rs.s ! {n = n ; p = P3}} ;
--
--    SentCN cn s = {s = \\n,c => cn.s ! n ! c ++ conjThat ++ s.s} ;
--    QuestCN cn qs = {s = \\n,c => cn.s ! n ! c ++ qs.s ! QIndir} ;

    UseN n = {
      s = \\_ => n.s ;
      g = n.g
      } ;

}
