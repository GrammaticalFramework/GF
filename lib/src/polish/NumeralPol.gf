--# -path=.:../abstract:../common:../prelude

-- Adam Slaski, 2009 <adam.slaski@gmail.com>

concrete NumeralPol of Numeral = CatPol ** open ResPol,Prelude, AdjectiveMorphoPol in {

  flags  coding=utf8 ;

  lincat -- a =  accomodation
    Digit =  { unit,teen,ten,hundred:     Case * Gender => Str; 
               ounit,oteen,oten,ohundred: AForm => Str;
               a:Accom };       -- 2..9 
    Sub10 =  { unit,hundred:   Case * Gender => Str; 
               ounit,ohundred: AForm => Str;
               a:Accom; n:Number };       -- 1..9
    Sub100, Sub1000, Sub1000000 = 
             { s:Case * Gender => Str; 
               o:AForm => Str;
               a:Accom; n:Number }; 

  lin 
--   num : Sub1000000 -> Numeral ;
    num a = { s = \\x,y=>a.s!<x,y>; o=a.o; a=a.a; n=a.n };
 
--   n2, n3, n4, n5, n6, n7, n8, n9 : Digit ;
    n2 = { unit = table {
        <(Nom|VocP|Acc),NeutGr|Plur      > => "dwoje";
        <Gen,NeutGr|Plur                 > => "dwojga";
        <(Dat|Loc),NeutGr|Plur           > => "dwojgu";
        <Instr,NeutGr|Plur               > => "dwojgiem";
        <(Nom|VocP),Masc Personal   > => "dwóch";
        <(Nom|VocP|Acc),Fem         > => "dwie";
        (<Gen,_>|<Acc,Masc Personal>) => "dwóch";
        <(Nom|VocP|Acc),_           > => "dwa";
        <Dat,_                      > => "dwóm";
        <Instr,Fem                  > => "dwiema";
        <Instr,_                    > => "dwoma";
        <Loc,_                      > => "dwóch"
      };
      teen = table {
        <(Nom|VocP|Acc),NeutGr|Plur      > => "dwanaścioro";
        <Gen,NeutGr|Plur                 > => "dwanaściorga";
        <(Dat|Loc),NeutGr|Plur           > => "dwanaściorgu";
        <Instr,NeutGr|Plur               > => "dwanaściorgiem";
        (<(Nom|VocP|Acc),Masc Personal>|
         <Gen|Dat|Instr|Loc,_>)       => "dwunastu";
        <(Nom|VocP|Acc),_           > => "dwanaście"
      };
      ten = table {
        <(Nom|VocP|Acc),NeutGr|Plur    > => "dwadzieścioro";
        <Gen,NeutGr|Plur               > => "dwadzieściorga";
        <(Dat|Loc),NeutGr|Plur         > => "dwadzieściorgu";
        <Instr,NeutGr|Plur             > => "dwadzieściorgiem";
        (<(Nom|VocP|Acc),Masc Personal>|
         <Gen|Dat|Instr|Loc,_>)     => "dwudziestu";
        <(Nom|VocP|Acc),_         > => "dwadzieścia"
      };
      hundred = table {
        (<(Nom|VocP|Acc),Masc Personal>|
         <Gen|Dat|Instr|Loc,_>)       => "dwustu";
        <(Nom|VocP|Acc),_           > => "dwieście"
      };
      ounit    = mkAtable( guess_model "drugi" );
      oteen    = mkAtable( guess_model "dwunasty" );
      oten     = mkAtable( guess_model "dwudziesty" );
      ohundred = mkAtable( guess_model "dwusetny" );
      a=DwaA
    };
    n3 = { unit = table {
        <(Nom|VocP|Acc),NeutGr|Plur      > => "troje";
        <Gen,NeutGr|Plur                 > => "trojga";
        <Dat,NeutGr|Plur                 > => "trojgu";
        <Instr,NeutGr|Plur               > => "trojgiem";
        <(Nom|VocP),Masc Personal   > => "trzech";
        <(Nom|VocP|Acc),Fem         > => "trzy";
        (<Gen,_>|<Acc,Masc Personal>) => "trzech";
        <(Nom|VocP|Acc),_           > => "trzy";
        <Dat,_                      > => "trzem";
        <Instr,Fem                  > => "trzema";
        <Instr,_                    > => "trzema";
        <Loc,_                      > => "trzech"
      };
      teen = table {
        <(Nom|VocP|Acc),NeutGr|Plur      > => "trzynaścioro";
        <Gen,NeutGr|Plur                 > => "trzynaściorga";
        <(Dat|Loc),NeutGr|Plur           > => "trzynaściorgu";
        <Instr,NeutGr|Plur               > => "trzynaściorgiem";
        (<(Nom|VocP|Acc),Masc Personal>|
         <Gen|Dat|Instr|Loc,_>)       => "trzynastu";
        <(Nom|VocP|Acc),_           > => "trzynaście"
      }; 
      ten = table {
        <(Nom|VocP|Acc),NeutGr|Plur    > => "trzydzieścioro";
        <Gen,NeutGr|Plur               > => "trzydzieściorga";
        <(Dat|Loc),NeutGr|Plur         > => "trzydzieściorgu";
        <Instr,NeutGr|Plur             > => "trzydzieściorgiem";
        (<(Nom|VocP|Acc),Masc Personal>|
         <Gen|Dat|Instr|Loc,_>)     => "trzydziestu";
        <(Nom|VocP|Acc),_         > => "trzydzieści"
      };
      hundred = table {
        (<(Nom|VocP|Acc),Masc Personal>|
         <Gen|Dat|Instr|Loc,_>)       => "trzystu";
        <(Nom|VocP|Acc),_           > => "trzysta"
      };
      ounit    = mkAtable( guess_model "trzeci" );
      oteen    = mkAtable( guess_model "trzynasty" );
      oten     = mkAtable( guess_model "trzydziesty" );
      ohundred = mkAtable( guess_model "trzechsetny" );
      a=DwaA
    };
    n4 = { unit = table {
        <(Nom|VocP|Acc),NeutGr|Plur      > => "czworo";
        <Gen,NeutGr|Plur                 > => "czworga";
        <Dat,NeutGr|Plur                 > => "czworgu";
        <Instr,NeutGr|Plur               > => "czworgiem";
        <(Nom|VocP),Masc Personal   > => "czterech";
        <(Nom|VocP|Acc),Fem         > => "cztery";
        (<Gen,_>|<Acc,Masc Personal>) => "czterch";
        <(Nom|VocP|Acc),_           > => "cztery";
        <Dat,_                      > => "czterem";
        <Instr,Fem                  > => "czterema";
        <Instr,_                    > => "czterma";
        <Loc,_                      > => "czterech"
      };
      teen = table {
        <(Nom|VocP|Acc),NeutGr|Plur      > => "czternaścioro";
        <Gen,NeutGr|Plur                 > => "czternaściorga";
        <(Dat|Loc),NeutGr|Plur           > => "czternaściorgu";
        <Instr,NeutGr|Plur               > => "czternaściorgiem";
        (<(Nom|VocP|Acc),Masc Personal>|
         <Gen|Dat|Instr|Loc,_>)       => "czternastu";
        <(Nom|VocP|Acc),_           > => "czternaście"
      }; 
      ten = table {
        <(Nom|VocP|Acc),NeutGr|Plur    > => "czterdzieścioro";
        <Gen,NeutGr|Plur               > => "czterdzieściorga";
        <(Dat|Loc),NeutGr|Plur         > => "czterdzieściorgu";
        <Instr,NeutGr|Plur             > => "czterdzieściorgiem";
        (<(Nom|VocP|Acc),Masc Personal>|
         <Gen|Dat|Instr|Loc,_>)     => "czterdziestu";
        <(Nom|VocP|Acc),_         > => "czterdzieści"
      };
      hundred = table {
        (<(Nom|VocP|Acc),Masc Personal>|
         <Gen|Dat|Instr|Loc,_>)       => "czterystu";
        <(Nom|VocP|Acc),_           > => "czterysta"
      };
      ounit    = mkAtable( guess_model "czwarty" );
      oteen    = mkAtable( guess_model "czternasty" );
      oten     = mkAtable( guess_model "czterdziesty" );
      ohundred = mkAtable( guess_model "czterechsetny" );
      a=DwaA
    };
    n5 = { unit = table {
        <(Nom|VocP|Acc),NeutGr|Plur      > => "pięcioro";
        <Gen,NeutGr|Plur                 > => "pięciorga";
        <Dat,NeutGr|Plur                 > => "pięciorgu";
        <Instr,NeutGr|Plur               > => "pięciorgiem";
        <(Nom|VocP),Masc Personal   > => "pięciu";
        (<Gen,_>|<Acc,Masc Personal>) => "pięciu";
        <(Nom|VocP|Acc),_           > => "pięć";
        <Dat,_                      > => "pięciu";
        <Instr,_                    > => "pięcioma";
        <Loc,_                      > => "pięciu"
      };
      teen = table {
        <(Nom|VocP|Acc),NeutGr|Plur      > => "piętnaścioro";
        <Gen,NeutGr|Plur                 > => "piętnaściorga";
        <(Dat|Loc),NeutGr|Plur           > => "piętnaściorgu";
        <Instr,NeutGr|Plur               > => "piętnaściorgiem";
        (<(Nom|VocP|Acc),Masc Personal>|
         <Gen|Dat|Instr|Loc,_>)       => "piętnastu";
        <(Nom|VocP|Acc),_           > => "piętnaście"
      }; 
      ten = table {
        <(Nom|VocP|Acc),NeutGr|Plur    > => "pięćdzieścioro";
        <Gen,NeutGr|Plur               > => "pięćdzieściorga";
        <(Dat|Loc),NeutGr|Plur         > => "pięćdzieściorgu";
        <Instr,NeutGr|Plur             > => "pięćdzieściorgiem";
        (<(Nom|VocP|Acc),Masc Personal>|
         <Gen|Dat|Instr|Loc,_>)     => "pięćdziesięciu";
        <(Nom|VocP|Acc),_         > => "pięćdziesiąt"
      };
      hundred = table {
        (<(Nom|VocP|Acc),Masc Personal>|
         <Gen|Dat|Instr|Loc,_>)       => "pięciuset";
        <(Nom|VocP|Acc),_           > => "pięćset"
      };
      ounit    = mkAtable( guess_model "piąty" );
      oteen    = mkAtable( guess_model "piętnasty" );
      oten     = mkAtable( guess_model "pięćdziesiąty" );
      ohundred = mkAtable( guess_model "pięćsetny" );

      a=PiecA
    };
n6 = { unit = table {
        <(Nom|VocP|Acc),NeutGr|Plur      > => "sześcioro";
        <Gen,NeutGr|Plur                 > => "sześciorga";
        <Dat,NeutGr|Plur                 > => "sześciorgu";
        <Instr,NeutGr|Plur               > => "sześciorgiem";
        <(Nom|VocP),Masc Personal   > => "sześciu";
        (<Gen,_>|<Acc,Masc Personal>) => "sześciu";
        <(Nom|VocP|Acc),_           > => "sześć";
        <Dat,_                      > => "sześciu";
        <Instr,_                    > => "sześcioma";
        <Loc,_                      > => "sześciu"
      };
      teen = table {
        <(Nom|VocP|Acc),NeutGr|Plur      > => "szesnaścioro";
        <Gen,NeutGr|Plur                 > => "szesnaściorga";
        <(Dat|Loc),NeutGr|Plur           > => "szesnaściorgu";
        <Instr,NeutGr|Plur               > => "szesnaściorgiem";
        (<(Nom|VocP|Acc),Masc Personal>|
         <Gen|Dat|Instr|Loc,_>)       => "szesnastu";
        <(Nom|VocP|Acc),_           > => "szesnaście"
      }; 
      ten = table {
        <(Nom|VocP|Acc),NeutGr|Plur    > => "sześćdzieścioro";
        <Gen,NeutGr|Plur               > => "sześćdzieściorga";
        <(Dat|Loc),NeutGr|Plur         > => "sześćdzieściorgu";
        <Instr,NeutGr|Plur             > => "sześćdzieściorgiem";
        (<(Nom|VocP|Acc),Masc Personal>|
         <Gen|Dat|Instr|Loc,_>)     => "sześćdziesięciu";
        <(Nom|VocP|Acc),_         > => "sześćdziesiąt"
      };
      hundred = table {
        (<(Nom|VocP|Acc),Masc Personal>|
         <Gen|Dat|Instr|Loc,_>)       => "sześciuset";
        <(Nom|VocP|Acc),_           > => "sześćset"
      };
      ounit    = mkAtable( guess_model "szósty" );
      oteen    = mkAtable( guess_model "szesnasty" );
      oten     = mkAtable( guess_model "sześćdziesiąty" );
      ohundred = mkAtable( guess_model "sześćsetny" );

      a=PiecA
    };
n7 = { unit = table {
        <(Nom|VocP|Acc),NeutGr|Plur      > => "siedmioro";
        <Gen,NeutGr|Plur                 > => "siedmiorga";
        <Dat,NeutGr|Plur                 > => "siedmiorgu";
        <Instr,NeutGr|Plur               > => "siedmiorgiem";
        <(Nom|VocP),Masc Personal   > => "siedmiu";
        (<Gen,_>|<Acc,Masc Personal>) => "siedmiu";
        <(Nom|VocP|Acc),_           > => "siedem";
        <Dat,_                      > => "siedmiu";
        <Instr,_                    > => "siedmioma";
        <Loc,_                      > => "siedmiu"
      };
      teen = table {
        <(Nom|VocP|Acc),NeutGr|Plur      > => "siedemnaścioro";
        <Gen,NeutGr|Plur                 > => "siedemnaściorga";
        <(Dat|Loc),NeutGr|Plur           > => "siedemnaściorgu";
        <Instr,NeutGr|Plur               > => "siedemnaściorgiem";
        (<(Nom|VocP|Acc),Masc Personal>|
         <Gen|Dat|Instr|Loc,_>)       => "siedemnastu";
        <(Nom|VocP|Acc),_           > => "siedemnaście"
      }; 
      ten = table {
        <(Nom|VocP|Acc),NeutGr|Plur    > => "siedemdzieścioro";
        <Gen,NeutGr|Plur               > => "siedemdzieściorga";
        <(Dat|Loc),NeutGr|Plur         > => "siedemdzieściorgu";
        <Instr,NeutGr|Plur             > => "siedemdzieściorgiem";
        (<(Nom|VocP|Acc),Masc Personal>|
         <Gen|Dat|Instr|Loc,_>)     => "siedemdziesięciu";
        <(Nom|VocP|Acc),_         > => "siedemdziesiąt"
      };
      hundred = table {
        (<(Nom|VocP|Acc),Masc Personal>|
         <Gen|Dat|Instr|Loc,_>)       => "siedemiuset";
        <(Nom|VocP|Acc),_           > => "siedemset"
      };
      ounit    = mkAtable( guess_model "siódmy" );
      oteen    = mkAtable( guess_model "siedemnasty" );
      oten     = mkAtable( guess_model "siedemdziesiąty" );
      ohundred = mkAtable( guess_model "siedemsetny" );

      a=PiecA
    };
n8 = { unit = table {
        <(Nom|VocP|Acc),NeutGr|Plur      > => "ośmioro";
        <Gen,NeutGr|Plur                 > => "ośmiorga";
        <Dat,NeutGr|Plur                 > => "ośmiorgu";
        <Instr,NeutGr|Plur               > => "ośmiorgiem";
        <(Nom|VocP),Masc Personal   > => "ośmiu";
        (<Gen,_>|<Acc,Masc Personal>) => "ośmiu";
        <(Nom|VocP|Acc),_           > => "osiemm";
        <Dat,_                      > => "ośmiu";
        <Instr,_                    > => "ośmioma";
        <Loc,_                      > => "ośmiu"
      };
      teen = table {
        <(Nom|VocP|Acc),NeutGr|Plur      > => "osiemnaścioro";
        <Gen,NeutGr|Plur                 > => "osiemnaściorga";
        <(Dat|Loc),NeutGr|Plur           > => "osiemnaściorgu";
        <Instr,NeutGr|Plur               > => "osiemnaściorgiem";
        (<(Nom|VocP|Acc),Masc Personal>|
         <Gen|Dat|Instr|Loc,_>)       => "osiemnastu";
        <(Nom|VocP|Acc),_           > => "osiemnaście"
      }; 
      ten = table {
        <(Nom|VocP|Acc),NeutGr|Plur    > => "osiemdzieścioro";
        <Gen,NeutGr|Plur               > => "osiemdzieściorga";
        <(Dat|Loc),NeutGr|Plur         > => "osiemdzieściorgu";
        <Instr,NeutGr|Plur             > => "osiemdzieściorgiem";
        (<(Nom|VocP|Acc),Masc Personal>|
         <Gen|Dat|Instr|Loc,_>)     => "osiemdziesięciu";
        <(Nom|VocP|Acc),_         > => "osiemdziesiąt"
      };
      hundred = table {
        (<(Nom|VocP|Acc),Masc Personal>|
         <Gen|Dat|Instr|Loc,_>)       => "ośmiuset";
        <(Nom|VocP|Acc),_           > => "osiemset"
      };
      ounit    = mkAtable( guess_model "ósmy" );
      oteen    = mkAtable( guess_model "osiemnasty" );
      oten     = mkAtable( guess_model "osiemdziesiąty" );
      ohundred = mkAtable( guess_model "osiemsetny" );
      a=PiecA
    };
n9 = { unit = table {
        <(Nom|VocP|Acc),NeutGr|Plur      > => "dziewięcioro";
        <Gen,NeutGr|Plur                 > => "dziewięciorga";
        <Dat,NeutGr|Plur                 > => "dziewięciorgu";
        <Instr,NeutGr|Plur               > => "dziewięciorgiem";
        <(Nom|VocP),Masc Personal   > => "dziewięciu";
        (<Gen,_>|<Acc,Masc Personal>) => "dziewięciu";
        <(Nom|VocP|Acc),_           > => "dziewięć";
        <Dat,_                      > => "dziewięciu";
        <Instr,_                    > => "dziewięcioma";
        <Loc,_                      > => "dziewięciu"
      };
      teen = table {
        <(Nom|VocP|Acc),NeutGr|Plur      > => "dziewiętnaścioro";
        <Gen,NeutGr|Plur                 > => "dziewiętnaściorga";
        <(Dat|Loc),NeutGr|Plur           > => "dziewiętnaściorgu";
        <Instr,NeutGr|Plur               > => "dziewiętnaściorgiem";
        (<(Nom|VocP|Acc),Masc Personal>|
         <Gen|Dat|Instr|Loc,_>)       => "dziewiętnastu";
        <(Nom|VocP|Acc),_           > => "dziewiętnaście"
      }; 
      ten = table {
        <(Nom|VocP|Acc),NeutGr|Plur    > => "dziewięćdzieścioro";
        <Gen,NeutGr|Plur               > => "dziewięćdzieściorga";
        <(Dat|Loc),NeutGr|Plur         > => "dziewięćdzieściorgu";
        <Instr,NeutGr|Plur             > => "dziewięćdzieściorgiem";
        (<(Nom|VocP|Acc),Masc Personal>|
         <Gen|Dat|Instr|Loc,_>)     => "dziewięćdziesięciu";
        <(Nom|VocP|Acc),_         > => "dziewięćdziesiąt"
      };
      hundred = table {
        (<(Nom|VocP|Acc),Masc Personal>|
         <Gen|Dat|Instr|Loc,_>)       => "dziewięciuset";
        <(Nom|VocP|Acc),_           > => "dziewięćset"
      };
      ounit    = mkAtable( guess_model "dziewiąty" );
      oteen    = mkAtable( guess_model "dziewiętnasty" );
      oten     = mkAtable( guess_model "dziewięćdziesiąty" );
      ohundred = mkAtable( guess_model "dziewięćsetny" );
      a=PiecA
    };
--   pot01 : Sub10 ;                               -- 1
    pot01 = {
    unit = table {
        (<(Nom|VocP),Masc _>|<Acc,Masc Inanimate>) => "jeden";
        <(Nom|Acc|VocP),Neut|NeutGr|Plur> => "jedno";
        <(Nom|VocP),Fem> => "jedna";
        <(Gen|Dat|Loc),Fem> => "jednej";
        <(Acc|Instr),Fem> => "jedną";
        (<Gen,_>|<Acc,Masc (Personal|Animate)>) => "jednego";
        <Dat,_> => "jednemu";
        <(Instr|Loc),_> => "jednym"        
      };
      hundred = table {
        (<(Nom|VocP|Acc),Masc Personal>|
         <(Gen|Dat|Instr|Loc),_>)       => "stu";
        <(Nom|VocP|Acc),_           > => "sto"
      };
      ounit    = mkAtable( guess_model "pierwszy" );
      ohundred = mkAtable( guess_model "setny" );
      a=NoA;
      n=Sg
    };
    
--   pot0 : Digit -> Sub10 ;                       -- d * 1
    pot0 d = {
        unit  = d.unit;   hundred  = d.hundred;
        ounit = d.ounit;  ohundred = d.ohundred;
        a = d.a;
        n = Pl
    };
    
--   pot110 : Sub100 ;                             -- 10
    pot110 = {
      s =table {
        <(Nom|VocP|Acc),NeutGr|Plur    > => "dziesięcioro";
        <Gen,NeutGr|Plur               > => "dziesięciorga";
        <(Dat|Loc),NeutGr|Plur         > => "dziesięciorgu";
        <Instr,NeutGr|Plur             > => "dziesięciorgiem";
        (<(Nom|VocP|Acc),Masc Personal>|
         <Gen|Dat|Instr|Loc,_>)     => "dziesięciu";
        <(Nom|VocP|Acc),_         > => "dziesięć"
      };
      o = mkAtable( guess_model "osiemdziesiąty" );
      a=PiecA;
      n=Pl
    };

--   pot111 : Sub100 ;                             -- 11
    pot111 = {
      s = table {
        <(Nom|VocP|Acc),NeutGr|Plur      > => "jedenaścioro";
        <Gen,NeutGr|Plur                 > => "jedenaściorga";
        <(Dat|Loc),NeutGr|Plur           > => "jedenaściorgu";
        <Instr,NeutGr|Plur               > => "jedenaściorgiem";
        (<(Nom|VocP|Acc),Masc Personal>|
         <Gen|Dat|Instr|Loc,_>)       => "jedenastu";
        <(Nom|VocP|Acc),_           > => "jedenaście"
      };
      o = mkAtable( guess_model "osiemnasty" );
      a=PiecA;
      n=Pl
    };

--   pot1to19 : Digit -> Sub100 ;                  -- 10 + d
    pot1to19 d = {
        s = d.teen;
        o = d.oteen;
        a = PiecA;
        n = Pl
    };

--   pot0as1 : Sub10 -> Sub100 ;                   -- coercion of 1..9
    pot0as1 s = {
        s = s.unit;
        o = s.ounit;
        a = s.a; 
        n = s.n
    };
    
--   pot1 : Digit -> Sub100 ;                      -- d * 10
    pot1 d = {
        s = d.ten;
        o = d.oten;
        a = PiecA;
        n = Pl
    };

--   pot1plus : Digit -> Sub10 -> Sub100 ;         -- d * 10 + n
    pot1plus d s = {
        s = \\x => d.ten!x  ++ s.unit!x;
        o = \\x => d.oten!x ++ s.ounit!x;
        a = s.a;
        n = Pl
    };

--   pot1as2 : Sub100 -> Sub1000 ;                 -- coercion of 1..99
    pot1as2 s = {
        s = s.s;
        o = s.o;
        a = s.a; 
        n = s.n
    };

--   pot2 : Sub10 -> Sub1000 ;                     -- m * 100
    pot2 s = {
        s = s.hundred;
        o = s.ohundred;
        a = StoA; 
        n = Pl
    };
    
--   pot2plus : Sub10 -> Sub100 -> Sub1000 ;       -- m * 100 + n
    pot2plus s10 s100 = {
        s = \\x => s10.hundred!x ++ case s100.n of { Sg => "jeden"; _=>s100.s!x } ;
        o = \\x => s10.hundred!<Nom, Masc Inanimate> ++ s100.o!x; -- sto drugi, nie setny drugi
        a = case s100.n of { Sg => StoA; _=> s100.a }; 
        n = Pl
    };


--   pot2as3 : Sub1000 -> Sub1000000 ;             -- coercion of 1..999
    pot2as3 s = {
        s = s.s;
        o = s.o;
        a = s.a; 
        n = s.n -- was Pl - why? very strange ASL
    };

--   pot3 : Sub1000 -> Sub1000000 ;                -- m * 1000
    pot3 s = {
        s = \\x => case s.n of { Sg => ""; Pl => s.s!<x.p1,Masc Inanimate> } 
            ++ tysiac!<(accom_case! <s.a,x.p1, Masc Inanimate>),s.n>;
        o = \\x => s.o!x ++ (mkAtable (guess_model "tysięczny"))!x; --FIXME dwu tysieczny, nie dwa tysieczny
        a = TysiacA;
        n = Pl
    };


--   pot3plus : Sub1000 -> Sub1000 -> Sub1000000 ; -- m * 1000 + n
    pot3plus s s2 = {
        s = \\x => case s.n of { Sg => ""; Pl => s.s!<x.p1,Masc Inanimate> } 
            ++ tysiac!<(accom_case! <s.a,x.p1, Masc Inanimate>),s.n> 
            ++ case s2.n of { Sg => "jeden"; _=>s2.s!x } ; --zabiłem dwa tysiące jeden policjantów
        o = \\x => case s.n of { Sg => ""; Pl => s.s!<Nom,Masc Inanimate> } -- tysiąc dwieście dziewięćdziesiąty pierwszy
            ++ tysiac!<(accom_case! <s.a,Nom, Masc Inanimate>),s.n> 
            ++ s2.o!x;
        a = case s2.n of { Sg => TysiacA; _=> s2.a } ;
        n = Pl
    };
    
oper tysiac = table {
    <(Nom|Acc), Sg> => "tysiąc";
    <Gen,       Sg> => "tysiąca";
    <Dat,       Sg> => "tysiącowi";
    <Instr,     Sg> => "tysiącem";
    <(Loc|VocP),Sg> => "tysiącu";
    <(Nom|Acc|VocP), Pl> => "tysiące";
    <Gen,       Pl> => "tysięcy";
    <Dat,       Pl> => "tysiącom";
    <Instr,     Pl> => "tysiącami";
    <Loc,       Pl> => "tysiącach"
  };


-- -- Numerals as sequences of digits have a separate, simpler grammar
  lincat 
    Dig = {s:Str; o:Str; n:Number; a:Accom};  -- single digit 0..9

  lin
--     IDig  : Dig -> Digits ;       -- 8
    IDig d = d;
    
--     IIDig : Dig -> Digits -> Digits ; -- 876
    IIDig d dd = { s = d.s ++ dd.s; o = d.s ++ dd.o; n=Pl; a=dd.a };

    D_0 = { s = "0"; o="0."; n=Pl; a=TysiacA };
    D_1 = { s = "1"; o="1."; n=Sg; a=NoA };
    D_2 = { s = "2"; o="2."; n=Pl; a=DwaA };
    D_3 = { s = "3"; o="3."; n=Pl; a=DwaA };
    D_4 = { s = "4"; o="4."; n=Pl; a=DwaA };
    D_5 = { s = "5"; o="5."; n=Pl; a=PiecA };
    D_6 = { s = "6"; o="6."; n=Pl; a=PiecA };
    D_7 = { s = "7"; o="7."; n=Pl; a=PiecA };
    D_8 = { s = "8"; o="8."; n=Pl; a=PiecA };
    D_9 = { s = "9"; o="9."; n=Pl; a=PiecA };

}
