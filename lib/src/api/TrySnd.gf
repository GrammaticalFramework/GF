--# -path=.:alltenses:prelude:/users/shafqat/www.grammaticalframework.org_4/lib/src/sindhi

resource TrySnd = SyntaxSnd - [mkAdN] , LexiconSnd, ParadigmsSnd - [mkAdv,mkDet,mkIP,mkAdN] ** 
  open (P = ParadigmsSnd) in {

oper

  mkAdv = overload SyntaxSnd {
    mkAdv : Str -> Adv = P.mkAdv ;
  } ;

  mkAdN = overload {
    mkAdN : CAdv -> AdN = SyntaxSnd.mkAdN ;
---   mkAdN : Str -> AdN = P.mkAdN ;
  } ;

--  mkOrd = overload SyntaxSnd {
--    mkOrd : A -> Ord = SyntaxSnd.OrdSuperl ;
--  } ;


}
