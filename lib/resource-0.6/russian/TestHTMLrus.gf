-- use this path to read the grammar from the same directory
--# -path=.:../abstract:../../prelude
concrete TestHTMLrus of TestHTML = StructuralRus ** open SyntaxRus in {

flags 
  coding=utf8 ;
  startcat=HTMLdoc ; lexer=text ; parser=chart ; unlexer=text ;

-- a random sample from the lexicon

lin
 body = {s= "<body> " ++"Это тело" ++ " </body>"};
 head = {s= "<head> " ++ "Это голова \\" ++ " </head>"};
 htmlText x y =  {s= " <html> "++ x.s ++ " " ++ y.s ++ " </html>"};

};
