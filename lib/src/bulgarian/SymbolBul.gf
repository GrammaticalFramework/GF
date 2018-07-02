--# -path=.:../abstract:../common:../prelude
--# -coding=cp1251

concrete SymbolBul of Symbol = CatBul ** open Prelude, ResBul in {

flags
  coding = cp1251 ;

lin
  SymbPN i = {s = i.s ; g = Neut} ;
  IntPN i  = {s = i.s ; g = Neut} ;
  FloatPN i = {s = i.s ; g = Neut} ;
  NumPN i = {s = i.s ! CFNeut Indef ; g = Neut} ;
  CNIntNP cn i = {
    s = \\c => cn.s ! NF Sg Indef ++ i.s ;
    a = agrP3 (gennum cn.g Sg) ;
    p = Pos
    } ;
  CNSymbNP det cn xs = {
    s = \\c => det.s ! False ! cn.g ! RSubj ++ cn.s ! NF (numnnum det.nn) Indef ++ xs.s ; 
    a = agrP3 (gennum cn.g (numnnum det.nn)) ;
    p = Pos
    } ;
  CNNumNP cn i = {
    s = \\c => (cn.s ! NF Sg Indef ++ i.s ! CFNeut Indef) ;
    a = agrP3 (gennum cn.g Sg) ;
    p = Pos
    } ;

  SymbS sy = sy ; 

  SymbNum sy = {s = \\_ => sy.s; n = Pl; nonEmpty = True} ;
  SymbOrd sy = {s = \\aform => sy.s ++ "-" ++ 
                               case aform of {
                                 ASg Masc Indef => "��" ;
                                 ASg Fem  Indef => "��" ;
                                 ASg Neut Indef => "��" ;
                                 ASg Masc Def   => "���" ;
                                 ASg Fem  Def   => "����" ;
                                 ASg Neut Def   => "����" ;
                                 ASgMascDefNom  => "����" ;
                                 APl Indef      => "��" ;
                                 APl Def        => "����"
                               }
                } ;

lincat 

  Symb, [Symb] = SS ;

lin

  MkSymb s = s ;

  BaseSymb = infixSS "�" ;
  ConsSymb = infixSS bindComma ;

}
