abstract Restaurant = {

flags startcat = Descr ;

cat
  Descr ;
  Name ;
  Nationality ;
  PriceLevel ;

fun
  MkDescr : Name -> PriceLevel -> Nationality -> Descr ;

  Cheap : PriceLevel ;
  Italian, Thai, Swedish, French : Nationality ;
  Konkanok : Name ;


}
