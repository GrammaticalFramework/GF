--# -path=.:../abstract:../common:../prelude

concrete NounLav of Noun = CatLav ** open
  MorphoLav,
  ResLav,
  Prelude
in {

flags
  coding = utf8 ;
  optimize = all_subs ;

lin

  UseN n = { s = \\_ => n.s ; g = n.g } ;

  UsePN pn = { s = pn.s ; a = agrgP3 pn.n pn.g ; isNeg = False } ;
  
  UsePron p = p ** { isNeg = False };

  PredetNP pred np = {
    s = \\c => pred.s ! (fromAgr np.a).g ++ np.s ! c ;
    a = np.a ;
    isNeg = False 
  } ;

  UseN2 n = { s = \\_ => n.s ; g = n.g } ;
  
  --UseN3 n = n ;

  ComplN2 f x = {
    s = \\_,n,c => preOrPost f.isPre (f.p.s ++ x.s ! (f.p.c ! (fromAgr x.a).n)) (f.s ! n ! c) ;
    g = f.g
  } ;

  ComplN3 f x = {
    s = \\n,c => preOrPost f.isPre1 (f.p1.s ++ x.s ! (f.p1.c ! (fromAgr x.a).n)) (f.s ! n ! c) ;
    g = f.g ;
    p = f.p2 ;
    isPre = f.isPre2
  } ;

  Use2N3 n = { s = n.s ; g = n.g ; p = n.p1 ; isPre = n.isPre1 } ;
  
  Use3N3 n = { s = n.s ; g = n.g ; p = n.p2 ; isPre = n.isPre2 } ;

  AdvNP np adv = {
    s = \\c => np.s ! c ++ adv.s ;
    a = np.a ;
    isNeg = np.isNeg
  } ;

  RelNP np rs = {
    s = \\c => np.s ! c ++ "," ++ rs.s ! np.a ;
    a = np.a ;
    isNeg = np.isNeg
  } ;

  DetCN det cn = {
    s = \\c => det.s ! cn.g ! c ++ cn.s ! det.d ! det.n ! c ;
    a = AgP3 det.n cn.g ;
    isNeg = det.isNeg
  } ;

  DetQuant quant num = {
    s = \\g,c => quant.s ! g ! num.n ! c ++ num.s ! g ! c ;
    n = num.n ;
    d = quant.d	; -- FIXME: ja ir kārtas skaitļa vārds, tad tikai noteiktās formas drīkst būt
    isNeg = quant.isNeg
  } ;

  DetQuantOrd quant num ord = {
    s = \\g,c => quant.s ! g ! num.n ! c ++ num.s ! g ! c ++ ord.s ! g ! c ;
    n = num.n ;
    d = quant.d	; --FIXME: ja ir kārtas skaitļa vārds, tad tikai noteiktās formas drīkst būt
    isNeg = quant.isNeg
  } ;

  DetNP det = {
    s = \\c => det.s ! Masc ! c ;
    a = AgP3 det.n Masc ;
    isNeg = det.isNeg
  } | {
    s = \\c => det.s ! Fem ! c ;
    a = AgP3 det.n Fem ;
    isNeg = det.isNeg
  } ;

  AdjCN ap cn = {
    s = \\d,n,c => ap.s ! d ! cn.g ! n ! c ++ cn.s ! d ! n ! c ;
    g = cn.g
  } ;

  DefArt = {
    s = \\_,_,_ => [] ;
    d = Def ;
    isNeg = False
  } ;

  IndefArt = {
    s = \\_,_,_ => [] ;
    d = Indef ;
    isNeg = False
  } ;

  PossPron p = {
    s = p.possessive ;
    d = Def ;
    isNeg = False
  } ;

  MassNP cn = {
    s = cn.s ! Indef ! Sg ;	-- FIXME: a 'šis alus'? der tak gan 'zaļš alus' gan 'zaļais alus'
    a = AgP3 Sg cn.g ;
    isNeg = False
  } ;

  NumSg = { s = \\_,_ => [] ; n = Sg ; hasCard = False } ;
  
  NumPl = { s = \\_,_ => [] ; n = Pl ; hasCard = False } ;

  NumCard n = n ** { hasCard = True } ;

  NumDigits n = { s = \\g,c => n.s ! NCard ; n = n.n } ;
  
  OrdDigits n = { s = \\g,c => n.s ! NOrd } ;

  NumNumeral numeral = { s = numeral.s ! NCard ; n = numeral.n } ;
  
  OrdNumeral numeral = { s = numeral.s ! NOrd } ;

  OrdSuperl a = { s = \\g,c => a.s ! (AAdj Superl Def g Sg c) } ;

  AdNum adn num = {
    s = \\g,c => adn.s ++ num.s ! g ! c ;
    n = num.n ;
    hasCard = num.n
  } ;

  AdvCN cn ad = {
    s = \\d,n,c => cn.s ! d ! n ! c ++ ad.s ;
    g = cn.g
  } ;

  -- 'Pielikums'
  ApposCN cn np = {
    s = \\d,n,c => case (fromAgr np.a).n of {
      n => cn.s ! d ! n ! c ++ np.s ! c ;	-- FIXME: comparison not working
      _ => NON_EXISTENT -- FIXME: pattern never reached
    } ;
    g = cn.g
  } ;

  RelCN cn rs = {
    s = \\d, n,c => cn.s ! d ! n ! c ++ "," ++ rs.s ! AgP3 n cn.g ;
    g = cn.g
  } ;

  SentCN cn sc = {
    s = \\d,n,c => cn.s ! d ! n ! c ++ "," ++ sc.s ;
    g = cn.g
  } ;

  -- FIXME: vajag -ts / -ta divdabja formu, + šķirot noteikto/nenoteikto galotni
  PPartNP np v2 = {
    s = \\c => v2.s ! Pos ! (Participle (fromAgr np.a).g (fromAgr np.a).n c) ++ np.s ! c ;
    a = np.a ;
    isNeg = np.isNeg
  } ;

  -- TODO: šim vajag -ts -ta divdabjus (+ noteiktās formas tiem)
  --PPartNP np v2 = {
  --  s = \\c => np.s ! c ++ v2.s ! VPPart ;
  --  a = np.a
  --} ;
  --SentCN cn sc = { s = \\n,c => cn.s ! n ! c ++ sc.s ; g = cn.g } ;

}
