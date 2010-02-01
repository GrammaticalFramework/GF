abstract LitAbs = {

cat CStr String ;
    CInt Int ;
    CFloat Float ;

data empty : CStr "" ;
     null  : CStr [] ;
     other : CStr "other" ;

data zero : CInt 0 ;

data pi : CFloat 3.14 ;

}