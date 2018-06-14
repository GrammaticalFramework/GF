--# -coding=cp1251
concrete ConjunctionBul of Conjunction = 
  CatBul ** open ResBul, Coordination, Prelude, Predef in {
  flags coding=cp1251 ;


  flags optimize=all_subs ;

  lin
    ConjS conj ss = {
      s = conj.s ++ (linCoordSep [])!conj.distr!conj.conj++ss.s!conj.distr!conj.conj;
      } ;

    ConjAdv conj ss = {
      s = conj.s ++ (linCoordSep [])!conj.distr!conj.conj++ss.s!conj.distr!conj.conj;
      } ;

    ConjAdV conj ss = {
      s = conj.s ++ (linCoordSep [])!conj.distr!conj.conj++ss.s!conj.distr!conj.conj;
      p = Pos
      } ;

    ConjIAdv conj ss = {
      s = \\qform => conj.s ++ (linCoordSep [])!conj.distr!conj.conj++ss.s!conj.distr!conj.conj!qform;
      } ;

    ConjNP conj ss = {
      s = \\role => conj.s ++ (linCoordSep [])!conj.distr!conj.conj++ss.s!conj.distr!conj.conj!role;
      a = {gn = conjGenNum (gennum (AMasc NonHuman) conj.n) ss.a.gn; p = ss.a.p};
      p = Pos
      } ;

    ConjAP conj ss = {
      s     = \\aform,p => conj.s ++ (linCoordSep [])!conj.distr!conj.conj++ss.s!conj.distr!conj.conj!aform!p;
      adv   =              conj.s ++ (linCoordSep [])!conj.distr!conj.conj++ss.adv!conj.distr!conj.conj;
      isPre = ss.isPre
      } ;

    ConjRS conj ss = {
      s = \\role => conj.s ++ (linCoordSep [])!conj.distr!conj.conj++ss.s!conj.distr!conj.conj!role
      } ;

    ConjCN conj ss = {
      s = \\nform => conj.s ++ (linCoordSep [])!conj.distr!conj.conj++ss.s!conj.distr!conj.conj!nform;
      g = ss.g
      } ;

-- These fun's are generated from the list cat's.
    BaseS x y  = {s  = \\d,t=>x.s++linCoord!t++ y.s} ; 
    ConsS x xs = {s  = \\d,t=>x.s++(linCoordSep comma)!d!t++xs.s!d!t} ;

    BaseAdv x y  = {s  = \\d,t=>x.s++linCoord!t++ y.s} ; 
    ConsAdv x xs = {s  = \\d,t=>x.s++(linCoordSep comma)!d!t++xs.s!d!t} ;

    BaseAdV x y  = {s  = \\d,t=>x.s++linCoord!t++ y.s} ; 
    ConsAdV x xs = {s  = \\d,t=>x.s++(linCoordSep comma)!d!t++xs.s!d!t} ;

    BaseIAdv x y  = {s  = \\d,t,qform=>x.s!qform++linCoord!t++ y.s!qform} ; 
    ConsIAdv x xs = {s  = \\d,t,qform=>x.s!qform++(linCoordSep comma)!d!t++xs.s!d!t!qform} ;

    BaseNP x y =
      {s = \\d,t,role=>x.s!role++linCoord!t++y.s!role; 
       a = conjAgr x.a y.a} ;
    ConsNP x xs =
      {s = \\d,t,role=>x.s!role++(linCoordSep comma)!d!t++xs.s!d!t!role; 
       a = conjAgr xs.a x.a} ;

    BaseAP x y =
      {s  = \\d,t,aform,p => x.s!aform!p++linCoord!t++y.s!aform!p; 
       adv= \\d,t         => x.adv      ++linCoord!t++y.adv;
       isPre = andB x.isPre y.isPre} ; 
    ConsAP x xs =
      {s  = \\d,t,aform,p =>x.s!aform!p++(linCoordSep comma)!d!t++xs.s!d!t!aform!p;
       adv= \\d,t         =>x.adv      ++(linCoordSep comma)!d!t++xs.adv!d!t;
       isPre = andB x.isPre xs.isPre} ; 

    BaseRS x y =
      {s = \\d,t,role=>x.s!role++linCoord!t++y.s!role} ;
    ConsRS x xs =
      {s = \\d,t,role=>x.s!role++(linCoordSep comma)!d!t++xs.s!d!t!role} ;

    BaseCN x y =
      {s = \\d,t,nform=>x.s!nform++linCoord!t++y.s!nform;
       g = x.g} ;
    ConsCN x xs =
      {s = \\d,t,nform=>x.s!nform++(linCoordSep comma)!d!t++xs.s!d!t!nform;
       g = x.g} ;

  lincat
    [S] = {s : Bool => Ints 3 => Str} ;
    [Adv] = {s : Bool => Ints 3 => Str} ;
    [AdV] = {s : Bool => Ints 3 => Str} ;
    [IAdv] = {s : Bool => Ints 3 => QForm => Str} ;
    [NP] = {s : Bool => Ints 3 => Role  => Str; a : Agr} ;
    [AP] = {s : Bool => Ints 3 => AForm => Person => Str; adv : Bool => Ints 3 => Str; isPre : Bool} ;
    [RS] = {s : Bool => Ints 3 => Agr   => Str} ;
    [CN] = {s : Bool => Ints 3 => NForm => Str; g : AGender} ;

}
