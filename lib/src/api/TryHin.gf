--# -path=.:alltenses:prelude:/users/shafqat/www.grammaticalframework.org_4/lib/src/hindi:/users/shafqat/www.grammaticalframework.org_4/lib/src/hindustani

resource TryHin = SyntaxHin - [mkAdN] , LexiconHin, ParadigmsHin - [mkAdv,mkDet,mkIP,mkAdN,mkQuant] ** 
  open (P = ParadigmsHin) in {

oper

  mkAdv = overload SyntaxHin {
    mkAdv : Str -> Adv = P.mkAdv ;
  } ;

  mkAdN = overload {
    mkAdN : CAdv -> AdN = SyntaxHin.mkAdN ;
---   mkAdN : Str -> AdN = P.mkAdN ;
  } ;

--  mkOrd = overload SyntaxHin {
--    mkOrd : A -> Ord = SyntaxHin.OrdSuperl ;
--  } ;


}
