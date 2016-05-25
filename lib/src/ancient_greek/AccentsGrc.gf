--# -path=.:../abstract:../common:../prelude

--1 Greek auxiliary operations.   -- NOT USED. Remember old version; sound law SL etc

resource AccentsGrc = {

flags 
  optimize = noexpand ;

oper

-- Accent shift and accent change: the following functions are applied to 
-- the stem in certain cases:

-- a) when the Pl Gen ending w~n is added, the accent in the stem 
--    must be removed using dropAccent:

  dropAccent : Str -> Str = \str -> case str of { 
      x + ("'" | "`" | "~") + z => x + z ;
      x + "="               + z => x + "-" + z ;
      _                         => str 
    } ;



{- Redesign: ------------------------------------------------------------------

   Try to extract the patterns of vowel lengths and accent position 
   and do the paradigms with less pattern matching.

   We need the general rule:
   1. the accent position is taken from SgNom, and only moved on demand.
   2. a shift is demanded if a an ending with a long vowel is added and 
      the accent position is on the 3rd last vowel.
   3. if an ending with accent is added, the accent in the stem has to be dropped.

-- Declension I,II: Word`stock'+NomSgEnding => wordkind includes ending. 
     Then from lists of endings *without accent* one takes the accent position 
     from the user-provided form(s), and given the vowel length of the ending,
     determines the accent position of other forms
-- Declension III:  
     Wordstem+Ending (wordstem+os=GenSg) => NomSg may have empty ending
     Then the accent position is taken from the NomSg.
-}

oper 
  Position : PType = Predef.Ints 3 ;

  WPat = { syl : Syllability ; 
            v : VPat * VPat * VPat ; 
            s : Str * Str * Str * Str;
           acnt : Accent 
         } ;
param
  Accent = Acute Position | Circum Position | NoAccent ;
  Syllability = Mono | Bi | Many ;

  Vowel  = A | E | I | O | U | AU | EU | OU | AI | EI | OI | UI | 
           -- vowel with spirtus asper/lenis:
           Aa | Ea | Ia | Oa | Ua | AUa | EUa | OUa | AIa | EIa | OIa | UIa | 
           Al | El | Il | Ol | Ul | AUl | EUl | OUl | AIl | EIl | OIl | UIl | 
           -- vowel with iota subscriptum and spiritus
           Ai | Ei | Oi | Aia | Eia | Oia | Ail | Eil | Oil 
         ;

  VPat   = NoVowel | Short Vowel | Long Vowel ;  -- 1+45+45 = 91 possibilities

  Spirit = Asper | Lenis | NoSpirit ;

oper
  removeLength : Str -> Str = \str -> case str of { 
     "a_" | "a." => "a" ; "i_" | "i." => "i" ;  "y_" | "y." => "y" ; x => x } ;

  toStr : VPat -> Str = \vpat -> case vpat of {
     Short A => "a" ;
     Short E => "e"  ;
     Short I => "i" ;  
     Short O => "o"  ;
     Short U => "y" ;
     Long A  => "a_" ; -- maybe better "a", since the unicode-table has not a_'
     Long E  => "h"  ;
     Long I  => "i_" ;
     Long O  => "w"  ;
     Long U  => "y_" ;
     Long AU => "ay" ;
     Long EU => "ey" ;
     Long OU => "oy" ;
     Long AI => "ai" ;
     Long EI => "ei" ;
     Long OI => "oi" ;
     Long UI => "yi" ;
     Short AI => "ai" ;
     Short OI => "oi" ;
     -- vowels and diphthongs with spriritus asper:
     Short Aa => "a(" ;
     Short Ea => "e(" ;       
     Short Ia => "i(" ;       
     Short Oa => "o(" ;       
     Short Ua => "y(" ;       
  -- Long Aa 
     Long Ea => "h(" ;    
  -- Long Ia
     Long Oa => "w(" ;       
  -- Long Ua
     Long AUa => "ay(" ;
     Long EUa => "ey(" ;
     Long OUa => "oy(" ;
     Long AIa => "ai(" ;
     Long EIa => "ei(" ;
     Long OIa => "oi(" ;
     Long UIa => "yi(" ;
     -- vowels and diphthongs with spriritus lenis:
     Short Al => "a)" ;       
     Short El => "e)" ;       
     Short Il => "i)" ;       
     Short Ol => "o)" ;       
     Short Ul => "y)" ;       
  -- Long Al
     Long El => "h)" ;       
  -- Long Il
     Long Ol => "w)" ;       
  -- Long Ul
     Long AUl => "ay)" ;
     Long EUl => "ey)" ;
     Long OUl => "oy)" ;
     Long AIl => "ai)" ;
     Long EIl => "ei)" ;
     Long OIl => "oi)" ;
     Long UIl => "yi)" ;
     -- vowels with iota subscriptum, and spirits
     Long Ai  => "a|" ;
     Long Ei  => "e|" ;
     Long Oi  => "o|" ;
     Long Aia => "a|(" ;
     Long Eia => "h|(" ;
     Long Oia => "w|(" ;
     Long Ail => "a|)" ;
     Long Eil => "h|)" ;
     Long Oil => "w|)" ;
     NoVowel => "" ;   -- TODO: trema etc. perhaps I2 = "i-" 
     _       => "*"    -- ca.30 possibilities
  } ;

  toVPat : Str -> VPat = \str -> case str of {
     ("a."|"a") => Short A ;
     ("i."|"i"|"i-"|"i=") => Short I ;
     ("y."|"y"|"y-"|"y=") => Short U ;
     "a_"       => Long A ;
     "i_"       => Long I ;
     "y_"       => Long U ;
     "a" => Short A ; 
     "e" => Short E ; 
     "i" => Short I ; 
     "o" => Short O ; 
     "y" => Short U ; 
     "a" => Long A  ; -- maybe better "a", since the unicode-table has not a_'
     "h" => Long E  ; 
     "i" => Long I  ; 
     "w" => Long O  ; 
     "y" => Long U  ; 
     "ay" => Long AU ; 
     "ey" => Long EU ; 
     "oy" => Long OU ; 
     "ai" => Long AI ; 
     "ei" => Long EI ; 
     "oi" => Long OI ; 
     "yi" => Long UI ; 
     -- vowels and diphthongs with spriritus asper:
     "a(" => Short Aa ; 
     "e(" => Short Ea ; 
     "i(" => Short Ia ; 
     "o(" => Short Oa ; 
     "y(" => Short Ua ; 
  -- Long Aa 
     "h(" => Long Ea ; 
  -- Long Ia
     "w(" => Long Oa ; 
  -- Long Ua
     "ay(" => Long AUa ; 
     "ey(" => Long EUa ; 
     "oy(" => Long OUa ; 
     "ai(" => Long AIa ; 
     "ei(" => Long EIa ; 
     "oi(" => Long OIa ; 
     "yi(" => Long UIa ; 
     -- vowels and diphthongs with spriritus lenis:
     "a)" => Short Al ; 
     "e)" => Short El ; 
     "i)" => Short Il ; 
     "o)" => Short Ol ; 
     "y)" => Short Ul ; 
  -- Long Al
     "h)" => Long El ; 
  -- Long Il
     "w)" => Long Ol ; 
  -- Long Ul
     "ay)" => Long AUl ; 
     "ey)" => Long EUl ; 
     "oy)" => Long OUl ; 
     "ai)" => Long AIl ; 
     "ei)" => Long EIl ; 
     "oi)" => Long OIl ; 
     "yi)" => Long UIl ; 
     -- vowels with iota subscriptum, and spirits
     "a|" => Long Ai  ; 
     "e|" => Long Ei  ; 
     "o|" => Long Oi  ; 
     "a|(" => Long Aia ; 
     "h|(" => Long Eia ; 
     "w|(" => Long Oia ; 
     "a|)" => Long Ail ; 
     "h|)" => Long Eil ; 
     "w|)" => Long Oil ; 
     _     => NoVowel  -- TODO: trema etc. perhaps I2 = "i-" 
  } ;

-- accent ~ can only be on long vowels, hence y~ must become <Long U, Circum> etc:

  toVPat2 : Str -> Str -> VPat = \o,z -> 
     case o of { (#shortV|#restV) => case z of {"~"+_ => toVPat (removeLength o + "_") ; 
                                                 _    => toVPat o} ;
                 _                => toVPat o } ;

  toAcntPos : Str -> Accent = \str -> 
     case str of { -- we don't check for double accent; the leftmost accent counts
     -- 3 syllables
     ("'"|"('"|")'") + _ + "$"       + _ + "$" + _  => Acute 1 ;
     ("~"|"(~"|")~") + _ + "$"       + _ + "$" + _  => Circum 1 ;
                       _ + "$" + "'" + _ + "$" + _  => Acute 2 ;
                       _ + "$" + "~" + _ + "$" + _  => Circum 2 ;
                       _ + "$" + _ + "$" + "'" + _  => Acute 3 ;
                       _ + "$" + _ + "$" + "~" + _  => Circum 3 ;
     -- 2 syllables
     ("'"|"('"|")'") + _ + "$" + _        => Acute 2 ;
     ("~"|"(~"|")~") + _ + "$" + _        => Circum 2 ;  
                       _ + "$" + "'" + _  => Acute 3 ;  
                       _ + "$" + "~" + _  => Circum 3 ;  
     -- 1 syllable
     ("'"|"('"|")'") + _          => Acute 3 ;
     ("~"|"(~"|")~") + _          => Circum 3 ;
     -(_ + ("'" | "~" | "`") + _) => NoAccent ;
     _  => Predef.error "Error: double accent" 
  } ;

-- The order of the patterns in the pattern alternatives is important since 
-- diphthongs match against vowel+vowel, and short vowels.
-- (Here "ai", "oi" count as long; for end syllables, this is adjusted in addAccent.)

  wpat : Str -> WPat = \str ->      
     let T = "$" ;             
         da = dropAccent 
     in 
     case str of { 
     -- monosyllabic words:
          y@(("r(" | "") + #nonvowels)
        + o@((#diphthong | #longV | #shortV | #restV) + (#spirit | "")) 
        + z@#nonvowels 
     => { syl = Mono ;  
          v = <NoVowel, NoVowel, toVPat2 o z> ; 
          acnt = toAcntPos z ; 
          s = <[] , [] , y , da z>
        } ;
     -- bisyllabic words:
         x@(("r(" | "") + #nonvowels)
       + e@((#diphthong | #longV | #shortV | #restV) + (#spirit | ""))
       + y@#nonvowels 
       + o@(#diphthong | #longV | #shortV | #restV) 
       + z@#nonvowels
     => { syl = Bi ;  
          v = <NoVowel , toVPat2 e y, toVPat2 o z> ; 
          acnt = toAcntPos (y + T + z) ; 
          s = <[] , x , da y , da z>
        } ;
     -- manysyllabic words:
         r@_ 
       + a@((#diphthong | #longV | #shortV | #restV) + (#spirit | ""))
       + x@#nonvowels 
       + e@(#diphthong | #longV | #shortV | #restV) 
       + y@#nonvowels 
       + o@(#diphthong | #longV | #shortV | #restV) 
       + z@#nonvowels  
     => { syl = Many ;  
          v = <toVPat2 a x, toVPat2 e y, toVPat2 o z> ;
          acnt = toAcntPos (x + T + y + T + z) ;
          s = <r , da x , da y , da z>
        } ;
     _ => -- Predef.error "vowel/accent pattern not recognized" 
          { syl = Mono ;
            v   = <NoVowel,NoVowel,NoVowel> ;
            acnt= NoAccent ;
            s   = <"BUGGY","VOWEL","ACCENT","PATTERN"> 
          }
     } ;
           
-- Add an accent to an unaccentuated string; includes necessary accent changes and shifts
-- (We don't check that the given string has enough vowels.)

  merge : (Str * Str * Str * Str) -> (Str * Str * Str) -> Str = 
           \cs,vs -> cs.p1 + vs.p1 + cs.p2 + vs.p2 + cs.p3 + vs.p3 + cs.p4 ;

  glue : (Str * Str * Str * Str )-> (VPat * VPat * VPat) -> Str = 
         \cs,vs -> cs.p1 + (toStr vs.p1) + cs.p2 + (toStr vs.p2) + cs.p3 + (toStr vs.p3) + cs.p4 ;

  addAccent0 : Accent -> Str -> Str = \accent,str -> str ;  -- for testing

  -- addAccent inserts the given accent = (accnt pos) to the vowel at the position,
  -- and for pos=1=3rd last and last vowel is short, puts the accent to 2nd last:
  addAccent : Accent -> Str -> Str = \accent,str -> 
    let 
         w = wpat str ;
        v1 = toStr w.v.p1 ;  -- third last vowel
        v2 = toStr w.v.p2 ;  -- second last vowel
        v3 = toStr w.v.p3 ;  -- last vowel
        v2s = removeLength v2 ;
        v3s = removeLength v3 ;
    in
       case accent of {
         Acute 3  => merge w.s <v1, v2, v3 + "'"> ;
         Circum 3 => merge w.s <v1, v2, v3s + "~"> ;
         Acute 2  => case <w.v.p2, w.v.p3> of {                   -- BR 9 4
                        <Long u2, Short u3> => merge w.s <v1, v2s + "~", v3> ; 
                                          _ => merge w.s <v1, v2 + "'", v3> 
                     } ;
         Circum 2 => merge w.s <v1, v2s + "~", v3> ; -- change to ' for v2 short?
         Acute 1  => case <w.v.p3, w.s.p4> of { 
                       <Short _, _> => merge w.s <v1 + "'", v2, v3> ;  -- BR 9 1.b
                       <Long AI,""> => merge w.s <v1 + "'", v2, v3> ;  -- BR 29.7 declension ; conjug?
                       <Long OI,""> => merge w.s <v1 + "'", v2, v3> ;  -- BR 29.7 declension ; conjug?
                       _            => merge w.s <v1, v2 + "'", v3>    -- sometimes changes to "~" needed?
                     } ;
         _ => -- Predef.error ("Illegal accentuation for " ++ str)
              str
    } ;

  -- from accent position in stem to accent position in (stem+long ending): ?
  --   stempos1,stempos2,stempos3 => (stem+end)pos1,(stem+end)pos2,(stem+end)pos3

  addAccent' : Accent -> Str -> Str = \accent,str ->
     let 
        accent'  = case accent of {Acute 2  => Acute 1 ;
                                   Circum 2 => Acute 1 ;
                                   Acute 3  => Acute 2 ;
                                   Circum 3 => Circum 2 ;
                                          _ => accent} 
     in addAccent accent' str ;
-}
-- --------------------------------------------------------------------------------

{- Sound laws on structured string (Example)

  -- Problem: 
  -- In addNEnding, an accent on the ending overwrites accents on the stem.
  -- But if vowel contraction <e',ei> => <[],ei~> deletes the final vowel of
  -- the stem, one would need to shift stem parts to the right:  
  -- c1+v1+c2+v2+c3+v3+[]++[]+v+c2 => c1+v1+c2+v2+c3+[]+[]++[]+(v3+v)+c2 
  -- to avoid the adjacent []+[]. But c1 may contain vowels, and the number of 
  -- syllables is not exactly known!
  -- If we use c1+v1+c2+v2+c3+v3+[]++[]+v+c2 => c1+v1+c2+v2+c3+(v3+v)+[]++[]+[]+c2,
  -- as with <e',ei> => <ei~,[]>, we have to adjust the accent in the stem. (ToDo)
  -- (could also turn the ending to c2+[]+[], but need not). 

  --  cV2 : soundlaw = \s2 -> <"", contractVowels s2.p1 s2.p2> ; -- deprec.

  -- Test
  SL : Soundlaw = \we -> let S = we.p1 ; 
                             E = we.p2 ; 
                             sv3 : Str = S.v.p3 + case S.a of { Acute 3  => "'" ;
                                                                Circum 3 => "~" ; 
                                                                       _ => "" } ;
                             sc4 = S.c.p4 ;
                             ec1 = E.c.p1 ;
                             ev  = E.v ;
                          in case <sv3,sc4,ec1,ev> of {
                                  <_,"","",_> => let vs = cV2 <sv3,ev> ;  -- contractVowels
                                                     S2 = substV3 S vs.p1 ;
                                                     E2 = toNEnding (vs.p2 + E.c.p2)
                                                 in <S2, E2> ; 
                                  <_,?+_,_+("m"|"s"|"t"|"v"),_> => 
                                                 let cs = mC2 <sc4,ec1> ;
                                                     S2 = substC4 S cs.p1 ;
                                                     E2 = substC E <cs.p2,E.c.p2> 
                                                 in <S2, E2> ; 
                                  _ => we } ;

  substV3 : Word -> Str -> Word =   -- assume that w.v.p3 and u are not "" !!
     \w,u -> { a = case u of { _+"~" => Circum 3 ; _+"'" => Acute 3 ; _ => w.a } ; 
               s = w.s ; 
               v = <w.v.p1, w.v.p2, dropAccent u>  ; -- We need u=/=[], else w.v.p1 prevents shifting
               l = <w.l.p1, w.l.p2, vowelLength (dropAccent u)> ; -- TODO: short "ai" etc
               c = w.c } ; 
  substC : NEnding -> (Str*Str) -> NEnding = 
     \w,cs -> { a = w.a ; v = w.v ; l = w.l ; c = cs } ; 

  -- expl: cc SL <toWord "nanoga'", toNEnding "wn">

   toStrN3 : Word -> Str -> Str =
      \w,e -> let we = SL (adjustAccent <w, toNEnding e>) 
               in toStrT (concat we) ;               

--    toStrN3 : Word -> Str -> Str = \w,e -> let we = (SL <w, toNEnding e>)
--                                            in toStr (addNEnding we.p1 we.p2) ; 

   -- cc let we = (SL <toWord "gene'", toNEnding "i">) in toStr (addNEnding we.p1 we.p2) 
   -- cc toStr (addNEnding (SL <toWord "gene'", toNEnding "i">).p1 (SL <toWord "gene'", toNEnding "i">).p2)
-}

} 
