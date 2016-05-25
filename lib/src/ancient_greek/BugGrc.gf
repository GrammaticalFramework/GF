--# -path=.:../abstract:../common:../prelude

resource BugGrc = ParamX ** open (Ph=PhonoGrc), ResGrc, (P=Predef) in {

-- flags optimize = noexpand ;  -- optimize=all is impossible with addAccent
flags optimize = noexpand;
oper
  vowel : pattern Str = Ph.vowel ;  -- Syntax problem: I still have to use #Ph.vowel, not #vowel
  toWord : Str -> Word = ResGrc.toWord ;      -- else I get a ConcreteLazy error: missing pattern
{-
  -- I. problematic calls are:
  call1 : Str = toStrNs1 (toWord "ge'ne") "os*" ;  -- 500ms
  call2 : Str = toStrNs2 (toWord "ge'ne") "os*" ;  --  12ms
  call3 : Str = toStrNs3 (toWord "ge'ne") "os*" ;  --  12ms
  call4 : Str = toStrNs4 (toWord "ge'ne") "os*" ;  -- 450ms

--  cc Id (toStrNs1) ; -- loops(?)
    -- ...
--  cc Id (toStrNs4) ; -- loops(?)

  toStrNs1 : Word -> Str -> Str =  -- bad
            \w,e -> let we = adjustAccent <w, toNEnding e> ;
                        sl : Soundlaw = 
                             case e of { #Ph.vowel + _ => \xy -> (cV (dS xy)) ; 
                                                  _ => \xy -> xy } ;
                        we' = sl we
                     in toStr (concat we') ;               

  toStrNs2 : Word -> Str -> Str =  -- ok
            \w,e -> let we = adjustAccent <w, toNEnding e> ;
                        we' : Word*NEnding = case e of { #Ph.vowel + _ => (cV (dS we)) ; 
                                                                  _ => we } ;
                     in toStr (concat we') ;               

   slOrig : Soundlaw = \ue -> case (toStr ue.p2) of { #Ph.vowel + _ => (cV (dS ue)) ; _ => ue } ;  
   toStrNs3 : Word -> Str -> Str =  -- ok
             \w,e -> let we = adjustAccent <w, toNEnding e> ;
                         sl : Soundlaw = slOrig ;
                         we' = sl we ;
                      in toStr (concat we') ;               

   toStrNs4 : Word -> Str -> Str =  -- bad 
             \w,e -> let we = adjustAccent <w, toNEnding e> ;
                         sl : Soundlaw = -- = slOrig 
                              \ue -> case (toStr ue.p2) of { #Ph.vowel + _ => (cV (dS ue)) ; _ => ue } ;  
                         we' = sl we ;
                      in toStr (concat we') ;               

  Id : (Word -> Str -> Str) -> (Word -> Str -> Str) = \x -> x ;

-- Also note: cc toStrNs1 (toWord "ge'ne") "o*s" ;  -- "o*s" instead o "os*" !
-- shows 

-- ====================================================================================
-- II. Embedding further: try building part of a noun paradigm using the toStrNs-functions
--     in some variations, and define . Then the slowdown muliplies(?) if the problem is nested.
--
-- cc the following call5 under various sl:Soundlaw, definied outside toStrNs (ls1 - ls6) 
-- used in the let sl : Soundlaw = ... of toStrNs 
-- either a) by  let sl : Soundlaw = slX  (X=1,..,6)
--     or b) by  let sl : Soundlaw = ... defining term of lsX .

   call5 : {PlGen : Str ; SgDat : Str} = noun3s "ge'nos*" "genoy~s*" ResGrc.Neutr ; 

   toStrNs : Word -> Str -> Str = 
             \w,e -> let we = adjustAccent <w, toNEnding e> ;
                        sl : Soundlaw = sl6 ;                                 --   30ms 
--                        sl : Soundlaw = \ue -> (cV (dS (adjustAccent ue))) ;  -- 2000ms
--
--                        sl : Soundlaw = sl5 ;                                                                      -- 12ms
--                        sl : Soundlaw = \ue -> case (toStr ue.p2) of { #Ph.vowel + _ => (cV (dS ue)) ; _ => ue } ; -- 730ms
--
--                        sl : Soundlaw = sl4 ;                                                             -- 20ms
--                        sl : Soundlaw = \we -> case (toStr we.p2) of { #Ph.vowel + _ => we ; _ => we } ;  -- Bug we_25
--                        sl : Soundlaw = \ue -> case (toStr ue.p2) of { #Ph.vowel + _ => ue ; _ => ue } ;  -- 20ms
--
--                        sl : Soundlaw = sl3 ;                                                                -- 50ms
--                        sl : Soundlaw = toSL' (\xy -> case xy of {<x+"e","o"+y> => <x,"oy"+y> ; _ => xy }) ; -- 50ms
                        we' = sl we ;
                     in toStr (concat we') ;               

  sl1 : Soundlaw = (\xy -> xy) ;                                                              -- identity
  sl2 : Soundlaw = toSL' (\xy -> xy) ;                                                        -- identity
  sl3 : Soundlaw = toSL' (\xy -> case xy of {<x+"e","o"+y> => <x,"oy"+y> ; _ => xy }) ;
  sl4 : Soundlaw = \we -> case (toStr we.p2) of { #Ph.vowel + _ => we ; _ => we } ;           -- identity
  sl5 : Soundlaw = \ue -> case (toStr ue.p2) of { #Ph.vowel + _ => (cV (dS ue)) ; _ => ue } ; 
  sl6 : Soundlaw = \ue -> (cV (dS (adjustAccent ue))) ;  -- 900ms

  noun3s : Str -> Str -> Gender -> { SgDat : Str ; PlGen : Str } = \genos, genoys, g -> 
    let 
        -- BR 48: stems ending in s; input needs -s* at the end
        w        = toWord genos ;
        syl      = w.s ;
        stem : Str = case genoys of { 
                        stm + ("oy's*"|"oy~s*") => stm + "e"; 
                        _                       => Predef.tk 4 genoys + "e" } ;
        -- toStrNs : Word -> Str -> Str = toStrNs;         -- does not(?) compile
        ge'ne:Word = let stm : Word = toWord stem 
                     in case stm.a of { NoAccent => toWord (addAccentW w.a stm) ; 
                                        _        => stm } ; 
        genei  = toStrNs ge'ne (endingsN3!Sg!Dat!g!syl) ;  -- Accent: gene'+wn > genw~n 
        genwn  = toStrNs ge'ne (endingsN3!Pl!Gen!g!syl) ;  --    not: ge'ne+wn > ge'nwn
    in { SgDat = genei ; PlGen = genwn } ;
-}
-- III. Finally, if you uncomment -- toStrNs in noun3s, it seems not to compile ...

{- Generic overwriting of table slots does not work in GF:

  exception : (P:PType) -> (V:Type) -> (p:P) -> (v:V) -> (P => V) -> (P => V) =
     \P,V,p,v,t -> table { p => v ; x => t ! x }  ;

  updateAdj : (AForm => Str) -> (AForm => Str) = 
      \adj -> exception AForm Str (AF Masc Sg Nom) "new" adj ; 

  updateMSN : (AForm => Str) -> (AForm => Str) = -- nongeneric; this works
      \adj -> table { (AF Masc Sg Nom) => "new" ; form => adj ! form } ;

  equal : (P:PType) -> P -> P -> Bool = 
      \P,p,q -> case q of { p => True ; _ => False } ;

  eq : (P:PType) -> (P*P) => Bool = 
      \P -> table (P*P) { <p,p> => True ; _ => False } ;

Lang> cc exception
\P_205,V_206,p_207,v_208,t_209 -> table P_205 {
             ^^^^^                  p_210 => v_208;
                                    ^^^^^
                                    x_211 => t_209 ! x_211
                                  }
-}

  eqParam : (P:PType) -> P -> P -> Predef.PBool = 
      \P,p,q -> Predef.eqStr ((Predef.show P) p) ((Predef.show P) q);

-- cc eqParam ResGrc.Gender ResGrc.Fem ResGrc.Masc
-- Predef.PFalse


  exception : (P:PType) -> (V:Type) -> (p:P) -> (v:V) -> (P => V) -> (P => V) =
     \P,V,p,v,t -> \\q => table { Predef.PTrue => v ; Predef.PFalse => t ! q } ! (eqParam P p q) ;

  
  tab1 : ResGrc.Gender => Str = \\c => "masc" ;
  tab2 : ResGrc.Gender => Str = exception ResGrc.Gender Str ResGrc.Fem "fem" tab1 ;
}
