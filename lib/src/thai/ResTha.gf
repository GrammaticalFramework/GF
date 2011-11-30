--# -path=.:../abstract:../common:../../prelude

--1 Thai auxiliary operations.
--
---- This module contains operations that are needed to make the
---- resource syntax work. To define everything that is needed to
---- implement $Test$, it moreover contains regular lexical
---- patterns needed for $Lex$.
--
resource ResTha = ParamX, StringsTha ** open Prelude in {

  oper

-- binding words together - if you want. But better do it with the unlexer -unchars.

  bIND = [] ;

  thbind = overload {
    thbind : Str -> Str = \s -> s ;
    thbind : (s1,s2 : Str) -> Str = \s1,s2 -> s1 ++ bIND ++ s2 ;
    thbind : (s1,_,s3 : Str) -> Str = \s1,s2,s3 -> s1 ++ bIND ++ s2 ++ bIND ++ s3 ;
    thbind : (s1,_,_,s4 : Str) -> Str = 
      \s1,s2,s3,s4 -> s1 ++ bIND ++ s2 ++ bIND ++ s3 ++ bIND ++ s4 ;
    thbind : (s1,_,_,_,s5 : Str) -> Str = 
      \s1,s2,s3,s4,s5 -> s1 ++ bIND ++ s2 ++ bIND ++ s3 ++ bIND ++ s4 ++ bIND ++ s5 ;
    thbind : (s1,_,_,_,_,s6 : Str) -> Str = 
      \s1,s2,s3,s4,s5,s6 -> 
       s1 ++ bIND ++ s2 ++ bIND ++ s3 ++ bIND ++ s4 ++ bIND ++ s5 ++ bIND ++ s6 ;

    thbind : SS -> SS = \s -> s ;
    thbind : (s1,s2 : SS) -> SS = \s1,s2 -> ss (s1.s ++ bIND ++ s2.s) ;
    thbind : (s1,_,s3 : SS) -> SS = \s1,s2,s3 -> ss (s1.s ++ bIND ++ s2.s ++ bIND ++ s3.s) ;
    thbind : (s1,_,_,s4 : SS) -> SS = 
      \s1,s2,s3,s4 -> ss (s1.s ++ bIND ++ s2.s ++ bIND ++ s3.s ++ bIND ++ s4.s) ;
    } ;

  thword = overload {
    thword : Str -> Str = \s -> s ;
    thword : (s1,s2 : Str) -> Str = \s1,s2 -> s1 + s2 ;
    thword : (s1,_,s3 : Str) -> Str = \s1,s2,s3 -> s1 + s2 + s3 ;
    thword : (s1,_,_,s4 : Str) -> Str = 
      \s1,s2,s3,s4 -> s1 + s2 + s3 + s4 ;
    thword : (s1,_,_,_,s5 : Str) -> Str = 
      \s1,s2,s3,s4,s5 -> s1 + s2 + s3 + s4 + s5 ;
    thword : (s1,_,_,_,_,s6 : Str) -> Str = 
      \s1,s2,s3,s4,s5,s6 -> s1 + s2 + s3 + s4 + s5 + s6 ;

    } ;

-- noun and classifier

    Noun = {s,c : Str} ;  

    mkNoun : Str -> Str -> Noun = \s,c -> {s = s ; c = c} ;

-- before and after classifier; whether classifier needed (default)

    Determiner = {s1, s2 : Str ; hasC : Bool} ; 

    mkDet : Str -> Str -> Determiner = -- before and after classifier
      \s,c -> {s1 = s ; s2 = c ; hasC = True} ;

    quantDet : Str -> Determiner = -- quantifier: before classifier 
      \s -> mkDet s [] ;

    demDet : Str -> Determiner =  -- demonstrative: after classifier 
      \s -> mkDet [] s ;

-- Part before and after negation (mai_s)

   Verb = {s1,s2 : Str ; isCompl : Bool} ;

   resV : Str -> Str -> Verb = \s,c -> {s1 = s ; s2 = c ; isCompl = True} ;

   regV : Str -> Verb = \s -> {s1 = [] ; s2 = s ; isCompl = False} ;

   dirV2 : Verb -> Verb ** {c2 : Str} = \v -> v ** {c2 = []} ;

-- Auxiliary verbs, according to order and negation.
-- The three types are $VV may VP | may VV VP | VP may VV$

 param VVTyp = VVPre | VVMid | VVPost ;

 oper 
   VVerb = {s : Str ; typ : VVTyp} ;

   Adj = SS ; 
 
   mkAdj : Str -> Adj = ss ;

-- Verb phrases: form negation and question, too.

   VP = {
     s : Polarity => Str ;
     e : Str -- extraposed clause
     } ;

  infVP : VP -> Str = \vp -> thbind (vp.s ! Pos) vp.e ; ----

  predV : Verb -> VP = \v -> {
     s = \\p => if_then_Str v.isCompl 
                   (thbind v.s1 (polStr may_s p ++ v.s2))
                   (v.s1 ++     (polStr may_s p ++ v.s2)) ; --- v.s1 = [] ;
     e = []
     } ;

   insertObj : NP -> VP -> VP = \o,vp -> {
     s = \\p => thbind (vp.s ! p) o.s ;
     e = vp.e
     } ; 

   insertExtra : Str -> VP -> VP = \o,vp -> {
     s = vp.s ;
     e = vp.e ++ o
     } ; 

   adjVP : Adj -> VP = \a -> {
     s = \\p => thbind (polStr may_s p) a.s ;
     e = []
     } ;

   insertObject : Str -> VP -> VP = \np,vp -> {
     s = \\p => thbind (vp.s ! p) np ;
     e = vp.e
     } ;

   polStr : Str -> Polarity -> Str = \m,p -> case p of {
     Pos => [] ;
     Neg => m
     } ;

   negation : Polarity -> Str = polStr may_s ;

-- clauses

param ClForm = ClDecl | ClQuest ;

oper
  NP = SS ;

  mkNP : Str -> NP = ss ;

  Clause = {
    s : ClForm => Polarity => Str
    } ;

  mkClause : NP -> VP -> Clause = \np,vp -> {
    s = table {
      ClDecl  => \\p => thbind np.s (vp.s ! p) vp.e ;
      ClQuest => \\p => thbind np.s (vp.s ! p) (polStr chay_s p) vp.e m'ay_s --- the place of vp.e?
      }
    } ;

  mkPolClause : NP -> VP -> {s : Polarity => Str} = \np,vp -> {
    s = (mkClause np vp).s ! ClDecl
    } ;

  conjThat = waa_s ;

  reflPron = thbind tua_s eeng_s ;

}
