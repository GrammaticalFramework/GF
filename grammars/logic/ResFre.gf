resource ResFre = {
param 
Gen = masc  | fem  ;
Num = sg  | pl  ;
Mod = ind  | subj  ;
Cas = nom  | aa  | dd  ;

oper 
nomReg : Str -> Num => Str = \str -> table {{sg} => str ; {pl} => str + "s"} ;
adjReg : Str -> Gen => Num => Str = \str -> 
  table {{masc} => nomReg str ; {fem} => nomReg (str + "e")} ;
adjEl : Str -> Gen => Num => Str = \str ->
  table {{masc} => nomReg str ; {fem} => nomReg (str + "le")} ;
adjAl : Str -> Gen => Num => Str =  \str ->
  table {{masc} => table {{sg} => str + "l" ; {pl} => str + "ux"} ; 
       {fem}  => nomReg (str + le) } ;
adjEr : Str -> Gen => Num => Str = \str ->
  table {{masc} => nomReg (str + "er") ; {fem}  => nomReg (str + "ère")} ;

LinElem = {g : Gen ; s : Cas => Str} ;
LinProp = {s : Mod => Str} ;

voyelle : Strs = strs {"a" ; "e" ; "i" ; "o" ; "u" ; "y" ; "é"} ;
elision : Str = pre {"e" ; "'" / voyelle} ;
ne : Str = "n" + elision ;
de : Str = "d" + elision ;
le : Str = "l" + elision ;
que : Str = "qu" + elision ;

si : Str = pre {"si" ; "s'" / strs {"il" ; "ils"}} ;
indef : Gen => Str = table {{masc} => "un" ; _ => "une"} ;
tel : Gen => Num => Str = adjEl "tel" ;
tout : Gen => Num => Str =
  table {{masc} => table {{sg} => "tout" ; {pl} => "tous"} ; {fem} => nomReg "toute" } ;
etre : Num => Mod => Str = formVerbe "est" "soit" "sont" "soient" ;

formVerbe : Str -> Str -> Str -> Str -> Num => Mod => Str = 
 \sgi -> \sgs -> \pli -> \pls ->
  table {{sg} => table {{ind} => sgi ; {subj} => sgs} ; 
       {pl} => table {{ind} => pli ; {subj} => pls}} ; 
prep : Cas => Str =
  table {{nom} => [] ; {aa} => "à" ; {dd} => de} ;

defin : Num => Gen => Cas => Str =
  table {
   {sg} => table {
     {masc} => table {
         {dd}  => pre {"du" ; "de"++"l'" / voyelle} ; 
         {aa}  => pre {"au" ; "à"++"l'" / voyelle} ;
         c     => prep ! c ++ le
                   } ;
     {fem}  => table {
         c     => prep ! c ++ pre {"la" ; "l'" / voyelle} 
                   }
               } ;
   {pl} => table {
     _     => table {
         {dd}  => "des" ; 
         {aa}  => "aux" ;
         c     => prep ! c ++ "les"
                  }
               }
  } ;

pronom : Gen => Cas => Str = table {
  masc => table {nom => "il" ; c => prep ! c ++ "lui"} ;
  fem  => table {c => prep ! c ++ "elle"} 
  } ;

mkPropA1 : LinElem -> (Gen => Num => Str) -> LinProp = \elem -> \adj ->
 {s = table {m => elem.s ! nom ++ etre ! sg ! m ++ adj ! elem.g ! sg}} ;

mkPropA2 : Cas -> LinElem -> (Gen => Num => Str) -> LinElem -> LinProp = 
 \cas -> \elem -> \adj -> \elem2 -> let 
   {adjP : Gen => Num => Str = table {g => table {n => adj ! g ! n ++ elem2.s ! cas}}}
 in mkPropA1 elem adjP ;

}
