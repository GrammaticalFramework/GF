--# -path=.:../abstract:../common:../prelude

-- Mongolian auxiliary operations.

-- This module contains operations that are needed to make the
-- resource syntax work. To define everything that is needed to
-- implement $Test$, it moreover contains regular lexical
-- patterns needed for $Lex$.

resource ResMon = ParamX ** open Prelude in {

 flags optimize=all ;  coding=utf8 ; 

param 
 VowelType = MascA | MascO | FemOE | FemE ; 

-- Suffixes:

-- Some suffixes have variants with different vowels; in adding the suffix 
-- to a stem, the variant that fits to the vowel type of the stem is used.

oper 
 Suffix = (VowelType => Str) ; 
  
-- Some of the suffixes with variants, used in noun and verb inflection, are:

  a4 = table { MascA => "а" ; MascO => "о" ; FemE => "э" ; FemOE => "ө" } ;  
  a3 = table { MascA => "а" ; MascO => "о" ; FemE | FemOE => "э" } ; 
  a2 = table { MascA | MascO => "а" ; FemE | FemOE => "э" } ; 
  i2 = table { MascA | MascO => "ы" ; FemE | FemOE => "ий" } ;    
  u2 = table { MascA | MascO => "у" ; FemE | FemOE => "ү" } ;    

    aa4 : Suffix = \\vt => a4!vt + a4!vt ;
    uu2 : Suffix = \\vt => u2!vt + u2!vt ;
    ai3 : Suffix = \\vt => a3!vt + "й" ;
    
-- Pluralsuffixes 
   uud2 : Suffix = \\vt => uu2!vt + "д" ;
   iud2 : Suffix = \\vt => "и" + u2!vt + "д" ;
  nuud2 : Suffix = \\vt => "н" + uu2!vt + "д" ;
  guud2 : Suffix = \\vt => "г" + uu2!vt + "д" ;

-- Declinationsuffixes
  iin2 : Suffix = \\vt => i2!vt + "н" ;
   nii2 : Suffix = \\vt => "н" + i2!vt ; 
    ii2 : Suffix = \\vt => i2!vt ;
    ad4 : Suffix = \\vt => a4!vt + "д" ;
   and4 : Suffix = \\vt => a4!vt + "нд" ;
   iig2 : Suffix = \\vt => i2!vt + "г" ; 
   aas4 : Suffix = \\vt => aa4!vt + "с" ; 
   ias3 : Suffix = \\vt => "и" + a3!vt + "с" ; 
    as4 : Suffix = \\vt => a4!vt + "с" ;
  naas4 : Suffix = \\vt => "н" + aa4!vt + "с" ;
  gaas4 : Suffix = \\vt => "г" + aa4!vt + "с" ;
   aar4 : Suffix = \\vt => aa4!vt + "р" ; 
   iar3 : Suffix = \\vt => "и" + a3!vt + "р" ; 
    ar4 : Suffix = \\vt => a4!vt + "р" ; 
  gaar4 : Suffix = \\vt => "г" + aa4!vt + "р" ;
   tai3 : Suffix = \\vt => "т" + a3!vt + "й" ;
   ruu2 : Suffix = \\vt => "р" + uu2!vt ;
   luu2 : Suffix = \\vt => "л" + uu2!vt ; 
   gaa4 : Suffix = \\vt => "г" + aa4!vt ;   
   
-- Conjugationsuffixes
   uul2 : Suffix = \\vt => uu2!vt + "л" ; 
    ul2 : Suffix = \\vt => u2!vt + "л" ;
	ga4 : Suffix = \\vt => "г" + a4!vt ;
   lga4 : Suffix = \\vt => "лг" + a4!vt ;
 tsgaa4 : Suffix = \\vt => "цг" + aa4!vt ;
    na4 : Suffix = \\vt => "н" + a4!vt ; 
   dag4 : Suffix = \\vt => "д" + a4!vt + "г" ;
   laa4 : Suffix = \\vt => "л" + aa4!vt ;
   san4 : Suffix = \\vt => "с" + a4!vt + "н" ;
    ya3 : Suffix = table { MascA => "я" ; MascO => "ё" ; FemE | FemOE => "е" } ;
 sugai2 : Suffix = table { MascA | MascO => "сугай" ; FemE | FemOE => "сүгэй" } ;
  aach4 : Suffix = \\vt => aa4!vt + "ч" ;
 aarai4 : Suffix = \\vt => aa4!vt + "р" + ai3!vt ;
 uuzai2 : Suffix = table { MascA | MascO => "уузай" ; FemE | FemOE => "үүзэй" } ;
  gtun2 : Suffix = \\vt => "гт" + u2!vt + "н" ;
  saar4 : Suffix = \\vt => "с" + aa4!vt + "р" ;
 aasai4 : Suffix = \\vt => aa4!vt + "с" + ai3!vt ;
 tugai2 : Suffix = table {MascA | MascO => "тугай" ; FemE | FemOE => "түгэй"} ;
   bal4 : Suffix = \\vt => "б" + a4!vt + "л" ;
   wal4 : Suffix = \\vt => "в" + a4!vt + "л" ;
 magts4 : Suffix = \\vt => "м" + a4!vt + "гц" ;
 hlaar4 : Suffix = \\vt => "хл" + aa4!vt + "р" ;
  haar4 : Suffix = \\vt => "х" + aa4!vt + "р" ;
   tal4 : Suffix = \\vt => "т" + a4!vt + "л" ;
  saar4 : Suffix = \\vt => "с" + aa4!vt + "р" ;
 nguut2 : Suffix = table {MascA | MascO => "нгуут" ; FemE | FemOE => "нгүүт"} ; 
  ngaa4 : Suffix = \\vt => "нг" + aa4!vt ;
   aad4 : Suffix = \\vt => aa4!vt + "д" ;
dugaar2 : Suffix = \\vt => "д" + u2!vt + "г" + a2!vt + a2!vt + "р" ;  

-- Word endings added in Mongolian inflection (of nouns, verbs, adjectives) depend on
-- the vowel type of the stem.

 vowelType : Str -> VowelType = \stem -> case stem of { 
    (_ + ("а"|"я"|"у") + ?)|(_ + ? + ("а"|"я"|"у"))     => MascA ;
	(_ + ("ё"|"о") + ?)|(_ + ? + ("ё"|"о"))             => MascO ;
	(_ + "ө" + ?)|(_ + ? + "ө")                         => FemOE ;
	(_ + ("э"|"ү"|"е"|"и") + ?)|(_ + ? + ("э"|"ү"|"е")) => FemE ;
	(("А"|"Я"|"У"|"Ю")+_)|(_+("а"|"я"|"у"|"ю")+_)       => MascA ;
    (("Ё"|"О")+_)|(_+("ё"|"о")+_)                       => MascO ;
    ("Ө"+_)|(_+"ө"+_)                                   => FemOE ;
    (("Э"|"Ү"|"Е"|"И")+_)|(_+("э"|"ү"|"е"|"и")+_)       => FemE ;
 	_    => Predef.error (["vowelType does not apply to: "] ++ stem)
    } ;
    
-- For $Noun$

-- Mongolian nouns do not have an inherent Gender parameter. Number is used
-- rarely. Nouns decline according to number and case. 
-- $Number$ is inherited from $ParamX$.
-- This is the $Case$ (8 cases in Mongolian) as needed for nouns and $NP$s.

param        
 RCase = Nom | Gen | Dat | Acc | Abl | Inst | Com | Dir ;
 NCase = NNom | NGen | NDat | NAcc Def | NAbl | NInst | NCom | NDir ;
 Def = Definite | Indefinite ;
 Poss = Possess| NonPoss ;
 
-- For the sake of shorter description number and case are 
-- combined in the type SubstForm.
 
 SubstForm = SF Number NCase ;
  
oper  
 Noun : Type = {s : SubstForm => Str} ;
 NounPhrase : Type = {s : RCase => Str; n : Number ; p : Person ; isPron : Bool ; isDef : Bool} ; 

param 
 PronForm = PronCase RCase | PronPoss RCase ;

oper 
 Pron = {s : PronForm => Str ; n : Number ;  p : Person } ; 
 mkCbP : Number -> Person -> Str = \n,p -> case <n,p> of { 
    <Sg,P1> => "минь" ; <Pl,P1> => "маань" ;
    <Sg,P2> => "чинь" ; <Pl,P2> => "тань" ;
    <_,P3> => "нь" 
    } ;
  
 reflPron : Number => RCase => Str = table {
    Sg => table RCase ["өөрөө";"өөрийнхөө";"өөртөө";"өөрийгөө";"өөрөөсөө";"өөрөөрөө";"өөртэйгээ";"өөр лүүгээ"] ;
    Pl => table RCase ["өөрсдөө";"өөрсдийнхөө";"өөрсөддөө";"өөрсдийгээ";
                       "өөрсдөөсөө";"өөрсдөөрөө";"өөрсөдтэйгээ";"өөрсөд рүүгээ"] 
    } ;
            
-- For $Numeral$

param
 CardOrd = NCard | NOrd ;
 DForm = Unit | Teen | Ten | Hundred ;
 Place = Indep | Attr ; 
  
-- For $Verb$  

-- The verb mood can be indicative (Tense-bound terminating suffixes (TTS)) and 
-- imperative (Person-bound terminating suffixes (PTS)). 
-- Indicative have tenses; but there are no person and (almost) no number suffixes.
-- Special forms are used for building coordination (Coordinating verb determining 
-- suffixes (CVDS)) and subordination (Subordinating verb determining suffixes (SVDS))
-- of sentences. Participles (Noun determining suffixes (NDS)) should be part of 
-- the adjectives.

 Voice = Act | Caus | Pass | Comm | Advs ; 
 Aspect = Simpl | Quick | Coll | Compl ;
 VTense = VPresPerf | VPastComp | VPastIndef | VFut ;
 
-- special parameter used for imperative 

 Directness = Direct | Indirect ; 
 Imperative = Int | Dec | Command | Req | Demand 
         | Admon | Appeal | Perm | Hope | Bless ;

-- Different verb forms are needed in subordinating clauses:
         
 Subordination = Condl | Conc | ISucc | LSucc | Intend | Limit | Progr | Succ ;
 VoiceSub = ActSub | CausSub | PassSub ;
 Participle = PPresIndef | PPresProgr | PPast | PFut | PDoer ;

-- Tense in ParamX does not fit well to Mongolian; therefore:

 Pastform = Perf | PresPerf | IndefPast ; -- в Perfect, лаа4 Presens Perfect, жээ Indefinite Past
 ClTense = ClPres | ClPast Pastform | ClFut ;
 
-- The VFORM verb forms, which we build on morphological level
-- combine voice, aspect and mood (TTS), where mood contains indicative tensed forms. 
-- Subordinate forms can be combined with some values of Voice and Aspect, while
-- participles, imperative and coordinating forms do not depend on Voice and Aspect:

 VerbForm = VFORM Voice Aspect VTense 
          | VIMP Directness Imperative 
	      | SVDS VoiceSub Subordination
          | CVDS Anteriority 
	      | VPART Participle RCase
          ; 
         
 VType = VAct | VRefl ;
 Passform = Passive | Causative ;
 
 VVVerbForm = VVTense VTense 
            | VVImp Directness Imperative 
            | VVSubordination Subordination
            | VVCoordination Anteriority
            | VVParticiple Participle RCase
            ;
            
 SType = Main | Sub Subordination | Coord | Quest Style | Part SubType ;
 SubType = Subject | Object | Adverbiale | Rel | emptySubject ;
 ComplType = ComplSubj | ComplObj | ComplAdv | Attributive | NoSubj ;
 Style = wQuest | yesNoQuest ;

 VPForm = VPFin ClTense Anteriority Polarity
        | VPImper Polarity Bool
        | VPPass Passform ClTense
        | VPPart ClTense Polarity RCase
        | VPSub Polarity Subordination
        | VPCoord Anteriority
        ; 
oper 
 Verb : Type = {
    s : VerbForm => Str ; 
    vtype : VType ;
    vt : VowelType
    } ;
    
 Aux : Type = {
    s : VVVerbForm => Str ; 
    vt : VowelType 
    } ;
   
 VerbPhrase : Type = { 
    s : VPForm => {fin,aux : Str} ;
    compl : RCase => Str ;
    adv : Str ; -- optional group of adverbial modifiers
    embedCompl : RCase => Str ; -- object sentence of the verb phrase
    vt : VowelType
	} ;

 vFin : ClTense -> VTense = \t -> case t of {
    ClPast pf => case pf of {
                  Perf      => VPastComp ;
                  PresPerf  => VPresPerf ;
                  IndefPast => VPastIndef 
                  } ;
    ClPres | ClFut     => VFut 
    } ; 
    
 vSub : Subordination -> VerbForm = \sub -> SVDS ActSub sub ;   
 
 vCoord : Anteriority -> VerbForm = \ant -> CVDS ant ;
 
 vPart : ClTense -> RCase -> VerbForm = \t,rc -> case t of {
           ClPres   => VPART PPresIndef rc;
           ClPast _ => VPART PPast rc;
           ClFut    => VPART PFut rc
           } ;
                    
 predV : Verb -> VerbPhrase = \verb -> 
   let
    vfin : ClTense -> Str = \t -> verb.s ! VFORM Act Simpl (vFin t) ;
    vaux : ClTense -> Str = \t -> case t of {
          ClPast pf => case pf of {
                         Perf => "байв" ;
                         PresPerf => "байлаа" ;
                         IndefPast => "байжээ" } ;
          ClPres | ClFut     => "байна" } ;
    vsub : Subordination -> Str = \sub -> verb.s ! vSub sub ;
    vcoord : Anteriority -> Str = \ant -> verb.s ! vCoord ant ;
    vpart : ClTense -> RCase -> Str = \t,rc -> verb.s ! vPart t rc ; 
    vpast = verb.s ! VPART PPast Nom ;
    ppart = ((verb.s! VPART PPresProgr Nom) ++ BIND ++ "гүй") ;
    vf : Str -> Str -> {fin,aux : Str} = \x,y -> {fin = x ; aux = y} ;
   in {
    s = table {
        VPFin t Simul Pos => vf (vfin t) [] ;
        VPFin t Simul Neg => vf ((vpart t Nom) ++ BIND ++ "гүй") [] ;
	    VPFin t Anter Pos => vf vpast (vaux t) ;
	    VPFin t Anter Neg => vf ppart (vaux t) ;
 	    VPImper _ False => vf (verb.s ! VIMP Direct Command)  [] ;
        VPImper pol True => case pol of { 
                      Neg => vf (verb.s ! VIMP Direct Demand) [] ;                                                     
                      Pos => let 
                              w = (verb.s ! VFORM Act Simpl VFut) ;
                              vvt = verb.vt
                             in 
                             vf (w ++ uu2!vvt) [] } ;
        VPPass passform t => case passform of {
                Passive => vf (verb.s ! VFORM Pass Simpl (vFin t)) [] ;
                Causative => vf (verb.s ! VFORM Caus Simpl (vFin t)) []
                } ;
	    VPPart t pol rc => case pol of {
                          Pos => vf (vpart t rc) [] ; 
                          Neg => vf ((vpart t Nom) ++ BIND ++ "гүй") []} ;
        VPSub pol sub => case pol of {
                          Pos => vf (vsub sub) [] ;
                          Neg => vf ppart "байвал" } ;
        VPCoord ant => vf (vcoord ant) [] }  ;
    compl = \\_ => [] ;
    adv = [] ;
    embedCompl = \\_ => [] ;
	vt = verb.vt
    } ;
   
 Clause : Type = {s : ClTense => Anteriority => Polarity => SType => Str} ;
 
 mkClause : (RCase => Str) -> Number -> VowelType -> RCase -> VerbPhrase -> Clause = \subj,n,vt,rc,vp -> {
   s = \\t,ant,pol,stype =>
   let
    verb = (vp.s ! VPFin t ant pol) ;
    verbCoord = (vp.s ! VPCoord ant) ;
    verbQuest = (vp.s ! VPPart t pol Nom) ;
	verbPart = (vp.s ! VPPart t pol rc) ;
	compl = vp.compl ! rc ++ vp.adv
   in 
    case stype of {
    Main => subj ! Nom ++ vp.compl ! rc ++ vp.embedCompl ! rc ++ vp.adv ++ verb.fin ++ verb.aux ;
    Sub sub => subj ! Acc ++ compl ++ (vp.s ! VPSub pol sub).fin ;
    Coord => subj ! Nom ++ vp.compl ! rc ++ vp.embedCompl ! rc ++ vp.adv ++ verbCoord.fin ;
    Quest style => case style of {
	   wQuest     => subj ! Nom ++ vp.compl ! rc ++ vp.embedCompl ! rc ++ vp.adv ++ verbQuest.fin ++ (wQuestPart (VPPart t pol Nom)) ;
	   yesNoQuest => subj ! Nom ++ vp.compl ! rc ++ vp.embedCompl ! rc ++ vp.adv ++ verbQuest.fin ++ (yesNoQuestPart vp.vt) } ;
    Part subtype => case subtype of {
	  Subject => subj ! Gen ++ compl ++ verbQuest.fin ++ "нь";
	  Object => subj ! Gen ++ compl ++ verbPart.fin ;
	  Adverbiale => subj ! Acc ++ compl ++ verbPart.fin ;
	  Rel =>  subj ! Gen ++ compl ++ verbPart.fin ;
	  emptySubject => "" ++ compl ++ verbPart.fin
    }
 } } ;	
 
 wQuestPart : VPForm -> Str = \vpf -> case vpf of {
	VPPart t pol _ => case t of {
	                  ClPast _ => "бэ" ;
                      _        => "вэ"} ;
    _            => "" } ;
 
 yesNoQuestPart : VowelType -> Str = \vt -> case vt of {
   (MascA|MascO) => "уу" ;
    _            => "үү" } ;

-- Kullmann 371: the subject linked to the predicate.
-- Coord: A combined sentence always consists of two or more predicates. The last predicate takes a verb with a TS; the other verbs ned a CVDS.
-- The tense is expressed with the last predicate only.
-- Sub: dominated by the main clause, has the function of one part of the main sentence, is placed before the main sentence 
-- Main: can exist independently of other clause, verbal predicate always takes a TS.

 insertObj : (RCase => Str) -> VerbPhrase -> VerbPhrase = \obj,vp -> {
    s = vp.s ;
    compl = \\rc => obj ! rc ++ vp.compl ! rc ;
    adv = vp.adv ; 
    embedCompl = \\rc => vp.embedCompl ! rc ;
	vt = vp.vt
    } ;
   
 insertObjPost : (RCase => Str) -> VerbPhrase -> VerbPhrase = \obj,vp -> {
    s = vp.s ;
    compl = \\rc => vp.compl ! rc ++ obj ! rc ;
    adv = vp.adv ;
    embedCompl = \\rc => vp.embedCompl ! rc ;
	vt = vp.vt
    } ;
   
 insertAdv : Str -> VerbPhrase -> VerbPhrase = \adv,vp -> {
    s = vp.s ;
    compl = vp.compl ;
    adv = vp.adv ++ adv ;
    embedCompl = \\_ => vp.embedCompl ! Dat ;
	vt = vp.vt
    } ;
   
 insertEmbedCompl : Str -> VerbPhrase -> VerbPhrase = \ext,vp -> {
    s = vp.s ;
    compl = vp.compl ;
    adv = vp.adv ;
    embedCompl = \\rc => vp.embedCompl ! rc ++ ext ;
	vt = vp.vt
    } ;
    
 infVP : VerbPhrase -> RCase -> Str = \vp,rc -> 
   let 
    obj = vp.compl ! rc ;
    verb = vp.s ! VPPart ClFut Pos Nom
   in 
    obj ++ vp.adv ++ verb.fin ;
 
-- For $Adjective$  

-- Mongolian adjectives have not comparative forms, only AP's have.
 
 Adjective : Type = {s : Str} ;

 Complement = {s : Str ; rc : RCase} ;
     
 appCompl : Complement -> (RCase => Str) -> Str = \compl,arg ->
            compl.s ++ arg ! compl.rc ;

 toNCase : RCase -> Def -> NCase = \rc,d -> case rc of {
	Nom => NNom ;
	Gen => NGen ;
	Dat => NDat ;
	Acc => (NAcc d) ;
	Abl => NAbl ;
	Inst => NInst ;
	Com => NCom ;
	Dir => NDir } ;	
	
 toRCase : NCase -> Def -> RCase = \nc,d -> case nc of {
    NNom => Nom ;
	NGen => Gen ;
	NDat => Dat ;
    NAcc d => Acc ;
	NAbl => Abl ;
	NInst => Inst ;
	NCom => Com ;
	NDir => Dir } ;
			
-- Transformations between parameter types

 numSF: SubstForm -> Number = \sf -> case sf of { SF n _ => n } ;
 
 caseSF: SubstForm -> NCase = \sf -> case sf of { SF _ nc => nc } ;

}

