incomplete concrete MathI of Math = 
  open Syntax, Symbol, LexMath in {

  flags startcat = Question ; lexer = textlit ; unlexer = text ;

  lincat 
    Answer   = Text ;
    Question = Text ;
    Object   = NP ;

  lin 
    Even   = questAdj even_A ;
    Odd    = questAdj odd_A ;
    Prime  = questAdj prime_A ;
    Number n = mkNP (IntPN n) ;

    Yes = mkText yes_Phr ;
    No  = mkText no_Phr ;

  oper
    questAdj : A -> NP -> Text = \adj,x -> mkText (mkQS (mkCl x adj)) ;

}
