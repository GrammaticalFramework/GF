--# -path=.:alltenses

concrete EngReal of Eng = IrregEng ** open (R = ResEng) in {

lincat 
  Display = Str ;
  Word = R.VForm => Str ;
  Form = {s : Str ; v : R.VForm} ;

lin

-- select the forms to display (here all forms)

  DAll w = w ! R.VInf ++ w ! R.VPres ++ w ! R.VPast ++ w ! R.VPPart ++ w ! R.VPresPart ;

-- this code should be generated automatically

  DForm w f = w ! f.v ++ f.s ;

  VInf = vf R.VInf ;
  VPres = vf R.VPres ; 
  VPast = vf R.VPast ;
  VPPart = vf R.VPPart ;
  VPresPart = vf R.VPresPart ;

  WVerb v = v.s ;

oper
  vf : R.VForm -> {s : Str ; v : R.VForm} = \f -> {s = [] ; v = f} ; ---

}
