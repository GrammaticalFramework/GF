resource ParamX = {

  param
    Number = Sg | Pl ;
    Person = P1 | P2 | P3 ;
    Degree = Posit | Compar | Superl ;

    Anteriority = Simul | Anter ;
    Tense       = Pres | Past | Fut | Cond ;
    Polarity    = Pos | Neg ;

    QForm = QDir | QIndir ;

  oper
    conjNumber : Number -> Number -> Number = \m,n -> 
      case <m,n> of {
        <Sg,Sg> => Sg ;
        _ => Pl 
        } ;

-- For persons, we let the latter argument win ("either you or I am absent"
-- but "either I or you are absent"). This is not quite clear.
  
    conjPerson : Person -> Person -> Person = \_,p -> 
      p ;

}
