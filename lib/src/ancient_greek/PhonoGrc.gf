resource PhonoGrc = open Prelude in {

flags coding=utf8 ;
      optimize=all ;
oper 
  -- consonants:
  labial : pattern Str   = #("p" | "b" | "f") ;
  dental : pattern Str   = #("t" | "d" | "v") ;
  guttural : pattern Str = #("k" | "g" | "c") ;
  nasal  : pattern Str   = #("n" | "m") ;
  liquid : pattern Str   = #("l" | "r") ;
  -- spirans : pattern Str  = #("s") ;

  consonant : pattern Str = 
           #("p"|"b"|"f"|"t"|"d"|"v"|"k"|"g"|"c"
            |"l"|"r"|"m"|"n"|"s"|"x"|"q"|"z") ;

  -- vowels:
  shortDiphthong : pattern Str = #( "ai" | "ei" | "oi" | "yi" | "ay" | "ey" | "oy" ) ;
  longDiphthong : pattern Str  = #("a_i" | "hi" | "wi" |       "a_y" | "hy" | "wy" |
                                   "a|"  | "h|" | "w|" |   -- iota subscriptum
                                   "Ai"  | "Hi" | "Wi" ) ; -- iota adscriptum


  diphthong : pattern Str = #("ai"|"ei"|"oi"|"yi"|"ay"|"ey"|"hy"|"oy" -- rare: "a_y", "wy"
                             |"a|"|"h|"|"w|") ;      -- with iota subscriptum
  longV  : pattern Str = #("h"|"w"|"a_"|"i_"|"y_") ; -- i-,y- translit: i=' = i ??
  shortV : pattern Str = #("e"|"o"|"a."|"i."|"y.") ; -- a,i,y short by default
  restV  : pattern Str = #("a"|"e"|"i"|"o"|"y"|"i-"|"y-"|"i="|"y=") ; 

  diphthongCap : pattern Str = #("Ai"|"Ei"|"Oi"|"Yi"|"Ay"|"Ey"|"Hy"|"Oy" -- rare: "a_y", "wy"
                                     |"Hi"|"Wi") ;      -- with iota adscriptum
  longVCap  : pattern Str = #("H"|"W"|"A_"|"I_"|"Y_") ; 
  shortVCap : pattern Str = #("E"|"O"|"A."|"I."|"Y.") ;  
  restVCap  : pattern Str = #("a"|"e"|"i"|"o"|"y"|"i-"|"y-"|"i="|"y=") ; 
  
  vowel  : pattern Str = 
           #("h"|"w"|"a_"|"i_"|"y_"|                  -- long vowels
             "e"|"o"|"a."|"i."|"y."|"a" |"i" |"y" ) ; -- short vowels +default
                                                      -- TODO: trema, aspirates
  consonant : pattern Str = 
           #("p"|"b"|"f"|"t"|"d"|"v"|"k"|"g"|"c"
            |"l"|"r"|"m"|"n"|"s"|"x"|"q"|"z") ;
  consonantCap : pattern Str = 
           #("P"|"B"|"F"|"T"|"D"|"V"|"K"|"G"|"C"
            |"L"|"R"|"M"|"N"|"S"|"X"|"Q"|"Z") ;


  aspirate : pattern Str = #(")"|"(") ;
  accent : pattern Str = #("'"|"~") ;
  acute  : pattern Str = #("'") ;
  circum : pattern Str = #("~") ;

  nonvowels : pattern Str =                           -- sequence of nonvowels and accents
           #(("p"|"b"|"f"|"t"|"d"|"v"|"k"|"g"|"c"     -- Does NOT cover aspirate asper/lenis
             |"l"|"r"|"m"|"n"|"s"|"x"|"q"|"z"|"s*"    -- consonants
             |"'"|"~"|"`")*) ;                        -- accents 
                                                      -- TODO: iota capitals

{- see below
  -- BR 13 -- TODO: add accents
  shortenVowel : Str -> Str = \str -> 
    let short : Str -> Str = \s -> case s of { "h" => "e" ;
                                               "w" => "o" ;
                                              "a_" => "a" ;
                                              "i_" => "i" ;
                                              "y_" => "y" ;
                                              "a_i" => "ai" ;
                                              "hi" => "ei" ;
                                              "wi" => "oi" ;
                                              "hy" => "ey" ;
                                              "a_y" => "ay" ;
                                              "wy" => "oy" ;       
                                                 _ => s } ;
     in
        case str of { x + d@#longDiphthong + y@(#consonant + _) => x+(short d)+y ;
                      x + v@#longV + y@(n@#nasal + c@#consonant + _) => x+(short v)+y ;
                      x + v@#longV + y@(#longV + _) => x+(short v)+y ;
                      x + "h~a." + y => x + "e'a_" + y ;
                      x + "h~o" + y  => x + "e'w" + y ;
                      x + "ha." + y  => x + "ea_" + y ;
                      x + "ho" + y   => x + "ew" + y ;
                      _              => str 
        } ;

  -- BR 15 
  contractVowels : Str -> Str = \str -> 
    case str of { x + "aa"        + y => x + "a_" + y ;     -- a)
                  x + "ee"        + y => x + "ei" + y ;           
                  x + ("eh"|"he") + y => x + "h"  + y ;
                  x + "oo"        + y => x + "oy" + y ;            
                  x + ("ow"|"wo") + y => x + "w"  + y ;          
                  x + ("oa"|"ao"|"wa"|"aw") + y => x + "w"  + y ;     -- b)
                  x + ("oe"|"eo") + y => x + "oy" + y ;                      
                  x + "a" + ("e"|"h") + y => x + "a_" + y ; -- c)
                  x + ("e"|"h") + "a" + y => x + "h"  + y ; 
                  x + "e"+"ei" + y    => x + "ei" + y ;     -- d) 
                  x + "o"+"oi" + y    => x + "oi" + y ;
                  x + "e"+"h|" + y    => x + "h|" + y ;
                  x + "e"+"ai" + y    => x + "h|" + y ;
                  x + "a"+"ei" + y    => x + "a|" + y ;
                  x + "a"+"oi" + y    => x + "w|" + y ;
                  _                   => str
    } ; 
        -- TODO: add accents according to BR 9
        -- v1+v2 contracted to u resp. last syllable u:
        -- v1+v2' => u' resp. u' 
        -- v1+v2~ => u' resp. u'
        -- v1'+v2 => u' resp. u~
        -- v1~+v2 => u' resp. u~
-}

  -- BR 24
  punctuation : Strs = strs { "." ; ";" } ;   -- + greek semicolon?

  vowelLenis : Strs = strs { 
     "h)" ; "w)" ; "a_)" ; "i_)" ; "y_)" ; "e)" ; "o)" ; "a)" ; "i)" ; "y)" ; -- "a.)" ; "i.)" ; "y.)" ;
     "ai)" ; " ei)" ; "oi)" ; "yi)" ; "ay)" ; "ey)" ; "oy)" } ;

  vowelAsper : Strs = strs { 
     "h(" ; "w(" ; "a_(" ; "i_(" ; "y_(" ; "e(" ; "o(" ; "a(" ; "i(" ; "y(" ; -- "a.(" ; "i.(" ; "y.(" ;
     "ai(" ; " ei(" ; "oi(" ; "yi(" ; "ay(" ; "ey(" ; "oy(" } ;

  ersatzdehnung1 : Str -> Str = \str -> case str of {
      ("a."|"a") => "a_" ; -- variants{"a_" ; "h"} ;  -- BR 12: x@(e|i|r)+a > x+a_ else x+h
      "e" => "ei" ; ("i."|"i") => "i_" ;              -- see mkVerbW1liq: efansa > efhna, but melans > mela_s
      "o" => "oy" ; ("y."|"y") => "y_" ; _ => str} ;  -- BR 14

  ersatzdehnung = overload {
    ersatzdehnung22 : (Str*Str) -> (Str*Str) = 
      \xy -> case xy of {
             <x + v@#vowel +a@(#accent|"") 
                + c@#consonant + n@#nonvowels, y> =>           -- need: new accent 
             <x + ersatzdehnung1(v) +a + c + n, y> ;            -- depending on y
             _ => xy } ;
    ersatzdehnung : Str -> Str = ersatzdehnung1 
  } ;

  auslaut : Str -> Str = \str -> case str of {  -- BR 23
      _ + ("n"|"r"|"s*") => str ;  -- allowed consonants at word ending
      _ + ("x"|"q")      => str ;  --
      stm + "s"          => stm + "s*" ;
      stm + #consonant   => stm ;   -- drop consonant (several?)
      _ => str } ;

  ablaut : Str -> Str =\str -> case str of {    -- BR 27b
      x + ("fh"|"fw") + y => x + "fa" + y ;
      x + "sth" + y       => x + "sta" + y ;
      x + ("vh"|"vw") + y => x + "ve" + y ;
      x + "dw" + y        => x + "do" + y ;
      x + "ih" + y        => x + "ie" + y ;
      x + "i('h" + y      => x + "i('e" + y ;
      _                   => str } ;

-- Assume that the vowel lengths in the user provided forms are explicitly 
-- marked, or unmarked vowels a,i,y which count as short. Then the paradigms 
-- can be produced correctly with length indications; however:
--
--  (i) length indications combined with accent have no utf-8 representation,
--      so the length indication must be removed in the paradigm;
--      (or can we keep the indications and extend the transliteration?)
-- (ii) decisions based on pattern matching have to treat the diphthongs
--      before the short vowels, since diphthongs contain the unmarked vowels.

  dropLength : Str -> Str = \str -> case str of { 
     "a_" | "a." => "a" ; "i_" | "i." => "i" ;  "y_" | "y." => "y" ; x => x } ;
  dropShortness : Str -> Str = \str -> case str of {  -- apply to a stem/form
     x + v@("a"|"i"|"y") + "." + y => x + v + y ; x => x } ; 

  -- BR 15 1.
  -- For the paradigms, we'd better only contract where stem + ending combine:
  -- Kleomenes+os > Kleomene+os > Kleomenoys   (dropS + contractVowels)
  -- This would be more accurate and more efficient, but clumsier to use.

  contractVowels = overload {
    
    -- Version that operates on strings and contracts the first occurrence:
    contractVowels : Str -> Str = \str -> 
    case str of { -- TODO: check accents according to BR 15 2. + BR 9
                  x + "e'ei" + y   => x + "ei~" + y ;    -- 2.
                  x + "o'oi" + y   => x + "oi~" + y ;
                  x + "o'h|" + y   => x + "w|~" + y ;
                  x + "e'h|" + y   => x + "h|~" + y ;
                  x + "e'ai" + y   => x + "h|~" + y ;
                  x + "e'oy" + y   => x + "oy~" + y ;    -- HL: poie'oy = poioy~
                  x + "a'ei" + y   => x + "a|~" + y ;
                  x + "a'h|" + y   => x + "a|~" + y ;    -- HL: tima'h|=>tima|~
                  x + "a'oi" + y   => x + "w|~" + y ;
                  x + "a'oy" + y   => x + "w~"  + y ;    -- HL: tima'oysi=>timw~si
                  x + "e'oi" + y   => x + "oi~" + y ;    
                  x + "eei" + y    => x + "ei" + y ;     -- d) V.+Dipht => Dipht
                  x + "ooi" + y    => x + "oi" + y ;
                  x + "eh|" + y    => x + "h|" + y ;
                  x + "eai" + y    => x + "h|" + y ;
                  x + "aei" + y    => x + "a|" + y ;
                  x + "aoi" + y    => x + "w|" + y ;
                  x + "eoi" + y    => x + "oi" + y ;     
                  x + "a'a" + y    => x + "a~" + y ;     -- a) VV => V_, EE => EI, OO => OY
                  x + "aa"  + y    => x + "a_" + y ;     -- a)
                  x + "e'eo" + y   => x + "e'oy" + y ;           
                  x + "e'ea" + y   => x + "e'a" + y ;           
                  x + "e'e" + y    => x + "ei~" + y ;           
                  x + "ee"  + y    => x + "ei" + y ;           
                  x + "h'h|" + y   => x + "h|~" + y ;    
                  x + "h'h" + y    => x + "h~" + y ;    
                  x + "h'w" + y    => x + "w~" + y ;    
                  x + "h('h|" + y  => x + "h|(~" + y ;   -- HL e('-
                  x + "h('h" + y   => x + "h(~" + y ;    -- HL
                  x + "h('w" + y   => x + "w(~" + y ;    -- HL i('hmi 
                  x + "h(o'" + y   => x + "w('" + y ;    -- HL e(-o'meva
                  x + ("e'h"|"h'e") + y    => x + "h~"  + y ;    
                  x + ("eh"|"he") + y      => x + "h"  + y ;    
                  x + "o'o"       + y      => x + "oy~" + y ;            
                  x + "oo"        + y      => x + "oy" + y ;            
                  x + ("o'w"|"w'o"|"w'w") + y => x + "w~"  + y ;          
                  x + ("ow"|"wo") + y      => x + "w"  + y ;          
                  x + ("o'a"|"a'o"|"o'h"|"w'a"|"a'w") + y      -- b)  O+(A|E) => O|OY
                                           => x + "w~"  + y ;  --     (A|E)+O => O|OY
                  x + ("oa"|"ao"|"wa"|"aw") + y     
                                           => x + "w"  + y ;   
                  x + ("o'e"|"e'o") + y    => x + "oy~" + y ;                   
                  x + ("oe"|"eo")   + y    => x + "oy" + y ;                   
                  x + ("w'h|") + y         => x + "w|~" + y ;                      
                  x + ("w'e"|"e'w"|"w'h") + y  => x + "w~" + y ;                      
                  x + ("we"|"ew") + y      => x + "w" + y ;                      
                  x + "a'" + ("e"|"h") + y => x + "a~" + y ; 
                  x + "ae'"            + y => x + "a'" + y ; -- for: a_'
                  x + "a"  + ("e"|"h") + y => x + "a_" + y ; -- c)  A+E => A
                  x + ("e"|"h") + "a" + y  => x + "h"  + y ; --     E+A => E
                  _                        => str
     } ; 

    --  'Positioned' version that operates on a split string, but produces 
    --  a string; hence cannot be followed by another 'positioned' sound law.

    contractVowels2 : Str -> Str -> Str = \s1,s2 -> 
    case <s1,s2> of { -- TODO: check accents according to BR 15 2. + BR 9
                  <x + "e'", "ei" + y>   => x + "ei~" + y ;    -- 2.
                  <x + "o'", "oi" + y>   => x + "oi~" + y ;
                  <x + "o'", "h|" + y>   => x + "w|~" + y ;
                  <x + "e'", "h|" + y>   => x + "h|~" + y ;
                  <x + "e'", "ai" + y>   => x + "h|~" + y ;
                  <x + "e'", "oy" + y>   => x + "oy~" + y ;    -- HL: poie'oy> = poioy~
                  <x + "a'", "ei" + y>   => x + "a|~" + y ;
                  <x + "a'", "h|" + y>   => x + "a|~" + y ;    -- HL: tima'h|=>tima|~
                  <x + "a'", "oi" + y>   => x + "w|~" + y ;
                  <x + "a'", "oy" + y>   => x + "w~"  + y ;    -- HL: tima'oysi=>timw~si
                  <x + "e'", "oi" + y>   => x + "oi~" + y ;    
                  <x + "e", "ei" + y>    => x + "ei" + y ;     -- d) V.+Dipht => Dipht
                  <x + "o", "oi" + y>    => x + "oi" + y ;
                  <x + "e", "h|" + y>    => x + "h|" + y ;
                  <x + "e", "ai" + y>    => x + "h|" + y ;
                  <x + "a", "ei" + y>    => x + "a|" + y ;
                  <x + "a", "oi" + y>    => x + "w|" + y ;
                  <x + "e", "oi" + y>    => x + "oi" + y ;     
                  <x + "a'", "a" + y>    => x + "a~" + y ;     -- a) VV => V_, EE => EI, OO => OY
                  <x + "a", "a"  + y>    => x + "a_" + y ;     -- a)
                  <x + "e'", "eo" + y>   => x + "e'oy" + y ;           
                  <x + "e'", "ea" + y>   => x + "e'a" + y ;           
                  <x + "e'", "e" + y>    => x + "ei~" + y ;           
                  <x + "e", "e"  + y>    => x + "ei" + y ;           
                  <x + "h'", "h|" + y>   => x + "h|~" + y ;    
                  <x + "h'", "h" + y>    => x + "h~" + y ;    
                  <x + "h'", "w" + y>    => x + "w~" + y ;    
                  <x + "h('", "h|" + y>  => x + "h|(~" + y ;   -- HL e('-
                  <x + "h('", "h" + y>   => x + "h(~" + y ;    -- HL
                  <x + "h('", "w" + y>   => x + "w(~" + y ;    -- HL i('hmi 
                  <x + "h(", "o'" + y>   => x + "w('" + y ;    -- HL e(-o'meva
                  <x + "e'", "h" + y>    => x + "h~"  + y ;    
                  <x + "h'", "e" + y>    => x + "h~"  + y ;    
                  <x + "e", "h" + y>     => x + "h"  + y ;    
                  <x + "h", "e" + y>     => x + "h"  + y ;    
                  <x + "o'", "o" + y>    => x + "oy~" + y ;            
                  <x + "o", "o"  + y>    => x + "oy" + y ;            
                  <x + "o'", "w" + y>    => x + "w~"  + y ;          
                  <x + "w'", ("o"|"w") + y> => x + "w~"  + y ;          
                  <x + "o", "w" + y>     => x + "w"  + y ;          
                  <x + "w", "o" + y>     => x + "w"  + y ;          
                  <x + "o'", ("a"|"h") + y> => x + "w~" + y ;  -- b)  O+(A|E) => O|OY 
                  <x + "w'", "a" + y>       => x + "w~" + y ;  
                  <x + "a'", ("o"|"w") + y> => x + "w~" + y ;  --     (A|E)+O => O|OY
                  <x + ("o"|"w"), "a" + y>  => x + "w"  + y ;   
                  <x + "a", ("o"|"w") + y>  => x + "w"  + y ;   
                  <x + "o'", "e" + y>    => x + "oy~" + y ;                   
                  <x + "e'", "o" + y>    => x + "oy~" + y ;                   
                  <x + "o", "e"  + y>    => x + "oy" + y ;                   
                  <x + "e", "o"  + y>    => x + "oy" + y ;                   
                  <x + "w'", "h|" + y>   => x + "w|~" + y ;    
                  <x + "w'", ("e"|"h") + y>  => x + "w~" + y ;                      
                  <x + "e'", "w" + y>    => x + "w~" + y ;                      
                  <x + "w", "e" + y>     => x + "w" + y ;                      
                  <x + "e", "w" + y>     => x + "w" + y ;                      
                  <x + "a'", ("e"|"h") + y> => x + "a~" + y ; 
                  <x + "a", "e'"       + y> => x + "a'" + y ; -- for: a_'
                  <x + "a", ("e"|"h") + y> => x + "a_" + y ; -- c)  A+E => A
                  <x + ("e"|"h"), "a" + y> => x + "h"  + y ; --     E+A => E
                  _                        => s1 + s2
        } ; -- Do we need h~e => h~ etc.??

    contractVowels22 : (Str*Str) -> (Str*Str) = \se -> 
    -- for soundlaws, but where to put the contraction in the result: <x+v,y> vs. <x,v+y>
    -- Treat the accent in the translated Soundlaw: if one of the vowels had an accent,
    -- the contracted one gets an accent, and then the accent rules may decide which one!

    case se of { -- short vowels followed by a diphthong beginning with the short vowel
                 -- are swallowed:
                  <x + "a", "ai" + y>   => <x, "ai" + y> ;    -- BR 15 d)
                  <x + "a", "ay" + y>   => <x, "ay" + y> ;    
                  <x + "e", "ei" + y>   => <x, "ei" + y> ;    
                  <x + "e", "ey" + y>   => <x, "ey" + y> ;    
                  <x + "o", "oi" + y>   => <x, "oi" + y> ;
                  <x + "o", "oy" + y>   => <x, "oy" + y> ;
                  <x + "y", "yi" + y>   => <x, "yi" + y> ;

                  <x + "e", "h|" + y>   => <x, "h|" + y> ;  -- <x + h|, y> ??
                  <x + "o", "h|" + y>   => <x, "w|" + y> ;           
                  <x + "w", "h|" + y>   => <x, "w|" + y> ;           
                  <x + "a", "h|" + y>   => <x, "a|" + y> ;           
                  <x + "h", "h|" + y>   => <x, "h|" + y> ;  

                 -- short vowels followed by a diphthong beginning with another vowel 
                 -- usually make a long diphthong:            -- BR 15 d)
                  <x + "a", "ei" + y>    => <x, "a|" + y> ;
                  <x + "a", "oi" + y>    => <x, "w|" + y> ;
                  <x + "a", "oy" + y>    => <x, "w"  + y> ;   -- HL?
                  <x + "e", "ai" + y>    => <x, "h|" + y> ;
                  <x + "e", "oi" + y>    => <x, "oi" + y> ;   -- ? 
                  <x + "e", "oy" + y>    => <x, "oy" + y> ;   -- ? w|

                 -- Two equal or similar vowels are turned into the long one:
                  <x + "a", "a"  + y>    => <x + "a_", y> ;  -- BR 15 a)
                  <x + "e", "e"  + y>    => <x + "ei", y> ;  
                  <x + "e", "h"  + y>    => <x,  "h" + y> ;  -- in verb inflection,
                  <x + "h", "e" + y>     => <x + "h",  y> ;  -- shorten the ending or  
                  <x + "o", "o"  + y>    => <x + "oy", y> ;  -- better shorten the stem?
                  <x + "o", "w" + y>     => <x,  "w" + y> ;          
                  <x + "w", "o" + y>     => <x + "w",  y> ;          
                  <x + "w", "w" + y>     => <x + "w",  y> ;  -- TODO: a_a > a_ etc ??       
                  <x + "h", "h" + y>     => <x,  "h" + y> ;  -- ??
                                                              
                 -- O+E. or E.+O give OY, else O             -- BR 15 b)
                  <x + "o", "e"  + y>    => <x + "oy", y> ;  -- but: E.+O:Y > O:Y      
                  <x + "e", "o"  + y>    => <x,  "oy"+ y> ;                   
                  <x + "w", "e" + y>     => <x + "w",  y> ;                      
                  <x + "e", "w" + y>     => <x,  "w" + y> ;                      
                  <x + "h", "w" + y>     => <x,  "w" + y> ;                      
                  <x + "w", "h" + y>     => <x + "w",  y> ;                      

                 -- O+A or A+O give O_
                  <x + "o", "a" + y>     => <x + "w",  y> ;   
                  <x + "a", "o" + y>     => <x,  "w" + y> ;   
                  <x + "w", "a" + y>     => <x + "w",  y> ;   
                  <x + "a", "w" + y>     => <x,  "w" + y> ;   

                 -- A+E gives A_, E+A gives E_              -- BR 15 c)
                  <x + "a", "e" + y>     => <x + "a_", y> ; 
                  <x + "a", "h" + y>     => <x + "a_", y> ; 
                  <x + "e", "a" + y>     => <x + "h",  y> ; 
                  <x + "h", "a" + y>     => <x + "h",  y> ; 

                 -- Dubious cases I needed at the beginning of a word
                  <x + "h(", "h|"+ y>   => <x + "h|(", y> ;   -- HL e('-
                  <x + "h(", "h" + y>   => <x + "h(",  y> ;    -- HL
                  <x + "h(", "w" + y>   => <x + "w(",  y> ;    -- HL i('hmi 
                  <x + "h(", "o" + y>   => <x + "w(",  y> ;    -- HL e(-o'meva

                 _                      => se
        } ; 

          -- Note: contractVowels22 should be the end version, if the accents are
          --       built into the derived souldlaws SL : Word*Ending -> Word*Ending
          -- BR 15 2. (see ResGrc.toSL')
          -- the accentuation follows from: new syllable gets an accent if one had
          --      <x "v'", "u" + y>  =>  <x, "(v+u)'" + y>
          --      <x "v", "u'" + y>  =>  <x, "(v+u)'" + y>
          -- and for end syllables:
          --      <x "v'", "u" + y>  =>  <x, "(v+u)~" + y>
          --      <x "v", "u'" + y>  =>  <x, "(v+u)'" + y>
          -- 
          --  Remaining cases with accents that would not follow: (where from?)
          --        <x + "e'", "eo" + y>   => <x + "e'oy" + y> ;           
          --        <x + "e'", "ea" + y>   => <x + "e'a" + y> ;           

    } ;
    
  -- contractConsonants

  mutaConsonant = overload { 
    mutaConsonant : Str -> Str = \str -> case str of {   -- BR 19 1. 
    x + #labial   + "m" + y => x + "mm" + y ; 
    x + #labial   + "s" + y => x + "q"  + y ;
    x + #labial   + "t" + y => x + "pt" + y ;
    x + #labial   + "v" + y => x + "fv" + y ;
    x + #guttural + "m" + y => x + "gm" + y ; 
    x + #guttural + "s" + y => x + "x"  + y ;
    x + #guttural + "t" + y => x + "kt" + y ;
    x + #guttural + "v" + y => x + "cv" + y ;
    x + #dental   + "m" + y => x + "sm" + y ; 
    x + #dental   + "s" + y => x + "s"  + y ;
    x + #dental   + "t" + y => x + "st" + y ;
    x + #dental   + "v" + y => x + "sv" + y ;
    _ => str
    } ;                                                -- BR 19 2. psv => ps => q  usw.
    mutaConsonant2 : (Str*Str) -> (Str*Str) = \str ->
    case str of {   -- BR 19 1.
    <x + #labial,   "m" + y> => <x + "m", "m" + y> ;
    <x + #labial,   "s" + y> => <x + "q",       y> ;
    <x + #labial,   "t" + y> => <x + "p", "t" + y> ;
    <x + #labial,   "v" + y> => <x + "f", "v" + y> ;
    <x + #guttural, "m" + y> => <x + "g", "m" + y> ;
    <x + #guttural, "s" + y> => <x + "x",       y> ;
--    <x + #guttural, "s" + y> => <x,  "x" +      y> ;
    <x + #guttural, "t" + y> => <x + "k", "t" + y> ;
    <x + #guttural, "v" + y> => <x + "c", "v" + y> ;
    <x + #dental,   "m" + y> => <x + "s", "m" + y> ;
    <x + #dental,   "s" + y> => <x,       "s" + y> ;
    <x + #dental,   "t" + y> => <x + "s", "t" + y> ;
    <x + #dental,   "v" + y> => <x + "s", "v" + y> ;
    _ => str
    } ;                                                -- BR 19 2. psv => ps => q  usw.
   } ;

  dropMSC : Str -> Str = \str -> case str of {
    x + m@(#labial | #guttural | #dental) + "s" + c@#consonant + y => x + m + c + y ;
    _ => str } ;
  mutaSConsonant : Str -> Str = \str -> mutaConsonant (dropMSC str) ;

  nasalConsonant = overload {
  -- operating on a string, deprecated:
  nasalConsonant1 : Str -> Str = \str -> case str of { -- BR 20.1
    x + "n" + c@#guttural + y => x + "g" + c + y ; -- n+guttural
    x + "n" + c@#labial   + y => x + "m" + c + y ; -- n+labial
    x + "n" + c@("l"|"r"|"m") + y => x + c + c + y ;   -- n+(liquid | m)
    _ => str 
    } ;
  nasalConsonant2 : Str -> Str -> Str = \s1,s2 -> case <s1,s2> of { -- BR 20.1
    <x + "n", c@#guttural + y> => x + "g" + c + y ;
    <x + "n", c@#labial   + y> => x + "m" + c + y ;
    <x + "n", c@("l"|"r"|"m") + y> => x + c + c + y ;
    _ => s1 + s2
    } ;
  nasalConsonant22 : (Str * Str) -> (Str * Str) = \str -> case str of { -- BR 20.1
    <x + "n", c@#guttural + y>     => <x + "g", c + y> ;
    <x + "n", c@#labial   + y>     => <x + "m", c + y> ;
    <x + "n", c@("l"|"r"|"m") + y> => <x + c,   c + y> ;
    _ => str
    } ;
  } ;

  -- short vowel + (n|m|r|l) + s > long vowel + (n|m|r|l)
  nasalSVowel = overload { -- TODO: and if there is an accent on the short vowel?
    nasalSVowel22 : (Str*Str) -> (Str*Str) = \str -> case str of { -- BR 20 2.
       <x + v@("a"|"e"|"i"|"o"|"y")          -- BR 20 4.
          + "n" + ("t"|""),        "s*"> => <x + ersatzdehnung(v), "s"> ;  -- logons > logoys
       <x + v@("a"|"e"|"i"|"o"|"y")                                        -- gigants> gigas 
          + n@(#nasal|#liquid), 
                  "s" + y@vowel + z> => <x + ersatzdehnung(v) + n, y+z> ;  -- efansa > efhna
       _ => str } 
    } ;

  -- instance of mutaConsonant, used in noun3LGL:
  -- c@(guttural or labial) + si > - + (cs)i  where cs is a consonant depending on c,s
  gutlabS = overload { 
    gutlabS22 : (Str*Str) -> (Str*Str) = \str -> case str of { -- BR 41 6.
       <x + c@#guttural,  "si" + y> => <x, "xi" + y> ;    
       <x + c@#labial,    "si" + y> => <x, "qi" + y> ;
       _ => str } 
  } ;

  dropS = overload {
    dropS1 : Str -> Str = \str -> case str of {       -- BR 16 1.
       x + v@#vowel + "s" + u@#vowel + y => x + v+u + y ;
       _ => str 
    } ;
    dropS22 : (Str*Str) -> (Str*Str) = \str -> case str of {       -- BR 16 1.
       <x + v@#vowel, "s" + u@#vowel + y> => <x + v, u + y> ;
       <x + v@#vowel + "s", u@#vowel + y> => <x + v, u + y> ;
       _ => str 
    } ;
  } ;

  swapLengths = overload {
    swapLengths1 : Str -> Str = \str -> case str of { -- BR 13 4. Quantitaetentausch
       x + "ha_"  + y => str ;
       x + "h'a_" + y => str ;
       x + "h~a_" + y => str ;
       x + "ha"   + y => x + "ea_" + y ;
       x + "h'a"  + y => x + "e'a_" + y ;
       x + "h~a"  + y => x + "e'a_" + y ;
       x + "ho"   + y => x + "ew"  + y ;
       x + "h'o"  + y => x + "e'w" + y ;
       x + "h~o"  + y => x + "e'w" + y ;
       _ => str } ;
    swapLengths22 : (Str*Str) -> (Str*Str) = \str -> case str of { -- BR 13 4. Quantitaetentausch
       <x + "h",  "a_" + y> => str ;
       <x + "h'", "a_" + y> => str ;
       <x + "h~", "a_" + y> => str ;
       <x + "h",  "a"  + y> => <x + "e",  "a_" + y> ;
       <x + "h'", "a"  + y> => <x + "e'", "a_" + y> ;
       <x + "h~", "a"  + y> => <x + "e'", "a_" + y> ;
       <x + "h",  "oi" + y> => <x + "e",  "oi" + y> ;
       <x + "h'", "oi" + y> => <x + "e'", "oi" + y> ;
       <x + "h~", "oi" + y> => <x + "e'", "oi" + y> ;
       <x + "h",  "o"  + y> => <x + "e",  "w" + y> ;
       <x + "h'", "o"  + y> => <x + "e'", "w" + y> ;
       <x + "h~", "o"  + y> => <x + "e'", "w" + y> ;
       <x + "h",  "w"  + y> => <x + "e",  "w" + y> ;  -- BR 13 3.
       <x + "h'", "w"  + y> => <x + "e'", "w" + y> ;
       <x + "h~", "w"  + y> => <x + "e'", "w" + y> ;
       _ => str } ;
  } ;

{-     
  iotaConsonant : Str -> Str = \str ->                                     -- BR 21.1-6
     case str of { x + v@("e"|"i"|"y") +a@("'"|[]) + c@("n"|"r") + "j" + y =>  
                                                        x + (ersatzdehnung v) + a + c + y ;
                   x + v@("a"|"o")     +a@("'"|[]) + c@("n"|"r") + "j" + y =>  
                                                        x + (v + "i") + a + c + y ;
                   x + "l"       + "j" + y => x + "ll" + y ;
                   x + ("t"|"v") + "j" + y => x + "s"  + y ;  -- + Edehnung: pantja > pansa > pa~sa
                   x + ("k"|"c") + "j" + y => x + "ss" + y ;
                   x + ("d"|"g") + "j" + y => x + "x"  + y ;
                   x + ("p"|"b"|"f") + "j" + y => x + "pt"  + y ;
                   x + v@#vowel +"s" + "j" + y => x + v + "i"  + y 
     } ;
-}

} 
