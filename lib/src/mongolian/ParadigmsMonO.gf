--# -path=.:../abstract:../prelude:../common

-- Mongolian Lexical Paradigms - implementations

-- This file contains the parts of ParadigmsMon which can be compiled with 
-- optimization=all; those which have to be compiled with optimize=noexpand 
-- are added in ParadigmsMon.gf

resource ParadigmsMonO = open Prelude, MorphoMon, CatMon in {

 flags coding=utf8 ; optimize=all ;      

-- Implementation of parameters

oper
 V0 = Verb ;      
 AS,AV = A ;      
 A2S,A2V = A2 ;    

 Bool  = Prelude.Bool ;
 true  = True;
 false = False ;

 RCase = MorphoMon.RCase ;
 nominative   = Nom ;
 genitive     = Gen ;
 dative       = Dat ;
 accusative   = Acc ;
 ablative     = Abl ;
 instrumental = Inst ;
 comitative   = Com ;
 directive    = Dir ;

 Number = MorphoMon.Number ;
 singular = Sg ;
 plural   = Pl ;

 Voice = MorphoMon.Voice ;
 active      = Act ;
 causative   = Caus ;
 passive     = Pass ;
 communal    = Comm ;
 adversative = Advs ;

 Aspect = MorphoMon.Aspect;
 simple     = Simpl ;  
 quick      = Quick ; 
 complete   = Compl ;
 collective = Coll ;

 VTense = MorphoMon.VTense ;
 presentperfect    = VPresPerf ;
 pastcomplete      = VPastComp ; 
 pastindefinite    = VPastIndef ; 
 future            = VFut ;
 
 Imperative = MorphoMon.Imperative ;
 intention  = Int ;
 decision   = Dec ;
 command    = Command ;
 request    = Req ;
 demand     = Demand ;
 admonition = Admon ;
 appeal     = Appeal ;
 permission = Perm ;
 hope       = Hope ;
 blessing   = Bless ;

 Subordination = MorphoMon.Subordination ;
 conditional        = Condl ;
 concessive         = Conc ;
 immediatsucceeding = ISucc ;
 logicalsucceeding  = LSucc ;
 intending          = Intend ;
 limiting           = Limit ;
 progressive        = Progr ;
 succeeding         = Succ ;

-- Implementation of Verbs:

-- Many suffixes have variants for different vowel types.
-- Since there are 3 causative and directness suffix alternatives (uul2/ul2, lga4 and ga4), 
-- we generate the tables depending on how the verb stem ends:									   
									   
 chooseCausativeSuffix : Str -> Suffix = \stem -> case stem of {
    _ + ("и"|("я"|"е"|"ё"|"ю")) => ul2 ; 
    _ + #longVowel              => lga4 ;
    _ + "ат"                    => aa4 ;					  
	_ + #consonant              => uul2 ;
	_                           => ga4
    } ;

-- Verb forms are build by attaching Voice, Aspect and Mood suffixes to the stem, 
-- in this order. The VoiceSuffix does not indicate a tense.
	
 chooseVoiceSuffix : Str -> Voice => Suffix = \stem ->
   let 
    caus = chooseCausativeSuffix stem 
   in
    table { 
        Act  => table { _ => [] } ; 
        Caus => caus ; 
        Pass => table {_ => "гд"} ; 
        Comm => table {_ => "лц"} ;
        Advs => table {_ => "лд"}  
	} ;
    
 AspectSuffix : Aspect => Suffix =
    table { 
        Simpl => table {_ => []} ;  
	    Quick => table {_ => "схий"} ; 
	    Coll  => tsgaa4 ; 
		Compl => table {_ => "чих"} 
	} ;
    
 VTenseSuffix : VTense => Suffix =
    table { 
        VPresPerf  => laa4 ; 
		VPastComp  => table {_ => "в"} ; 	
	    VPastIndef => table {_ => "жээ"} ; 
		VFut       => na4 
    } ;			  

 chooseSubordinationSuffix : Str -> Subordination => Suffix = \stem ->
    table { 
        Condl  => case stem of {
                    _ + ("в"|"л"|"м"|"н") => bal4 ; 
                                        _ => wal4 
                    } ;
       	Conc   => table {_ => "вч"} ;
        ISucc  => magts4 ;
        LSucc  => hlaar4 ;
        Intend => haar4 ;
        Limit  => tal4 ;
        Progr  => saar4 ;
        Succ   => nguut2 
    } ;	
	
 chooseDirectnessSuffix : Str -> Directness => Suffix = \stem ->
    table { 
        Indirect => chooseCausativeSuffix stem ; 
        Direct   => table { _ => []}
    } ;	
    
 ImperativeSuffix : Imperative => Suffix =
    table {
        Int     => ya3 ; 
        Dec     => sugai2 ;
		Command => table { _ => []} ; 
        Req     => aach4 ; 
        Demand  => aarai4 ;
        Admon   => uuzai2 ;
		Appeal  => gtun2 ;
        Perm    => table { _ => "г"} ;
        Hope    => aasai4 ; 
		Bless   => tugai2 
    } ;

 chooseAnterioritySuffix : Str -> Anteriority => Suffix = \stem ->
   let 
    chooseSimulSuffix : Str -> Suffix = \stm -> case stm of { 
        _ + ("б"|"н")                                    => table {_ => "ч"} ;
        (?|"")+(#doubleVowel|(#shortVowel + "й")) + "р"  => table {_ => "ч"} ;
        (_|"") + #basicVowel + _ + #basicVowel + _ + "р" => table {_ => "ч"} ;
        ("ав"|"өг"|"хүр"|"гар"|"сур")                    => table {_ => "ч"} ;
                                                       _ => table {_ => "ж"} 
    } ;
    chooseAnterSuffix : Str -> Suffix = \stm -> case stm of {
        _ + ("и"|#yVowel) => ad4 ; 
		_ + #longVowel    => table {vt => "г" + aad4!vt} ;
        _                 => aad4 
    } ;
   in
    table {
        Simul => chooseSimulSuffix stem ;
        Anter => chooseAnterSuffix stem 
    } ;

 chooseParticipleSuffix : Str -> Participle => Suffix = \stem ->
    table { 
        PPresIndef => dag4 ;
        PPresProgr => case stem of { 
                        _ + ("и"|#yVowel) => a4 ; 
		                _ + #longVowel    => table {vt => "г" + aa4!vt} ;
                                        _ => aa4 
        } ;
        PPast      => san4 ;
		PFut       => table {_ => "х"} ;
		PDoer      => table {_ => "гч"}
    } ;
	
  infSuffixes : RCase => Suffix = table {Dat  => ad4 ;
                                         Acc  => iig2 ;
                                         Abl  => aas4 ;										
                                         Inst => aar4 ;
										 Com  => tai3 ;
                                            _ => table { _ => [] }
                                       } ;
    
 chooseVoiceSubSuffix : Str -> VoiceSub => Suffix = \stem ->
   let 
    chVoice = chooseVoiceSuffix stem 
   in 
    table { 
        ActSub  => chVoice ! Act ;
        CausSub => chVoice ! Caus ;
		PassSub => chVoice ! Pass 
    } ;

-- The combined suffixes do not quite regularly depend on the vowel type of the unknown stem,
-- except that when one of the (causative or imperative) suffixes is uul2, the following ones
-- take the vowel type of this suffix rather than of the verb stem.

 modifyVT : (Voice => Suffix) -> Voice => VowelType => VowelType = \VoiceSuf -> 
    table Voice { 
        Caus => \\vt => case (VoiceSuf ! Caus ! vt) of {
                            ("уул"|"ул") => MascA ; 
                            ("үүл"|"үл") => FemE ; 
                                       _ => vt 
                        } ;
           _ => \\vt => vt 
    } ;
    
-- To combine suffixes to an extended verb stem, (stem + suffix) is refined by MorphoMon.addSufVt, 
-- so that insertion of softness markers or vowels between stem and suffix is cared for.

-- Testing showed that ((... (stem + suffix1) + suffix2) ...) + suffixN) is much slower
-- than (stem + (suffix1 + ... + suffixN)), because we can precompute the combination of 
-- all the suffixes for the 4 possible vowel types of stems. 

-- In the following combine-functions, use table types rather than function types, since
-- for function types like combineVAM : (Voice => Suffix) -> Voice -> Aspect -> VTense -> Suffix
-- the compiler does not execute applications like !vc!asp!md, whereas these are executed
-- via case distinction in tables when we use table types.

 voiceToVoiceSub : (Voice => VoiceSub) = 
    table { 
        Caus => CausSub ; 
        Pass => PassSub ; 
        _ => ActSub 
    } ;

 voiceSubToVoice : (VoiceSub => Voice) = 
    table { 
        CausSub => Caus ; 
        PassSub => Pass ; 
        ActSub => Act 
    } ;
	   
 voiceToDirectness : (Voice => Directness) = 
    table { 
        Caus => Indirect ; 
        _ => Direct 
    } ;

 directnessToVoice : (Directness => Voice) =
    table { 
        Indirect => Caus ; 
        Direct => Act 
    } ;
 	
 combineVAT : (Voice => Suffix) -> Voice => Aspect => VTense => Suffix = \VoiceSuf -> \\vc,asp,te => 
   let 
    AspTe = case asp of {
        Quick => table VowelType { vt => addSufVt vt (AspectSuffix!asp!vt) (VTenseSuffix!te!FemE) } ;
            _ => table VowelType { vt => addSufVt vt (AspectSuffix!asp!vt) (VTenseSuffix!te!vt) } } ;
    ModVT = (modifyVT VoiceSuf) ! vc
   in 
    table VowelType {vt => addSufVt (ModVT!vt) (VoiceSuf!vc!vt) (AspTe!(ModVT!vt))} ;
		
 combineDI : Str -> Directness => Imperative => Suffix = \stem -> \\direct,imp => 
   let 
	DirSuffix = chooseDirectnessSuffix stem ;
	ModVT = modifyVT (table Voice { vc => DirSuffix!(voiceToDirectness!vc) }) ! (directnessToVoice!direct)
   in  
    table VowelType { vt => addSufVt (ModVT!vt) (DirSuffix!direct!vt) (ImperativeSuffix!imp!(ModVT!vt)) } ;
 
 combineVS : (VoiceSub => Suffix) -> (Subordination => Suffix) -> VoiceSub => Subordination => Suffix = 
    \VoiceSubSuf,SubordSuf -> \\vcs,so => 
   let 
    ModVT = modifyVT (table Voice { vc => VoiceSubSuf ! (voiceToVoiceSub!vc) }) ! (voiceSubToVoice!vcs)
   in 
    table VowelType { vt => addSufVt (ModVT!vt) (VoiceSubSuf!vcs!vt) (SubordSuf!so!(ModVT!vt)) } ;   
 
 combinePRc : (Participle => Suffix) -> Participle => RCase => Suffix = \PartSuf -> \\part,rc => 
   let 
     modPart = chooseVtPart (table Participle { participle => PartSuf ! participle }) ! part
   in 
     table VowelType {vt => addSufVt (modPart!vt) (PartSuf!part!vt) (infSuffixes!rc!(modPart!vt))} ; 
	 
 chooseVtPart : (Participle => Suffix) -> Participle => VowelType => VowelType = \PartSuf -> table Participle {_ => \\vt => vt} ;
 
-- Prepositions: Mongolian has postpositions only.
 
 mkPrep : RCase -> Str -> Prep = \rc,p -> lin Prep {rc = rc ; s = p} ;
 noPrep : RCase -> Prep = \rc -> mkPrep rc [] ;
 
-- Conjunctions

 mkConj = overload {mkConj : Str -> Conj = mk1Conj ;
                    mkConj : Str -> Str -> Conj = mk2Conj} ;
                    
 mk1Conj : Str -> Conj = \y -> mk2Conj [] y ; 
 mk2Conj : Str -> Str -> Conj = \x,y -> lin Conj (sd2 x y) ; 
 mkSubj : Str -> Bool -> Subj = \x,b -> lin Subj {s = x ; isPre = b} ;
 
-- Noun stem classification 

 chooseDcl : Str -> Dcl = \str -> case str of {
    _ + #longVowel                             => longDcl ; 
    _ + #consonant + #consonant + #neuterVowel => iDcl ;
    _ + "л" + "ь"                              => lneuterConsDcl ;
    _ + "ь"                                    => neuterConsDcl ;
    _ + "н"                                    => nDcl ;
	_ + "в"                                    => vDcl ;
    _ + ("с"|"х")                              => shDcl ;
    _ + "г"                                    => gDcl ;
    _ + "г" + #shortVowel                      => gaDcl ;
    _ + #consonant + #shortVowel               => shortDcl ;
    _ + ("д"|"з"|"т"|"ц")                      => c91Dcl ;
    _ + ("ж"|"ш"|"ч"|"к")                      => c92kDcl ;
    _ + ("е"|"я")                              => yeyaDcl ;
    _ + "р"                                    => rDcl ;
    _                                          => nounDcl 
    } ;

 mkN2 : Noun -> N2 = \n -> mkNoun2 n (noPrep Gen) ;
 mkNoun2 : Noun -> Prep -> N2 ;
 mkNoun2 n p = lin N2 {
    s = n.s ; 
    c2 = {s = p.s ; rc = p.rc}
    } ;
    
 mkN3 : Noun -> Prep -> Prep -> N3 = \n,p1,p2 -> lin N3 {
    s = \\sf => n.s ! sf ; 
    c2 = p1 ; 
    c3 = p2
    } ;
 
-- Implementation of Adjectives
  
 mkA : (positive : Str) -> Adjective = \a -> lin A (ss a) ;
                
 mkA2 : Adjective -> Prep -> A2 = \a,p -> lin A2 a ** {c2 = p} ;

-- Definitions of determiners and quantifiers 
 
 mkOrd : Str -> Ord = \s -> lin Ord (ss s) ;

-- Adverb definitions

 mkAdv : Str -> Adv = \x -> lin Adv (ss x) ;
 
-- Verb definitions (without type, these defs cause errors because argtype is unknown)

-- Transitive verbs are verbs with two argument places.
 
 mkV2 = overload { mkV2 : Verb -> V2 = dirV2 ;
                   mkV2 : Verb -> Prep -> V2 = mkV2P } ;
                   
 dirV2 : Verb -> V2 = \v -> mkV2P v (noPrep Acc) ;
 mkV2P : Verb -> Prep -> V2 = \v,p -> lin V2 (v ** {c2 = p}) ;	

-- Ditransitive verbs are verbs with three argument places.

 mkV3 = overload { mkV3 : Verb -> V3 = dirV3 ;          
                   mkV3 : Verb -> Prep -> Prep -> V3 = mkV3P } ;
				   
 mkV3P : Verb -> Prep -> Prep -> V3 = \v,p1,p2 -> lin V3 (v ** {c2 = p1 ; c3 = p2}) ; 
 dirV3 : Verb -> V3 = \v -> mkV3P v (noPrep Acc) (noPrep Dat) ;

-- Other verbs 

 mkV0 : Verb -> V0 = \v -> lin V0 v ;
 mkVA : Verb -> VA = \v -> lin VA v ; 
 mkVS : Verb -> VS = \v -> lin VS v ;
 mkVV : Aux -> VV = \v -> lin VV v ;
 mkVQ : Verb -> VQ = \v -> lin VQ v ;

 mkV2S : Verb -> Prep -> V2S = \v,p -> lin V2S v ** {c2 = p} ;
 mkV2V : Verb -> Prep -> V2V = \v,p -> lin V2V (mkV2P v p) ;
 mkV2A : Verb -> Prep -> V2A = \v,p -> lin V2A v ** {c2 = p} ;
 mkV2Q : Verb -> Prep -> V2Q = \v,p -> lin V2Q v ** {c2 = p} ;

 mkAS, mkAV : Adjective -> A = \a -> lin A a ;
 mkA2S, mkA2V : Adjective -> Prep -> A2 = \a,p -> mkA2 a p ;

} 
