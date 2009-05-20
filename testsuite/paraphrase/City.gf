abstract City = {

cat S ; City ; Country ; Adj ;

data
  PredIn : City -> Country -> S ;
fun
  PredAdj    : City -> Adj -> S ;
  Capital    : Country -> City ;
  CountryAdj : Adj -> Country ;
data
  Stockholm, Helsinki : City ;
  Sweden, Finland : Country ;
  Swedish, Finnish : Adj ;

def
  PredAdj city x = PredIn city (CountryAdj x) ;

  Capital Finland = Helsinki ;
  Capital Sweden = Stockholm ;

  CountryAdj Finnish = Finland ;
  CountryAdj Swedish = Sweden ;


}
