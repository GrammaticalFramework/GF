--# -path=.:../abstract:../../prelude

concrete MathRus of Math = CategoriesRus **  open Prelude, SyntaxRus, ParadigmsRus
 in {
flags  coding=utf8 ;
lin
  SymbPN i = {s = \\_ => i.s ; g = Masc ; anim = Inanimate} ; 
  IntPN i  = {s = \\_ => i.s ; g = Neut ; anim = Inanimate } ;
  IntNP mu i =  {s = \\pf => mu.s! Sg !(extCase pf) ++ i.s; 
     n = Sg ; p = P3; g = PGen mu.g ; pron = False; anim = mu.anim } ; 
 

  IndefSymbNumNP dva mu xs = 
    {s = \\pf => dva.s ! (extCase pf) !  mu.g ++ mu.s! Pl !(extCase pf) ++xs.s; 
     n = Pl ; p = P3; g = PGen mu.g ; pron = False; anim = mu.anim } ; 
  DefSymbNumNP dva mu xs = 
    {s = \\pf => dva.s ! (extCase pf) !  mu.g ++ mu.s! Pl !(extCase pf) ++xs.s; 
     n = Pl ; p = P3; g = PGen mu.g ; pron = False; anim = mu.anim } ; 
  NDetSymbNP det dva mu xs = 
    {s = \\pf => dva.s ! (extCase pf) !  mu.g ++ det.s!AF (extCase pf) mu.anim APl 
     ++mu.s! Pl !(extCase pf) ++xs.s; 
     n = Pl ; p = P3; g = PGen mu.g ; pron = False; anim = mu.anim } ; 


lincat 
  SymbList = SS ;

lin
  SymbTwo  = infixSS "and" ;
  SymbMore = infixSS "," ;

  LetImp x np = {s = \\_,_ => "пусть" ++ x.s ! PF Nom No NonPoss ++ "это" ++ np.s ! PF Inst No NonPoss } ;

  ExistNP bar = {s =\\b,clf => case b of 
    {True =>  verbSuchestvovat.s ! (getActVerbForm clf (pgen2gen bar.g) bar.n P3) 
           ++ bar.s ! PF Nom No NonPoss;
     False => "не" ++ verbSuchestvovat.s !(getActVerbForm clf (pgen2gen bar.g) bar.n P3) 
           ++ bar.s ! PF Nom No NonPoss
       }
   } ;

-- Moved from $RulesRus$.
  --- these two by AR 3/6/2004
  SymbCN cn s =
    {s = \\n,c => cn.s ! n ! c ++ s.s ; 
     g = cn.g ;
     anim = cn.anim
    } ;

  IntCN cn s =
    {s = \\n,c => cn.s ! n ! c ++ s.s ; 
     g = cn.g ;
     anim = cn.anim
     } ;
 
}

