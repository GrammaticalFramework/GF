concrete NounEng of Noun = CatEng ** open ResEng in {

  flags optimize=all_subs ;

  lin
    DetCN det cn = {s = \\c => det.s ++ cn.s ! det.n ! c} ** agrP3 det.n ;
    UsePN pn = pn ** agrP3 Sg ;
    UsePron p = p ; --- causes mcfg error, even if expanded

    MkDet pred quant num = {
      s = pred.s ++ quant.s ++ num.s ; 
      n = quant.n
      } ;

    PossPronSg p = {s = p.s ! Gen ; n = Sg} ;
    PossPronPl p = {s = p.s ! Gen ; n = Pl} ;

    NoNum, NoPredet = {s = []} ;
    NumInt n = n ;

    DefSg = {s = "the" ; n = Sg} ;
    DefPl = {s = "the" ; n = Pl} ;

    IndefSg = {s = "a" ; n = Sg} ;
    IndefPl = {s = []  ; n = Pl} ;

    UseN n = n ;

    ComplN2 f x = {s = \\n,c => f.s ! n ! Nom ++ f.c2 ++ x.s ! c} ;
    ComplN3 f x = {s = \\n,c => f.s ! n ! Nom ++ f.c2 ++ x.s ! c ; c2 = f.c3} ;

-- structural

    only_Predet = {s = "only"} ;

}
