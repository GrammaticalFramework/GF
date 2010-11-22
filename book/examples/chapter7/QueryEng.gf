concrete QueryEng of Query = {
  lincat 
    Answer, Question, Object = Str ;
  lin 
    Even  = pred "even" ;
    Odd   = pred "odd" ;
    Prime = pred "prime" ;
    Number i = i.s ;
    Yes = "yes" ;
    No = "no" ;
  oper
    pred : Str -> Str -> Str = \f,x -> "is" ++ x ++ f ;
}
