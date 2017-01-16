concrete VerbIce of Verb = CatIce ** open ResIce, Prelude in {

--  flags optimize=all_subs ;

	lin
		UseV v = predV v;

		ComplVV vv vp = insertDir (predV vv) (\\_ => vv.c2.s ++ infVP vp) ;

		ComplVS vs s = insertDir (predV vs) (\\_ =>  s.s) ;

		ComplVQ vq qs = insertDir (predV vq) (\\_ => qs.s ! QDir) ;

		ComplVA va ap = insertDir (predV va) (\\a => ap.s ! a.n ! a.g ! Strong ! Nom) ;

		SlashV2a v = predV v ** {c2 = v.c2} ;

		Slash2V3 v3 np = (insertDir (predV v3) (\\a => v3.c3.s ++ np.s ! NCase v3.c3.c)) ** {dirShift = np.isPron; c2 = v3.c2} ;

		Slash3V3 v3 np = (insertInd (predV v3) (\\a => v3.c2.s ++ np.s ! NCase v3.c2.c)) ** {indShift = np.isPron; c2 = v3.c3} ;

		SlashV2V v2v vp = (insertDir (predV v2v) (\\_ => v2v.c3.s ++ infVP vp)) ** {c2 = v2v.c2} ;

		SlashV2S v2s s = (insertDir (predV v2s) (\\a => s.s)) ** {c2 = v2s.c2} ;

		SlashV2Q v2q qs = (insertDir (predV v2q) (\\a => qs.s ! QDir)) ** {c2 = v2q.c2} ; 

		SlashV2A v2a ap = (insertDir (predV v2a) (\\a => ap.s ! a.n ! a.g ! Strong ! v2a.c2.c)) ** {c2 = v2a.c2} ;

		ComplSlash vps np = insertDir vps (\\a => vps.c2.s ++ np.s ! NCase vps.c2.c ++ vps.dirObj ! np.a );

		SlashVV vv vps = (insertDir (predV vv) (\\_ => vv.c2.s ++ infVP vps)) ** {c2 = vps.c2} ;

		SlashV2VNP v2v np vps = (insertDir 
						(predV v2v) 
						(\\_ => v2v.c2.s ++ np.s ! NCase v2v.c2.c ++ v2v.c3.s ++ infVP vps)
					) ** {c2 = vps.c2} ;

		ReflVP vps = (insertInd 
					vps 
					(\\a => vps.indObj ! a ++ reflPron a.p a.n a.g vps.c2.c ++ vps.c2.s)
				) ** {indShift = True} ;

		UseComp comp = insertDir (predV verbBe) (\\a => comp.s ! a) ;

		PassV2 v2 = 
			let
				vp = predV verbBe
			in
				{
					s = \\vpform,pol,agr => vf (vp.s ! vpform ! pol ! agr).fin (v2.p ! PStrong agr.n agr.g Nom) (negation pol) True;
					p = \\pform	=> v2.p ! pform ;
					indObj = \\_	=> [] ;
					dirObj = \\a	=> vp.dirObj ! a ;
					a2 = [] ;
					indShift,dirShift = False
				} ;

		AdvVP vp adv = vp ** {a2 = vp.a2 ++ adv.s} ;

		ExtAdvVP vp adv = vp ** {n2 = \\a => adv.s ++ vp.n2 ! a} ;

		AdVVP adv vp = insertAdV adv.s vp ;

		AdvVPSlash vps adv = vps ** {a2 = vps.a2 ++ adv.s} ;

		AdVVPSlash adv vps = (insertAdV adv.s vps) ** {c2 = vps.c2} ;

		VPSlashPrep vp prep = vp ** {c2 = prep} ;

		CompAP ap = { 
			s = \\a => ap.s ! a.n ! a.g ! Strong ! Nom ;
		} ;
				
		CompNP np = {s = \\_ => np.s ! NCase Nom} ;

		CompAdv adv = {s = \\_ => adv.s} ;

		CompCN cn = {
			s = \\a	=> cn.s ! a.n ! Free ! Strong ! Nom ++ cn.comp ! a.n ! Nom;
		} ;

		UseCopula = predV verbBe ;

	oper
		insertDir : ResIce.VP -> (Agr => Str) -> ResIce.VP =\vp,obj -> vp ** {
			dirObj = obj
		} ;

		insertInd : ResIce.VP -> (Agr => Str) -> ResIce.VP =\vp,obj -> vp ** {
			indObj = obj
		} ;
			
		insertAdV  : Str -> ResIce.VP -> ResIce.VP = \adv,vp -> vp ** {
			s = \\vpform,pol,agr => 
				let
					vps = vp.s ! vpform ! pol ! agr
				in {
					fin = vps.fin ;
					inf = vps.inf ;
					a1 = case vpform of {
						VPImp | VPMood Pres Simul | VPMood Past Simul
								=> <vps.a1.p1, vps.a1.p2 ++ adv> ;
						_		=> <vps.a1.p1 ++ adv, vps.a1.p2>
					};
				} ;
		};
}
