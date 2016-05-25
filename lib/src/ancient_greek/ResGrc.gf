--# -path=.:../abstract:../common:../prelude

-- Memo:
-- Show the paradigm:              gf> l -table -to_ancientgreek apple_N
-- Show the transliteration table: gf> unicode_table -ancientgreek
-- Parsing from greek input:       gf> l -from_ancientgreek <greek> | p -cat=... 
-- Normalizing the accentuation:   gf> ps -lexgreek <transliterated greek>
-- De-normalizing the accentuation: gf> ps -unlexgreek <transliterated greek>
-- Combined: gf> ps -from_ancientgreek -lexgreek | p -cat=NP <greek>
--           gf> l -unlexgreek -to_ancientgreek <abstract syntax tree>
--           gf> l -unlexer="LangGrc=unlexgreek,to_ancientgreek" <syntax tree>

--1 Greek auxiliary operations.

-- Based on E.Bornemann/E.Risch: Griechische Grammatik, 2.Auflage 1978 (2008)
-- (referred to as BR <Paragraph>) www.diesterweg.de, ISBN 978-3-425-06850-3  

-- Author: Hans Leiß, LMU Munich, CIS


resource ResGrc = ParamX - [Number,Sg,Pl,ImpForm,numImp,Tense,ImpF] 
                  ** open Prelude, PhonoGrc, Predef in {
flags 
  optimize = noexpand ;  -- optimize=all is impossible with addAccent

--2 For $Phono$logy: accentuation and data structures for stems/words and endings

-- NOTE: An acute accent on the end syllable of a word has to be turned into gravis,
-- except before an interpunctuation symbol. The resource, morphology and paradigm
-- files only treat the acute and circumflex accents, assuming that the unlexer
-- turns the acute on an end syllable to a gravis, and the lexer 'normalizes' 
-- the gravis accent to an acute. 
-- See gf/src/runtime/haskell/PGF/LexingAGreeek.hs for the lexer 'lexgreek' that 
-- 'normalizes' accentuation, including enclitics (but not crasis, i.e. contraction 
-- of end vowel and initial vowel, ta` e)kei~ > ta)kei~). The unlexer 'unlexgreek'
-- de-normalizes corresponding acute accents to grave accents etc. See 'help ps'.

param
  Accent = Acute Position | Circum Position | NoAccent ;
  Syllability = Mono | Bi | Multi | Nil ;   -- Nil for endings without vowels
  Length = Zero | Short | Long ;

oper 
  Position : PType = Predef.Ints 3 ;        -- 1,2,3 as 3rd last, 2nd last, last (!)

  Word = { s : Syllability ;                -- number of end syllables
           v : Str * Str * Str ;            -- last three end vowels/diphthongs
           l : Length * Length * Length ;   -- length of these vowels/diphthongs
           c : Str * Str * Str * Str ;      -- consonants in between 
           a : Accent                       -- (length for accents =/= vowelLength)
         } ;

  -- Admissible accentuations in greek words (except atona and enclitica) are those 
  -- where the accent is on one of the three final vowels/diphthongs as follows, 
  -- using A=Acute, C=Circumflex, N=NoAccent for accent kinds and L=Long, S=Short
  -- for vowel lengths:
  --
  --      3rd last vowel    2nd last vowel    last vowel 
  --        A    N   N        N   A   N       N    N    A   
  --       L|S  L|S  S       L|S  S  L|S     L|S  L|S  L|S
  --                         L|S  L   L
  --
  --                          N   C   N       N    N   C
  --                         L|S  L   S      L|S  L|S  L   
  --
  
  -- All the mkWord functions taking a string by the lexicon writer ought to check accents:

  checkAccent : Word -> Word = \w -> case <w.a, w.v.p2, w.v.p3> of { 
    <Circum 3, _, y@#shortV> => Predef.error ("Accent ~ on short vowel in: " ++ (toStr0 w)) ;
    <Circum 2, x@#shortV, y> => Predef.error ("Accent ~ on short vowel in: " ++ (toStr0 w)) ;
    <Circum 2, _, y@#longV>  => Predef.error ("Accent ~ needs short endvowel in:" ++ (toStr0 w)) ;
    <Circum 1, _, y>         => Predef.error ("Accent too far left in: " ++ (toStr0 w)) ;
    <Acute 1, _, y@#longV>   => Predef.error ("Accent too far left in: " ++ (toStr0 w)) ;
    _                        => case w.c.p1 of { _ + #PhonoGrc.accent + _ => 
                                  Predef.error ("Accent too far left in: " ++ (toStr0 w)) ;
                                  _ => w }
  } ;

  -- The mkWord functions should not expect aspiration at initial r and special sigma at the end,
  -- while the inflection functions should; hence canonize the strings in time:

  canonize : Str -> Str = \RhodoS ->
        -- after initial r, insert missing "(" 
        -- after final s,   insert missing *  (but keep vowel length indicators . and _! )
        case RhodoS of { 
                        "r(" + stm + ("s"|"s*") => "r(" + stm + "s*" ;
                        "r"  + stm + ("s"|"s*") => "r(" + stm + "s*" ;   
                        "r(" + stm              => "r(" + stm ; 
                        "r"  + stm              => "r(" + stm ;  
                        stm + "s"               => stm + "s*" ;
                        _                       => RhodoS } ;

  -- Convert a string into a structured word: toWord : Str -> Word

  vowelLength : Str -> Length = \str -> 
    case str of {
                  (#diphthong | #longV) + (#aspirate | "") => Long ;
                  (#shortV | #restV) + (#aspirate | "")    => Short ;  
                  _                                        => Zero 
                } ;

  -- accent ~ can only be on long vowels, hence y~ must be Long etc:

  vowelLength2 : Str -> Str -> Length = \o,z -> 
     case o of { (#shortV|#restV) => case z of {"~"+_ => Long ; _ => vowelLength o} ;
                 _                => vowelLength o } ;

  toAccent : (Str * Str * Str) -> Accent = \ss -> 
     case ss of { -- we don't check for double accent; the leftmost accent counts
     -- 3 syllables
     <("'"|"('"|")'") + _ , _            , _      >  => Acute 1 ;
     <("~"|"(~"|")~") + _ , _            , _      >  => Circum 1 ;
     <                  _ , "'" + _      , _      >  => Acute 2 ;
     <                  _ , "~" + _      , _      >  => Circum 2 ;
     <                  _ , _            , "'" + _>  => Acute 3 ;
     <                  _ , _            , "~" + _>  => Circum 3 ;
     -- 2 syllables
     <""           , ("'"|"('"|")'") + _ , _      >  => Acute 2 ;
     <""           , ("~"|"(~"|")~") + _ , _      >  => Circum 2 ;  
     <""           , _                   , "'" + _>  => Acute 3 ;  
     <""           , _                   , "~" + _>  => Circum 3 ;  
     -- 1 syllable
     <""           , ""      , ("'"|"('"|")'") + _>  => Acute 3 ;
     <""           , ""      , ("~"|"(~"|")~") + _>  => Circum 3 ;
     <""           , ""      , -(_ + ("'" | "~" | "`") + _)> => NoAccent ;
     _ => NoAccent  -- Predef.error
  } ;

-- The order of the patterns in the pattern alternatives is important since 
-- diphthongs match against vowel+vowel, and short vowels.
-- (Here "ai", "oi" count as long; for end syllables, this is adjusted in addAccent.)

  toWord : Str -> Word = \str ->      -- TODO: treat initial capitals appropriately
     let 
         da = dropAccent 
     in 
     case str of { 
     -- non-words: endings consisting of consonants only: 
          z@#nonvowels 
     => { s = Nil ;  
          v = <[], [], []> ; 
          l = <Zero, Zero, Zero> ; 
          a = toAccent <[], [], z> ; 
          c = <[] , [] , [] , da z>
        } ;
     -- monosyllabic words:
          y@(("r(" | "" | "R(" | #consonantCap) + #nonvowels)
        + o@((#diphthong | #longV | #shortV | #restV |
              #diphthongCap | #longVCap | #shortVCap | #restVCap) + (#aspirate | "")) 
        + z@#nonvowels 
     => { s = Mono ;  
          v = <[], [], o> ; 
          l = <Zero, Zero, vowelLength2 o z> ; 
          a = toAccent <[], [], z> ; 
          c = <[] , [] , y , da z>
        } ;
     -- bisyllabic words:
         x@(("r(" | "" | "R(" | #consonantCap) + #nonvowels)
       + e@((#diphthong | #longV | #shortV | #restV |
              #diphthongCap | #longVCap | #shortVCap | #restVCap) + (#aspirate | "")) 
       + y@#nonvowels 
       + o@(#diphthong | #longV | #shortV | #restV) 
       + z@#nonvowels
     => { s = Bi ;  
          v = <[] , e, o> ; 
          l = <Zero , vowelLength2 e y, vowelLength2 o z> ; 
          a = toAccent <[], y, z> ; 
          c = <[] , x , da y , da z>
        } ;
     -- manysyllabic words:
         r@_ 
       + a@((#diphthong | #longV | #shortV | #restV |
              #diphthongCap | #longVCap | #shortVCap | #restVCap) + (#aspirate | "")) 
       + x@#nonvowels 
       + e@(#diphthong | #longV | #shortV | #restV) 
       + y@#nonvowels 
       + o@(#diphthong | #longV | #shortV | #restV) 
       + z@#nonvowels  
     => { s = Multi ;  
          v = <a, e, o> ;
          l = <vowelLength2 a x, vowelLength2 e y, vowelLength2 o z> ;
          a = toAccent <x, y, z> ;
          c = <r , da x , da y , da z>
        } ;
     -- _ => Predef.error ("vowel/accent pattern not recognized in: " ++ str)
     _ => { s = Multi ;  
          v = <"U",[],[]> ;
          l = <Zero, Short, Zero> ;
          a = NoAccent ;
          c = <"B", "G:", str , ".">
        } 
     } ;
           
-- Add an accent to an unaccentuated string; includes necessary accent changes and shifts
-- (We don't check that the given string has enough vowels (only for Acute 2).)

  addAccent0 : Accent -> Str -> Str = \accent,str -> str ;  -- for testing

  -- addAccent inserts the given accent = (accnt pos) to the vowel at the position,
  -- and when pos=1=(3rd last) and last vowel is short, puts the accent to 2nd last:
  addAccent : Accent -> Str -> Str = \accent,str ->   -- still used for adjectives!
    let 
         w = toWord str ; -- TOO EXPENSIVE: a lot of repeated work! 
        v1 = w.v.p1 ;  -- third last vowel
        v2 = w.v.p2 ;  -- second last vowel
        v3 = w.v.p3 ;  -- last vowel
        dropLength : Str -> Str = \s -> s ;  -- keep length indicators in the paradims for testing
        v1s = dropLength v1 ;
        v2s = dropLength v2 ;
        v3s = dropLength v3 ;
    in
       case accent of {
         Acute 3  => merge w.c <v1, v2, v3s + "'"> ;
         Circum 3 => merge w.c <v1, v2, v3s + "~"> ;
         Acute 2  => case w.s of { 
                       Mono => merge w.c <v1,v2,v3+"'"> ;
                       _    => case <w.l.p2, w.l.p3> of {                   -- BR 9 4
                                <Long, Short> => merge w.c <v1, v2s + "~", v3> ; 
                                _             => merge w.c <v1, v2s + "'", v3> 
                                } 
                     } ;
         Circum 2 => merge w.c <v1, v2s + "~", v3> ; -- change to ' for v2 short?
         Acute 1  => case <w.l.p3, w.c.p4> of {                       -- (BR 29.7: declension only)
                       <Short, _> => merge w.c <v1s + "'", v2, v3> ;  -- BR 9 1.b 
                       _          => merge w.c <v1, v2s + "'", v3>    -- sometimes "~" needed?
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

  merge : (Str * Str * Str * Str) -> (Str * Str * Str) -> Str = 
           \cs,vs -> cs.p1 + vs.p1 + cs.p2 + vs.p2 + cs.p3 + vs.p3 + cs.p4 ;

-- gf-3.2, obsolete by 3.2.8(?):
-- Due to the 5 splitting points, this is too slow when the string is long.
-- A verb contains 12 adjectives (as participles; plus 2 verbal adjectives),
-- an adjective consists of 3 nouns, a noun has 15 forms, hence:
-- if accentuation in noun3 is done with addAccent/toWord, it costs
-- 12x3x15 = 500 calls of toWord, so a verb needs 500x100ms = 50s for its 
-- participles!
-- In contrast, merge cs vs costs 0msec even for long strings. 
-- So we should replace addAccent : Accent -> Str -> Str by something like
--   addAccent : Acccent -> Word * Word -> Str, i.e. remember the Word of the
-- stem form, calculate the Word of the ending, and then merge pieces. This still 
-- calls toWord on each ending, but that could be done once for each ending table.

-- ===================================================================================
-- Make addAccent faster by using the stem pattern rather than the strings: 
-- 8/11 (Barcelona)

  -- General accent rules (we turn ~ into ' if it is put on a short vowel, 
  --                       and ' to ~ if it is put where only ~ is allowed):
  -- Raises an error if there are not enough syllables. 

  addAccentW : Accent -> Word -> Str = \accent, w ->
    let 
        v1 = w.v.p1 ;  -- third last vowel
        v2 = w.v.p2 ;  -- second last vowel
        v3 = w.v.p3 ;  -- last vowel
        l2 = w.l.p2 ;  -- length of second last vowel
        l3 = w.l.p3 ;  -- length of last vowel
    in
       case accent of {
         Acute 3  => merge w.c <v1, v2, v3 + "'"> ;
         Circum 3 => case l3 of { Long  => merge w.c <v1, v2, v3 + "~"> ;
                                  _     => merge w.c <v1, v2, v3 + "'"> } ;
         Acute 2  => case w.s of { 
                       Mono => Predef.error ("Accent needs bisyllabic word: " 
                                             ++ (merge w.c w.v)) ;
                               -- merge w.c <v1, v2, v3 + "'"> ;
                       _    => case <l2, l3> of {                   -- BR 9 4
                                <Long, Short> => merge w.c <v1, v2 + "~", v3> ; 
                                _             => merge w.c <v1, v2 + "'", v3> } 
                     } ;
         Circum 2 => case w.s of { 
                       Mono => Predef.error ("Accent needs bisyllabic word: " 
                                              ++ (merge w.c w.v)) ;
                       _    => case l3 of { Short => merge w.c <v1, v2 + "~", v3> ; 
                                            _     => merge w.c <v1, v2 + "'", v3> } 
                     } ; 
         Acute 1  => case w.s of {
              Multi => case l3 of { -- BR 9 1.b (BR 29.7: declension only)
                         Short => merge w.c <v1 + "'", v2, v3> ;  
                         _     => merge w.c <v1, v2 + "'", v3>    -- sometimes "~" ?
                       } ;
              _     => Predef.error ("Accent needs multisyllabic word: " 
                                      ++ (merge w.c w.v))
              } ;
         NoAccent => merge w.c w.v ;
         _ => toStr0 w -- Predef.error ("Illegal accentuation for " ++ (merge w.c w.v))
    } ;

  -- Convert a Word (or Ending) back to a string: toStr 

  toStrW : Word    -> Str = \w -> addAccentW w.a w ;  -- enforce accent rules
  toStrE : NEnding -> Str = \e -> e.c.p1 
                                  + e.v + case e.a of {Acute 3 => "'" ; 
                                                       Circum 3 => "~" ; _ => ""}
                                  + e.c.p2 ;

  toStr = overload {
     toStr : Word -> Str    = toStrW ;
     toStr : NEnding -> Str = toStrE 
  } ;
  toStr0 : Word -> Str = \w -> let v : Str * Str * Str = 
                                   case w.a of { Acute 3  => <w.v.p1,w.v.p2,w.v.p3+"'"> ;
                                                 Acute 2  => <w.v.p1,w.v.p2+"'",w.v.p3> ;
                                                 Acute 1  => <w.v.p1+"'",w.v.p2,w.v.p3> ;
                                                 Circum 3 => <w.v.p1,w.v.p2,w.v.p3+"~"> ;
                                                 Circum 2 => <w.v.p1,w.v.p2+"~",w.v.p3> ;
                                                 Circum 1 => <w.v.p1+"~",w.v.p2,w.v.p3> ;
                                                 _        => w.v }
                               in merge w.c v ;
  -- for testing, show accent and indicate splitting points by a dash:
  toStrT : Word -> Str = \w -> let v : Str * Str * Str = 
                                   case w.a of { Acute 3  => <w.v.p1,w.v.p2,w.v.p3+"'"> ;
                                                 Acute 2  => <w.v.p1,w.v.p2+"'",w.v.p3> ;
                                                 Acute 1  => <w.v.p1+"'",w.v.p2,w.v.p3> ;
                                                 Circum 3 => <w.v.p1,w.v.p2,w.v.p3+"~"> ;
                                                 Circum 2 => <w.v.p1,w.v.p2+"~",w.v.p3> ;
                                                 _        => w.v }
                               in
                               w.c.p1 +"-"+ v.p1 +"-"+ 
                               w.c.p2 +"-"+ v.p2 +"-"+ 
                               w.c.p3 +"-"+ v.p3 +"-"+ w.c.p4 ;

-- The following may be too general in that Endings are simpler than Words; special case 
-- for nouns with NEnding is treated below; maybe use Ending to cover endings of verbs
-- as well, i.e. by composing Word+Ending = ...stem + end... where ... may be empty.

-- Aarne (Barcelona, 8/2011) : ending : Word -> Word
--        wordcat  : { s : params => Word } , 
--        decl     : Number -> Case -> (Word -> Word)
--        soundlaw : Str -> Str (resp. Str * Str -> Str)
-- type Soundlaw = (Word * Word -> Word * Word), so that
--      contractV, dropS : Soundlaw => contractVowels o dropS : Soundlaw

--(a) Analyse full-form to a Word, and check if the user-provided string satisfies 
--    the accent rules (or should we separate an ending?)
--    toWord : Str -> Word  (or toWords : Str -> Word * Word)
--
--(b) Chop an ending from a full-form:
--    chop : Str -> Word * Word  resp.  chop : Word -> Str -> Word
--
--    Problem: do the accent laws allow us to just change the accent position by the
--             number of syllables of the removed ending? I.e. not change the accent type?

--(c) Combine stem with ending, perhaps with soundlaw as a parameter:

--    Assume in (compose w1 w2) that the general accent rules hold for w1,w2:Word
--    (whence we need not check if ~ stands on a long vowel).
--    If w2 (i.e. the ending to be added to w1), has an accent, use that for w1+w2.
--    Else give w1+w2 the accent position of w1 adjusted by |syllables w2|, and
--    enforce the general accent rule for w1+w2 (by shifting and changing the accent).

   compose : Word -> Word -> Word = \e,w -> case e.s of 
                { Nil  => { s = w.s ; a = w.a ; 
                            c = <w.c.p1,w.c.p2,w.c.p3,w.c.p4 + e.c.p4> ;
                            v = w.v ; l = w.l } ;                        
                  Mono => { s = addSyl w.s e.s ;
                            a = case e.a of { 
                                  NoAccent => let a' = toLeft ! w.a in
                                     case <a', w.l.p3, e.l.p3> of { 
                                       <Acute 1, _,Long>    => Acute 2 ;  -- BR 9 1.b
                                       <Circum 1, _,_>      => Predef.error -- BR 9 3.
                                         ("Accent ~ on 3rd last syllable in: " 
                                          ++ (toStr w + toStr e)) ;
                                       <Acute 2,Long,Short> => Circum 2 ; -- BR 9 4.
                                       _                    => a' 
                                     } ;
                                  _        => e.a 
                                } ;
                            c = <w.c.p1 + w.v.p1 + w.c.p2, w.c.p3, w.c.p4 + e.c.p3, e.c.p4> ;
                            v = <w.v.p2, w.v.p3, e.v.p3> ;
                            l = <w.l.p2, w.l.p3, e.l.p3> ;
                          } ;
                  Bi   => { s = addSyl w.s e.s ;
                            a = case e.a of { 
                                  NoAccent => let a' = toLeft ! (toLeft ! w.a) in
                                     case <a', w.l.p3, e.l.p3> of { 
                                       <Acute 1, _,Long>    => Acute 2 ;  -- BR 9 1.b
                                       <Circum 1, _,_>      => Predef.error -- BR 9 3.
                                         ("Accent ~ on 3rd last syllable in: " 
                                          ++ (toStr w + toStr e)) ;
                                       <Acute 2,Long,Short> => Circum 2 ; -- BR 9 4.
                                       _                    => a' 
                                     } ;
                                  _        => e.a 
                                } ;
                            c = <w.c.p1+w.v.p1+w.c.p2+w.v.p2+w.c.p3, 
                                 w.c.p4 + e.c.p2, e.c.p3, e.c.p4> ;
                            v = <w.v.p3, e.v.p2, e.v.p3> ;
                            l = <w.l.p3, e.l.p2, e.l.p3> ;
                          } ;
                  Multi=> { s = addSyl w.s e.s ;  -- endings without accent are =<3-syllabic
                            a = case e.a of { NoAccent => Predef.error 
                                                           ("accent error in: " ++ (toStr w)) ;
                                                     _ => e.a } ;
                            c = <w.c.p1+w.v.p1 + w.c.p2+w.v.p2 + w.c.p3+w.v.p3 + w.c.p4+e.c.p1, 
                                 e.c.p2, e.c.p3, e.c.p4> ;
                            v = <e.v.p1, e.v.p2, e.v.p3> ;
                            l = <e.l.p1, e.l.p2, e.l.p3> ;
                          } 
                } ; 

  addSyl : Syllability -> Syllability -> Syllability = \s1,s2 -> 
     case <s1,s2> of { <Nil, _>    => Predef.error "Stem without vowel" ;
                       <_, Nil>    => s1 ; 
                       <Mono,Mono> => Bi ; 
                       _           => Multi } ;

  -- to change accent description when an ending is cut off: 
  -- (but who remembers the ending's vowellengths?)
  toLeft : Accent => Accent = -- keeps accent type regardless of vowel lengths
     \\a => case a of { Acute 3 => Acute 2 ; Circum 3 => Circum 2 ;
                       Acute 2 => Acute 1 ; Circum 2 => Circum 1 ; 
                       NoAccent => NoAccent ;
                       _ => a 
--                       _        => Predef.error "Left accent shift impossible"
                     } ; 
  toRight : Accent -> Accent = -- keeps accent type regardless of vowel lengths
     \a -> case a of { Acute 2 => Acute 3 ; Circum 2 => Circum 3 ;
                       Acute 1 => Acute 2 ; Circum 1 => Circum 2 ; 
                       NoAccent => NoAccent ;
                       _ => a 
--                       _        => Predef.error "Right accent shift impossible"
                     } ; 

--  ending : Number -> Case -> Gender -> (Word -> Word) = 
--    \n,c,g -> \w -> (compose (toWord (endingsN3!n!c!g!w.s)) w) ;

-- ===================================================================================

-- $Phon$ology: sound laws 

  Soundlaw = (Word * NEnding) -> (Word * NEnding) ;

  -- A Soundlaw ought to adjust accent and syllability in the stem, if a vowel 
  -- is added/dropped/changed in length, so that soundlaws can be combined.

  -- We want to admit
  --(a) (soundlaws o adjustAccent) : Word * NEnding -> Word * NEnding, and
  --(b) (adjustAccent o soundlaws) : Word * NEnding -> Word * NEnding
  --
  --(a) When combining stem+ending, an accent in the stem may have to be changed, depending 
  --    on the length of the vowel in the ending: (this may be followed by a soundlaw)
  --    Expl: cc toStrT (adjustAccent <toWord "ge'ne", toNEnding "wn">).p1 => "--g-e-n-e'-"
  --(b) 

  adjustAccent : Soundlaw = \we ->  -- move and change accent in S, if needed when adding E
     let S = we.p1 ; E = we.p2 ;    -- according to accent rules for S+E (count pos as in S)
      in case <E.l,E.a> of {        -- (does not change E at all).
           <_, Acute 3>     => <{a = NoAccent ; v = S.v ; c = S.c ; l = S.l ; s = S.s}, E> ;
           <_,Circum 3>     => <{a = NoAccent ; v = S.v ; c = S.c ; l = S.l ; s = S.s}, E> ;
           <Long,NoAccent>  => <{a = case S.a of { Acute 2 | Acute 3 | Circum 3 => Acute 3 ; 
                                                   _ => Predef.error "Accent too far left" } ; 
           -- Predef-Problems!!
                                 v = S.v ; c = S.c ; l = S.l ; s = S.s}, E> ; 
           <Short,NoAccent> => <{a = case S.a of {
                                       Acute 2 => S.a ;
                                       Acute 3 => case S.l.p3 of { Long => Circum 3 ;
                                                                   _    => Acute 3 } ;
                                     -- Predef.error "Accent error 1 (should not occur)" 
                                             _ => S.a 
                                     } ;
                                 v = S.v ; c = S.c ; l = S.l ; s = S.s}, E> ; 
                          _ => <S,E> 
      } ;                                          

  -- Concat stem and ending: 
  -- If the ending has no vowel, append its consonants to the stem's end consonants
  -- and adjust the accent in the stem (which alone need not obey the accent rules).
  -- Otherwise, if the ending has an accent, ignore that of the stem, if not, use 
  -- the accent of the stem part, and in both cases combine the s,v,l,c components
  -- modulo the length of the ending's vowel:

  concat : (Word * NEnding) -> Word = 
    \we -> let w = we.p1 ; e = we.p2 
            in case e.l of { -- 
                 Zero => { s = w.s ; 
                           v = w.v ; l = w.l ; 
                           c = <w.c.p1, w.c.p2, w.c.p3, w.c.p4 + e.c.p1 + e.c.p2> ; 
                           a = case e.a of { 
                                 NoAccent => case <w.l.p2,w.l.p3,w.a> of { 
                                               <Long,Short,Acute 2> => Circum 2 ; _ => w.a } ;
                                 _ => e.a } -- end accent after contracting vowel with stem
                         } ;
                 _    => { s = case w.s of { Mono => Bi ; _ => Multi } ;  
                           v = <w.v.p2, w.v.p3, e.v> ;
                           l = <w.l.p2, w.l.p3, e.l> ;
                           c = <w.c.p1 + w.v.p1 + w.c.p2, w.c.p3, w.c.p4 + e.c.p1, e.c.p2> ; 
                           a = case e.a of { 
                                 NoAccent => case w.a of { Acute 3 => Acute 2 ; 
                                                           Circum 3 => Circum 2 ; 
                                                           Acute 2 => Acute 1 ;
                                                           -- _ => Predef.error "concat: Accent error 2" 
                                                           _ => w.a 
                                                         } ; 
                                        _ => e.a }
                         }
               } ;
  concatT : (Word * NEnding) -> Str = \we -> toStrT (concat we) ;

  -- Specification of soundlaws as operations on split strings (see PhonoGrc.gf)

  soundlaw = (Str*Str) -> (Str*Str) ;  

  nC2 : soundlaw = nasalConsonant ; 
  mC2 : soundlaw = mutaConsonant ; 
  nSV2 : soundlaw = nasalSVowel ;   -- (including ersatzdehnung)
  glS2 : soundlaw = gutlabS ;
  dS2 : soundlaw = dropS ;
  ntS2 : soundlaw = 
    \xy -> case xy of {
            <x + v@#vowel +a@(#accent|"") + "nt", "s" + y>   -- BR 20 2. 46 1. 45 2.
                     => <x + ersatzdehnung(v) + a,"s" + y> ; 
            <x + v@#vowel +a@(#accent|"") + "n",  "s" + y>   -- BR 20 3. 45 2. 
                     => <x + v + a,               "s" + y> ; -- (sometimes: ersatzdehnung)
             _       => mC2 (mC2 xy) } ;      -- nykt+si > nyk+si > nyx+i BR 44 1.+4. 

  -- without accents; with accents in cV below !!! 
  cV2 : soundlaw = \xy -> let x : Str = case xy.p1 of {x+#accent => x ; x => x}
                           in contractVowels <x, xy.p2> ; 

  eV2 : soundlaw = ersatzdehnung ;  -- not keeping the accent as it was 

  -- Raise a soundlaw specification (sl : Str*Sr -> Str*Str) to structured words 
  -- and endings, SL : Word*Ending -> Word*Ending.
  -- We can then compose soundlaws (with appropriat accent handling!), use ad-hoc 
  -- ones in a paradigm, and do not restrict the specifications sl : soundlaw. 

  -- We do the transformation in the brute force way of converting we : Word*NEnding 
  -- <w,e>:Str*Str, apply the sl:soundlaw to <w,e>, and convert the resulting strings
  -- to we' : Word*NEnding. This converts very often, but with gf-3.2.8 may work fine. 

  -- TODO: Care for efficiency later, if needed. Writing an efficent transformation 
  -- in terms of operations on Word and NEndings is cumbersome, due to the counting 
  -- and possibly empty fields in the tuples (lists would be better). And only such 
  -- sl's could be treated this way whose pairs <str1,str2> fit to the data structure 
  -- Word*NEnding = <<c1,v1,c2,v2,c3,v3,c4>,<c1,v,c2>>, and we had to check if all 
  -- or just part of a field cj is given in <str1,str2>. 

  toSL : soundlaw -> Soundlaw =                -- toStr0 to not apply accent rules:
       \sl -> \we ->                                       -- sw'mat+si > sw'ma+si
       let se = sl <toStr0 we.p1, toStr we.p2>             -- not sw~mat+si > ...
        in adjustAccent <toWord se.p1, toNEnding se.p2> ;  

  -- This works for sound laws that only change consonants and don't affect the
  -- number and lengths of end vowels (like nasalConsonant: n+k > gk). 

  -- The following toSL' treats the accent on the final syllable (BR 15 2.), if a vowel
  -- contraction applies at the final two vowels, and by adjustAccent it does the
  -- accent shift/change that is needed if the accent was farer left. 
  -- In noun declension, the vowel contraction constructs a long end syllable, so this 
  -- seems ok. 

  toSL' : soundlaw -> Soundlaw =
       \sl -> \we ->
       let we' = sl <toStr0 we.p1,toStr we.p2> ;  
           w = toWord we'.p1 ;                  -- turn the pieces into structured data
           e = toNEnding we'.p2 
        in case <we.p1.a, we.p2.a> of {         -- BR 15 2. (TODO in case2: check e.l =/= Zero ?)
                <_ , Acute 3 | Circum 3> => <w, { a = Acute 3 ; v = e.v ; l = e.l ; c = e.c }> ;
                <Acute 3 | Circum 3, _ > => <w, { a = Circum 3 ; v = e.v ; l = e.l ; c = e.c }> ;
                _                        => adjustAccent <w, e> 
       } ;  

  -- Soundlaw cV reduces the number of syllables, others don't. Hence: can we have 
  -- the accent right in both cases, (if it is not on one of the involved syllables)? 

  -- (a) consonant changes like mutaConsonant, nasalConsonant, liquidaConsonant
  --     which use <cs+c,c+cs> -> <cs+c',c'+cs>
  -- (b) consonant dropping with ersatzdehnung <v,c+cs> -> <V,cs>
  -- (c) vowel contraction <v,v'> -> <0,V> | <V,0>
  -- (d) vowel stretching or shortening <V,0> -> <v,0> or <0,v> -> <0,V> etc.

  nC  : Soundlaw = toSL nC2 ;  -- nasalConsonant 
  mC  : Soundlaw = toSL mC2 ;  -- mutaConsonant 
  glS : Soundlaw = toSL glS2 ; -- gutlabS: guttural+s > 0+x, labial+s > 0+q  
  dS  : Soundlaw = toSL dS2 ;  -- dropSigma between vowels
  nSV : Soundlaw = toSL nSV2 ; -- nasalSVowel   -- TODO: ersatzdehnung may change accent 
  cV  : Soundlaw = toSL' cV2 ; -- vowel contraction with accent handling (omitted in cV2)
  eV  : Soundlaw = toSL eV2 ;  -- ersatzdehnung: vcs+y > Vcs+y: (adjust accents later?)
  --  cVdS : Soundlaw = \we -> cV (dS we) ;
  cVdS : Soundlaw = toSL' (\xy -> cV2 (dS2 xy)) ; -- does fewer conversions

  -- TODO: cover further sound laws, in particular those that change vowel lengths and 
  --       hence have an impact on accentuation
  -- sV : Soundlaw = ... shortenVowel
  -- lV : Soundlaw = ... lengthenVowel
  -- dC : drop consonants c=/=sigma between vowels <v,c+cs> -> <ersatzdehung(v),cs>

  -- So far, the soundlaws are applied in noun3s, noun3LGL, noun3DenN, 19.9.2011
  -- but ought to be used more often. (Cleaner, though somewhat slower code.)

-- ===================================================================================

oper
  artDef : Gender => Number => Case => Str = table {
    Masc => table { Sg => table Case ["o("  ; "to'n"   ; "toy~"  ; "tw|~"   ; "w)~" ] ;
                    Pl => table Case ["oi(" ; "toy's*" ; "tw~n"  ; "toi~s*" ; "oi(" ] ;
                    Dl => table Case ["tw'" ; "tw'"    ; "toi~n" ; "toi~n"  ; "w'"  ] } ;
    Fem  => table { Sg => table Case ["h("  ; "th'n"   ; "th~s*" ; "th|~"   ; "w)~" ] ;
                    Pl => table Case ["ai(" ; "ta's*"  ; "tw~n"  ; "tai~s*" ; "ai(" ] ;
                    Dl => table Case ["tw'" ; "tw'"    ; "toi~n" ; "toi~n"  ; "w'"  ] } ;
    Neutr => table{ Sg => table Case ["to'" ; "to'"    ; "toy~"  ; "tw|~"   ; "w)~" ] ;
                    Pl => table Case ["ta'" ; "ta'"    ; "tw~n"  ; "toi~s*" ; "oi(" ] ;
                    Dl => table Case ["tw'" ; "tw'"    ; "toi~n" ; "toi~n"  ; "w'"  ] } 
    } ;


--2 For $Noun$ 

param 
  Gender = Masc | Fem | Neutr ;
  Case = Nom | Acc | Gen | Dat | Voc ;       
  Number = Sg | Pl | Dl ;     -- Greek has an additional number, the dual.

oper
  Noun       : Type = {s : Number => Case => Str ; g : Gender} ;
  ProperNoun : Type = {s : Case => Str ; g : Gender ; n : Number} ; 

  -- Agreement of $NP$ has three parts.

param
  Agr = Ag Gender Number Person ;   -- BR 257: also Case, for AcI, AcP

oper
  mkAgr : {g : Gender ; n : Number ; p : Person} -> Agr = \r ->
      Ag r.g r.n r.p ;
  genderAgr : Agr -> Gender = \r -> case r of {Ag g _ _ => g} ;
  numberAgr : Agr -> Number = \r -> case r of {Ag _ n _ => n} ;
  personAgr : Agr -> Person = \r -> case r of {Ag _ _ p => p} ;

  agrP3 : Number -> Agr = agrgP3 Neutr ;

  agrgP3 : Gender -> Number -> Agr = \g,n -> Ag g n P3 ;

  conjAgr : Agr -> Agr -> Agr = \a,b -> 
    let conjNumber : Number -> Number -> Number =
          \n,m -> case n of { Sg => m ; _ => Pl } ; 
        conjPerson : Person -> Person -> Person =
          \_p,q -> q 
    in mkAgr { -- ConjunctionGrc.gf
      g = Neutr ; -- irrelevant ? 
      n = conjNumber (numberAgr a) (numberAgr b) ;
      p = conjPerson (personAgr a) (personAgr b)
    } ;

  -- Vowel length indicators in strings:
  -- TODO: make all paradigm functions work (better!) with length indicators! 

  -- don't drop any length indication: 
  dL0 : Str -> Str = \s -> s ;
  -- drop the first matched length indicator (as there are no recursive opers, 
  -- we can't remove several indicators in a string!):
  dL1 : Str -> Str = \s -> case s of { x+("_"|".")+y => x+y ; _ => s } ; 
  -- drop the length indicator that is followed by an accent or iota subscript 
  -- i.e. just the one that is missing in the unicode for ancient greek:
  dL2: Str -> Str = \s -> case s of { x+("_"|".")+a@(#accent|"|") + y => x+a+y ; _ => s } ; 
  -- drop the first length indicator that is followed by an accent or iota 
  -- subscript or any other character, or none:
  dL3 : Str -> Str = \s -> case s of { x+("_"|".")+a@(#accent|"|"|"") + y => x+a+y ; _ => s } ; 
  -- dropping function used in the output of paradigm constructors:
  dL : Str -> Str = \s -> dL3 (dL3 s) ; -- remove up to 2 vowel length indications
  -- for testing (and learning), dL = dL0 or dL1 may be useful
--  dL = dL0 ;  -- Paradigms with vowel length indications, but: a_| has no glyph

  -- Noun paradigms, worst case: provide 6 singular, 4 plural, and 2 dual forms

  mkNoun : (n1,_,_,_,_,_,_,_,_,_,n11 : Str) -> Gender -> Noun = 
    \sn,sg,sd,sa,sv,pn,pg,pd,pa,dn,dg , g -> {
    s = table {
      Sg => table {
        Nom => dL sn ;
        Gen => dL sg ;
        Dat => dL sd ;
        Acc => dL sa ;
        Voc => dL sv
        } ;
      Pl => table {
        Nom | Voc => dL pn ;
        Gen => dL pg ;
        Dat => dL pd ;
        Acc => dL pa 
      } ;
      Dl => table {
        Nom | Acc | Voc => dL dn ;
        Gen | Dat => dL dg 
      }};
    g = g
    } ;

  mkProperNoun : (n1,_,_,_,n5 : Str) -> Gender -> Number -> ProperNoun = 
    \nom,gen,dat,acc,voc,g,n -> 
    { s = table{ Nom => nom ; Acc => acc ; Gen => gen ; Dat => dat ; Voc => voc } ;
      g = g ;
      n = n } ;      

  -- declensions (should probably go to Morpho or Paradigms)

{- Redesign: (used in noun declension III) -----------------------------------------

   Extract the patterns of vowel lengths and accent position and do the paradigms 
   with less pattern matching. But the soundlaws ...

  Forms: general rules for all declensions (BR 29 3.+7.)
  -- PlVoc = PlNom, often SgVoc=SgNom 
  -- Sg(Nom|Acc|Voc)Neutr = SgNomNeutr, 
  -- Pl(Nom|Acc|Voc)Neutr = PlNomNeutr with ending a. (resp. contraction to a_ or h)

  Accents:
   1. the accent position is taken from SgNom, and only moved on demand.
   2. a shift is demanded if a an ending with a long vowel is added and 
      the accent position is on the 3rd last vowel; PlNom-endings -ai and 
      -oi count as short (differing from their vowel length).
   3. if an ending with accent is added, the accent in the stem has to be dropped.
   4. in (Sg|Pl|Dl)(Gen|Dat), accentuated endings which are long have Circumflex.
   Special rules hold for proper names, adjectives etc.

-- Declension I,II: Word`stock'+NomSgEnding => wordkind includes ending. 
     Then from lists of endings *without accent* one takes the accent position 
     from the user-provided form(s), and given the vowel length of the ending,
     determines the accent position of other forms
-- Declension III:  
     Wordstem+Ending (wordstem+os=GenSg) => NomSg may have empty ending
     Then the accent position is taken from the NomSg.

     Monosyllabic words have the accent in (Sg|Pl|Dl)(Gen|Dat) on the ending.
-}

-- (Old design, declension I and II only; faster, but less abstract)
-- Accent shift and accent change: the following functions are applied to 
-- the stem in certain cases:

--(a) when the Pl Gen ending w~n is added, the accent in the stem 
--    must be removed using dropAccent:

  dropAccent : Str -> Str = \str -> case str of { 
      x + ("'" | "`" | "~") + z => x + z ;
      x + "="               + z => x + "-" + z ;
      _                         => str 
    } ;

--(b) when the vowel of the ending is long an accent on the 3rd last 
--    syllable must be moved to the 2nd last:
--    - we see where the accent goes by demanding the SgGen -

--(c) when the vowel of the ending is short  (including Pl Nom ai and oi),
--    an accent over a long vowel or diphthong on the 2nd last syllable 
--    must be turned into a circumflex ~, using changeAccent:

  toCircumflex : Str -> Str = \str -> case str of {  
      x + v@("w"|"h"|"ey)") + "'" +y => x+v+"~"+y ;
      _ => str } ;

--    for the O-declension, the Sg Nom,Acc and Pl Nom have endings with short 
--    vowels os,on,oi,a while Sg Gen,Dat and Pl Acc have endings with long vowels
--    oy, w|, ous*, so the converse change has to be performed.

  toAcute : Str -> Str = \str -> case str of {
      x + v@("w"|"h") + "~" +y => x+v+"'"+y ;
      _ => str } ;

-- d) the accent in the stem must be moved to the next vowel to the right 
--    when an ending with a long vowel is added:

  shiftToAcute : Str -> Str = \str -> case str of {
      x + u@#vowel + #accent + y + v@#diphthong + z => x + u + y + v + "'" + z ;
      x + u@(#vowel+#aspirate) + #accent + y + v@#diphthong + z => x + u + y + v + "'" + z ;
      x + u@#vowel + #accent + y + v@#shortV + z => x + u + y + v + "'" + z ;
      x + u@(#vowel+#aspirate) + #accent + y + v@#shortV + z => x + u + y + v + "'" + z ;
--    x + u@#vowel + #accent + y + v@#longV  + z => x + u + y + v + "'" + z ;
      _ => str } ;

-- I. declension (A-declension)  (TODO: rename noun3X to reserve that for declension III)

-- For nouns ending in a or h, without accent, provide SgNom,SgGen,PlNom
-- in the worst case. From these we infer vowel changes and accent shifts. 

  noun3A : Str -> Str -> Str -> Noun = 
    \valatta, valatths, valattai ->  
    let valatt : Str = case valatta of { x + ("a_" | "h" | "a" | "a.") => x ; 
                         _ => Predef.error ("noun3A does not apply to " ++ valatta) } ;
        valatth : Str = case valatths of { x + "a_s*" => x+"a" ; 
                                      _ => Predef.tk 2 valatths } ; -- omit "s*" 
        valattPl : Str = case valatths of {     -- omit "hs*", "a_s*", "as*"
                     x + ("a_"|"h"|"a") + "s*" => x ; 
                     _ => Predef.error ("noun3A need SgGen -a_s*|-hs* in " ++ valatths) } ; 
    in 
    mkNoun valatta valatths (valatth + "|") (valatta + "n") valatta
           valattai (dropAccent valatt + "w~n") (valattPl + "ais*") (valattPl + "a_s*")
           (valattPl + "a_") (valattPl + "ain")   -- BR 74
           Fem ; 

-- PlNom is needed only because the short vowel ai of the ending may cause
-- an accent change on vowels a', i', y' if these are long - which cannot
-- be inferred:

  noun2A : Str -> Str -> Noun = 
    \valatta, valatths ->  
    let valatt : Str = case valatta of { x + ("a_" | "h" | "a" | "a.") => x ; 
                          _ => Predef.error ("noun2A does not apply to " ++ valatta) } ;
        valattai = toCircumflex (valatt + "ai")
    in noun3A valatta valatths valattai ; 

-- SgGen is needed only if an accent shift or a vowel change in the endings 
-- is needed (see noun : Str -> N).

-- For those nouns ending in a' or h', SgGen,SgDat,PlDat take a~ resp. h~:

  nounA' : Str -> Noun = \tima' ->  -- accent on the final (always long?) vowel 
    let                             -- other cases catched in noun
        acnt: Str = Predef.dp 1 tima' ;
        tim:Str = case tima' of { x + ("h" | "a_" | "a") + ("'"|"~") => x ; _ => tima' } ;
        A : Str = case tima' of { x + v@("h" | "a_" | "a") + ("'"|"~") => v ; _ => "BUG" } ; 
        a : Str = case A of { v + "_" => v ; _ => A } ;
    in 
    mkNoun tima' (tim + a + "~s*") (tim + a + "|~") (tim + A + acnt + "n") tima'
           (tim + "ai" + acnt) (tim + "w~n") (tim + "ai~s*") (tim + "a_" + acnt + "s*") 
           (tim + "a" + acnt) (tim + "ai~n")
           Fem ; 

-- Those nouns ending in as* or hs* are masculine and have SgGen ending in oy;
-- for those ending in ths* the vocative ends in a., whence the accent on a long 
-- vowel has to be changed to ~. If the accented vowel is among a,i,y, 
-- we need the PlNom to see if in SgVoc and PlNom the ' is to be ~:

  noun2As : Str -> Str -> Noun = \poli'ths, poliitai ->
    let
      { poli'th = Predef.tk 2 poli'ths ;
             n = noun2A poli'th poli'ths ;
        poli't = Predef.tk 1 poli'th ;
        poliit = Predef.tk 2 poliitai }
    in 
    { s = table { Sg => table { Nom => poli'ths ;
                                Gen => poli't + "oy" ; 
                                Voc => case poli'ths of 
                                          { x + "ths*" => poliit + "a" ; 
                                            _ => n.s ! Sg ! Voc } ;
                                c   => n.s ! Sg ! c } ;
                  Pl => table { Nom => poliitai ;
                                c   => n.s ! Pl ! c } ;
                  Dl => n.s ! Dl
                } ;
      g = Masc } ;

  nounAs : Str -> Noun = \neanias ->     -- reduce to noun2As ?
    let
      { neania = Predef.tk 2 neanias ;
             n = noun2A neania neanias ;
        neani = Predef.tk 1 neania }
    in 
    { s = table { Sg => table { Nom => neanias ;
                                Gen => neani + "oy" ; 
                                Voc => case neanias of 
                                          { x + "ths*" => toCircumflex neani + "a" ; 
                                            _ => n.s ! Sg ! Voc } ;
                                c   => n.s ! Sg ! c } ;
                  num => n.s ! num } ; 
      g = Masc } ;

-- Similarly for nouns ending in a's* or h's*, with the accent on the ending:

  nounA's : Str -> Noun = \dikasths ->
    let
        dikasth = Predef.tk 2 dikasths ;
             n = nounA' dikasth ; 
        dikast : Str = case dikasth of { x + ("a_" | "h" | "a") + "'" => x ; 
                                         _ => Predef.tk 1 dikasth } ;
    in 
    { s = table { Sg => table { Nom => dikasths ;
                                Gen => dikast + "oy~" ; 
                                Voc => case dikasths of 
                                          { x + "th's*" => toCircumflex dikast + "a'" ; 
                                            _ => n.s ! Sg ! Voc } ;
                                c   => n.s ! Sg ! c } ;
                  num => n.s ! num } ; 
      g = Masc } ;

-- Finally, there are the stems where a'a_ is contracted to a~ and e'a_ to h~:

  nounAa : Str -> Noun = \athnaa ->  -- ~ accent on the final vowel 
    let
      { athn = Predef.tk 2 athnaa ;
        a = Predef.tk 1 (Predef.dp 2 athnaa) 
      }
    in 
    mkNoun athnaa (athn + a + "~s*") (athn + a + "|~")  (athn + a + "~n") athnaa
           (athn + "ai~") (athn + "w~n") (athn + "ai~s*") (athn + "a~s*") 
           athnaa (athn + "ai~n")
           Fem ; 

  nounAas : Str -> Noun = \Ermhhs -> 
    let sing = (nounA's Ermhhs).s ! Sg ;
        Ermh = Predef.tk 3 Ermhhs ;
        Erm = Predef.tk 1 Ermh ;
        cV : Str -> Str = \str -> case str of { x+("e"|"h")+v@vowel => x+v ; _ => str }
    in 
    mkNoun (sing ! Nom) (cV (sing ! Gen)) (sing ! Dat) (sing ! Acc) (sing ! Voc)
           (cV (Ermh + "ai~")) (cV (Ermh + "w~n")) (cV (Ermh + "ai~s*")) (cV (Ermh + "a~s*"))
           (Erm + "a~") (Erm + "ai~n")  -- TODO: check the Dl Nom+Acc
           Masc ; 

{---- The inflection tables might be compacted using the indicators for 
---- vowel lengths, i.e. _ and . :
--
--   -- Bornemann/Risch, Par.32: in case we use vowel length annotations:
--   -- (unmarked a, i, y are short, diphthongs are long)
   
  nounA2 : Str -> Noun = \idea ->
     case idea of {
       ide + ("a_" | "h") =>             -- BR 32 1.b,c
           mkNoun idea (idea + "s*") (idea + "|")  (idea + "n") idea
           ((changeAccent ide) + "ai") (dropAccent ide + "w~n") (ide + "ais*") (ide + "a_s*") 
           (ide + "a") (ide + "ain")
           Fem ; 
       ide@(_ + ("e"|"i"|"r")) + "a" =>  -- BR 32 1.d
           mkNoun idea (idea + "s*") ((changeAccent idea) + "|")  (idea + "n") idea
           (changeAccent ide + "ai") (dropAccent ide + "w~n") (ide + "ais*") (ide + "a_s*") 
           (ide + "a") (ide + "ain")
           Fem ; 
       ide@(_ + #consonant) + "a" =>     -- BR 32 1.e
           mkNoun idea (ide + "h" + "s*") ((changeAccent ide) + "h|")  (idea + "n") idea
           (changeAccent ide + "ai") (dropAccent ide + "w~n") (ide + "ais*") (ide + "a_s*") 
           (ide + "a") (ide + "ain")
           Fem ;
       _ => Predef.error ("nounA2 does not apply to: "++ idea)
       } ;
changeAccent : Str -> Str = \str -> str ;

-- Redefine this using toWord/addAccent to make it uniform for all declensions!
--   changeAccent : Str -> Str = \str -> case str of { -- str without ending
--       -- accent on 3rd last syllable:
--       x + u@#longV + #accent + y + v@#shortV + z => x + u + y + v + "'" + z ;
--       x + u@#longV + #accent + y + v@#longV  + z => x + u + y + v + "~" + z ;
--       x + u@#longV + #acute  + y + v@#diphthong + z => x + u + y + v + "~" + z ;  -- ~ ??
--       x + u@#shortV + #acute + y + v@#longV + z  => x + u + y + v + "~" + z ;
--       -- else, if accent on 2nd last syllable:
--       x + u@#longV + #acute  + y => x + u + "~" + y ;  
--       _ => str } ;
-}

-- II declension (O-declension)

-- If the accent is on the ending, we only need the SgNom form and the gender:

  noun2O' : Str -> Gender -> Noun = -- BR 36
    \odo's, g ->  
    let 
        od : Str = case odo's of { x + ("o's*"|"o'n") => x ; 
                                   _ => Predef.error ("noun2O' does not apply to" ++ odo's) } ;
        sgVoc : Str = case odo's of { _+"o's*" => "e'"    ; _ => "o'n" } ;
        plNom : Str = case odo's of { _+"o's*" => "oi'"   ; _ => "a'"  } ;
        plAcc : Str = case odo's of { _+"o's*" => "oy's*" ; _ => "a'"  }
    in 
    mkNoun odo's (od + "oy~") (od + "w|~") (od + "o'n") (od + sgVoc)
           (od + plNom) (od + "w~n") (od + "oi~s*") (od + plAcc)
           (od + "w~") (od + "oi~n") g ;  -- TODO: check Dl forms

-- If the accent is not in the ending, we need the SgNom and SgGen forms, and the gender:

  noun3O : Str -> Str -> Gender -> Noun = -- BR 36
    \a'nvrwpos, anvrw'poy, g ->  
    let 
        a'nvrwpos = canonize a'nvrwpos ;
        anvrw'poy = canonize anvrw'poy ;
        anvrw'p = Predef.tk 2 anvrw'poy ;
        a'nvrwp : Str = case a'nvrwpos of { 
                    x + ("os*"|"on") => x ;
                                   _ => Predef.error ("noun3O does not apply to" ++ a'nvrwpos) 
                  } ;
        sgNom : Str = case a'nvrwpos of {_+ "os*" => "os*" ; _ => "on"} ;
        sgVoc : Str = case sgNom of {"os*" => "e"  ; _ => "on"} ;
        plNom : Str = case sgNom of {"os*" => "oi" ; _ => "a"} ;
        PlAcc : Str = case sgNom of {"os*" => anvrw'p+"oys*" ; -- long 
                                         _ => a'nvrwp+"a"}     -- short a
    in 
    mkNoun (a'nvrwp + sgNom) anvrw'poy (anvrw'p + "w|") (a'nvrwp + "on") (a'nvrwp + sgVoc)
           (a'nvrwp + plNom) (anvrw'p + "wn") (anvrw'p + "ois*") PlAcc
           (anvrw'p + "w") (anvrw'p + "oin") g ; 

-- Contracta: no-os > nous, oste-os > ostoun  BR 38

  nounO'c : Str -> Noun = \nous ->
    let 
        n : Str = case nous of { x + ("oy~s*"|"oy~n") => x ; 
                           _ => Predef.error ("nounOc does not apply to" ++ nous) } ;
        sgVoc : Str = case nous of { _+"oy~s*" => "o'e"   ; _ => "oy~n" } ;
        plNom : Str = case nous of { _+"oy~s*" => "oi~"   ; _ => "a~"   } ;
        plAcc : Str = case nous of { _+"oy~s*" => "oy~s*" ; _ => "a~"   } ;
        g : Gender  = case nous of { _+"oy~s*" => Masc ; _ => Neutr } 
    in 
    mkNoun nous (n+"oy~") (n+"w|~") (n+"oy~n") (n+sgVoc)
           (n+plNom) (n+"w~n") (n+"oi~s*") (n+plAcc)
           (n+"w~") (n+"oi~n") g ;  -- TODO: check Dl and SgVoc forms


  nounOc : Str -> Noun = \e'kploys ->
    let 
        e'kpl : Str = case e'kploys of { x + ("oys*"|"oyn") => x ; 
                           _ => Predef.error ("nounOc does not apply to" ++ e'kploys) } ;
        sgVoc : Str = case e'kploys of { _+"oys*" => "oe"   ; _ => "oyn" } ;
        plNom : Str = case e'kploys of { _+"oys*" => "oi"   ; _ => "oa"   } ;
        plAcc : Str = case e'kploys of { _+"oys*" => "oys*" ; _ => "oa"   } ;
        g : Gender  = case e'kploys of { _+"oys*" => Masc ; _ => Neutr } 
    in 
    mkNoun e'kploys (e'kpl+"oy") (e'kpl+"w|") (e'kpl+"oyn") (e'kpl+sgVoc)
           (case plNom of {"oi" => (toCircumflex (e'kpl+plNom)) ;
                              _ => (e'kpl+plNom)}) 
                       (e'kpl+"wn") (e'kpl+"ois*") (e'kpl+plAcc)
           (e'kpl+"w") (e'kpl+"oin") g ;  -- TODO: check Dl and SgVoc forms


  nounOs : Str -> Gender -> Noun = \news,g -> -- BR 40
    let 
        xs : Str * Str = case news of { x + "w" + acnt@("'"|"") + ("s*"|"n") => <x+"w",acnt> ; 
                                        _ => <Predef.tk 2 news, ""> } ;
        new = xs.p1 ; acnt = xs.p2 ;
        newj = (new + "|" + acnt) ;
    in  
    mkNoun news (new+acnt) newj (new+acnt+"n") news 
           (case g of { Neutr => Predef.tk 1 new + "a" ; _ => newj }) -- Neutr for Adj
                (new+acnt+"n") (newj + "s*") 
           (case g of { Neutr => Predef.tk 1 new + "a" ; _ => (new + acnt +"s*") })
           new (Predef.tk 1 new + "oin") -- CHECK Duals -w, -oin BR 74.2
           g ;    
           

-- Smart paradigm for nouns in A/O-declension ------------------

  noun : Str -> Noun = \logos -> let logos = canonize logos -- rxs -> r(xs* 
    in 
    case logos of {
      _ + ("a_"|"h")      => noun2A  logos (logos + "s*") ; -- default; no vowel change BR 32.b,c
      x + y@("e"|"i"|"r")+("a."|"a") => noun2A  logos (x + y + "a_s*") ;   -- BR 32.d
      x + y@#consonant + ("a."|"a")  => noun2A  logos (x + y + "hs*") ;    -- BR 32.e
      _ + ("a_'" | "h'" | "a'")   => nounA'  logos ;  -- ok
      _ + ("as*"|"hs*")   => nounAs  logos ;  -- ok
      _ + ("a's*"|"h's*") => nounA's logos ;  -- ??
      _ + ("a~" | "h~")   => nounAa  logos ;  -- ok
      _ + ("a~s*"|"h~s*") => nounAas logos ;  -- ok
      _ + "o'n"           => noun2O' logos Neutr ;                   
      x + "o's*"          => noun2O' logos Masc ;           -- default; may be feminine
      x + "os*"           => noun3O  logos (toAcute x +"oy") Masc ;  -- default; may be feminine
      x + "on"            => noun3O  logos (toAcute x +"oy") Neutr ; -- default; when s+vow~+on
      _ + ("oy~s*"|"oy~n")=> nounO'c logos ;                -- default; may be feminine
      _ + ("oys*"|"oyn")  => nounOc  logos ;                -- default; may be feminine
      _ + ("ws*"|"w's*")  => nounOs logos Masc ;            -- default gender
      _ + "wn"            => nounOs logos Neutr ; -- BR 40, Adj
      _  => Predef.error ("noun does not apply to: " ++ logos)
      } ;

  noun2 : Str -> Str -> Noun = \poli'ths, poliitai ->   -- SgNom, SgGen|PlNom
    let poliitai = canonize poliitai 
     in
    case poliitai of {
      _ + ("as*" | "hs*") => noun2A poli'ths poliitai ;  -- SgGen
      _ + "ai"            => noun2As poli'ths poliitai ; -- PlNom
      _                   => Predef.error ("noun2 does not apply to: " ++ poli'ths)
    } ;

-- III declension (using the "redesign" stuff) 

  -- Smart paradigm for nouns in third declension:

  noun3 : Str -> Str -> Gender -> Noun = \rhtwr, rhtoros, g -> 
    let rhtwr   = canonize rhtwr ;
        rhtoros = canonize rhtoros 
    in 
    case rhtoros of {
      _ + ("os*"|"o's*"|"ews*"|"ew's*"|"e'ws*"|"oys*"|"oy's*"|"oy~s*") 
        => let 
               -- errorNoun : Noun = noun3O "lo'gos" "lo'gous" Masc  ;
               stem : Str = case rhtoros of { 
                        stm + ("os*"|"o's*")    => stm ;
                        stm + ("ews*"|"ew's*")  => stm + "e" ;  -- BR 49 3. po'le-ws  (ew's* ??)
                        stm + "e'ws*"           => stm + "ey" ; -- BR 52    basile'-ws
                        -- genos, genous => genes-os :
                        stm + ("oys*"|"oy's*"|"oy~s*") => stm + "es" ;
                        _ => rhtoros -- cannot occur
                      }
           in 
              case stem of { 
                _ + ("r"|"l"|"k"|"g"|"c"|"p"|"b"|"f") => noun3LGL  rhtwr rhtoros g ;
                _ + ("nt"|"n"|"t"|"d"|"v")            => noun3DenN rhtwr rhtoros g ;
                _ + "s"                               => noun3s    rhtwr rhtoros g ;  
                _ + "e"                               => 
                    case rhtwr of { _ + ("ay" | "oy" | "ey") + #accent + "s*"
                                                      => noun3ay   rhtwr rhtoros g ;
                                    _                 => noun3i    rhtwr rhtoros g } ; 
                _ + "ey"                              => noun3ey   rhtwr rhtoros g ; 
                _ + ("y"|"y'"|"y~"|"y_'"|"y.")        => noun3y    rhtwr rhtoros g ;  
                _ + ("o" | "i")                       => noun3ay   rhtwr rhtoros g ; -- bo-o's, Di-o's
                _ + "w"                               => noun3w    rhtwr rhtoros g ;
                -- _                                     => errorNoun 
                _ => Predef.error ("noun3 does not apply to: " ++ rhtwr + " -- " + rhtoros)
              } ;
      _ => Predef.error ("GenSg" ++ rhtoros ++ "does not end in os|oys|ews") 
    } ; 


  -- The accent position is as it is in NomSg (BR 29 7.) and only changed
  -- (a) if demanded by the general accent rules, or
  -- (b) for monosyllabic nouns (of third declension), where the accent is
  --     on the ending in (Gen|Dat) (Sg|Pl|Dl) (BR 41 6.), 
  --     and must be ~ if the ending is long (i.e. Gen (Pl|Dl), Dat Dl) (BR 29 7.).

  endingsN3 : Number => Case => Gender => Syllability => Str = 
     table { 
       Sg => table {
                Nom => table { Neutr => \\_ => [] ; _ => \\_ => "s*" } ;
                Gen => table { _ => table { Mono => "o's*" ; _    => "os*" } } ;
                Dat => table { _ => table { Mono => "i'" ;  _    => "i" } } ;
                Acc => table { Neutr => \\_ => [] ; _ => \\_ => "a" } ; 
                                  -- + exception x+vowel => "n" TODO
                Voc => table { Neutr => \\_ => [] ; _ => \\_ => "s*" } 
             } ;
       Pl => table Case {
          Nom | Voc => table { Neutr => \\_ => "a" ; _ => \\_ => "es*" } ;
                Gen => table { _ => table { Mono => "w~n" ; _ => "wn" } } ;
                Dat => table { _ => table { Mono => "si'" ; _ => "si" } } ; -- si'+(n) | si
                Acc => table { Neutr => \\_ => "a" ; _ => \\_ => "as*" } 
                                   -- + exception x+vowel => "n" TODO
             } ;
       Dl => table Case { 
          Nom | Voc => table { _ => table { _ => "e" } } ;
                Gen => table { _ => table { Mono => "oi~n" ; _ => "oin" } } ;
                Dat => table { _ => table { Mono => "oi~n" ; _ => "oin" } } ;
                Acc => table { _ => table { _ => "e" } } 
             } 
     } ;

  -- specific paradigms of declension III:

  -- To work on structured data Word*Ending -> Word*Ending, define a simpler 
  -- type of endings (with at most one vowel) that is sufficient for nouns.

  NEnding = { a : Accent ; v : Str ; l : Length ; c : Str * Str } ;

  toNEnding : Str -> NEnding = \str ->  -- TODO: complete, check!!!
     case str of {                      -- Only one vowel/diphtong 
          y@#nonvowels 
        + o@(#diphthong | #longV | #shortV | #restV) 
        + z@#nonvowels 
          => { v = o ; 
               l = case <y,o,z> of { <"","ai",""> => Short ; -- BR 29 7.
                                     <"","oi",""> => Short ; -- BR 29 7.
                                     _ => vowelLength2 o z } ; 
               a = toAccent <[], [], z> ; 
               c = <y , dropAccent z>
             } ;
          z@#nonvowels 
          => { v = [] ; l = Zero ; a = NoAccent ; c = <[], z> } ;
--        _ => Predef.error 
--             ("toNEnding needs one vowel/diphtong, no aspirate, s* only at the end: " ++ str) 
          _ => { v = "U" ; l = Zero ; a = NoAccent ; c = <"B","G"> } -- TODO
      } ;

  -- Applying soundlaws:

  -- WARNING (see BugGrc.gf): 
  -- Don't define a function g that may run into a Predef.error among the let-variables
  -- of another one, i.e. f = \x -> let g = ... in ... x ... g ..., but try to make a 
  -- (perhaps more general) top-level version g = \y -> ... ; f = \x -> ... x ... g ... !
  -- The embedded declarations can cause immense slowdowns due(?) to the handling of
  -- Predef.error in the compiler (factor 20 and more).
  -- In particular, define the soundlaws and toStrN on top level!

  toStrN : Word -> Str -> Str = toStrN0 ;   
  toStrNsl : Soundlaw -> Word -> Str -> Str = \sl,w,e -> toStr (concat (sl <w,toNEnding e>)) ;

  toStrN0 : Word -> Str -> Str = \w,e -> toStr (concat <w,toNEnding e>) ; 
  -- Remark: toStrN2 is slower a previous toStrN1, but cleaner and intended not just for nouns.
  -- toStrN2 : Word -> Str -> Str = \w,e -> toStr (compose (toWord e) w) ;  -- for nouns|verbs?

  -- Paradigms: 

  noun3LGL : Str -> Str -> Gender -> Noun = \rhtwr, rhtoros, g -> 
    let -- stem ends in "l","r"     (Liquida)  -- BR 42  
        --              "k","g","c" (Guttural) -- BR 43
        --              "p","b","f" (Labial)   -- BR 43
        stem : Str = case rhtoros of { stm + ("os*"|"o's*") => stm ; 
                                       _ => rhtwr } ;
        rhtwr : Word = toWord rhtwr ;
        -- Ablaut: undo vowel lengthening in SgNom
        rhtor : Word = let stem' = toWord stem 
                        in case stem'.s of { Mono => stem' ** { a = rhtwr.a } ; -- accent of NomSg
                                             _    => stem' } ;     
    in noun3LGLw rhtwr rhtor g ;

  noun3LGLw : Word -> Word -> Gender -> Noun = \rhtwr,rhtor,g ->
    let -- two forms because of ablaut in the stem
        syl = rhtwr.s ;
        rhtwr   = toStrN rhtwr "" ;
        rhtoros = toStrN rhtor (endingsN3!Sg!Gen!g!syl) ; 
        rhtori  = toStrN rhtor (endingsN3!Sg!Dat!g!syl) ; 
        rhtora  = toStrN rhtor (case g of { 
                                  Neutr => [] ;
                                  _     => (case (toStr rhtor) of { _ + #vowel => "n" ; 
                                                                    _          => "a" })}) ; 
        rhtorV : Str = case (toStrN rhtor "") of {               -- BR 41 4. BR 23
                     x + e@("n"|"r"|"s") => auslaut (x+e) ; 
                                       _ => rhtwr } ;
        rhtores  = toStrN rhtor (endingsN3!Pl!Nom!g!syl) ;
        rhtoras  = toStrN rhtor (endingsN3!Pl!Acc!g!syl) ;
        rhtorwn  = toStrN rhtor (endingsN3!Pl!Gen!g!syl) ; 
        rhtorsi  = toStrNsl glS rhtor (endingsN3!Pl!Dat!g!syl) ; -- BR 43, BR 41 6. 
        rhtore   = toStrN rhtor (endingsN3!Dl!Nom!g!syl) ;
        rhtoroin = toStrN rhtor (endingsN3!Dl!Gen!g!syl) ;
    in                                                                          
        mkNoun rhtwr rhtoros rhtori rhtora rhtorV
               rhtores rhtorwn rhtorsi rhtoras 
               rhtore rhtoroin g ;

  substC4 : Word -> Str -> Word = -- TODO: adjust accent if c4 contains an accent
     \w,c4 -> { a = w.a ; s = w.s ; v = w.v ; l = w.l ; c = <w.c.p1, w.c.p2, w.c.p3, c4> } ;


  noun3r3 : Str -> Str -> Str -> Gender -> Noun = \pathr, patros, patera, g -> 
    let -- stem ends in "r", but 3 ablautlevels  (pater-, mhter-, aner-)  -- BR 47  
        pater : Word = toWord (Predef.tk 1 patera) ;
        syl = pater.s ;
        pateres  = toStrN pater (endingsN3!Pl!Nom!g!syl) ;
        pateras  = toStrN pater (endingsN3!Pl!Acc!g!syl) ;
        paterwn  = toStrN pater (endingsN3!Pl!Gen!g!syl) ; 
        patere   = toStrN pater (endingsN3!Dl!Nom!g!syl) ;
        pateroin = toStrN pater (endingsN3!Dl!Gen!g!syl) ;
                  
        patr  : Word = toWord (case (canonize patros) of { 
                                 stm + ("os*"|"o's*") => stm ; _ => pathr }) ;
        patros  = toStrN patr (endingsN3!Sg!Gen!g!Mono) ; 
        patri   = toStrN patr (endingsN3!Sg!Dat!g!Mono) ; 

        patra : Word = toWord (case (canonize patros) of { 
                                 stm + ("os*"|"o's*") => stm + "a'" ; _ => pathr }) ;
        patrasi = toStrN patra (endingsN3!Pl!Dat!g!(case syl of {Mono => Bi; _ => syl})) ; 

        paterV: Word = let acnt = case pater.s of { Mono => Acute 3 ; -- andr
                                                      Bi => Acute 2 ;
                                                    _    => Acute 1 } 
                        in { s = pater.s ; c = pater.c ;  -- LexiconGrc: change c for anhr: a'ndr > a'ner
                             v = pater.v ; l = pater.l ; a = acnt } ; 
    in                                                                          
        mkNoun pathr patros patri patera (toStr paterV)
               pateres paterwn patrasi pateras
               patere pateroin g ;

  ntS : Soundlaw = toSL ntS2 ;
  tN  : Soundlaw = toSL (\xy -> case xy of {<x+"t", "n"> => <x,"n"> ; _ => xy}) ;

  noun3DenN : Str -> Str -> Gender -> Noun = \elpis, elpidos, g -> 
    let -- stem ending in "n" or "nt" -- BR 45, 46
        -- or          in "t","d","v" -- BR 44 (Dental)
        stem : Str = case elpidos of { stm + ("os*"|"o's*") => stm ; 
                                       _ => elpis } ;
        w        = toWord elpis ;
        elpid:Word = let stem2 : Word = toWord stem 
                      in case stem2.a of { NoAccent => toWord (addAccentW w.a stem2) ; 
                                           _        => stem2 } ; -- sw~ma, sw'matos*
        syl = elpid.s ;
        elpidi   = toStrN elpid (endingsN3!Sg!Dat!g!syl) ;
        a : Str  = (case elpis of { _ + "is*" => "n" ;   -- ca'ris - ca'rin 
                                           _ => (endingsN3!Sg!Acc!g!syl) }) ;
        elpida   = auslaut (toStrNsl tN elpid a) ;    -- BR 44 1.  sw~mat+ > sw~ma+, 
                                                      --           ca'rit+n > ca'ri+n
        elpis0   = (case g of {Neutr => elpida ; _ => elpis})  ; -- for adjectives!
        rhtor:Str= case elpid.c.p4 of {                          -- BR 45,46
                     _ + ("n"|"nt") => toStr (substC4 elpid (auslaut elpid.c.p4)) ;
                     _              => elpis } ;
        rhtores  = toStrN elpid (endingsN3!Pl!Nom!g!syl) ;
        rhtoras  = toStrN elpid (endingsN3!Pl!Acc!g!syl) ;
        rhtorwn  = toStrN elpid (endingsN3!Pl!Gen!g!syl) ;
        rhtorsi  = toStrNsl ntS elpid (endingsN3!Pl!Dat!g!syl) ; -- BR 44 1., 45 2., 46 1.  
                                                                 -- TODO: sw'ma-si
        rhtore   = toStrN elpid (endingsN3!Dl!Nom!g!w.s) ;       -- dai'mon+si > dai'mo+si 
        rhtoroin = toStrN elpid (endingsN3!Dl!Gen!g!w.s) ; 
    in 
        mkNoun elpis0 elpidos elpidi elpida rhtor
               rhtores rhtorwn rhtorsi rhtoras 
               rhtore rhtoroin g ;


  -- Declension noun3s uses sl=(contractVowels o dropS)=(cV o dS) when the ending begins 
  -- with a vowel, but has to count the accent position before the contraction:

  --   cVdS : Soundlaw = \ue -> case (toStr ue.p2) of { #vowel + _ => (cV (dS ue)) ; _ => ue } ;
  toStrNs : Word -> Str -> Str =  -- takes 30-70 ms for cc (noun3s "ge'nos*" "genoy~s*" Neutr)
             \w,e -> let we = adjustAccent <w, toNEnding e> ;
                         we' = cVdS we ;
                     in toStr (concat we') ;               

  noun3s : Str -> Str -> Gender -> Noun = \genos, genoys, g -> 
    let 
        -- BR 48: stems ending in s; 
        --        if the ending starts with a vowel, omit s and contract the vowels   
        --        Neutr -os: SgGen -os, SgDat -i, Pl(Nom|Acc|Gen|Voc)
        --        Neutr -as: SgGen -ws, SgDat a|
        -- ASSUME genos  ends in -os* or o's*          -- did not compile with Predef.error's
        -- ASSUME genoys ends in oys*, oy's* or oy~s*
        w        = toWord genos ;
        syl      = w.s ;
        stem : Str = case genoys of { 
                        stm + ("oy's*"|"oy~s*") => stm + "e"; 
                        _                       => Predef.tk 4 genoys + "e" } ;
        ge'ne:Word = let stm : Word = toWord stem 
                     in case stm.a of { NoAccent => toWord (addAccentW w.a stm) ; 
                                        _        => stm } ; 
        gene   = toStr ge'ne ;
        genei  = toStrNs ge'ne (endingsN3!Sg!Dat!g!syl) ;
        genea  = toStrNs ge'ne (endingsN3!Pl!Nom!g!syl) ;  -- PlGen needs accent shift ge'ne+a. vs
        geneA  = toStrNs ge'ne (endingsN3!Pl!Acc!g!syl) ;  -- gene'+wn before vowel contraction:
        genwn  = toStrNs ge'ne (endingsN3!Pl!Gen!g!syl) ;  -- Accent: gene'+wn > genw~n 
        genesi = toStrN  ge'ne (endingsN3!Pl!Dat!g!syl) ;  --    not: ge'ne+wn > ge'nwn
        genoin = toStrNs ge'ne (endingsN3!Dl!Gen!g!syl) ;  
    in 
        mkNoun genos genoys genei genos gene
               genea genwn genesi geneA
               genei genoin g ;

  noun3i : Str -> Str -> Gender -> Noun = \polis, polews, g ->
    let 
        -- BR 49, 50: stems on i/y with Ablaut: (poli-,pole-) and (phcy-,phce-) 
        -- ASSUME: polews ends in "ews*"  
        stemE : Str = Predef.tk 3 polews ;
        StemE = toWord stemE ;
        stemI : Str = case polis of { 
                         stm + "is*" => stm + "i"; 
                         stm + "ys*" => stm + "y"; 
                         stm + "y's*"=> stm + "y'";  -- h(dy's : A
                         stm + "y"   => stm + "y"; 
                         _ => "noun3i:stmI" } ;  -- not exhaustive (Predef.error-problem) TODO
        polin   = (stemI + (case g of { Neutr => [] ; _ => "n" })) ; -- after vowel: a/n
        syl = StemE.s ;
        polei : Str = 
          let i : Str = endingsN3!Sg!Dat!g!syl in  -- h(de'+i > h(dei~
          (case StemE.a of { Acute 3 => (addAccentW (Circum 3) (toWord (dropAccent stemE + i))) ;
                             _ => (stemE+i) }) ;
        polejes : Str = contractVowels stemE (endingsN3!Pl!Nom!g!syl) ;
        polejee : Str = contractVowels stemE (endingsN3!Dl!Nom!g!syl) ;   -- ? BR 74
        polejeoin : Str = contractVowels stemE (endingsN3!Dl!Gen!g!syl) ; -- ? BR 74
    in 
        mkNoun polis polews polei polin stemI
               polejes (stemE + "wn") (stemE + "si") polejes 
               polejee polejeoin g ;


  -- TODO: check and simplify noun3y, use lY 
  sY : Soundlaw = toSL (\xy -> case xy of { -- shorten stem end y_ 
                                 < x+"y_", v@#vowel +z> => <x+"y.", v+z> ;
                                 _                      => xy }) ;
  lY : Soundlaw = toSL (\xy -> case xy of { -- lengthen stem end y. 
                                 < x+("y"|"y."), z> => <x+"y_", z> ;
                                 _                  => xy }) ;

  noun3y : Str -> Str -> Gender -> Noun = \icvys, icvyos, g ->
    let 
        -- BR 51: pure stems (those without Ablaut) on y_ or y 
        -- BR 51 1. stem+y_s has accent on final syllable                
        --          sY: y_+voc > y.+voc, y_+DatPl > y.
        -- BR 51 2. stem+y.s with accent in stem has Pl Acc y_s (via: yn+s > y_+s)
        stem : Str = case icvys of { 
                         stm + ("y~s*"|"y_'s*")      => stm + "y_"; 
                         stm + ("ys*"|"y.s*"|"y's*") => stm + "y." ;
                         _ => "ystem" } ;  -- not exhaustive (Predef.error-problem)
        stemS : Str = case icvys of { 
                         stm + ("y~s*"|"y_'s*")      => stm + "y.";   -- BR 51 1. 
                         stm + ("ys*"|"y.s*"|"y's*") => stm + "y." ; 
                         _ => "ystemS" } ; 
        at      = (toWord icvys).a ;
        at2     = (toWord icvyos).a ;
        syl     = (toWord stem).s ; 
        stemW   = toWord (addAccentW at (toWord stem)) ;
        stemSW  = toWord (addAccentW at (toWord stemS)) ;
        icvyi   = toStrNsl sY stemSW (endingsN3!Sg!Dat!g!syl) ;     -- BR 41 6.
        icvyn   = toStrN stemW (case g of { Neutr => [] ; _ => "n" }) ; -- after vowel: a/n
        icvy    = toStrN stemW "" ;                            -- HL
        icvyes  = toStrNsl sY stemSW (endingsN3!Pl!Nom!g!syl) ;     -- Mono: sy'es
        icvywn  = toStrNsl sY stemSW (endingsN3!Pl!Gen!g!syl) ;
        icvysi  = toStrNsl sY  stemSW (endingsN3!Pl!Dat!g!syl) ;     -- BR 41 6.
        icvyns  = toStrN (case stemW.a of { 
                            (Acute 3) => (toWord (addAccentW (Circum 3) stemW)) ;
                            _          => stemW }) "s*" ;
        icvye   = toStrNsl sY stemSW (endingsN3!Dl!Nom!g!syl) ;
        icvyoin = toStrNsl sY stemSW (endingsN3!Dl!Gen!g!syl) ;
    in 
        mkNoun icvys icvyos icvyi icvyn icvy
               icvyes icvywn icvysi icvyns
               icvye icvyoin g ;


   sL : Soundlaw = toSL PhonoGrc.swapLengths ;  

   noun3ey : Str -> Str -> Gender -> Noun = \basileys, basilews, g -> 
     -- BR 52 works for basileys, but is it general enough?
     let 
         w = toWord basilews ;               -- TODO: 52 2. contraction ve'+a_ > v+a~
         at = w.a ;                          --       (v vowel)         ve'+w  > v+w~
         syl = case w.s of {
                 Bi | Multi => w.s ; 
                 _ => Predef.error ("noun3ey does not apply to monosyllabic "++basileys) } ;
         stem : Str = case basilews of { 
                        stm + ("e'ws*"|"w~s*")  => stm + "ey'" ; -- BR 52    basile'-ws
                        _ => Predef.error ("GenSg" ++ basilews ++ "does not end in -e'ws") 
                       } ; 
         stemEU     = toWord stem ; 
         stemH      = toWord (Predef.tk 3 stem + "h'") ;         
         basilea    = toStrNsl sL stemH (endingsN3!Sg!Acc!g!syl) ;          -- BR 52 1. 
         basilei    = Predef.tk 2 stem + (endingsN3!Sg!Dat!g!syl) + "~" ;
         basiley    = Predef.tk 1 stem + "~";
         basileis   = toStrNsl cV stemH (endingsN3!Pl!Nom!g!syl) ;
         basilewn   = toStrNsl sL stemH (endingsN3!Pl!Gen!g!syl) ;
         basileysi  = toStrN stemEU (endingsN3!Pl!Dat!g!syl) ;
         basileas   = toStrNsl sL stemH (endingsN3!Pl!Acc!g!syl) ;          -- BR 52 1. 
         basileye   = toStrN stemEU (endingsN3!Dl!Nom!g!syl) ;
         basileoin  = toStrNsl sL stemH (endingsN3!Dl!Gen!g!syl) ;
     in 
     mkNoun basileys basilews basilei basilea basiley
            basileis basilewn basileysi basileas 
            basileye basileoin Masc ;                    -- replace g by Masc: BR 52 3. 
      
-- TODO: use soundlaws with digamma F and j in noun3ay and noun3w (?)

-- BR 53 Monosyllabic stems in -oy, -ay, -ey  (nay~s, nayo's > new's ; boy~s, bojo's > boo's)
--                                            (Djeys > Zeys, Dio's)
   noun3ay : Str -> Str -> Gender -> Noun = \nays, news, g -> 
     let 
         w = toWord nays ;
      in 
         case w.s of { 
           Mono => let 
                       at = w.a ;
                       syl = w.s ;
                       stem : Str = case news of { 
                          stm + ("o's*"|"w's*")  => stm ; 
                          _ => Predef.error ("GenSg" ++ news ++ "does not end in -w's|o's") 
                          } ; 
                       stemF = toWord stem ; 
                       stemH = toWord (Predef.tk 2 nays) ;         
                       sl = toSL (\xy -> case xy of { < x+"e",y >  => < x+"h",y > ; 
                                                      < x+"e'",y > => < x+"h~",y > ; 
                                                      _            => xy }) ;
                       nayn  = toStrN stemH (case g of { Neutr => [] ; _ => "n" }) ; -- after vowel: a/n
                       nhi   = toStrNsl sl stemF (endingsN3!Sg!Dat!g!syl) ;          -- e/h o/o i/i 
                       nay   = addAccentW (Circum 3) stemH ;
                       nhes  = toStrNsl sl (toWord (addAccentW (Acute 3) stemF))
                                           (endingsN3!Pl!Nom!g!syl) ; -- TODO
                       newn  = toStrNsl sL stemF (endingsN3!Pl!Gen!g!syl) ; -- sL unneccessary?
                       naysi = toStrN stemH (endingsN3!Pl!Dat!g!syl) ;
                       naye  = toStrN stemF (endingsN3!Dl!Nom!g!syl) ;
                       neoin = toStrN stemF (endingsN3!Dl!Gen!g!syl) ;
                   in 
                       mkNoun nays news nhi nayn nay
                              nhes newn naysi nays
                              nay neoin g ;
              _ => Predef.error "noun3ay still undefined" } ; -- sometimes: use noun3ey 

-- BR 54 stems in -oi, -w

   noun3w : Str -> Str -> Gender -> Noun = \hrws, hrwos, g -> 
     let 
         hrws = canonize hrws ;
         hrwos = canonize hrwos ;  
         syl   = (toWord hrws).s ;
         stem : Word = toWord (Predef.tk 3 hrwos) ;     -- ASSUME hrwos ends in os|os*
         nayn  = toStrN stem (endingsN3!Sg!Acc!g!syl) ; -- hrw-a, not hrw-n
         nhi   = toStrN stem (endingsN3!Sg!Dat!g!syl) ; 
         nay   = toStrN stem (endingsN3!Sg!Voc!g!syl) ; 
         nhes  = toStrN stem (endingsN3!Pl!Nom!g!syl) ; 
         hrwas = toStrN stem (endingsN3!Pl!Acc!g!syl) ; 
         newn  = toStrN stem (endingsN3!Pl!Gen!g!syl) ; 
         naysi = toStrN stem (endingsN3!Pl!Dat!g!syl) ;
         naye  = toStrN stem (endingsN3!Dl!Nom!g!syl) ;
         neoin = toStrN stem (endingsN3!Dl!Gen!g!syl) ;
      in 
         mkNoun hrws hrwos nhi nayn nay
                nhes newn naysi hrwas
                nay neoin g ;

-- TODO: peivw': peivo(j) > peivoi + contraction

-----------------------------------------------------------------------------------------------

--2 For $Adjective$ 

-- We first define only the positive forms, and below the adjective with
-- comparative and superlative forms. 

param AForm = AF Gender Number Case ;

oper         
  Adj : Type = { s : AForm => Str ; adv : Str } ; 

  genderAf : AForm -> Gender = \r -> case r of {AF g _ _ => g} ;
  numberAf : AForm -> Number = \r -> case r of {AF _ n _ => n} ;
  caseAf   : AForm -> Case   = \r -> case r of {AF _ _ c => c} ;

  mkAdj : (_,_,_ : Noun) -> Adj = 
    \agavos,agavh,agavon -> { 
        s = table { AF Masc n c  => agavos.s ! n ! c ;
                    AF Fem  n c  => agavh.s  ! n ! c ;
                    AF Neutr n c => agavon.s ! n ! c } ;
        adv = case agavos.s ! Pl ! Gen of {
                agavw + "n" => agavw + "s*" ;
                _           => agavos.s ! Pl ! Gen 
              }
    } ;

-- For adjectives with the accent on the endings, or the triple-ended ones 
-- without accent shift, we need only the SgNomMasc form:  -- BR 37, 38, 39

  adjAO : Str -> Adj = \agavos -> 
    let agavos : Str = canonize agavos ;
        agavh : Str = 
          case agavos of { aisxr@(_+("e"|"i"|"|"|"r"))+"o's*"      => aisxr+"a'" ;
                           agav                       +"o's*"      => agav+"h'" ;
                           argyr@(_+("e"|"i"|"|"|"r"))+"oy~s*"     => argyr+"a~" ;
                           xrys                       +"oy~s*"     => xrys+"h~" ;
                           eun                        +"oys*"      => eun+"oys*" ;
                           n@(_+("e'"|"e"|"i"|"|"|"|~"|"r"))+"os*" => n+"a_" ; -- ne'os
                           fil                         +"os*"      => fil+"h" ;
                           i'le + "ws*"                            => i'le+"ws*" } ; -- BR 40, 2-ended
        agavon : Str = 
          case agavos of { agav+"o's*"   => agav+"o'n" ;
                           argyr+"oy~s*" => argyr+"oy~n" ;
                           ne'+"os*"     => ne'+"on" ;
                           eu'n+"oys*"   => eu'n+"oyn" ;
                           i'le+"ws*"    => i'le+"wn" }  
    in 
    mkAdj (noun agavos) (noun agavh) (noun agavon) ;

-- 8/11: with vowel length indicators, SgNomMasc suffices, but first (noun "di'kaia_") 
--       has to be made to work with vowel lengths.

  adjAO2 : Str -> Adj = \agavos ->
    let agavos : Str = canonize agavos ;
        at : Accent  = (toWord agavos).a ;
        agavh  : Str = 
          case agavos of { aisxr@(_+("e"|"i"|"|"|"r"))+"os*" => aisxr+"a_" ; -- noun ("dikaia_") ??
                           _ => "kala"} ;
        agavon : Str = 
          case agavos of { di'kai+"os*" => (di'kai+"on") ; _ => "kalo'n" } ; -- Predef.error
    in 
    mkAdj (noun agavos) (noun (addAccent at agavh)) (noun agavon) ;


-- In adj2AO, we ask for the forms SgNomMasc, SgGenFem to find the   -- BR 37
-- accent shifts, and infer whether the Fem forms equal the Masc forms.

  adj2AO : Str -> Str -> Adj = \di'kaios, dikai'as ->  -- = dikai'a_s !
    let 
        di'kaios = canonize di'kaios ;
        dikai'as = canonize dikai'as ;
        di'kai = Predef.tk 3 di'kaios ; -- omit "os*" 
        split : Str*Str = 
           case dikai'as of { x + y@("a_s*"|"hs*"|"oy") => <x,y> ; 
                              _ => Predef.error ("adj2AO needs Sg.Gen.Fem -a_s*|-hs*|-oy in" 
                                                  ++ dikai'as) } ;
        dikai' = split.p1 ;
        masc  = (noun3O di'kaios (dikai'+"oy") Masc) ;
        neutr = (noun3O (di'kai+"on") (dikai'+"oy") Neutr) ;
        fem : Noun  = 
           case split.p2 of {
                   "oy" => (noun3O di'kaios (dikai'+"oy") Fem) ;
                    hs  => let 
                               dikaia = noun (dikai' + (Predef.tk 2 hs))
                           in 
                           { s = table { Pl => table { Nom|Voc  => di'kai+"ai" ;
                                                       Gen      => dikai'+"wn" ;
                                                         c      => dikaia.s ! Pl ! c } ;
                                        num => dikaia.s ! num } ;
                             g = Fem }
          } 
    in 
    mkAdj masc fem neutr ;

  -- adjectives following declension III  (provide MascSgNom, MascSgGen)

  -- smart paradigm: 
  adj3 : Str -> Str -> Adj = \eudaimwn, eudaimonos ->
      let 
         eudaimwn   = canonize eudaimwn ;
         eudaimonos = canonize eudaimonos 
      in 
         case <eudaimwn, eudaimonos> of {
           <_ + ("hs*"|"h's*"), _>       => adj3s eudaimwn eudaimonos ;
           <cari + "eis*", _cari'entos>  => adj3nteis eudaimwn eudaimonos ; -- BR 46.b 4.
           <_, _ + "nos*">               => adj3n eudaimwn eudaimonos ;
           <_, _ + ("ntos*"|"nto's*")>   => adj3nt eudaimwn eudaimonos ;
           <_ + "w's*", _ + "o'tos*">    => adj3d eudaimwn eudaimonos ;
           _ => Predef.error ("adj3 undefined for: " ++ eudaimonos) 
         } ;
       
  -- stem ending in -t|d|v (dental):                    -- BR 44.5 
  -- TODO a)'caris, a)ca'rit-os: preserve accent positions in adj3d

  adj3d : Str -> Str -> Adj = \paideykw's, paideyko'tos ->  -- BR 44.6
    let
      paideykw's = canonize paideykw's ;
      paideyko'tos = canonize paideyko'tos ;
      paideyk = Predef.tk 6 paideyko'tos ; -- drop o'tos*
      paideykyi'a = paideyk + "yi~a" ;
      paideykyi'as = paideyk + "yi'a_s*" ;
      paideyko's = paideyk + "o's" ;      
      masc = noun3DenN paideykw's paideyko'tos Masc ;
      fem = noun2A paideykyi'a paideykyi'as ;
      neutr = noun3DenN paideyko's paideyko'tos Neutr ;
    in
    mkAdj masc fem neutr ;

  -- stem ending in -n:                                 -- BR 45
  adj3n : Str -> Str -> Adj = \eudai'mwn, eudai'monos ->
    let 
        eudai'mon = (Predef.tk 3 eudai'monos) ;         -- remove -os*
        masc  = noun3DenN eudai'mwn eudai'monos Masc ;  -- TODO: Shift accent left: Sg Voc eu'daimon
        fem   = noun3DenN eudai'mwn eudai'monos Fem ;   -- same form as Masc
        neutr = noun3DenN eudai'mwn eudai'monos Neutr ;
    in 
    mkAdj masc fem neutr ;

  -- stem ending in -nt:                                -- BR 46 b)
  -- Compiler bug: this auxiliary function cannot be local to adj3nt + adj3nteis
  noun3DenN' : Str -> Str -> Gender -> Noun = \nom,gen,g ->  
    let noun = noun3DenN nom gen g
    in { s = \\n,c => case c of { Voc => noun.s!n!Nom ; _ => noun.s!n!c } ; g = noun.g } ;

  adj3nt : Str -> Str -> Adj = \lywn, lyontos ->
    let 
        lywn = canonize lywn ;
        lyontos = canonize lyontos ;
        lyont: Str = case lyontos of {x + "o's*" => x ; _ => (Predef.tk 3 lyontos)} ; -- remove -os*
        stemFem = table Str { st + v@#vowel + a@("'"|"") + "nt"      -- BR 20 2. 46 1. 45 2.
                                     => st + (ersatzdehnung v) + a + "s" ; 
                              stm    => stm + "s" } ;
        lyousa0 = (stemFem!lyont + "a") ;
        at : Accent = let acnt : Accent = (toWord lyousa0).a         -- BR 29 7 monosyllabic stems
                       in case acnt of { NoAccent => Acute 2 ; _ => acnt } ;
        lyousa  = addAccent at lyousa0 ; -- may change ' to ~
        lyoushs = addAccent at (stemFem!lyont + "hs*") ;
        masc  = noun3DenN' lywn lyontos Masc ;  -- TODO: Shift accent to the left: Sg Voc eu'daimon
        fem   = noun2A lyousa lyoushs ;        
        neutr = noun3DenN' lywn lyontos Neutr  
    in 
    mkAdj masc fem neutr ;     -- TODO: Voc = Nom; Accent in noun3DenN for monosyllabic stems 41 6

  -- stem ending in -nt, adjective ending in -eis:      -- BR 46.b 4.
  adj3nteis : Str -> Str -> Adj = \carieis, carientos ->
    let 
        carieis = canonize carieis ;
        carientos = canonize carientos ;
        carient   = (Predef.tk 3 carientos) ;           -- remove -os*
        stemFem = table Str { st + v@#vowel + "nt"      -- BR 20 2. 46 1. 45 2.
                                     => st + v + "ss" ; -- BR 46 4. 
                              stm    => stm + "s" } ;
        cariessa  = stemFem!carient + "a" ;
        cariesshs = addAccent (toWord cariessa).a (stemFem!carient + "hs*") ;
        noun3DenN' : Str -> Str -> Gender -> Noun = \nom,gen,g ->  
          let noun = noun3DenN nom gen g ;
              nts : Str -> Str = \str -> case str of {x+"eisi" => x+"esi" ; _ => str } ;
          in { s = \\n,c => case <g,n,c> of { <Masc,Sg,Acc>          => carient+"a" ;
                                              <Neutr,Sg,Nom|Acc|Voc> => Predef.tk 1 carient ;
                                              <Masc|Neutr,Pl,Dat>    => nts (noun.s!n!c) ;
                                              <_,_,Voc>              => noun.s!n!Nom ; 
                                              _                      => noun.s!n!c } ; 
               g = noun.g } ;
        masc  = noun3DenN' carieis carientos Masc ;  
        fem   = noun2A cariessa cariesshs ;             
        neutr = noun3DenN' carieis carientos Neutr ;
    in 
    mkAdj masc fem neutr ;

  -- stem ending in -s                                  -- BR 48 b)
  adj3s : Str -> Str -> Adj = \eugenhs, eugenoys ->
    let 
        eugen   = (Predef.tk 4 eugenoys) ;              -- remove -oys*
        masc  = noun3s eugenhs eugenoys Masc ;          -- TODO M/N Pl Dat = i'esi statt i'eisi
        fem   = masc ;
        neutr = noun3s eugenhs eugenoys Neutr ;
    in 
    mkAdj masc fem neutr ;

  -- 3-ending: h(dy's h(dei~a hdu'               5/16
  adj3y : Str -> Str -> Adj = \hdy's, hde'os ->  -- BR 50: stem ending in -y, with ablaut y/e 
    let                                          -- TODO: use Word,End to bring this to work
        hdy's = canonize hdy's ; 
        hde'os = canonize hde'os ;
        stemE : Str = Predef.tk 3 hde'os ;
        stemY : Str = case hdy's of { 
                         stm + "y's*" => stm + "y'";  -- h(dy's : A
                         _ => "adj3y: stmY" } ;  -- not exhaustive (Predef.error-problem) TODO

        masc : Noun = 
          let hde'ws : Str = ((Predef.tk 3 hde'os) + "ws*") ;
              masc : Noun = noun3i hdy's hde'ws Masc ;
          in { s = \\n,c => case <n,c> of { <Sg,Gen> => hde'os ; _ => masc.s ! n ! c } ;
               g = masc.g } ; 
        fem = noun2A (stemE + "ia") (stemE + "ia_s*") ;
        neutr = mkNoun stemY hde'os (stemE + "i") stemY stemY 
                      (stemE + "a") (stemE + "wn") (stemE + "si") (stemE + "a") 
                      (stemE + "a") (stemE + "a") Neutr ;  -- Dual: CHECK
    in 
        mkAdj masc fem neutr ;

  -- Adjective paradigm depending on degree:

  Adjective : Type = { s : Degree => AForm => Str ; adv : Degree => Str } ;

  mkAdjective : Adj -> Adjective =  -- TODO: work out the details BR 59, BR 60, BR 61
   \agavos -> 
       let stem : Str = -- TODO: compute stem correctly
             addAccent (Acute 3) (case agavos.s ! AF Masc Sg Nom of { 
                          st + "os*"  => st + "o" ;
                          st + "o's*" => st + "o'" ;
                                    _ => Predef.tk 1 (agavos.s ! AF Masc Sg Nom) }) ;  -- TEST case only
           stem0 = dropAccent stem ;
           posA : Adj = agavos ;
           cmpA : Adj = mkAdj (noun (stem+"teros")) (noun (stem0+"te'ra_")) (noun (stem+"teron")) ;
           supA : Adj = mkAdj (noun (stem+"tatos")) (noun (stem0+"ta'th")) (noun (stem+"taton")) ;
        in 
         { s   = table { Posit => posA.s ;   Compar => cmpA.s ;   Superl => supA.s } ;
           adv = table { Posit => posA.adv ; Compar => cmpA.adv ; Superl => supA.adv } 
         } ;

-- proper nouns

  -- stem ending in -s:  (diogenes-)                    -- BR 48 b).4, b).5
  pn3s : Str -> Gender -> ProperNoun = \diogenhs,g -> 
    let
        diogenhs = canonize diogenhs ;
        stem : Str = (case diogenhs of { stm + "hs*"  => stm + "es" ;      
                                         stm + "h~s*" => stm + "e'es" }) ; 
        at  = (toWord stem).a ; 
        cV : Str -> Str = contractVowels ;
        nom = diogenhs ;                    
        gen : Str = cV (dropS (stem + "os*")) ;
        dat : Str = cV (dropS (stem + "i")) ;
        acc : Str = variants{ cV (dropS (stem + "a")) ; cV (dropS (stem + "an")) } ;
        voc : Str = addAccent' at (cV (stem + "*"))
     in
        mkProperNoun nom gen dat acc voc g Sg ;
  
  
-- verbs ----------------------------------------------------------------------------

-- For $Verb$

-- We use the verb tenses for clauses, as the Greek verbal system is organized
-- around aspect and expresses absolute or relative tenses rather implicitly.

  oper 
    Tense = VTense ;  

-- When forming sentences, we use antTense : VTense -> Anteriority -> VTense
-- to choose some ad-hoc anterior tense. 

param 
  -- Full verbs have three voices (the medium roughly corresponds to reflexive verbs)

  Voice = Act | Med | Pass ;  -- Active, Medium, Passiv:

  -- Greek has two kinds of deponent verbs lacking active forms.

  VType = VFull | DepMed | DepPass ; -- to be used in predV 

  -- There are four "main" tenses, which except GFut correspond to 
  -- the three aspects: imperfective, perfective and perfect:

  VTmp = GPres | GFut | GAor | GPerf ;  -- greek main tenses

  --   VAspect = Durativ -- ongoing     (Praesens-stem)  -- Imperfective
  --           | Perform -- pointwise   (Aorist-stem)    -- Performative
  --           | State   -- resultative (Perfect-stem)   -- Perfect
  --           ;

  -- finite Forms: the 'main' tenses are those with several moods, Pres,Fut,Aor,Perf.

  VTense = VPres Mood   -- (in the order of verbstems)
         | VImpf        -- imperfect has just Ind, no Opt, no Conj mood
         | VFut MoodF   -- future has just Ind and Opt, no Conj mood
         | VAor  Mood 
         | VPerf Mood
         | VPlqm ;      -- plusquamperfect has just Ind, no Opt, no Conj mood
  Mood  = VInd | VConj | VOpt; -- | VImp 
  MoodF = FInd | FOpt ; -- Conj and Imp don't exist in Fut

  -- Imperatives exist in all voices but only three of the main tenses and of course 
  -- not all (person,number)-combinations:  [BR say nothing on imperatives in Dual]

  ITmp   = IPres | IAor | IPerf ;  
  NumPers = SgP2 | SgP3 | PlP2 | PlP3 ;

  -- Remark: there are no imperative forms in Active IPerf; we deliver dummy values.

  -- infinite Forms: infinitives and participles, exist in the main tenses. 
  -- Additionally, there are two verbal adjectives (modalized passive participles).

{- -- Hence we should have a verb type with the following finite and infinite forms:
 oper 

  Verb : Type = {
    s : VForm => Str ;
    vadj1 : Adj ;  -- paideyto's  = who can be educated
    vadj2 : Adj ;  -- paideyte'os = who must be educated
    vtype : VType 
    } ;
  
 param
  VForm  = VFin Voice VTense Number Person    
         | VImp Voice ITmp NumPers
         | VInf Voice VTmp                    
         | VPart Voice VTmp AForm
         | VAdj1 AForm 
         | VAdj2 AForm
         ;
-}

  -- But to produce the paradigms more easily, we split the verb forms into active, 
  -- medium and passive forms, and generate these separately. 

param
  Vform = Fin VTense Number Person 
        | Imp ITmp NumPers 
        | Inf VTmp 
        | Part VTmp AForm ;
  
oper
  Verb : Type = {
    act : Vform => Str ;
    med : Vform => Str ;
    pass : Vform => Str ;
    vadj1 : Adj ;  -- paideyto's  = who can be educated
    vadj2 : Adj ;  -- paideyte'os = who must be educated
    vtype : VType 
    } ;

-- Two conjugation classes: -w (paideyw) and -mi (isthmi) BR 78

  endingsV : (Str*Str*Str*Str*Str*Str*Str*Str) -> Number -> Person -> Str = 
    \es,n,p -> case n of {
      Sg => case p of { P1 => es.p1 ; P2 => es.p2 ; P3 => es.p3 } ;
      Pl => case p of { P1 => es.p4 ; P2 => es.p5 ; P3 => es.p6 } ; 
      Dl => case p of { P1 => es.p4 ; P2 => es.p7 ; P3 => es.p8 } -- BR 141
      } ;

--  themVoc = endingsV <"o",[],"e","o","e","o",[],[]> ;

  endingsImp : (Str*Str*Str*Str) -> NumPers -> Str = 
    \es,np -> case np of { SgP2 => es.p1 ; SgP3 => es.p2 ; PlP2 => es.p3 ; PlP3 => es.p4 } ;


  -- Augmentation and reduplication: for Ind (Impf|Aor|Plqm) and (Perf|Plqm|PerFut)
  -- Note: Verbs with prepositional prefix reduplicate *after* the prefix (BR 85);
  --       this is done in prefixV of ParadigmsGrc.gf.

  -- augmentation: BR 83, used in Ind (Impf|Aor|Plqm)
  dehnung : Str -> Str = \v ->
     case v of { (#longV|"oy")    => v ;
                 ("ai"|"a|"|"ei") => "h|" ;   -- i.e. "a_|" => "h|"
                 ("ay"|"ey")      => "hy" ;
                 "oi"             => "w|" ;
                 "y."             => "y_" ;
                 "i."             => "i_" ;
                 ("a"|"e")        => "h" ; 
                 "o"              => "w" ;
                 x                => x } ;
                 
  augment : Str -> Str = \v ->
     case v of { vow@(#longV|"oy"|"ai"|"a|"|"ei"|"ay"|"ey"|"oi"|"y."|"i."|"a"|"e"|"o") 
                 + rest           => dehnung vow + rest ;
                 "r(" + rest      => "e)rr" + rest ; 
                 c@#consonant + _ => "e)" + v ;
                 _                => v } ;  -- Predef.error

  unaugment : Str -> Str = \v ->                 -- partial; used in MorphoGrc.mkVerbW 
     case v of { "e)'" + rest => rest ;          -- TODO: complete
                 "e)"  + rest => rest ;
                 "h)'" + rest => "a)'" + rest ;
                 "h)" + rest  => "a)" + rest ;
                 "w('" + rest => "o('" + rest ;  -- "w('plizon" > "o(pli'zw" 
                 _            => v } ;           

  -- reduplication: BR 84, used in the perfectstem (Perf|Plqm|PerFut)
  reduplicate : Str -> Str = \v ->
     case v of { ("r"|"q"|"x"|"z") + _                 => augment v ;      -- BR 84.3
                 "f" + rest@(("l"|"r") + _)            => "p" + "e" + v ;  -- BR 84.2
                 "v" + rest@(("l"|"r") + _)            => "t" + "e" + v ;
                 "c" + rest@(("l"|"r") + _)            => "k" + "e" + v ;
                 "f" + #consonant + _                  => augment v     ;  -- BR 84.3
                 "v" + #consonant + _                  => augment v     ;  -- BR 84.3
                 "c" + #consonant + _                  => augment v     ;  -- BR 84.3
                 c@("p"|"t"|"k"|"b"|"d"|"g")
                     + rest@(("l"|"r"|"n"|"m") + _)    =>  c  + "e" + v ; 
                 "f" + _                               => "p" + "e" + v ;  -- BR 84.1
                 "v" + _                               => "t" + "e" + v ;  
                 "c" + _                               => "k" + "e" + v ; 
                 #consonant + #consonant + _           =>  augment v    ;  
                 c@#consonant + _                      =>  c  + "e" + v ;  
                 _                                     => augment v        -- BR 84.3
       } ;
       -- TODO: exceptions BR 86: augment ei instead of h, augment+prepostion, double augment

  unaspirate : Str -> Str = \str ->                                        -- BR 22.3
     case str of { x + "f" + v@vowel + "f" + y => x + "p" + v + "f" + y ;  -- conjugation
                   x + "v" + v@vowel + "v" + y => x + "t" + v + "v" + y ;
                   x + "c" + v@vowel + "c" + y => x + "k" + v + "c" + y ;
                   _ => str } ;

  -- Accent in finite verb forms is as far back from the end as possible 
  -- by the accent rules                                                   -- BR 87

  -- tempusstems: BR 80 2 (weak: by adding tempus marker)
  -- act|med|pass Pres : paideyw      VAct (VPres VInd) Sg P1  
  --      act|med Fut  : paideysw     VAct (VFut  FInd) Sg P1
  --      act|med Aor  : epaideysa    VAct (VAor VInd)  Sg P1
  --          act Perf : pepaideyka   VAct (VPerf VInd) Sg P1
  --     med|pass Perf : pepaideymai  VMed (VPerf VInd) Sg P1
  --         pass Aor  : epaideyvhn   VPass (VAor VInd) Sg P1
  --              VAdj : paideytos    VAdj Masc Sg Nom 
                                      -- verbal adjective (may be missing)
         
  -- Paradigms for verbs: (incomplete) see MorphoGrc.gf


  -- Verb Phrases: we construct verb phrases from verbs by fixing a voice (to 
  -- arrive at a predicate) and storing objects and modifiers as separate fields
  -- of a record:

oper
  VP : Type = {                
    s : VPForm => Str ; 
    neg : Polarity ;           -- TODO: need 3 values: Pos, Ouk, Mh 
    obj : Agr => Str ;         -- nominal complement (Agr: for reflexives, possessives)
    adj : Gender => Number => Str ; -- predicative adj
    adv : Str ;                -- adverb
    ext : Str                  -- sentential complement
  } ;

  -- Since there are no analytic forms, verb forms are just the (intended) verb forms
  -- (VForm rather than Vform) with a fixed voice:

param
  VPForm = VPFin VTense Number Person          -- VPForm has fixed Voice
         | VPImp VPImpForm                     -- resp.: VPImp ITmp NumPers
         | VPInf VTmp 
         | VPPart VTmp AForm
         | VPAdj1 AForm 
         | VPAdj2 AForm
         ;
  VPImpForm = ImpF ITmp NumPers ;              -- needed by lincat Imp in CatGrc.gf 

oper
  -- using VType, we choose active (for full verbs) or medium resp. passive (for deponents)
 
  predV : Verb -> VP = \v -> 
   {
     s = table { VPFin t n p => case v.vtype of { -- DepPass has "active" forms in v.med
                                    VFull              => v.act ! (Fin t n p) ;
                                    (DepMed | DepPass) => v.med ! (Fin t n p) } ;
                 VPInf tmp => case v.vtype of {
                                    VFull              => v.act ! (Inf tmp) ;
                                    (DepMed | DepPass) => v.med ! (Inf tmp) } ;
                 VPPart tmp af => case v.vtype of {
                                    VFull              => v.act ! (Part tmp af) ;
                                    (DepMed | DepPass) => v.med ! (Part tmp af) } ; 
                 VPImp (ImpF IPres n_p) => 
                                  case v.vtype of {
                                    VFull              => v.act ! (Imp IPres n_p) ;  
                                    (DepMed | DepPass) => v.med ! (Imp IPres n_p) } ;
                 VPImp (ImpF IAor n_p) => 
                                  case v.vtype of {
                                    VFull              => v.act ! (Imp IAor n_p) ;  
                                    (DepMed | DepPass) => v.med ! (Imp IAor n_p) } ;
                 VPImp (ImpF IPerf n_p) => 
                                  case v.vtype of {
                                    VFull              => v.act ! (Imp IPerf n_p) ;  
                                    (DepMed | DepPass) => v.med ! (Imp IPerf n_p) } ;
                 VPAdj1 a    => v.vadj1.s ! a ;
                 VPAdj2 a    => v.vadj2.s ! a
         } ;
     neg = Pos ; 
     obj = \\_ => [] ;
     adj = \\_,_ => [] ;
     adv = [] ;
     ext = [] 
  } ;

  VPSlash = VP ** {c2 : Preposition} ;

  predV2 : (Verb ** {c2 : Preposition}) -> VPSlash = \v -> predV v ** {c2 = v.c2} ;

  -- Pronouns following a preposition must be emphasized, hence appPrep: Prep -> NP -> Str

  insertObj : (Agr => Str) -> VP -> VP = \obj,vp -> {
    s   = vp.s ;
    neg = vp.neg ;
    obj = \\a => vp.obj ! a ++ obj ! a ;
    adj = vp.adj ;
    adv = vp.adv ;
    ext = vp.ext
  } ;

  insertObjPre : (Agr => Str) -> VP -> VP = \obj,vp -> {
    s   = vp.s ;
    neg = vp.neg ;
    -- obj needs  (Agr => Str):  them to Vinf[.. their:refl(GenNum) ..]
    obj = \\a => obj ! a ++ vp.obj ! a ;   
    adj = vp.adj ;
    adv = vp.adv ;
    ext = vp.ext
  } ;

  insertObjc : (Agr => Str) -> VPSlash -> VPSlash = \obj,vp -> 
    insertObjPre obj vp ** {c2 = vp.c2} ;


  insertAdj : (AForm => Str) -> VP -> VP = \adj,vp -> {
     s   = vp.s ;
     neg = vp.neg ;
     obj = vp.obj ;
     adj = \\g,n => adj ! AF g n Nom ++ vp.adj ! g ! n ;
     adv = vp.adv ;
     ext = vp.ext
   } ;

  insertAdv : Str -> VP -> VP = \adv,vp -> {
    s   = vp.s ;
    neg = vp.neg ;
    obj = vp.obj ;
    adj = vp.adj ;
    adv = vp.adv ++ adv ;
    ext = vp.ext
  } ;

   infVP : VP -> Agr -> Str = \vp,a ->     -- TODO: dependence on VTmp : (VTmp => Str) ?
      vp.s ! VPInf GPres ++ vp.obj ! a ;

   -- for linref VP etc in CatGrc.gf
   useInfVP : VP -> Str = \vp -> vp.obj ! (Ag Masc Sg P3) ++ vp.adv ++ vp.s ! VPInf GPres;    

   Clause : Type = {s : VTense => Polarity => Order => Str} ;  -- VTense contains Mood parts

   mkClause : Str -> Agr -> VP -> Clause = \subj,a,vp -> {
    s = \\t,p => let 
                     g = genderAgr a ;
                     n  = numberAgr a ;
                     pers = personAgr a ;
                     vform : VPForm =               -- BR 257.2, agreement exception
                         case a of { Ag Neutr Pl P3 => VPFin t Sg P3 ; 
                                                  _ => VPFin t n  pers } ;
                     vpf = vp.s ! vform ;
                 in  -- ad-hoc word orders:
                     table { SVO => subj ++ negation ! p ++ vpf ++ vp.obj ! a ++ vp.adj ! g ! n ++ vp.adv ;
                             OSV => vp.obj ! a ++ subj ++ negation ! p ++ vp.adj ! g ! n ++ vp.adv  ++ vpf ; 
                             VSO => negation ! p ++ vpf ++ subj ++ vp.obj ! a ++ vp.adj ! g ! n ++ vp.adv 
                           } ;  -- negation also sentence-initial?! TODO
   } ;

-- TODO: BR 250 Distinguish between two negations: 
--       oy in assertions, 
--       mh in wishes, conditionals and conditional-like adverbials, participles e.a., infinitives
-- Is it useful to have a field vp.neg for the negation adverb? To store the ou- versus mh-negation?

   negation : Polarity => Str = table {
     Pos => [] ;   
     Neg => pre {"oy)" ; 
                 "oy)k" / vowelLenis ; 
                 "oy)c" / vowelAsper ; 
                 "oy)'" / punctuation }  -- BR 24, BR 10 b
   } ;

{- TEST: i -retain ResGrc.gf
Lang> cc negation ! ParamX.Neg ++ "e)'cw"  ==> "oy)k" ++ "e)'cw"
Lang> cc negation ParamX.Neg ++ "e('cw"  ==> "oy)c" ++ "e('cw"
Lang> cc negation ParamX.Neg ++ "sch'sw" ==> "oy)" ++ "sch'sw"
Lang> cc negation ParamX.Neg ++ ".Blah"  ==> "oy)'" ++ ".Blah"
-}

-- determiners

-- Probably, the Voc case and the Dl number should be excluded in
-- determiners and quantifiers and pronouns.
oper
  Determiner : Type = {
    s : Gender => Case => Str ;
    n : Number
    } ;

  Quantifier : Type = { 
    s : Number => Gender => Case => Str ;  -- sp: for quantifier used as NP
    } ;

  mkQuantifG : (_,_,_,_, _,_,_,_, _,_,_,_ : Str) -> 
    Gender => Case => Str = 
    \mn,ma,mg,md, fnm,fa,fg,fd, nn,na,ng,nd -> table {
      Masc  => cases mn ma mg md ;
      Fem   => cases fnm fa fg fd ;  -- fnm, since fn is a keyword of gf
      Neutr => cases nn na ng nd 
    } ;
      
  mkQuantifier : (sg,pl,dl : Gender => Case => Str) -> Quantifier = \sg,pl,dl ->
    { s  = table {Sg => sg ; Pl => pl ; Dl => dl} } ;

  -- definite article: (Greek has no indefinite article)
  ho_Quantifier = mkQuantifier  
       (mkQuantifG "o(" "to'n" "toy~" "tw|~" 
                   "h(" "th'n" "th~s" "th|~"
                   "to'" "to'" "toy~" "tw|~")
       (mkQuantifG "oi(" "toy's*" "tw~n" "toi~s*" 
                   "ai(" "ta's*"  "tw~n" "tai~s*"
                   "ta'" "ta'" "tw~n" "toi~s*")
       (mkQuantifG "tw'" "tw'" "toi~n" "toi~n"     -- from DefArt
                   "tw'" "tw'" "toi~n" "toi~n"
                   "tw'" "tw'" "toi~n" "toi~n") ;

-- demonstrative pronoun 

   hode_Quantifier = mkQuantifier
       (mkQuantifG "o('de" "to'nde" "toy~de" "tw|~de" 
                   "h('de" "th'nde" "th~sde" "th|~de"
                   "to'de" "to'de"  "toy~de" "tw|~de")
       (mkQuantifG "oi('de" "toy'sde" "tw~nde" "toi~sde" 
                   "ai('de" "ta'sde"  "tw~nde" "tai~sde"
                   "ta'de" "ta'de" "tw~nde" "toi~sde")
       (mkQuantifG "tw'" "tw'" "toi~n" "toi~n"   -- TODO: Dual???
                   "tw'" "tw'" "toi~n" "toi~n"   -- from DefArt
                   "tw'" "tw'" "toi~n" "toi~n") ;

   houtos_Quantifier = mkQuantifier
       (mkQuantifG "oy(~tos*" "toy~ton" "toy'toy" "toy'tw|" 
                   "ay('th" "tay'thn" "tay'ths*" "tay'th|" 
                   "toy~to" "toy~to" "toy'toy" "toy'tw|" )
       (mkQuantifG "oy(~toi" "toy'toys*" "toy'twn" "toy'tois*" 
                   "ay(~tai" "tay'ta_s*" "tay'twn" "tay'tais*"
                   "tay~ta" "tay~ta" "toy'twn" "toy'tois*")
       (mkQuantifG "tw'" "tw'" "toi~n" "toi~n"   -- TODO: Dual???
                   "tw'" "tw'" "toi~n" "toi~n"   -- from DefArt
                   "tw'" "tw'" "toi~n" "toi~n") ;

   ekeinos_Quantifier : Quantifier = 
        let ekeinos = adj2AO "e)kei~nos" "e)kei'nhs"
         in { s : Number => Gender => Case => Str = 
                 \\n,g,c => case <g,n,c> of {<Neutr,Sg,Nom|Acc> => "e)kei~no" ;
                                              _ => ekeinos.s ! AF g n c} 
            };

   oydeis_Quantifier = mkQuantifier              -- BR 73.1
     (mkQuantifG "oy)dei's*" "oy)de'na" "oydeno's*" "oy)deni'"
                 "oy)demi'a" "oy)demi'an" "oy)demia~s*" "oy)demia~|"
                 "oy)de'n"   "oy)de'n"  "oy)deno's*" "oy)deni'")
     (mkQuantifG "oy)de'nes*" "oy)de'nas*" "oy)de'nwn" "oy)de'si"
                 "oy)de'nes*" "oy)de'nas*" "oy)de'nwn" "oy)de'si" -- guessed (nonExists?)
                 "oy)de'nes*" "oy)de'nas*" "oy)de'nwn" "oy)de'si") -- guessed 
     (mkQuantifG nonExists nonExists nonExists nonExists
                 nonExists nonExists nonExists nonExists
                 nonExists nonExists nonExists nonExists) ;

   mhdeis_Quantifier = mkQuantifier              -- BR 73.1
     (mkQuantifG "mhdei's*" "mhde'na" "mhdeno's*" "mhdeni'"
                 "mhdemi'a" "mhdemi'an" "mhdemia~s*" "mhdemia~|"
                 "mhde'n"   "mhde'n"  "mhdeno's*" "mhdeni'")
     (mkQuantifG "mhde'nes*" "mhde'nas*" "mhde'nwn" "mhde'si"
                 "mhde'nes*" "mhde'nas*" "mhde'nwn" "mhde'si" -- guessed (nonExists?)
                 "mhde'nes*" "mhde'nas*" "mhde'nwn" "mhde'si") -- guessed 
     (mkQuantifG nonExists nonExists nonExists nonExists
                 nonExists nonExists nonExists nonExists
                 nonExists nonExists nonExists nonExists) ;

   nonExists : Str = [] ;

--2 For $Pronoun$: see MorphoGrc

param 
  Tonicity = Ton | Aton ;  -- for emphasized vs. unemphasized personal pronoun
                           
  PronForm = NPCase Tonicity Case         -- forms of personal pronouns
           | NPPoss Gender Number Case ;  -- forms of possessive pronouns (adjective)
  
oper
   cases = overload {
     cases : (_,_,_,_ : Str) -> Case => Str = 
             \n,a,g,d   -> table Case [n ; a ; g ; d ; n] ;
     cases : (_,_,_,_,_: Str) -> Case => Str = 
             \n,a,g,d,v -> table Case [n ; a ; g ; d ; v] ;
   } ;

   -- To build the reflexive: BR 65
             
   autos : { s : Gender => Number => Case => Str } = -- himself/the same, ipse/idem, BR 65
        let autos = adjAO "ay)to's" ;
         in {s = \\g,n,c => case <g,n,c> of {<Neutr,Sg,Nom|Acc> => "ay)to'" ;
                                              _ => autos.s ! AF g n c} 
            };
   allos : { s : Gender => Number => Case => Str } = -- another, alius, BR 65
        let allos = adjAO "a)'llos" ;
         in {s = \\g,n,c => case <g,n,c> of {<Neutr,Sg,Nom|Acc> => "a)'llo" ;
                                              _ => allos.s ! AF g n c} 
            };

   tosoytos : { s : Gender => Number => Case => Str } =  -- variant: toioytos
        let dAsp : Str -> Str = \str -> case str of { "ay(" + r => "ay" + r ;
                                                      "oy(" + r => "oy" + r ; 
                                                      "t" + r   => r ;
                                                              _ => str } 
         in  
        { s = \\g,n,c => "tos" + dAsp(houtos_Quantifier.s ! n ! g ! c) } ;

   toioytos : { s : Gender => Number => Case => Str } =  -- variant: toioytos
        let dAsp : Str -> Str = \str -> case str of { "ay(" + r => "ay" + r ;
                                                      "oy(" + r => "oy" + r ; 
                                                      "t" + r   => r ;
                                                              _ => str } 
         in  
        { s = \\g,n,c => "toi" + dAsp(houtos_Quantifier.s ! n ! g ! c) } ;


--2 For $Numeral$

-- All Greek ordinals inflect for gender and case (Number ??) BR 73.1.
-- Greek cardinals n < 4 and n > 200 depend on gender and case (BR 73.1), 
-- the remaining ones are constant (hence: unnecessarily big as tables).

param
  CardOrd = NCard Gender Case   
          | NOrd AForm           -- TODO: can they depend on number? 
          | NAdv ;               --       oi tritoi anthropoi?

  DForm = DUnit  | DTeen  | DTen | DHundred ; 
  Unit = one | ten | hundred ;   -- TODO: add chiliad = 1.000, myriad = 10.000 ?

--5 Prepositions:

oper
  Preposition : Type = {s : Str ; c : Case} ;

  -- Greek pronouns must be in stressed form if preceeded by a preposition. BR 64 2b
  appPrep : Preposition -> { s : Case => Str ; e : Case => Str ; isPron : Bool } -> Str = 
    \p,np -> if_then_Str np.isPron (p.s ++ np.e ! p.c) (p.s ++ np.s ! p.c) ;

  -- TODO: reflexive arguments (and those with a possessive) depend on agreement parameters
  --       add this to emphasized forms!
  -- See ExtraGrc

--2 For $Sentence$

param
  Order  = SVO | OSV | VSO ;  -- VOS

oper
  conjThat : Str = "o('ti" ;

-- 15.3.12
-- Clauses are build using all tense, aspect, mood combinations
-- possible for verbs in Greek. Sentences have one of eight
-- fixed values. CatGrc puts
--
--     Temp  = {s : Str ; t : ResGrc.VTense ; a : Anteriority } ; 
--     Tense = {s : Str ; t : ResGrc.VTense } ;  -- cf. TenseGrc
--
-- See TenseGrc for the (preliminarily) chosen interpretation of 
-- TPres, TPast, TFut, TCond : Tense by values of VTense. Combined 
-- with Anter, Simul : Anteriority, this gives 8 Temp values. 
-- 
-- The following function chooses (in a flexible, preliminary way)
-- some "anterior" tenses for TPres,...,TCond from VTense, which is
-- used in UseCl when building sentences from clauses:

oper 
--   (anteriorTense : T.Temp -> VTense = \t -> antTense t.t t.a ;
--    raises missing lockfield warnings)

   antTense : VTense -> Anteriority -> VTense = \t,a -> 
      case <t,a> of { <VPres VInd,  Anter>  => VAor VInd ;   -- TPres.t
                      <VImpf,       Anter>  => VPlqm     ;   -- TPast.t
                      <VFut FInd,   Anter>  => VPres VConj ; -- TFut.t
                      <VPres VConj, Simul>  => VAor VConj ;  -- TCond.t
                      _                     => t
      } ;                       

{-
oper  eqParam : (P:PType) -> P -> P -> PBool = 
      \P,p,q -> eqStr (show P p) (show P q);

      exception : (P:PType) -> (V:Type) -> (p:P) -> (v:V) -> (P => V) -> (P => V) =
      \P,V,p,v,t -> \\q => case (eqParam P p q) of { PTrue => v ; PFalse => t ! q } ;

   In gf-3.3.3 it now works:                        
   cc exception Case Str Acc "a)'ndra" (table Case { Nom => "a)nh'r" ; _ => "a)ndro's*"}) 
   table ResGrc.Case {
     ResGrc.Nom => "a)nh'r";
     ResGrc.Acc => "a)'ndra";
     ResGrc.Gen => "a)ndro's*";
     ResGrc.Dat => "a)ndro's*";
     ResGrc.Voc => "a)ndro's*"
   }

  But in gf-3.7.1, Predef.show and hence eqParam don't work, nor does Predef.eqVal.
oper
  exception : (P:PType) -> P -> Str -> {s:P => Str} -> {s:P => Str} =
  \P,p,v,c -> c ** { s = \\q => case (pbool2bool (eqVal P p q))
                                of { True => v ; _ => c.s ! q } } ;

  But this has the disadvantage that one cannot use subtypes c : C =< { s : P => Str }
  to overwrite the paradigm, but leave other fields of c intact: 

    (exception P p v c)  does not have type C, but only { s : P => Str }.
-}
}
