concrete LogicFre of Logic = open ResFre, Prelude in {

flags lexer=vars ; unlexer=text ;

lincat 
Text = {s : Str} ;
Dom = {g : Gen ; s : Num => Str} ;
Prop = LinProp ;
Elem = LinElem ;
Proof = {s : Str} ;

lindef Elem = \e -> {g = masc ; s = table {c => prep ! c ++ e}} ;

lin
Statement A = 
  {s = A.s ! ind ++ "."} ;
ThmWithProof A a =
  {s = "Théorème"++"." ++ (A.s ! ind) ++ "."++ PARA ++ "Démonstration"++"." ++ a.s ++ "."} ;
ThmWithTrivialProof A a =
  {s = "Théorème"++"." ++ (A.s ! ind) ++ "."++ PARA ++ "Démonstration"++"."++"Triviale"++"."} ;
Disj A B =
  {s = table {m => (A.s ! m) ++ "ou" ++ B.s ! m}} ;
Conj A B =
  {s = table {m => (A.s ! m) ++ "et" ++ B.s ! m}} ;
Impl A B =
  {s = table {m => si ++ (A.s ! ind) ++ "alors" ++ B.s ! m}} ;
Univ A B =
  {s = table {m => "pour" ++ tout ! A.g ! pl ++ "les" ++ A.s ! pl ++ B.$0 ++ "," ++ B.s ! m}} ;
Exist A B =
  {s = table {m => "il"++"existe" ++ indef ! A.g ++ A.s ! sg ++ B.$0 ++ 
        tel ! A.g ! sg ++ que ++ B.s ! subj}} ;
Abs  =
  {s = table {{ind} => "nous"++"avons"++"une"++"contradiction" ; {subj} => "nous"++"ayons"++"une"++"contradiction"}} ;
Neg A =
  {s = table {m => "il" ++ ne ++ etre ! sg ! m ++ "pas"++"vrai" ++ que ++ A.s ! subj}} ;
ImplP A B =
  {s = table {m => si ++ (A.s ! ind) ++ "alors" ++ B.s ! m}} ;
ConjI A B a b =
  {s = a.s ++ "." ++ b.s ++ "."++"Donc" ++ (A.s ! ind) ++ "et" ++ B.s ! ind} ;
ConjEl A B c =
  {s = c.s ++ "."++"A"++"fortiori," ++ A.s ! ind} ;
ConjEr A B c =
  {s = c.s ++ "."++"A"++"fortiori," ++ B.s ! ind} ;
DisjIl A B a =
  {s = a.s ++ "."++"A"++"fortiori," ++ (A.s ! ind) ++ "ou" ++ B.s ! ind} ;
DisjIr A B b =
  {s = b.s ++ "."++"A"++"fortiori," ++ (A.s ! ind) ++ "ou" ++ B.s ! ind} ;
DisjE A B C c d e =
  {s = c.s ++ "."++
       "Nous"++"avons"++"deux"++"possibilités."++ 
       "Premièrement,"++ "supposons" ++ que ++ A.s ! ind ++ "(" ++ d.$0 ++ ")" ++ 
       "." ++ d.s ++ "."++
       "Deuxièmement,"++ "supposons" ++ que ++ B.s ! ind ++ "(" ++ e.$0 ++ ")" ++ 
       "." ++ e.s ++ "."++"Donc" ++ (C.s ! ind) ++ "dans"++"les"++"deux"++"cas"} ;
ImplI A B b =
  {s = "supposons" ++ que ++ A.s ! ind ++ "(" ++ b.$0 ++ ")" ++ "." ++ b.s ++ "."++
       "Donc"++"," ++ si  ++ A.s ! ind ++ "alors" ++ B.s ! ind} ;
ImplE A B c a =
  {s = a.s ++ "."++"Mais" ++ c.s ++ "."++"Donc" ++ B.s ! ind} ;
NegI A b =
  {s = "supposons" ++ que ++ A.s ! ind ++ "(" ++ b.$0 ++ ")" ++ "." ++ b.s ++ "." ++
       ["Donc , il n'est pas vrai"] ++ que ++ A.s ! subj} ;
NegE A c a =
  {s = a.s ++ "."++"Mais" ++ c.s ++ "." ++ ["Nous avons une contradiction"]} ;
UnivI A B b =
  {s = "considérons" ++ indef ! A.g ++ A.s ! sg ++ b.$0 ++ "arbitraire." ++ 
       b.s ++ "."++"Donc"++","++"pour" ++ tout ! A.g ! pl ++ 
       "les" ++ A.s ! pl ++ B.$0 ++ "," ++ B.s ! ind} ;
UnivE A B c a =
  {s = c.s ++ "."++
       "Donc" ++ B.s ! ind ++ "avec" ++ B.$0 ++ "remplacé" ++ "par" ++ a.s ! nom} ;
ExistI A B a b =
  {s = b.s ++ "."++"Donc"++"il"++"existe" ++ indef ! A.g ++ A.s ! sg ++ B.$0 ++ 
       tel ! A.g ! sg ++ que ++ B.s ! subj} ;
ExistE A B C c d =
  {s = c.s ++ "."++"Considérons" ++ indef ! A.g ++ A.s ! sg ++ d.$0 ++ 
       ["arbitraire , et supposons"] ++ que ++ B.s ! ind ++ "(" ++ d.$1 ++ ")" ++ 
       "." ++ d.s ++ "."++"Donc" ++ C.s ! ind ++ "indépendamment" ++ "de" ++ d.$0} ;
AbsE C c =
  {s = c.s ++ "." ++ "Nous" ++ "concluons" ++ que ++ C.s ! ind} ;
Hypo A a =
  {s = "par"++"l'hypothèse" ++ a.s ++ "," ++ A.s ! ind} ;
Pron A _ = {s = pronom ! A.g ; g = A.g} ;
} ;