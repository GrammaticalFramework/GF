concrete RelativeGrc of Relative = CatGrc ** open ResGrc in {

  flags optimize=all_subs ;

  lin

--    RelCl cl = {
--      s = \\t,a,p,_ => "such" ++ "that" ++ cl.s ! t ! a ! p ! ODir ; 
--      c = Nom
--      } ;

   RelVP rp vp = {
--     s = \\t,ant,b,ag => 
     s = \\t,b,agr =>  -- TODO: anteriority, tense/vtense
       let 
         cl = mkClause (rp.s ! (genderAgr agr) ! numberAgr agr ! Nom) agr vp
       in
--       cl.s ! t ! ant ! b ! ODir ;
       cl.s ! t ! b ! SVO ; --ODir ;
     c = Nom
     } ;

-- Pied piping: "at which we are looking". 

   RelSlash rp slash = {
--     s = \\t,a,p,agr => 
--         slash.c2 ++ rp.s ! RPrep (fromAgr agr).g ++ slash.s ! t ! a ! p ! ODir ;
     s = \\t,p,agr =>  -- TODO: anteriority, tense/vtense
           slash.c2.s
           ++ rp.s ! (genderAgr agr) ! (numberAgr agr) ! (slash.c2.c)
           ++ slash.s ! t ! p ! OSV 
         ; 
     c = Acc -- ??
     } ;

--    FunRP : Prep -> NP -> RP -> RP ;  -- the mother of whom
--    FunRP p np rp = {
--      s = \\c => np.s ! Acc ++ p.s ++ rp.s ! RPrep (fromAgr np.a).g ;
--      a = RAg np.a
--      } ;

  IdRP = { s = \\g,n,c => relPron ! n ! g ! c } ;

oper     
    relPron : Number => Gender => Case => Str =  -- BR 69
      table { Sg => table { Masc => cases "o('s*" "o('n" "oy(~"  "w|(~" ;
                            Fem  => cases "h('"   "h('n" "h(~s*" "h|(~" ;
                            Neutr=> cases "o('"   "o('"  "oy(~"  "w|(~" 
                          } ;
              Pl | Dl =>        -- are there dual forms ??
                    table { Masc => cases "oi('" "oy('s*" "w(~n" "oi(~s*" ;
                            Fem  => cases "ai('" "a('s*"  "w(~n" "ai(~s*" ;
                            Neutr=> cases "a('"  "a('"    "w(~n" "oi(~s*" 
                          } 
             } ;
}
