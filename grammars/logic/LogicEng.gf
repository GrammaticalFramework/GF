concrete LogicEng of Logic = open LogicResEng, Prelude in {

flags lexer=vars ; unlexer=text ;

lincat 
  Dom = {s : Num => Str} ;
  Prop, Elem = {s : Str} ;

lin 
Statement A = {s = A.s ++ "."} ;
ThmWithProof A a = {s = 
  ["Theorem ."] ++ A.s ++ "." ++ PARA ++ "Proof" ++ "." ++ a.s ++ "."} ;
ThmWithTrivialProof A a = 
  {s = "Theorem" ++ "." ++ A.s ++ "." ++ PARA ++ "Proof" ++ "." ++ "Trivial" ++ "."} ;
Disj A B = {s = A.s ++ "or" ++ B.s} ;
Conj A B = {s = A.s ++ "and" ++ B.s} ;
Impl A B = {s = "if" ++ A.s ++ "then" ++ B.s} ;
Univ A B = {s = ["for all"] ++ A.s ! pl ++ B.$0 ++ "," ++ B.s} ;
Exist A B =
  {s = ["there exists"] ++ indef ++ A.s ! sg ++ B.$0 ++ ["such that"] ++ B.s} ;
Abs = {s = ["we have a contradiction"]} ;
Neg A = {s = ["it is not the case that"] ++ A.s} ;
ImplP A B = {s = "if" ++ A.s ++ "then" ++ B.s} ;
ConjI A B a b = {s = a.s ++ "." ++ b.s ++ [". Hence"] ++ A.s ++ "and" ++ B.s} ;
ConjEl A B c = {s = c.s ++ [". A fortiori ,"] ++ A.s} ;
ConjEr A B c = {s = c.s ++ [". A fortiori ,"] ++ B.s} ;
DisjIl A B a = {s = a.s ++ [". A fortiori ,"] ++ A.s ++ "or" ++ B.s} ;
DisjIr A B b = {s = b.s ++ [". A fortiori ,"] ++ A.s ++ "or" ++ B.s} ;
DisjE A B C c d e = {s = 
  c.s ++ 
  [". There are two possibilities . First , assume"] ++ 
  A.s ++ "(" ++ d.$0 ++ ")" ++ "." ++ d.s ++ 
  [". Second , assume"] ++ B.s ++ "(" ++ e.$0 ++ ")" ++ "." ++ e.s ++ 
  [". Thus"] ++ C.s ++ ["in both cases"]} ;
ImplI A B b = {s = 
  "assume" ++ A.s ++ "(" ++ b.$0 ++ ")" ++ "." ++ 
  b.s ++ [". Hence , if"] ++ A.s ++ "then" ++ B.s} ;
ImplE A B c a = {s = a.s ++ [". But"] ++ c.s ++ [". Hence"] ++ B.s} ;
NegI A b = {s = 
  "assume" ++ A.s ++ "(" ++ b.$0 ++ ")" ++ "." ++ b.s ++ 
  [". Hence, it is not the case that"] ++ A.s} ;
NegE A c a =
  {s = a.s ++ [". But"] ++ c.s ++ [". We have a contradiction"]} ;
UnivI A B b = {s = 
  ["consider an arbitrary"] ++ A.s ! sg ++ b.$0 ++ "." ++ b.s ++ 
  [". Hence, for all"] ++ A.s ! pl ++ B.$0 ++ "," ++ B.s} ;
UnivE A B c a =
  {s = c.s ++ [". Hence"] ++ B.s ++ "for" ++ B.$0 ++ ["set to"] ++ a.s} ;
ExistI A B a b = {s = 
  b.s ++ [". Hence, there exists"] ++ indef ++ 
  A.s ! sg ++ B.$0 ++ ["such that"] ++ B.s} ;
ExistE A B C c d = {s = 
  c.s ++ [". Consider an arbitrary"] ++ d.$0 ++ 
  ["and assume that"] ++ B.s ++ "(" ++ d.$1 ++ ")" ++ "." ++ d.s ++ 
  [". Hence"] ++ C.s ++ ["independently of"] ++ d.$0} ;
AbsE C c = {s = c.s ++ [". We may conclude"] ++ C.s} ;
Hypo A a = {s = ["by the hypothesis"] ++ a.s ++ "," ++ A.s} ;
Pron _ _ = {s = "it"} ;

} ;
