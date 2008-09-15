concrete MathIta1 of Math = {

param
  Gender = Masc | Fem ;
  Case = Nom | Gen | Dat ;

lincat 
  Prop = Str ;
  Exp = NounPhrase ;

oper
  NounPhrase : Type = {s : Case => Str ; g : Gender} ;

  exp : (n,g,d : Str) -> Gender -> NounPhrase = 
    \n,g,d,ge -> { 
      s = table {
        Nom => n ;
        Gen => g ;
        Dat => d 
        } ;
      g = ge
      } ;
 
  const : Str -> Gender -> NounPhrase = \s,g -> 
    exp s ("di" ++ s) ("a" ++ s) g ;

  funct1 : Str -> Gender -> NounPhrase -> NounPhrase = \f,g,x -> {
    s = \\c => defArt g c ++ f ++ x.s ! Gen ;
    g = g
    } ;

  funct2 : Str -> Gender -> NounPhrase -> NounPhrase -> NounPhrase = \f,g,x,y -> {
    s = \\c => defArt g c ++ f ++ x.s ! Gen ++ y.s ! Gen ;
    g = g
    } ;

  defArt : Gender -> Case -> Str = \g,c -> case <g,c> of {
    <Masc,Nom> => "il" ;
    <Masc,Gen> => "del" ;
    <Masc,Dat> => "al" ;
    <Fem, Nom> => "la" ;
    <Fem, Gen> => "della" ;
    <Fem, Dat> => "alla"
    } ;

  Adjective : Type = Gender -> Str ;

  pred1 : Str -> NounPhrase -> Str = \a,x ->
    x.s ! Nom ++ "è" ++ adj a x.g ;

  pred2 : Str -> Str -> Case -> NounPhrase -> NounPhrase -> Str = \a,s,c,x,y ->
    x.s ! Nom ++ "è" ++ adj a x.g ++ s ++ y.s ! c ;

  adj : Str -> Adjective = \s,g -> case g of {
    Masc => s ;
    Fem => case s of {
      ner + "o" => ner + "a" ;
      _ => s
      }
    } ;

lin
  And a b = a ++ "e" ++ b ;
  Or a b = a ++ "o" ++ b ;
  If a b = "si" ++ a ++ "allora" ++ b ;

  Zero = const "zero" Masc ;

  Successor = funct1 "successore" Masc ;

  Sum = funct2 "somma" Fem ;
  Product = funct2 "prodotto" Masc ;

  Even = pred1 "pari" ;
  Odd = pred1 "dispari" ;
  Prime = pred1 "primo" ;
  
  Equal = pred2 "uguale" [] Dat ;
  Less = pred2 "inferiore" [] Dat ;
  Greater = pred2 "superiore" [] Dat ;
  Divisible = pred2 "divisibile" "per" Nom ;

lincat 
  Var = Str ;
lin
  X = "x" ;
  Y = "y" ;

  EVar x = const x Masc ;
  EInt i = const i.s Masc ;

  ANumberVar x = const ("un numero" ++ x) Masc ;
  TheNumberVar x = {
   s = \\c => defArt Masc c ++ "numero" ++ x ;
   g = Masc
   } ;


-- overloaded API
oper
  funct = overload {
    funct : Str -> Gender -> NounPhrase = const ;
    funct : Str -> Gender -> NounPhrase -> NounPhrase = funct1 ;
    funct : Str -> Gender -> NounPhrase -> NounPhrase -> NounPhrase = funct2
    } ;

  pred = overload {
    pred :  Str -> NounPhrase -> Str = pred1 ;
    pred :  Str -> Str -> Case -> NounPhrase -> NounPhrase -> Str = pred2
    } ;

}
