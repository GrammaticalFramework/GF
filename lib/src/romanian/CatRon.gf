--# -path=.:../Romance:../common:../abstract:../common:prelude

concrete CatRon of Cat =
  CommonX - [Temp,TTAnt,Tense,TPres,TPast,TFut,TCond] 
  ** open Prelude, ResRon, MorphoRon,(R = ParamX) in {

  flags optimize=all_subs ;


  
  lincat

-- Tensed/Untensed

    S  = {s : Mood => Str} ;
    QS = {s : QForm => Str} ;
    RS = {s : Mood => Agr => Str ; c : NCase} ;
    SSlash = {
      s  : AAgr => Mood => Str ; 
      c2 : Compl
      } ;
-- Sentence

    Cl    = {s : Direct => RTense => Anteriority => Polarity => Mood => Str} ;
    ClSlash = {
      s  : AAgr => Direct => RTense => Anteriority => Polarity => Mood => Str ; 
      c2 : Compl
      } ;
    Imp   = {s : Polarity => ImpForm => Gender => Str} ;

-- Relative

    RCl  = {
      s : Agr => RTense => Anteriority => Polarity => Mood => Str ; 
      c : NCase 
      } ;
    RP   = {s : AAgr => NCase => Str ; a : AAgr ; hasAgr : Bool; hasRef : Bool} ;

-- Verb

   VP = {
      s : VForm => Str ;
      isRefl : Agr => RAgr ;
      nrClit : VClit ;
      isFemSg : Bool ;                 -- needed for the correct placement of the Accusative clitic    
      neg    : Polarity => Str ;         -- ne-pas  not needed - just "nu"
      clAcc  : RAgr ;                    -- le/se -- not needed if they are used in the noun
      clDat  : RAgr ;                    -- lui -- not needed if they are used in the noun
      comp   : Agr => Str ;              -- content(e) ; à ma mère ; hier - 
      ext    : Polarity => Str ;         -- que je dors / que je dorme - so that it always comes after all the complements
      } ;
 
  VPSlash = VP ** {c2 : Compl; needAgr : Bool} ;
  --  Comp = {s : Agr => Str} ; 

-- Adjective

    AP = {s : AForm => Str ; isPre : Bool} ; 

-- Noun
 lincat 
   CN      = {s : Number => Species => ACase => Str; g : NGender; a : Animacy } ; 
   Pron    = {s : NCase =>  Str ;
              c1, c2 : Clitics => Str ;
              a : Agr ;
              poss : Number => Gender => Str 
              } ;
   NP      = NounPhrase ;
     --NCase because of the pronoun

   Det      = {s : Gender => NCase => Str ;  n : Number ; 
               isDef : Bool ; 
               post : Gender => NCase => Str ;
               sp : Gender => NCase => Str ;   -- pentru Lexicon e aceeasi forma totusi ! posibil
                                              -- probabil pentru ca orice Quant -> Det
               size : Str ; --because of the numerals
               hasRef : Bool
               };
   Predet  = {s : AAgr   => ACase => Str ; c : NCase} ;
  -- Art     = {s : Bool => Number => Gender => NCase => Str ; isDef : Bool } ;
   Quant = {
     s  : Bool => Number => Gender => ACase => Str ; 
     sp : Number => Gender => ACase => Str ; -- diferente si in Lexicon, ex : acesta, aceasta 
     isDef : Bool ;
     isPost : Bool ;
     hasRef : Bool 
    };  

-- Numeral

   Numeral = {s : ACase => CardOrd => NumF => Str ;
              sp : ACase => CardOrd => NumF => Str ; size : Size } ;
   Digits  = {s : CardOrd => Str ; n : Size ; isDig : Bool} ;

   Num     = {s : Gender => Str ; sp : Gender => Str ; 
              isNum : Bool ; n : Number; size : Str } ;
   Card    = {s : Gender => Str ; sp : Gender => Str ;
               n : Number; size : Size} ;
   Ord     = {s : Number => Gender => NCase => Str; isPre : Bool} ;
    
--Question 
  -- Question

    QCl    = {s : RTense => Anteriority => Polarity => QForm => Str} ;
    IComp  = {s : AAgr => Str} ;     
    IDet   = {s : Gender => ACase => Str ; n : Number} ;
    
    IQuant = {s : Number => Gender => ACase => Str } ;
    IP     = {s : NCase => Str ; a : AAgr ; hasRef : Bool} ;
-- Structural
 
    Conj = {s1,s2 : Str ; n : Number} ;
    Subj = {s : Str} ; --they all need Indicative mood
    Prep = {s : Str ; c : NCase ; isDir : PrepDir ; needIndef : Bool ; prepDir : Str} ;

-- Open lexical classes, e.g. Lexicon
    --Verb = {s : VForm => Str } ;
    V ={s : VForm => Str ; isRefl : Agr => RAgr; nrClit : VClit} ;
    VQ, VA = V ; 
    V2,V2S, V2Q = V ** {c2 : Compl} ;
    V3,V2A, V2V = V ** {c2,c3 : Compl} ;
    VS = V ** {m : Polarity => Mood} ;
    VV = V ** {c2 : Agr => Str} ;
    A  = {s : AForm => Str ; isPre : Bool} ;
    A2 = {s : AForm => Str ; c2 : Compl} ;

    N  = Noun ; 
    N2 = Noun  ** {c2 : Compl} ;
    N3 = Noun  ** {c2,c3 : Compl} ;
    PN = {s : NCase => Str ; g : Gender ; n : Number; a : Animacy} ;
   
    Comp = {s : Agr => Str} ;
   
    Temp  = {s : Str ; t : RTense ; a : Anteriority} ;
    Tense = {s : Str ; t : RTense} ;
  lin
    TTAnt t a = {s = a.s ++ t.s ; a = a.a ; t = t.t} ;
    TPres = {s = []} ** {t = RPres} ;
    TPast = {s = []} ** {t = RPast} ;   --# notpresent
    TFut  = {s = []} ** {t = RFut} ;    --# notpresent
    TCond = {s = []} ** {t = RCond} ;   --# notpresent




oper
  aagr : Gender -> Number -> AAgr = \g,n ->
    {g = g ; n = n} ;
  agrP3 : Gender -> Number -> Agr = \g,n ->
    aagr g n ** {p = P3} ;

  conjGender : Gender -> Gender -> Gender = \m,n -> 
    case m of {
      Fem => n ;
      _ => Masc 
      } ;

  conjAgr : Agr -> Agr -> Agr = \a,b -> {
    g = conjGender a.g b.g ;
    n = conjNumber a.n b.n ;
    p = conjPerson a.p b.p
    } ;

--Conjuctions 
conjThan  : Str  = "decât" ;
conjThat  : Str = "cã" ;




}
