resource MorphoAra = ResAra ** open Prelude in  {

flags optimize = all ;--noexpand;  
  coding=utf8 ;

  oper

    mkDet : Str -> Number -> State -> Det 
      = \word,num,state -> 
      { s = \\_,_,c => word + vowel ! c ;
        n = numberToSize num;
        d = state;  --only Const is used now. check StructuralAra
        isNum = False;
        isPron = False
      };
    
    mkPredet : Str -> Bool -> Predet 
      = \word,decl ->
      { s = \\c => 
          case decl of {
            True => word + vowel!c;
            False => word
          };
        isDecl = decl
      };

   mkQuantNum : Str -> Number -> State -> { 
      s: Species => Gender => Case => Str; n: Number; d : State; isPron: Bool; isNum : Bool} = 
      \waHid,num,state -> 
     let waHida = waHid + "َة" in 
      { s = \\_,g,c => 
          let word = 
          case g of {
            Masc => waHid;
            Fem => waHida
          } in Al ! state + word + dec1sg ! state ! c;
        n = num;
        d = state;
        isPron = False;
        isNum = True
      };
    
    vowel : Case => Str = 
      table {
        Nom =>  "ُ";
        Acc =>  "َ";
        Gen =>  "ِ"
      };

}
