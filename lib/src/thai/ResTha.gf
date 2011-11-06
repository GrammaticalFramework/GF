--# -path=.:../abstract:../common:../../prelude

--1 Thai auxiliary operations.
--
---- This module contains operations that are needed to make the
---- resource syntax work. To define everything that is needed to
---- implement $Test$, it moreover contains regular lexical
---- patterns needed for $Lex$.
--
resource ResTha = ParamX ** open StringsTha, Prelude in {

  oper

-- binding words together

  thbind = overload {
    thbind : Str -> Str = \s -> s ;
    thbind : (s1,s2 : Str) -> Str = \s1,s2 -> s1 ++ BIND ++ s2 ;
    thbind : (s1,_,s3 : Str) -> Str = \s1,s2,s3 -> s1 ++ BIND ++ s2 ++ BIND ++ s3 ;
    thbind : (s1,_,_,s4 : Str) -> Str = 
      \s1,s2,s3,s4 -> s1 ++ BIND ++ s2 ++ BIND ++ s3 ++ BIND ++ s4 ;
    thbind : (s1,_,_,_,s5 : Str) -> Str = 
      \s1,s2,s3,s4,s5 -> s1 ++ BIND ++ s2 ++ BIND ++ s3 ++ BIND ++ s4 ++ BIND ++ s5 ;
    thbind : (s1,_,_,_,_,s6 : Str) -> Str = 
      \s1,s2,s3,s4,s5,s6 -> 
       s1 ++ BIND ++ s2 ++ BIND ++ s3 ++ BIND ++ s4 ++ BIND ++ s5 ++ BIND ++ s6 ;
    } ;


-- noun and classifier

    Noun = {s,c : Str} ;  

    mkN : Str -> Str -> Noun = \s,c -> {s = s ; c = c} ;

-- before and after classifier; whether classifier needed (default)

    Determiner = {s1, s2 : Str ; hasC : Bool} ; 

    mkDet : Str -> Str -> Determiner = 
      \s,c -> {s1 = s ; s2 = c ; hasC = True} ;

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

-- Verb phrases: form negation and question, too.

   VP = {
     s : Polarity => Str 
     } ;

   mkVP : Verb -> VP = \v -> {
     s = \\p => if_then_Str v.isCompl 
                   (thbind v.s1 (polStr may_s p ++ v.s2))
                   (v.s1 ++     (polStr may_s p ++ v.s2)) --- v.s1 = []
     } ;

   insertObj : VP -> NP -> VP = \vp,o -> {
     s = \\p => thbind (vp.s ! p) o.s
     } ; 

   adjVP : Adj -> VP = \a -> {
     s = \\p => polStr may_s p ++ a.s
     } ;

   insertObject : Str -> VP -> VP = \np,vp -> {
     s = \\p => thbind (vp.s ! p) np
     } ;

   polStr : Str -> Polarity -> Str = \m,p -> case p of {
     Pos => [] ;
     Neg => thbind m []
     } ;

-- clauses

param ClForm = ClDecl | ClQuest ;

oper
  NP = SS ;

  Clause = {
    s : ClForm => Polarity => Str
    } ;

  mkClause : NP -> VP -> Clause = \np,vp -> {
    s = table {
      ClDecl  => \\p => thbind np.s (vp.s ! p) ;
      ClQuest => \\p => thbind np.s (vp.s ! p) m'ay_s
      }
    } ;

}
