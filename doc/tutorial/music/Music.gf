  abstract Music = {

    flags startcat=Kind ;

    cat 
      Kind ;
      Property ;
    fun 
      PropKind : Kind -> Property -> Kind ; 
      Song : Kind ;
      American : Property ;
}