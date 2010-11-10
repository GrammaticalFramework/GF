concrete RelativeAmh of Relative = CatAmh ** open ResAmh in {
----
----  flags optimize=all_subs ;
----
----  lin
----
----    RelCl cl = {
----      s = \\t,a,p,_ => "سُعه" ++ "تهَت" ++ cl.s ! t ! a ! p ! ODir
----      } ;
----
----    RelVP rp vp = {
----      s = \\t,ant,b,ag => 
----        let 
----          agr = case rp.a of {
----            RNoAg => ag ;
----            RAg a => a
----            } ;
----          cl = mkClause (rp.s ! Nom) agr vp
----        in
----        cl.s ! t ! ant ! b ! ODir
----      } ;
----
----    RelSlash rp slash = {
----      s = \\t,a,p,_ => slash.c2 ++ rp.s ! Acc ++ slash.s ! t ! a ! p ! ODir
----      } ;
----
----    FunRP p np rp = {
----      s = \\c => np.s ! c ++ p.s ++ rp.s ! Acc ;
----      a = RAg np.a
----      } ;
----
----    IdRP = mkIP "وهِعه" "وهِعه" "وهْسي" Sg ** {a = RNoAg} ;


{-

-- The simplest way to form a relative clause is from a clause by
-- a pronoun similar to "such that".

    RelCl    : Cl -> RCl ;            -- such that John loves her

-- The more proper ways are from a verb phrase 
-- (formed in [``Verb`` Verb.html]) or a sentence 
-- with a missing noun phrase (formed in [``Sentence`` Sentence.html]).

    RelVP    : RP -> VP -> RCl ;      -- who loves John
    RelSlash : RP -> ClSlash -> RCl ; -- whom John loves

-- Relative pronouns are formed from an 'identity element' by prefixing
-- or suffixing (depending on language) prepositional phrases or genitives.

    IdRP  : RP ;                      -- which
    FunRP : Prep -> NP -> RP -> RP ;  -- the mother of whom


-}
----
}
