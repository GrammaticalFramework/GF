--# -path=.:../abstract:../prelude:../common


-- Mongolian Lexical Paradigms - implementations

instance ParadigmsMon of ParadigmsMonI = ParadigmsMonO ** open Prelude, MorphoMon, CatMon, ResMon in {

-- NOTE: regV and mkN,mk2N etc. cannot be compiled with optimize=all/value, because 
-- addSuf in regV and mkDecl in mkN would horribly increase the code size by inserting 
-- many copies of dropVowel, plSuffix, vowelType, which cannot yet be evaluated as 
-- stem is unknown. So it's important to not expand the let-declarartions.

-- With optimize=noexpanding, ParadigmsMon can be compiled, but building LexiconMon 
-- is slow (200 sec); improved by reorganization of mkN-functions (to 70 sec).

 flags optimize=noexpand ; coding=utf8 ;  -- see NOTE!

oper

-- Noun definitions: 

 mkN = overload { mkN : Str -> Noun = regN ;
                  mkN : (_,_ : Str) -> Noun = reg2N } ; 

 mk2N : (adj : Str) -> Noun -> Noun = \adj,n -> { 
    s = table { 
        sf => adj ++ (n.s ! sf) 
        } 
    } ;


 mkLN = overload { mkLN : Str -> Noun = loanN ;
                   mkLN : (_,_ : Str) -> Noun = loan2N } ; 

 regN  : Str -> Noun = \nomSg -> mkDeclDrop (chooseDcl nomSg) nomSg ; 
 loanN : Str -> Noun = \nomSg -> mkDeclNoDrop (chooseDcl nomSg) nomSg ; 

 mkPN = \pn -> lin PN {
    s = \\rc => (loanN pn).s ! (SF Sg (toNCase rc Definite)) 
    } ;


 modDecl : (Dcl -> Dcl) -> Str -> Noun = 
            \mod,nomSg -> mkDeclDrop (mod (chooseDcl nomSg)) nomSg ;
 modDeclL : (Dcl -> Dcl) -> Str -> Noun = 
            \mod,nomSg -> mkDeclNoDrop (mod (chooseDcl nomSg)) nomSg ;

 mkN01a : Str -> Noun = \nomSg -> modDecl modDcl01a nomSg ;
 mkN01b : Str -> Noun = \nomSg -> modDecl modDcl01b nomSg ;
 mkN01c : Str -> Noun = \nomSg -> modDecl modDcl01c nomSg ;
 mkN01d : Str -> Noun = \nomSg -> modDecl modDcl01d nomSg ;
 mkN01e : Str -> Noun = \nomSg -> modDecl modDcl01e nomSg ; 
 mkN01f : Str -> Noun = \nomSg -> modDecl modDcl01f nomSg ;
 mkN01g : Str -> Noun = \nomSg -> modDecl modDcl01g nomSg ;
 mkN01h : Str -> Noun = \nomSg -> modDecl modDcl01h nomSg ;
 mkLN01c : Str -> Noun = \nomSg -> modDeclL modDcl01c nomSg ;

 modDecl2 : (Dcl -> Dcl) -> Str -> Str -> Noun = 
            \mod,nomSg,nomPl -> mkDecl2Drop (mod (chooseDcl nomSg)) nomSg nomPl ;
 modDecl2L : (Dcl -> Dcl) -> Str -> Str -> Noun = 
            \mod,nomSg,nomPl -> mkDecl2NoDrop (mod (chooseDcl nomSg)) nomSg nomPl ;

 reg2N : (nomSg,nomPl : Str) -> Noun = modDecl2 modDcl2N ;
 loan2N : (nomSg,nomPl : Str) -> Noun = modDecl2L modDcl2N ;

 mkN02a : (nomSg,nomPl : Str) -> Noun = modDecl2 modDcl02a ;
 mkN02b : (nomSg,nomPl : Str) -> Noun = modDecl2 modDcl02b ;
 mkN02c : Str -> Str -> Noun = \nomSg,ablSg -> 
            (mkDeclDrop (modDcl02c (chooseDcl nomSg) ablSg)) nomSg ;
 mkN02d : (nomSg,nomPl : Str) -> Noun = modDecl2 modDcl02d ;
 mkN02e : (nomSg,nomPl : Str) -> Noun = modDecl2 modDcl02e ;

  
-- On the top level, maybe $NP$ is used rather than $PN$.  

 mkNP : Str -> Def -> NP = \x,d -> lin NP { 
    s = \\rc => (regN x).s ! (SF Sg (toNCase rc d)) ; 
    p = P3 ; 
    n = Sg ;
    isPron = False ;
	isDef = case d of {
	Definite => True ;
	_ => False } ;
    } ;

-- Verb definitions 

 regV : Str -> Verb = \inf ->  
   let 
    vt                  = vowelType inf ;
    stem                = stemVerb inf ;
    VoiceSuffix         = chooseVoiceSuffix stem ;
    VoiceSubSuffix      = chooseVoiceSubSuffix stem ;
    CoordinationSuffix  = chooseAnterioritySuffix stem ;  
    ParticipleSuffix    = chooseParticipleSuffix stem ;   
    SubordinationSuffix = chooseSubordinationSuffix stem
   in { 
    s = table { 
        VFORM vc asp te => addSuf stem (combineVAT VoiceSuffix ! vc ! asp ! te) ;
        VIMP direct imp => addSuf stem ((combineDI stem) ! direct ! imp) ;
        SVDS vc so      => addSuf stem (combineVS VoiceSubSuffix SubordinationSuffix ! vc ! so) ;
        CVDS anter      => addSuf stem (CoordinationSuffix ! anter) ;
		VPART part rc   => addSuf stem (combinePRc ParticipleSuffix ! part ! rc)
        } ;
    vtype = VAct ;
    vt = vt ; -- vowelType stem ;
    } ;
         
 verbToAux : Verb -> Aux = \verb -> {
    s = table {
        VVTense t => verb.s ! VFORM Act Simpl t ;
        VVImp direct imp => verb.s ! VIMP direct imp ;
        VVSubordination sub => verb.s ! SVDS ActSub sub ;
        VVCoordination ant => verb.s ! CVDS ant ;
        VVParticiple part rc => verb.s ! VPART part rc
        } ;
    vt = verb.vt 
    } ;
    
 auxToVerb : Aux -> Verb = \aux -> {
    s = table {
        VFORM _ _ t => aux.s ! VVTense t ;
        VIMP direct imp => aux.s ! VVImp direct imp ;
        SVDS _ sub => aux.s ! VVSubordination sub ;
        CVDS ant => aux.s ! VVCoordination ant ;
        VPART part rc => aux.s ! VVParticiple part rc
        } ;
    vtype = VAct ;
    vt = aux.vt 
    } ;
 
 mkV : Str -> Verb = regV ;
 auxBe : Aux = verbToAux (regV "байх") ;

 -- remaining functions mkV2,mkV3,...,mkVA in ParadigmsMonO.gf

} 
