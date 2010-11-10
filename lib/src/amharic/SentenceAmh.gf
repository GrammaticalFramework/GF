--# -path=.:abstract:common:prelude
--
concrete SentenceAmh of Sentence = CatAmh ** open 
  ResAmh, ParamX
   in {
--
--
 flags optimize=all_subs ; coding=utf8 ;
--        
  lin

	


	PredVP np vp = mkClause (np.s ! Nom) np.a.png vp ;

        SlashVP np vp =  mkClause (np.s ! Nom) np.a.png vp ** {c2 = vp.c2} ;

	ImpVP vp = {
			s = \\p,g,n =>
			case p of {
				Pos => vp.obj.s  ++  vp.imp  ;
				Neg => vp.obj.s  ++ "አት" ++ "&+" ++ vp.imp 
			}
		      };
	
--ImpVP     : VP -> Imp ;              -- love yourselves
    --FIXME, all tenses

	    UseCl  t ap cl = 
	      let ss : Str = case t.t of 
		      {
		       Pres => cl.s ! PresFut ! ap.p ;
		       Cond => cl.s ! PresFut ! ap.p ;
		       Past => cl.s ! SimplePast ! ap.p ;
		       Fut  => cl.s ! PresFut ! ap.p
		      }
		   in {

		s =  ss
	     };

		


	    UseQCl  t ap qcl = 

	      let ss : Str = case t.t of 
		      {
		       Pres => qcl.s ! PresFut ! ap.p ;
		       Cond => qcl.s ! PresFut ! ap.p ;
		       Past => qcl.s ! SimplePast ! ap.p ;
		       Fut  => qcl.s ! PresFut ! ap.p
		      }
		   in {

		s =  ss
	     };
	
	EmbedVP vp = {s =   vp.obj.s ++ vp.inf} ;

	AdvS a s = {s = a.s ++ "፤" ++ s.s} ;

	SSubjS a s b = {s = b.s ++ s.s ++ a.s} ;




}
