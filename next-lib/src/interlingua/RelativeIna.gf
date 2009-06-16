concrete RelativeIna of Relative = CatIna ** open ResIna in {

  flags optimize=all_subs ;

  lin

    RelCl cl = {
      s = \\use_irreg,t,a,p,agr => 
	(case agr.n of {Sg => "tal"; Pl => "tales"}) ++ 
	"que" ++ cl.s ! use_irreg ! t ! a ! p ! ODir ; 
      c = Nom
      } ;

    RelVP rp vp = {
      s = \\use_irreg,t,a,p,agr => (mkClause (rp.s!Nom) agr vp).s ! use_irreg ! t ! a ! p ! ODir;
      c = Nom
      } ; 
    -- !!! person agreement is probably bad here; see below.

---- Pied piping: "a que tu invia flores"

    RelSlash rp slash = {
      s = \\use_irreg,t,a,p,agr => slash.p2 ++ rp.s ! slash.c2 ++ slash.s ! use_irreg ! t ! a ! p ! ODir ;
      c = slash.c2; 
      } ; 
    -- !!! In the above The agreement feature of the RP does not match
    -- the the (parametric!) agreement of the resulting clause.  
    -- Is it a bug? I believe there is the same behaviour in the english grammar.

    FunRP p np rp = {
      s = \\c => np.s ! Acc ++ p.s ++ rp.s ! p.c ;
      a = np.a
      } ;


    IdRP = {
	-- TODO: variant: "le qual"
      a = {p = P3; n = variants {Sg; Pl}};
      s = table {
	Nom => quique;   --  Le ultime traino que pote portar me ibi a tempore parti in cinque minutas
	Gen => "cuje";  --  Le documentos cuje importantia esseva dubitose incriminava le spia
	Acc => "que";   --  Le documentos que le spia portava con se esseva multo importante 
	Dat => "a" ++ quique;
	Abl => "de" ++ quique
      }} ;

    oper 
      quique = variants {"qui";  -- !!! Only for humans, only after a preposition.
			 -- This is extremely strange, because it does not match any Romance language I know. 
			 -- For now just be lax and make it a variant of "que"
			 "que"};
      
}
