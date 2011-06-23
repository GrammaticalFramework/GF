--# -path=.:../abstract:../prelude:../common

-- Adam Slaski, 2011

   resource ParadigmsPol = open 
     MorphoPol, ResPol
  in 
     {
  flags  coding=utf8;

  oper mkPN : Str -> (Str -> SubstForm => Str) -> GenNum -> NounPhrase;
  oper mkPN form tab gennum = 
      { nom = (tab form)!SF Sg Nom; 
		voc = (tab form)!SF Sg VocP;
        dep = let forms = (tab form) in table {
          GenPrep|GenNoPrep=>forms!SF Sg Gen; 
		  AccPrep|AccNoPrep=>forms!SF Sg Acc;
          DatPrep|DatNoPrep=>forms!SF Sg Dat; 
		  InstrC=>forms!SF Sg Instr;
          LocPrep=>forms!SF Sg Loc};
        gn= gennum ; 
		p=P3
      } ;

  oper mkA2 : Adj -> Str -> ComplCase -> Adj ** {c : Complement };
  oper mkA2 adj s c = adj ** { c={s=s; c=c} };

};
