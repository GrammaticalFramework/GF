concrete NumeralSlv of Numeral = CatSlv [Numeral,Digits] ** open Prelude, ResSlv in {

lincat 
  Digit      = {s : DForm  => Case => Str; n : NumAgr} ;
  Sub10      = {s : Gender => Case => Str; h : Case => Str; e : Str; n : NumAgr} ;
  Sub100     = {s : Gender => Case => Str; e : Str; n : NumAgr} ;
  Sub1000    = {s : Gender => Case => Str; e : Str; n : NumAgr} ;
  Sub1000000 = {s : Gender => Case => Str; n : NumAgr} ;

lin num x = x ;

lin n2 =
      {s = table {
             Unit g => mkDigit "dvá" "dvé" "dvé" "dvá" "dvé" "dvé" "dvéh" "dvéh" "dvéh" "dvéma" "dvéma" "dvéma" "dvéh" "dvéh" "dvéh" "dvéma" "dvéma" "dvéma" ! g;
             Teen   => mkNum "dvanájst";
             Ten    => mkNum "dvájset";
             Hundred=> mkNum "dvésto"
           } ;
       n = UseNum Dl
      } ;
    n3 =
      {s = table {
             Unit g => mkDigit "tríje" "trí" "trí" "trí" "trí" "trí" "tréh" "tréh" "tréh" "trém" "trém" "trém" "tréh" "tréh" "tréh" "trémi" "trémi" "trémi" ! g;
             Teen   => mkNum "trinájst";
             Ten    => mkNum "trídeset";
             Hundred=> mkNum "trísto"
           } ;
       n = UseNum Pl
      } ;
    n4 =
      {s = table {
             Unit g => mkDigit "štírje" "štíri" "štíri" "štíri" "štíri" "štíri" "štírih" "štírih" "štírih" "štírim" "štírim" "štírim" "štírih" "štírih" "štírih" "štírimi" "štírimi" "štírimi" ! g;
             Teen   => mkNum "štirinájst";
             Ten    => mkNum "štírideset";
             Hundred=> mkNum "štíristo"
           } ;
       n = UseNum Pl
      } ;
    n5 =
      {s = table {
             Unit g => mkDigit2 "pét" "pét" "pêtih" "pêtim" "pêtih" "pêtimi" ! g;
             Teen   => mkNum "petnájst";
             Ten    => mkNum "pétdeset";
             Hundred=> mkNum "pétsto"
           } ;
       n = UseGen
      } ;
    n6 =
      {s = table {
             Unit g => mkDigit2 "šést" "šést" "šêstih" "šêstim" "šêstih" "šêstimi" ! g;
             Teen   => mkNum "šestnájst";
             Ten    => mkNum "šéstdeset";
             Hundred=> mkNum "šéststo"
           } ;
       n = UseGen
      } ;
    n7 =
      {s = table {
             Unit g => mkDigit2 "sédem" "sédem" "sêdmih" "sêdmim" "sêdmih" "sêdmimi" ! g;
             Teen   => mkNum "sedemnájst";
             Ten    => mkNum "sédemdeset";
             Hundred=> mkNum "sédemsto"
           } ;
       n = UseGen
      } ;
    n8 =
      {s = table {
             Unit g => mkDigit2 "ósem" "ósem" "ôsmih" "ôsmim" "ôsmih" "ôsmimi" ! g;
             Teen   => mkNum "osemnájst";
             Ten    => mkNum "ósemdeset";
             Hundred=> mkNum "ósemsto"
           } ;
       n = UseGen
      } ;
    n9 =
      {s = table {
             Unit g => mkDigit2 "devét" "devét" "devêtih" "devêtim" "devêtih" "devêtimi" ! g;
             Teen   => mkNum "devetnájst";
             Ten    => mkNum "devétdeset";
             Hundred=> mkNum "devétsto"
           } ;
       n = UseGen
      } ;

lin pot01 =
      {s = mkDigit "èn" "êna" "êno" "èn" "êno" "êno" "ènega" "êne" "ênega" "ènemu" "êni" "ênemu" "ènem" "êni" "ênem" "ènim" "êno" "ênim";
       h = table {
             Nom   => "stó" ;
             Acc   => "stó" ; 
             Gen   => "stôtih" ;
             Dat   => "stôtim" ;
             Loc   => "stôtih" ;
             Instr => "stôtimi"
           } ;
       e = "";
       n = UseNum Sg
      } ;
lin pot0 d = {s = \\g=>d.s ! Unit g;
              h = d.s ! Hundred;
              e = "";
              n = d.n
             };

lin pot110 = {s=\\g => table {
                         Nom   => "desét" ;
                         Acc   => "desét" ; 
                         Gen   => "desêtih" ;
                         Dat   => "desêtim" ;
                         Loc   => "desêtih" ;
                         Instr => "desêtimi"
                       } ;
              e = "" ;
              n = UseGen
             } ;
    pot111 = {s=\\g => mkNum "enájst"; e=""; n = UseGen} ;
    pot1to19 d = {s = \\g => d.s ! Teen; e=""; n = UseGen} ;
    pot0as1 x = x ;
    pot1 d = {s = \\g => d.s ! Ten; e=""; n = UseGen} ;
    pot1plus d e = {s = \\g,c => e.s ! Fem ! c ++ BIND ++ "in" ++ BIND ++ d.s ! Ten ! c; e=e.e; n = UseGen} ;

    pot1as2 x = x ;
    pot2 n = {s = \\g=>n.h; e=n.e; n = UseGen} ;
    pot2plus d e = {
      s = \\g,c=>d.h ! c ++ e.s ! g ! c ;
      e = e.e ;
      n = UseGen
    } ;
    pot2as3 x = x ;
    
    pot3 n = {
      s = \\g,c => case n.n of {
                     UseNum Sg => n.e ;
                     _         => n.s ! Masc ! c
                   } ++ "tísoč" ;
      n = UseGen
    } ;
    pot3plus n m = {
      s = \\g,c => case n.n of {
                     UseNum Sg => n.e ;
                     _         => n.s ! Masc ! c
                   } ++ "tísoč" ++
                   m.s ! g ! c;
      n = UseGen
    } ;

oper mkDigit : (_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_ : Str) -> Gender => Case => Str;
     mkDigit nomMasc nomFem nomNeut accMasc accFem accNeut 
             genMasc genFem genNeut datMasc datFem datNeut
             locMasc locFem locNeut instrMasc instrFem instrNeut =
       table {
         Masc => table {
                   Nom => nomMasc;
                   Acc => accMasc;
                   Gen => genMasc;
                   Dat => datMasc;
                   Loc => locMasc;
                   Instr=>instrMasc
                 } ;
         Fem  => table {
                   Nom => nomFem;
                   Acc => accFem;
                   Gen => genFem;
                   Dat => datFem;
                   Loc => locFem;
                   Instr=>instrFem
                 } ;
         Neut => table {
                   Nom => nomNeut;
                   Acc => accNeut;
                   Gen => genNeut;
                   Dat => datNeut;
                   Loc => locNeut;
                   Instr=>instrNeut
                }
       } ;
oper mkDigit2 : (_,_,_,_,_,_ : Str) -> Gender => Case => Str;
     mkDigit2 nom acc gen dat loc instr =
       mkDigit nom nom nom acc acc acc gen gen gen dat dat dat loc loc loc instr instr instr ;

     mkNum : Str -> Case => Str;
     mkNum s = 
       table {
         Nom   => s ;
         Acc   => s ; 
         Gen   => s+"ih" ;
         Dat   => s+"im" ;
         Loc   => s+"ih" ;
         Instr => s+"imi"
       } ;

-----------------------------------------AR BEGIN ; copied from Italian
-- numerals as sequences of digits

  lincat 
    Dig = TDigit ;

  lin
    IDig d = d ;

    IIDig d i = {
      s = d.s ++ BIND ++ i.s ;
----      s = \\o => d.s ! NCard Masc ++ BIND ++ i.s ! o ;
      n = Pl
    } ;

    D_0 = mkDig "0" ;
    D_1 = mk2Dig "1"  Sg ; ---- gender
    D_2 = mkDig "2" ;
    D_3 = mkDig "3" ;
    D_4 = mkDig "4" ;
    D_5 = mkDig "5" ;
    D_6 = mkDig "6" ;
    D_7 = mkDig "7" ;
    D_8 = mkDig "8" ;
    D_9 = mkDig "9" ;

  oper
    mkDig : Str -> TDigit = \c -> mk2Dig c Pl ;
    
    mk2Dig : Str -> Number -> TDigit = \c,n -> {
      s = c ; ----
----      s = table {NCard _ => c ; 
----                 NOrd Masc Sg => c + ":o" ; NOrd Fem Sg => c + ":a" ;
----                 NOrd Masc Pl => c + ":i" ; NOrd Fem Pl => c + ":e"
----                 } ; 
      n = n
      } ;

    TDigit = {
      n : Number ;
      s : Str ; ---- CardOrd => Str
    } ;

---------------------AR END

}
