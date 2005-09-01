resource ResDep = {
  param
    Case  = C_ | C_to ;
    VComp = VC_ | VC1 Case | VC2 Case Case ; 

  oper
    case1, case2 : VComp -> Str ;
    case1 c = case c of {
      VC1 C_to   => "to" ;
      VC2 C_to _ => "to" ;
      _ => []
      } ;
    case2 c = case c of {
      VC2 _ C_to => "to" ;
      _ => []
      } ;
}
