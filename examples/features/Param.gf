resource Param = {

  param Bool = True | False ;

  oper and : Bool -> Bool -> Bool = \x,y -> case x of {
    True => y ;
    _ => False
    } ;

}
