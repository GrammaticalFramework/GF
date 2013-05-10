  resource BeschGre = open Prelude,ResGre in {

  flags coding = utf8 ;


  oper 


  mkImper :  Str -> Str = \v -> case v of {
    c +  "στ"  => v + "άτε" ;
    c +  ("β" | "γ" | "δ"| "ζ" |"θ" | "κ"| "μ" | "ν"| "π" |"ρ" | "τ"| "φ" | "χ" | "λλ" ) => v + "ετε" ;
    c +  ("λ" |  "σ"| "ξ" |"ψ" ) => v + "τε" 
     };

  -----For Contracted Verbs, give extra consonant----
  mkContr : Str -> Str = \s -> 
    case s of { 
    "σπάω" => "ζ" ;
    ("ακούω" | "κλαίω" | "καίω" |  "φταίω" | "φυλάω")  => "γ" 
    };

  ------Patterns for verbs with reduplication in the participle-------
  exept : pattern Str = #("πει");
  exept2 : pattern Str = #("συνδε");
  exept3 : pattern Str = #("τελε");
  exept4 : pattern Str = #("διακο");
  exept5 : pattern Str = #("εισα" | "εξα");
  exept6 : pattern Str = # "προ" ;
  exept7 : pattern Str = # ("διαδω") ;



  



  -------Participles  according to passive perfect stem ------------------    
  mkPartStem :  Str -> Str = \s -> 
    case s of
    {
   "αρκεστ"   =>   "αρκούμενος";   ---irreg
   "αποτελέσ"   =>   "αποτελούμενος";   ---irreg
   "εξαιρεθ"   =>   "εξηρημένος";   ---irreg 
   "λήφθ"   =>   "ειλλημένος";   ---irreg
   "κα"    => "καμένος" ; ---irreg
   "κλαυτ" => "κλαμένος" ;  ---irreg
   "ταξιδευτ"  => "ταξιδεμένος" ;
   "κερδηθ"    => "κερδισμένος" ;
   "αφεθ"   => "αφημένος" ;
   "προστεθ"=> "προστιθέμενος" ;
   "τραγουδηθ" => "τραγουδισμένος" ;
   x@(#exept) + "στ"  => "πε" + x + "σμένος" ;   -----reduplication πε-πεισμένος
   x@(#exept2) + "θ"  =>  x +  "δε" + "μένος" ;   -----reduplication  συνδε-δε-μένος
   x@(#exept3) + "στ"  =>  "τε" + x +   "σμένος" ;   -----reduplication τε-τελεσμένος
   x@(#exept4) + "π"  =>  "δια"  + "κε"  + "κομμένος" ;   -----reduplication δια-κε-κομμένος
   x@(#exept5) + "χθ"  =>  x + "γό"  + "μενος" ;   -----reduplication εισαγ-ο-μενος
   x@(#exept6) + "βληθ"  =>  x + "βε"  + "βλημένος" ;   -----reduplication προ-βε-βλημένος
   x@(#exept7) + "θ"  =>  "δια"  + "δε"  + "δομένος" ;   -----reduplication δια-δε-δομμένος
   x + ("στ" | "σθ"|"νθ"  )  =>   x + "σμένος"; 
   x + ("χτ" | "χθ" )  =>   x + "γμένος" ;   
   x + "ευτ"  =>   x + "ημένος" ; 
   x + "αχ"   =>   x + "εγμένος" ; 
   x + ("φτ" | "φθ" | "π" | "φ" )  =>   x + "μμένος";
   x + "εύσ"  =>   x + "ευμένος" ; 
   x + "ιώ"  =>   x + "ιωμένος" ;
   x + "αρθ" => x + "αρμένος" ;  
   x + "αλθ" => x + "αλμένος" ;  
   x + "ερθ" => x + "ερμένος" ; 
   x + "ηθ" => x + "ημένος" ;  
   x + "ευρεθ" => x + "ευρισκόμενος" ;  
   x + "ταθ" => x + "τεινόμενος" ;  
   x + "υθ" => x + "υμένος" ; 
   x + "εθ" => x + "εμένος" ;
   x + "ωθ" => x + "ωμένος" ;
   x + "αθ" => x + "αμένος" ;  
   x + "θ" => x + "σμένος" ;
   x + "γ" => x + "γμένος"      
     };


  -------Stem for passive perfective according to active imperfective ------------------    
  mkStem : Str -> Str = \s -> 
    case s of
    { 
   "βρέχω" => "βράχ" ;
   "δίνω" => "δόθ" ;
   "τρέφω" => "τράφ" ;
   "πνίγω" => "πνίγ" ;
   "σέρνω"  => "σύρθ" ;
   "αφήνω"  => "αφέθ" ;
   "σπέρνω"  => "σπάρθ" ;
   "στέλνω"  => "στάλθ" ;
   "στρέφω"  => "στράφ" ;
   "σβήνω"   => "σβήστ" ;
   "τρέπω"  => "τράπ" ;
   "φθείρω" => "φθάρθ" ;
   "καθιστώ" => "καθίστ" ;
   "παρέχω" => "παρασχέθ" ;
   "συμμετέχω" => "συμμετάσχ" ;
   ("ψάλλω" | "ψέλνω" ) => "ψάλθ" ;
   x + "έχω" => x + "ασχέθ";
   x + "είρω"  => x + "έρθ";  ----εγείρω Irreg
   x + "κόπτω" => x + "κόπ" ;
   x + "ζω"  => x + "χθ" ;  ---σφάζω  
   x + "νω" => x + "θ" ;   ----χάνω 
   x + "έω" => x + "εύστ" ;  ----εμπνέω  
   x + "χ" =>   x + "χ" ;
   x + "ξω" =>   x + "χθ" ;   
   x + ("ττω" | "σσω")  =>   x + "χθ" ;  ---κυρήττω  
   x + ("δω" | "θω")  =>   x + "στ" ;      ----πειθω 
   x + "εύω" =>   x + "εύτ" ;   --- γιατρεύω  
   x + "αύω" =>   x + "αύτ" ;   --- παύω  
   x + ("βω" | "πω"| "πτω"|"φω" | "φτω")  =>   x + "φτ";  ----θάβω 
   x + ("γω" | "γγω"| "γχω"|"κω" | "σκω" | "χνω" | "χω")  =>   x + "χθ"   ----παράγω, σφίγγω   
    };


  -------Stem for passive perfective according to active perfective ------------------    
  mkStem2 : Str -> Str = \s -> 
    case s of
    { 
    "κάψω" => "κά" ;
    "κλάψω" => "κλαύτ" ;
    "κλέψω" => "κλάπ" ;
    "κόψω" => "κόπ" ;
    "λάβω"  => "λήφθ" ;
    "προτείνω"  => "προτάθ" ;
    "προβάλλω"  => "προβλήθ" ;
    "εφεύρω"  => "εφευρέθ" ;
    "πλήξω"  => "πλήγ" ;
    "θέσω"  => "τέθ" ;
    "σώσω"  => "σώθ" ;
    "πρήξω"  => "πρήστ" ;
    "πετύχω"  => "επιτεύχθ" ;
    x + "ζω"  => x + "στ";   
    x + "ήσω"  => x + "ήθ";  
    x + "πλήξω"  => x + "πλάγ"; 
    x + "σω"  => x + "στ" ;  
    x + "άρω"  => x + "άρθ";  
    x + "είρω"  => x + "άρθ";    
    x + "άω"  => x + "αγώθ";
    x + "λω" => x + "λθ" ;  
    x + "σκω" => x + "σκήσθ" ;    
    x + "ξω"  => x + "χτ"; 
    x + "ψω"  => x + "φθ"; 
    x + "άνω"  => x + "άνθ";  
    x + "αρίσω"  => x + "αρίστ";  
    x + "άρω"  => x + "αρίστ";  
    x + "ιρίσω"  => x + "ιρίστ"; 
    x + "ίρω"  => x + "ιρίστ"; 
    x + "νω"  => x + "θ"  
     };
   

   -------Stem for passive perfective according to active perfective, cases as in mkStem2, extra variations ------------------      
  mkStem3 : Str -> Str = \s -> 
    case s of 
    { 
  "εκτείσω"  => "εκτάθ" ; 
  "κερδίσω"  => "κερδήθ" ;
  "παραδώσω"  => "παραδόθ" ;
  "μάθω"   => "μαθεύτ" ;
  "διαθέσω"  => "διατέθ" ;
  "προσθέσω"  => "προστέθ" ;
  x + "ίσω"  => x + "ίστ" ; 
  x + "σω"  => x + "θ" ;  
  x + "άνω"  => x + "άθ";
  x + "νω"  => x + "νθ" ;
  x + "άβω"  => x + "ήφθ" ;
  x + "μω"  => x + "μηθ" ;
  x + "ξω"  => x + "χθ" ;
  x + "εύω" =>   x + "εύτ" ;   
  x + "άλλω"  => x + "λήθ" 
   };


    -------Conjugation 2 (A,B).Stem for passive perfective regular ------------------      
  mkStem4 : Str -> Str = \s -> 
    case s of 
    {
    x + "ήσ"  => x + "ήθ";
    x + "έσ"  => x + "έστ";  
    x +  "άσ"  => x + "άστ" ;
    x + "άξ"  => x + "άχτ" ;
    x + "ήξ" =>   x + "ήχτ"   
   };

   mkStem5 : Str -> Str = \s -> 
    case s of 
    {
    x + "έσ"  => x + "έθ" ;
    x + "ήσ"  => x + "ήσθ";
    x + "στ"  => x + "στάχτ" ;
    x + "άξ"  => x + "άχτ" ;
    "πώ"  => "ειπώθ";
    "δώ"  => "ειδώθ"; 
   x + "θώ"  => "θηκ" 
   };


  ---For the formation of the passive imperative singular----
  mkImperPassive :  Str -> Str = \v -> case v of {
    "πλύν" => "πλύσ" ;
     c +  "τεύχθ" => c + "τεύξ" ;   
     c +  "γείρ" => c + "γέρσ" ;   
     c +  "είρ" => c + "άρσ" ;   
     c +  "είν" => c + "άσ" ;   
     c +  "είλ" => c + "άλσ" ;   
     c +  "άγ" => c + "άξ" ;   
     c +  "άρ" => c + "άρσ" ;   
     c +  "εύρ" => c + "ευρέσ" ;   
     c +  "άξ" => c + "άξ" ;   
     c + ( "άλ" |"άλλ" ) => c + "άλσ" ;   
     _ => v
     }; 



            -------------------Verbs of First Conjugation-----------------
      mkVerb1 : (x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15 : Str) -> Verb = \paIzw, paIksw, Epeksa, Epeza, paIz,paIks, Epeks, Epez, De, p, p1, Imp, Imp2, Imp3 ,part->
     {
      s = table {
            VPres Ind Sg P1 Active _ => paIzw ;
            VPres Ind Sg P2 Active _ => paIz + "εις" ; 
            VPres Ind Sg P3 Active _=> paIz + "ει" ;
            VPres Ind Pl P1 Active _ => paIz+ "ουμε" ;
            VPres Ind Pl P2 Active _ => paIz + "ετε" ;
            VPres Ind Pl P3 Active _ => paIz + "ουν" ;

            VPres Ind Sg P1 Passive  _ => paIz + "ομαι" ; 
            VPres Ind Sg P2 Passive  _ => paIz + "εσαι" ;
            VPres Ind Sg P3 Passive  _=> paIz + "εται" ;
            VPres Ind Pl P1 Passive  _=> p + "όμαστε" ;   
            VPres Ind Pl P2 Passive  _ => paIz + "εστε" ;
            VPres Ind Pl P3 Passive  _ => paIz + "ονται" ;
            
            VPres _ Sg P1 Active  _ => paIksw ;
            VPres _ Sg P2 Active  _ => paIks + "εις" ;  
            VPres _ Sg P3 Active  _ => paIks + "ει" ;
            VPres _ Pl P1 Active  _=> paIks + "ουμε" ;
            VPres _ Pl P2 Active  _ => paIks + "ετε" ;
            VPres _ Pl P3 Active  _ => paIks + "ουν" ;

            VPres _ Sg P1 Passive  _ => p1 + "ώ" ;
            VPres _ Sg P2 Passive  _ => p1 + "είς" ;
            VPres _ Sg P3 Passive  _ => p1 + "εί" ;
            VPres _ Pl P1 Passive  _ => p1 + "ούμε" ;
            VPres _ Pl P2 Passive  _ => p1 + "είτε" ;
            VPres _ Pl P3 Passive  _ => p1 + "ούν" ;

            VPast _ Sg P1 Active Perf => Epeksa ;
            VPast _ Sg P2 Active Perf=> Epeks + "ες" ;
            VPast _ Sg P3 Active Perf => Epeks + "ε" ;
            VPast _ Pl P1 Active Perf => paIks + "αμε" ;
            VPast _ Pl P2 Active Perf => paIks + "ατε" ;
            VPast _ Pl P3 Active Perf => Epeks + "αν" ;

            VPast _ Sg P1 Passive Perf => De  + "ηκα" ;
            VPast _ Sg P2 Passive Perf => De + "ηκες" ;
            VPast _ Sg P3 Passive Perf => De + "ηκε" ;
            VPast _ Pl P1 Passive Perf => p1 + "ήκαμε" ;
            VPast _ Pl P2 Passive Perf=> p1 + "ήκατε" ;
            VPast _ Pl P3 Passive Perf => De + "ηκαν" ;

            VPast _ Sg P1 Active Imperf => Epeza ;
            VPast _ Sg P2 Active Imperf => Epez + "ες" ;
            VPast _ Sg P3 Active Imperf => Epez + "ε" ;
            VPast _ Pl P1 Active Imperf => paIz + "αμε" ;
            VPast _ Pl P2 Active Imperf => paIz + "ατε" ;
            VPast _ Pl P3 Active Imperf => Epez + "αν" ;

            VPast _ Sg P1  Passive Imperf=> p + "όμουν" ;
            VPast _ Sg P2  Passive Imperf => p + "όσουν" ;
            VPast _ Sg P3  Passive Imperf => p + "όταν" ;
            VPast _ Pl P1  Passive Imperf => p + "όμασταν" ;
            VPast _ Pl P2  Passive Imperf=> p + "όσασταν" ;
            VPast _ Pl P3  Passive Imperf => p + "όντουσαν" ;

            VNonFinite Active       => paIks + "ει" ; 
            VNonFinite Passive       => p1 + "εί" ; 

            VImperative Perf Sg Active=> Imp2 ;
            VImperative Perf Pl Active => Imp ;
            VImperative Imperf Sg  Active => Imp3  ;
            VImperative Imperf Pl Active => paIz + "ετε" ;

            VImperative _  Sg Passive => mkImperPassive paIks + "ου" ;
            VImperative _ Pl Passive => p1 + "είτε" ;

            Gerund => paIz + "οντας" ;

            Participle d  g n c => (regAdj part).s !d! g !n !c
             }       
             };

    ---for verbs of First Conjugation, imperative typeA----
    Verb1a : (x1,_,_,_ : Str) -> Verb = \ paIzw, paIksw, Epeksa, Epeza-> 
     let
        paIz = init paIzw ;             
        paIks = init paIksw ;             
        Epeks = init Epeksa;            
        Epez = init Epeza;      
        De = mkStem paIzw;  
        p = mkVerbStem paIz; 
        p1 = mkVerbStem De ;
        Imp = mkImper paIks ;
        Imp2 = paIks + "ε";
        Imp3 = paIz + "ε";
        part= mkPartStem  p1;
      in 
       mkVerb1 paIzw paIksw Epeksa Epeza  paIz paIks Epeks Epez De p p1 Imp Imp2 Imp3 part;

  ---for verbs of first Conjugation, imperative typeB----
    Verb1b : (x1,_,_,_ : Str) -> Verb = \ anoIgw, anoIksw, Anoiksa, Anoiga-> 
     let
        anoIg = init anoIgw ;             
        anoIks = init anoIksw ;             
        Anoiks = init Anoiksa;            
        Anoig = init Anoiga;      
        De = mkStem anoIgw;  
        p = mkVerbStem anoIg; 
        p1 = mkVerbStem De ;
        Imp = mkImper anoIks ;
        Imp2 = Anoiks + "ε";
        Imp3 = Anoig + "ε";
        part= mkPartStem  p1;
      in 
       mkVerb1 anoIgw anoIksw Anoiksa Anoiga anoIg anoIks Anoiks Anoig De p p1 Imp Imp2 Imp3 part;

    
       
    ---for verbs of first Conjugation,Stem2, imperative typeA----
    Verb1c : (x1,_,_,_ : Str) -> Verb = \ kleInw, kleIsw, Ekleisa, Ekleina-> 
     let
        kleIn = init kleInw ;             
        kleIs = init kleIsw ;             
        Ekleis = init Ekleisa;            
        Eklein = init Ekleina;      
         De = mkStem2 kleIsw;  
        p = mkVerbStem kleIn; 
        p1 = mkVerbStem De ;
        Imp = mkImper kleIs ;
        Imp2 = kleIs+ "ε" ;
        Imp3 = kleIn + "ε";
        part= mkPartStem  p1;
      in 
       mkVerb1 kleInw kleIsw Ekleisa Ekleina kleIn kleIs Ekleis Eklein De p p1 Imp Imp2 Imp3 part ;
    

    ---for verbs of first Conjugation,Stem2, imperative typeB----
    Verb1d : (x1,_,_,_ : Str) -> Verb = \ didAskw, didAksw, dIdaksa, dIdaska-> 
     let
        didAsk = init didAskw ;             
        didAks = init didAksw ;             
        dIdaks = init dIdaksa;            
        dIdask = init dIdaska;      
        De = mkStem2 didAksw;  
        p = mkVerbStem dIdask; 
        p1 = mkVerbStem De ;
        Imp = mkImper didAks ;
        Imp2 = dIdaks + "ε" ;
        Imp3 = dIdask + "ε";
        part= mkPartStem  p1;
      in 
       mkVerb1 didAskw didAksw dIdaksa dIdaska didAsk didAks dIdaks dIdask De p p1 Imp Imp2 Imp3 part;

  ----Verbs First Conjugation, stem3, alternative endings------
    mkVerb1x : (idrYw,idrY,p,idrYsw,idrYs,p1,Idrysa,Idrys,De,Idry,idrY,Idrya,Imp,Imp2,part,ImpP : Str) -> Verb = 
     \idrYw,idrY,p,idrYsw,idrYs,p1,Idrysa,Idrys,De,Idry,idrY,Idrya,Imp,Imp2,part,ImpP-> {
      s = table {
            VPres Ind Sg P1 Active _ => idrYw ;
            VPres Ind Sg P2 Active _ => idrY + "εις" ; 
            VPres Ind Sg P3 Active _=> idrY + "ει" ;
            VPres Ind Pl P1 Active _ => idrY+ "ουμε" ;
            VPres Ind Pl P2 Active _ => idrY + "ετε" ;
            VPres Ind Pl P3 Active _ => idrY + "ουν" ;

            VPres Ind Sg P1 Passive  _ => idrY + "ομαι" ; 
            VPres Ind Sg P2 Passive  _ => idrY + "εσαι" ;
            VPres Ind Sg P3 Passive  _=> idrY + "εται" ;
            VPres Ind Pl P1 Passive  _=> p + "όμαστε" ;   
            VPres Ind Pl P2 Passive  _ => idrY + "εστε" ;
            VPres Ind Pl P3 Passive  _ => idrY + "ονται" ;
            
            VPres _ Sg P1 Active  _ => idrYsw ;
            VPres _ Sg P2 Active  _  => idrYs + "εις" ;  
            VPres _ Sg P3 Active  _ => idrYs + "ει" ;
            VPres _ Pl P1 Active  _=> idrYs + "ουμε" ;
            VPres _ Pl P2 Active  _ => idrYs + "ετε" ;
            VPres _ Pl P3 Active  _ => idrYs + "ουν" ;

            VPres _ Sg P1 Passive  _ => p1 + "ώ" ;
            VPres _ Sg P2 Passive  _ => p1 + "είς" ;
            VPres _ Sg P3 Passive  _ => p1 + "εί" ;
            VPres _ Pl P1 Passive  _ => p1 + "ούμε" ;
            VPres _ Pl P2 Passive  _ => p1 + "είτε" ;
            VPres _ Pl P3 Passive  _ => p1 + "ούν" ;

            VPast _ Sg P1 Active Perf => Idrysa ;
            VPast _ Sg P2 Active Perf=> Idrys + "ες" ;
            VPast _ Sg P3 Active Perf => Idrys + "ε" ;
            VPast _ Pl P1 Active Perf => idrYs + "αμε" ;
            VPast _ Pl P2 Active Perf => idrYs + "ατε" ;
            VPast _ Pl P3 Active Perf => Idrys + "αν" ;

            VPast _ Sg P1 Passive Perf => De  + "ηκα" ;
            VPast _ Sg P2 Passive Perf => De + "ηκες" ;
            VPast _ Sg P3 Passive Perf => De + "ηκε" ;
            VPast _ Pl P1 Passive Perf => p1 + "ήκαμε" ;
            VPast _ Pl P2 Passive Perf=> p1 + "ήκατε" ;
            VPast _ Pl P3 Passive Perf => De + "ηκαν" ;

            VPast _ Sg P1 Active Imperf => Idrya ;
            VPast _ Sg P2 Active Imperf => Idry + "ες" ;
            VPast _ Sg P3 Active Imperf => Idry + "ε" ;
            VPast _ Pl P1 Active Imperf => idrY + "αμε" ;
            VPast _ Pl P2 Active Imperf => idrY + "ατε" ;
            VPast _ Pl P3 Active Imperf => Idry + "αν" ;

            VPast _ Sg P1  Passive Imperf=> p + "όμουν" ;
            VPast _ Sg P2  Passive Imperf => p + "όσουν" ;
            VPast _ Sg P3  Passive Imperf => p + "όταν" ;
            VPast _ Pl P1  Passive Imperf => p + "όμασταν" ;
            VPast _ Pl P2  Passive Imperf=> p + "όσασταν" ;
            VPast _ Pl P3  Passive Imperf => p + "όντουσαν" ;

            VNonFinite Active       => idrYs + "ει" ; 
            VNonFinite Passive       => p1 + "εί" ; 

            VImperative Perf Sg Active=> Imp2;
            VImperative Perf Pl Active => Imp ;
            VImperative Imperf Sg  Active => Idry + "ε" ;
            VImperative Imperf Pl Active => idrY + "ετε"  ;

            VImperative _  Sg Passive => ImpP;
            VImperative _ Pl Passive => p1 + "είτε" ;

            Gerund => idrY + "οντας" ;

            Participle d  g n c => (regAdj part).s !d! g !n !c
          } 
          } ;




    Verb1dx : (x1,_,_,_ : Str) -> Verb = \idrYw, idrYsw, Idrysa, Idrya-> 
      let
        idrYs = init idrYsw ; 
        Idrys = init Idrysa ;
        idrY = init idrYw;  
        Idry = init Idrya; 
        De = mkStem3 idrYsw; 
        p = mkVerbStem Idry; 
        p1 = mkVerbStem De ; 
        Imp = mkImper idrYs; 
        Imp2 = Idrys + "ε" ;
        part= mkPartStem  p1;
        ImpP = idrYs + "ου" ;   
      in 
      mkVerb1x idrYw idrY p idrYsw idrYs p1 Idrysa Idrys De Idry idrY Idrya Imp Imp2 part ImpP;


    -----verbs with prepositional prefix-----
    Verb1prepSuf : (x1,_,_,_ : Str) -> Verb = \ syndEo, syndEso, synEdesa, synEdea-> 
      let
        syndEs = init syndEso ;
        synEdes = init synEdesa ;
        syndE = init syndEo;  
        synEde = init synEdea; 
        syndEth = mkStem3 syndEso; 
        synde = mkVerbStem syndE; 
        syndeth = mkVerbStem syndEth ; 
        syndEste = mkImper syndEs; 
        Imp2  = synEdes + "ε" ;
        part= mkPartStem  syndeth; 
        ImpP = syndEs + "ου" ;  
      in 
       mkVerb1x syndEo syndE synde syndEso syndEs syndeth synEdesa synEdes syndEth synEde syndE synEdea syndEste Imp2 part ImpP ;


    Verb1dxx : (x1,_,_,_ : Str) -> Verb = \ mathaInw, mAthw, Ematha, mAthaina-> 
      let       
        mAth = init mAthw ;
        Emath = init Ematha ;
        mathaIn = init mathaInw;  
        mAthain = init mAthaina; 
        matheUt = mkStem3 mAthw; 
        matheut = mkVerbStem matheUt ; 
        matheu = init matheut; 
        mAthete = mkImper mAth; 
        Imp2  = mAth + "ε" ;
       part= mkPartStem  matheut;
       ImpP = matheu + "σου" ; 
      in 
       mkVerb1x mathaInw mathaIn matheu mAthw mAth matheut Ematha Emath matheUt mAthain mathaIn mAthaina mAthete Imp2 part ImpP;

       Verb1dxxx : (x1,_,_,_ : Str) -> Verb = \ lamvAnw, lAvw, Elava, lAmvana-> 
      let       
        lAv = init lAvw ;
        Elav = init Elava ;
        lamvAn = init lamvAnw;  
        lAmvan = init lAmvana; 
        lIfth = mkStem3 lAvw ;
        lifth = mkVerbStem lIfth ; 
        lamvan = mkVerbStem lAmvan; 
        lAvete = mkImper lAv; 
        Imp2  = lAv + "ε" ;
        ImpP = " " ; 
       part= mkPartStem  lIfth; 
      in 
       mkVerb1x lamvAnw lamvAn lamvan lAvw lAv lifth Elava Elav lIfth lAmvan lamvAn lAmvana lAvete Imp2 part ImpP;



        ---------Verbs of Second Conjugation, Type A -----------------
      mkVerb2A : (x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13 : Str) -> Verb = \agapW, agapIsw,agApisa, agapoYsa, agap, agapIs,agApis, agapoYs, De,p1, Imp, agAp,part ->
       {
        s = table {
            VPres Ind Sg P1 Active _ => agapW ;
            VPres Ind Sg P2 Active _ => agap + "άς" ; 
            VPres Ind Sg P3 Active _=> agap + "ά" ;
            VPres Ind Pl P1 Active _ => agap+ "άμε" ;
            VPres Ind Pl P2 Active _ => agap + "άτε" ;
            VPres Ind Pl P3 Active _ => agap + "ούν" ;

            VPres Ind Sg P1 Passive  _ => agap + "ιέμαι" ; 
            VPres Ind Sg P2 Passive  _ => agap + "ιέσαι" ;
            VPres Ind Sg P3 Passive  _=> agap + "ιέται" ;
            VPres Ind Pl P1 Passive  _=> agap + "ιόμαστε" ;   
            VPres Ind Pl P2 Passive  _ => agap + "ιέστε" ;
            VPres Ind Pl P3 Passive  _ => agap + "ιούνται" ;
            
            VPres _ Sg P1 Active  _ => agapIsw ;
            VPres _ Sg P2 Active  _ => agapIs + "εις" ;  
            VPres _ Sg P3 Active  _ => agapIs + "ει" ;
            VPres _ Pl P1 Active  _=> agapIs + "ουμε" ;
            VPres _ Pl P2 Active  _ => agapIs + "ετε" ;
            VPres _ Pl P3 Active  _ => agapIs + "ουν" ;

            VPres _ Sg P1 Passive  _ => p1 + "ώ" ;
            VPres _ Sg P2 Passive  _ => p1 + "είς" ;
            VPres _ Sg P3 Passive  _ => p1 + "εί" ;
            VPres _ Pl P1 Passive  _ => p1 + "ούμε" ;
            VPres _ Pl P2 Passive  _ => p1 + "είτε" ;
            VPres _ Pl P3 Passive  _ => p1 + "ούν" ;

            VPast _ Sg P1 Active Perf => agApisa ;
            VPast _ Sg P2 Active Perf=> agApis + "ες" ;
            VPast _ Sg P3 Active Perf => agApis + "ε" ;
            VPast _ Pl P1 Active Perf => agapIs + "αμε" ;
            VPast _ Pl P2 Active Perf => agapIs + "ατε" ;
            VPast _ Pl P3 Active Perf => agApis + "αν" ;

            VPast _ Sg P1 Passive Perf => De  + "ηκα" ;
            VPast _ Sg P2 Passive Perf => De + "ηκες" ;
            VPast _ Sg P3 Passive Perf => De + "ηκε" ;
            VPast _ Pl P1 Passive Perf => p1 + "ήκαμε" ;
            VPast _ Pl P2 Passive Perf=> p1 + "ήκατε" ;
            VPast _ Pl P3 Passive Perf => De + "ηκαν" ;

            VPast _ Sg P1 Active Imperf => agapoYsa ;
            VPast _ Sg P2 Active Imperf => agapoYs + "ες" ;
            VPast _ Sg P3 Active Imperf => agapoYs + "ε" ;
            VPast _ Pl P1 Active Imperf => agapoYs + "αμε" ;
            VPast _ Pl P2 Active Imperf => agapoYs + "ατε" ;
            VPast _ Pl P3 Active Imperf => agapoYs + "αν" ;

            VPast _ Sg P1  Passive Imperf=> agap + "ιόμουν" ;
            VPast _ Sg P2  Passive Imperf => agap + "ιόσουν" ;
            VPast _ Sg P3  Passive Imperf => agap + "ιόταν" ;
            VPast _ Pl P1  Passive Imperf => agap + "ιόμασταν" ;
            VPast _ Pl P2  Passive Imperf=> agap + "ιόσασταν" ;
            VPast _ Pl P3  Passive Imperf => agap + "ιόντουσαν" ;

            VNonFinite Active       => agapIs + "ει" ; 
            VNonFinite Passive       => p1 + "εί" ; 

            VImperative Perf Sg Active=> agApis + "ε" ;
            VImperative Perf Pl Active => Imp ;
            VImperative Imperf Sg  Active => agAp + "α" ;
            VImperative Imperf Pl Active => agap + "άτε" ;

            VImperative _  Sg Passive => agapIs + "ου" ;
            VImperative _ Pl Passive => p1 + "είτε" ;

            Gerund => agap + "ώντας" ;

            Participle d  g n c => (regAdj part).s !d! g !n !c
            } 
            };

    ---for verbs of second Conjugation, typeA, using stem4------
    Verb2a : (x1,_,_,_ : Str) -> Verb = \agapW, agapIsw,agApisa, agapoYsa-> 
      let
        agap = init agapW ;             
        agapIs = init agapIsw ;             
        agApis = init agApisa ;            
        agapoYs = init agapoYsa ;      
        De = mkStem4 agapIs ;   
        p1 = mkVerbStem De ;
        Imp = mkImper agapIs ;
        part = mkPartStem  p1 ;
        agAp = Predef.tk 2  agApis ;   
      in 
      mkVerb2A agapW agapIsw agApisa agapoYsa agap agapIs agApis agapoYs De p1 Imp agAp part;


    ---for verbs of second Conjugation, typeA, using stem5------
    Verb2b : (x1,_,_,_ : Str) -> Verb = \ forW, forEsw, fOresa, foroYsa-> 
      let
        for = init forW ;             
        forEs = init forEsw ;             
        fOres = init fOresa ;            
        foroYs = init foroYsa ;      
        De = mkStem5 forEs ;   
        p1 = mkVerbStem De ;
        Imp = mkImper forEs ;
        part = mkPartStem  p1 ;
        fOr = Predef.tk 2  fOres ;    
      in 
       mkVerb2A forW forEsw fOresa foroYsa for forEs fOres foroYs De p1 Imp fOr part;


    ---for verbs of second Conjugation, typeA, using stem4, with extra consonant in the imperative------
    Verb2c : (x1,_,_,_ : Str) -> Verb = \ xepernW, xeperAsw, xepErasa, xepernoYsa-> 
      let
        xepern = init xepernW ;             
        xeperAs = init xeperAsw ;             
        xepEras = init xepErasa ;            
        xepernoYs = init xepernoYsa ;      
        De = mkStem4 xeperAs ;   
        p1 = mkVerbStem De ;
        Imp = mkImper xeperAs ;
        part = mkPartStem  p1 ;
        xepEr = Predef.tk 2  xepEras + "v" ;    
      in 
       mkVerb2A xepernW xeperAsw xepErasa xepernoYsa  xepern xeperAs xepEras xepernoYs De p1 Imp xepEr part;


     
         

    ---------Verbs of Second Conjugation, Type B -----------------
     mkVerb2B : (x1,_,_,_,_,_,_,_,_,_,_,_: Str) -> Verb = \theoro,theoriso,theorisa, theorousa,theor,theorIs,theOris,theoroYs, De, p1, Imp,part   ->
     {
      s = table {
            VPres Ind Sg P1 Active _ => theoro ;
            VPres Ind Sg P2 Active _ => theor + "είς" ; 
            VPres Ind Sg P3 Active _=> theor + "εί" ;
            VPres Ind Pl P1 Active _ => theor+ "ούμε" ;
            VPres Ind Pl P2 Active _ => theor + "είτε" ;
            VPres Ind Pl P3 Active _ => theor + "ούν" ;

            VPres Ind Sg P1 Passive  _ => theor + "ούμαι" ; 
            VPres Ind Sg P2 Passive  _ => theor + "είσαι" ;
            VPres Ind Sg P3 Passive  _=> theor + "είται" ;
            VPres Ind Pl P1 Passive  _=> theor + "ούμαστε" ;   
            VPres Ind Pl P2 Passive  _ => theor + "είστε" ;
            VPres Ind Pl P3 Passive  _ => theor + "ούνται" ;
            
            VPres _ Sg P1 Active  _ => theoriso ;
            VPres _ Sg P2 Active  _ => theorIs + "εις" ;  
            VPres _ Sg P3 Active  _ => theorIs + "ει" ;
            VPres _ Pl P1 Active  _=> theorIs + "ουμε" ;
            VPres _ Pl P2 Active  _ => theorIs + "ετε" ;
            VPres _ Pl P3 Active  _ => theorIs + "ουν" ;

            VPres _ Sg P1 Passive  _ => p1 + "ώ" ;
            VPres _ Sg P2 Passive  _ => p1 + "είς" ;
            VPres _ Sg P3 Passive  _ => p1 + "εί" ;
            VPres _ Pl P1 Passive  _ => p1 + "ούμε" ;
            VPres _ Pl P2 Passive  _ => p1 + "είτε" ;
            VPres _ Pl P3 Passive  _ => p1 + "ούν" ;

            VPast _ Sg P1 Active Perf => theorisa ;
            VPast _ Sg P2 Active Perf=> theOris + "ες" ;
            VPast _ Sg P3 Active Perf => theOris + "ε" ;
            VPast _ Pl P1 Active Perf => theorIs + "αμε" ;
            VPast _ Pl P2 Active Perf => theorIs + "ατε" ;
            VPast _ Pl P3 Active Perf => theOris + "αν" ;

            VPast _ Sg P1 Passive Perf => De  + "ηκα" ;
            VPast _ Sg P2 Passive Perf => De + "ηκες" ;
            VPast _ Sg P3 Passive Perf => De + "ηκε" ;
            VPast _ Pl P1 Passive Perf => p1 + "ήκαμε" ;
            VPast _ Pl P2 Passive Perf=> p1 + "ήκατε" ;
            VPast _ Pl P3 Passive Perf => De + "ηκαν" ;

            VPast _ Sg P1 Active Imperf => theorousa ;
            VPast _ Sg P2 Active Imperf => theoroYs + "ες" ;
            VPast _ Sg P3 Active Imperf => theoroYs + "ε" ;
            VPast _ Pl P1 Active Imperf => theoroYs + "αμε" ;
            VPast _ Pl P2 Active Imperf => theoroYs + "ατε" ;
            VPast _ Pl P3 Active Imperf => theoroYs + "αν" ;

            VPast _ Sg P1  Passive Imperf=> theor + "ούμουν" ;
            VPast _ Sg P2  Passive Imperf => theor + "ούσουν" ;
            VPast _ Sg P3  Passive Imperf => theor + "ούνταν" ;
            VPast _ Pl P1  Passive Imperf => theor + "ούμασταν" ;
            VPast _ Pl P2  Passive Imperf=> theor + "ούσασταν" ;
            VPast _ Pl P3  Passive Imperf => theor + "ούνταν" ;

            VNonFinite Active       => theorIs + "ει" ; 
            VNonFinite Passive       => p1 + "εί" ; 

            VImperative Perf Sg Active=> theOris + "ε" ;
            VImperative Perf Pl Active => Imp ;
            VImperative Imperf Sg  Active => " ";
            VImperative Imperf Pl Active => theor + "είτε" ;

            VImperative _  Sg Passive => theorIs + "ου" ;
            VImperative _ Pl Passive => p1 + "είτε" ;

            Gerund => theor + "ώντας" ;

            Participle d  g n c => (regAdj part).s !d! g !n !c
            } 
            };


            ---for verbs of second Conjugation, typeB, Stem4------
       Verb2Ba : (x1,_,_,_ : Str) -> Verb = \theorW, theorIsw, theOrisa, theoroYsa-> 
      let
        theor = init theorW ;             
        theorIs = init theorIsw ;             
        theOris = init theOrisa ;            
        theoroYs = init theoroYsa ;      
        De = mkStem4 theorIs ;   
        p1 = mkVerbStem De ;
        Imp = mkImper theorIs ;
        part = mkPartStem  p1 ;    
      in 
       mkVerb2B theorW theorIsw theOrisa theoroYsa  theor theorIs theOris theoroYs De p1 Imp part ;

        Verb2Bb : (x1,_,_,_ : Str) -> Verb = \afairW, afairEsw, afaIresa, afairoYsa-> 
      let
        afair = init afairW ;             
        afairEs = init afairEsw ;             
        afaIres = init afaIresa ;            
        afairoYs = init afairoYsa ;      
        De = mkStem5 afairEs ;   
        p1 = mkVerbStem De ;
        Imp = mkImper afairEs ;
        part = mkPartStem  p1 ;    
      in 
       mkVerb2B afairW afairEsw afaIresa afairoYsa  afair afairEs afaIres afairoYs De p1 Imp part ;




  ---------Verbs of Second Conjugation, Type B, different endings in passive -----------------
    mkVerb2B3 : (x1,_,_,_ : Str) -> Verb = \miso,misiso,misisa, misousa->
      let
        mis = init miso ;             
        misIs = init misiso ;             
        mIsis = init misisa ;            
        misoYs = init misousa ;      
        De = mkStem4 misIs ;   
        p1 = mkVerbStem De ;
        Imp = mkImper misIs ;
        part = mkPartStem  p1 ;
      in 
     {
      s = table {
            VPres Ind Sg P1 Active _ => miso ;
           VPres Ind Sg P2 Active _ => mis + "είς" ; 
            VPres Ind Sg P3 Active _=> mis + "εί" ;
            VPres Ind Pl P1 Active _ => mis+ "ούμε" ;
            VPres Ind Pl P2 Active _ => mis + "είτε" ;
            VPres Ind Pl P3 Active _ => mis + "ούν" ;

            VPres Ind Sg P1 Passive  _ => mis + "ιέμαι" ; 
            VPres Ind Sg P2 Passive  _ => mis + "ιέσαι" ;
            VPres Ind Sg P3 Passive  _=> mis + "ιέται" ;
            VPres Ind Pl P1 Passive  _=> mis + "ιόμαστε" ;   
            VPres Ind Pl P2 Passive  _ => mis + "ιέστε" ;
            VPres Ind Pl P3 Passive  _ => mis + "ιούνται" ;
            
            VPres _ Sg P1 Active  _ => misiso ;
            VPres _ Sg P2 Active  _ => misIs + "εις" ;  
            VPres _ Sg P3 Active  _ => misIs + "ει" ;
            VPres _ Pl P1 Active  _=> misIs + "ουμε" ;
            VPres _ Pl P2 Active  _ => misIs + "ετε" ;
            VPres _ Pl P3 Active  _ => misIs + "ουν" ;

            VPres _ Sg P1 Passive  _ => p1 + "ώ" ;
            VPres _ Sg P2 Passive  _ => p1 + "είς" ;
            VPres _ Sg P3 Passive  _ => p1 + "εί" ;
            VPres _ Pl P1 Passive  _ => p1 + "ούμε" ;
            VPres _ Pl P2 Passive  _ => p1 + "είτε" ;
            VPres _ Pl P3 Passive  _ => p1 + "ούν" ;

            VPast _ Sg P1 Active Perf => misisa ;
            VPast _ Sg P2 Active Perf=> mIsis + "ες" ;
            VPast _ Sg P3 Active Perf => mIsis + "ε" ;
            VPast _ Pl P1 Active Perf => misIs + "αμε" ;
            VPast _ Pl P2 Active Perf => misIs + "ατε" ;
            VPast _ Pl P3 Active Perf => mIsis + "αν" ;

            VPast _ Sg P1 Passive Perf => De  + "ηκα" ;
            VPast _ Sg P2 Passive Perf => De + "ηκες" ;
            VPast _ Sg P3 Passive Perf => De + "ηκε" ;
            VPast _ Pl P1 Passive Perf => p1 + "ήκαμε" ;
            VPast _ Pl P2 Passive Perf=> p1 + "ήκατε" ;
            VPast _ Pl P3 Passive Perf => De + "ηκαν" ;

            VPast _ Sg P1 Active Imperf => misousa ;
            VPast _ Sg P2 Active Imperf => misoYs + "ες" ;
            VPast _ Sg P3 Active Imperf => misoYs + "ε" ;
            VPast _ Pl P1 Active Imperf => misoYs + "αμε" ;
            VPast _ Pl P2 Active Imperf => misoYs + "ατε" ;
            VPast _ Pl P3 Active Imperf => misoYs + "αν" ;

            VPast _ Sg P1  Passive Imperf=> mis + "ιόμουν" ;
            VPast _ Sg P2  Passive Imperf => mis + "ιόσουν" ;
            VPast _ Sg P3  Passive Imperf => mis + "ιόταν" ;
            VPast _ Pl P1  Passive Imperf => mis + "ιόμασταν" ;
            VPast _ Pl P2  Passive Imperf=> mis + "ιόσασταν" ;
            VPast _ Pl P3  Passive Imperf => mis + "ιόντουσαν" ;

            VNonFinite Active       => misIs + "ει" ; 
            VNonFinite Passive       => p1 + "εί" ; 

            VImperative Perf Sg Active=> mIsis + "ε" ;
            VImperative Perf Pl Active => Imp ;
            VImperative Imperf Sg  Active => " ";
            VImperative Imperf Pl Active => mis + "είτε" ;

            VImperative _  Sg Passive => misIs + "ου" ;
            VImperative _ Pl Passive => Imp + "είτε" ;

            Gerund => mis + "ώντας" ;

            Participle d  g n c => (regAdj part).s !d! g !n !c
            } 
            };
     

             ------Contracted Verbs. ----------
        mkVerbContrac : (x1,_,_,_,_,_,_,_,_,_,_,_,_,_ : Str) -> Verb = \akoUw, akoUsw, Akouga, Akousa, akoU,  akoUs, Akoug, Akous, akou, akoUst, akoust, Imp, Imp2, part->
         {
             s = table {
              VPres Ind Sg P1 Active _ => akoU + "ω" ;
              VPres Ind Sg P2 Active _ => akoU + "ς" ;
              VPres Ind Sg P3 Active _=> akoU + "ει" ;
              VPres Ind Pl P1 Active _ => akoU + "με" ;
              VPres Ind Pl P2 Active _ => akoU + "τε" ;
              VPres Ind Pl P3 Active _ => akoU + "νε" ;

              VPres Ind Sg P1 Passive  _ => akoU + mkContr akoUw + "ομαι" ; 
              VPres Ind Sg P2 Passive  _ => akoU + mkContr akoUw +"εσαι" ;
              VPres Ind Sg P3 Passive  _=> akoU + mkContr akoUw +"εται" ;
              VPres Ind Pl P1 Passive  _=> akou + mkContr akoUw +"όμαστε" ;   
              VPres Ind Pl P2 Passive  _ => akoU +mkContr akoUw + "εστε" ;
              VPres Ind Pl P3 Passive  _ => akoU + mkContr akoUw +"ονται" ;
            
              VPres _ Sg P1 Active  _ => akoUsw ;
              VPres _ Sg P2 Active  _ => akoUs + "εις" ;
              VPres _ Sg P3 Active  _ => akoUs + "ει" ;
              VPres _ Pl P1 Active  _=> akoUs + "ουμε" ;
              VPres _ Pl P2 Active  _ => akoUs + "ετε" ;
              VPres _ Pl P3 Active  _ => akoUs + "ουν" ;

              VPres _ Sg P1 Passive  _ => akoust + "ώ" ;
              VPres _ Sg P2 Passive  _ => akoust + "είς" ;
              VPres _ Sg P3 Passive  _ => akoust + "εί" ;
              VPres _ Pl P1 Passive  _ => akoust + "ούμε" ;
              VPres _ Pl P2 Passive  _ => akoust + "είτε" ;
              VPres _ Pl P3 Passive  _ => akoust + "ούν" ;
            
              VPast _ Sg P1 Active Perf => Akousa ;
              VPast _ Sg P2 Active Perf=> Akous + "ες" ;
              VPast _ Sg P3 Active Perf => Akous+ "ε" ;
              VPast _ Pl P1 Active Perf => akoUs + "αμε" ;
              VPast _ Pl P2 Active Perf => akoUs + "ατε" ;
              VPast _ Pl P3 Active Perf => Akous+ "αν" ;

              VPast _ Sg P1 Passive Perf => akoUst  + "ηκα" ;
              VPast _ Sg P2 Passive Perf => akoUst + "ηκες" ;
              VPast _ Sg P3 Passive Perf => akoUst + "ηκε" ;
              VPast _ Pl P1 Passive Perf => akoust + "ήκαμε" ;
              VPast _ Pl P2 Passive Perf=> akoust + "ήκατε" ;
              VPast _ Pl P3 Passive Perf => akoUst + "ηκαν" ;


              VPast _ Sg P1 Active Imperf => Akouga ;
              VPast _ Sg P2 Active Imperf => Akoug + "ες" ;
              VPast _ Sg P3 Active Imperf => Akoug + "ε" ;
              VPast _ Pl P1 Active Imperf => akoU + "γ" +"αμε" ;
              VPast _ Pl P2 Active Imperf => akoU +"γ" + "ατε" ;
              VPast _ Pl P3 Active Imperf => Akoug + "αν" ;

              VPast _ Sg P1  Passive Imperf=> akou + mkContr akoUw + "όμουν" ;
              VPast _ Sg P2  Passive Imperf => akou + mkContr akoUw + "όσουν" ;
              VPast _ Sg P3  Passive Imperf => akou + mkContr akoUw + "όταν" ;
              VPast _ Pl P1  Passive Imperf => akou + mkContr akoUw + "όμασταν" ;
              VPast _ Pl P2  Passive Imperf=> akou + mkContr akoUw + "όσασταν" ;
              VPast _ Pl P3  Passive Imperf => akou + mkContr akoUw + "όντουσαν" ;
            
              VNonFinite Active       => akoUs + "ει" ;
              VNonFinite Passive       => akoust + "εί" ; 

              VImperative Perf Sg Active=> Imp +  "ε" ;
              VImperative Perf Pl Active => akoUs +  "τε" ;
              VImperative Imperf Sg  Active => Imp2 + "ε" ;
              VImperative Imperf Pl Active => akoU + "τε"  ;

              VImperative _  Sg Passive => akoUs + "ου" ;
              VImperative _ Pl Passive => akoust + "είτε" ;

              Gerund =>akoU +mkContr akoUw + "οντας" ;

             Participle d  g n c => (regAdj part).s !d! g !n !c
             } 
            } ;


   
        ---for Contracted verbs, more than two syllables----
     VerbContr : (x1,_,_,_ : Str) -> Verb = \ akoUw, akoUsw, Akouga, Akousa-> 
      let
        akoU = init akoUw ;             
        akoUs = init akoUsw ;             
        Akoug = init Akouga;            
        Akous = init Akousa;
        akou = mkVerbStem akoU ;      
        akoUst  = mkStem2 akoUsw ;
        akoust = mkVerbStem akoUst ;
        Imp = Akoug ;
        Imp2 = Akous ;
        part= mkPartStem  akoust;
      in 
       mkVerbContrac akoUw akoUsw Akouga Akousa akoU  akoUs Akoug Akous akou akoUst akoust Imp Imp2 part;


      ---for Contracted verbs, two syllables----
      VerbContr2 : (x1,_,_,_ : Str) -> Verb = \ klaIw, klApsw, Eklaiga, Eklapsa-> 
         let
          klaI = init klaIw ;             
          klAps = init klApsw ;             
          Eklaig = init Eklaiga;            
          Eklaps = init Eklapsa;
          klai = mkVerbStem klaI ;      
          klAfth  = mkStem2 klApsw ;
          klafth = mkVerbStem klAfth ;
          Imp = klAps;
          Imp2 = klaI + mkContr klaIw; 
          part= mkPartStem  klafth;
        in 
          mkVerbContrac  klaIw klApsw Eklaiga Eklapsa klaI  klAps Eklaig Eklaps klai klAfth klafth Imp Imp2 part;


      ----------------Irregular verbs with _tracted types in Cond------------------------
       mkVerbContracIrreg : (x1,_,_,_,_,_,_,_,_,_,_,_,_ : Str) -> Verb = \trWw,fAw,Efaga,Etrwga, trW,fA, Efag, Etrwg, trw, fagWth, fagwth, fag,part ->
        {
          s = table {
            VPres Ind Sg P1 Active _ => trW + "ω" ;
            VPres Ind Sg P2 Active _ => trW + "ς" ;
            VPres Ind Sg P3 Active _=> trW + "ει" ;
            VPres Ind Pl P1 Active _ => trW + "με" ;
            VPres Ind Pl P2 Active _ => trW + "τε" ;
            VPres Ind Pl P3 Active _ => trW + "νε" ;

            VPres Ind Sg P1 Passive  _ => trW + "γ" + "ομαι" ; 
            VPres Ind Sg P2 Passive  _ => trW + "γ" +"εσαι" ;
            VPres Ind Sg P3 Passive  _=> trW + "γ" +"εται" ;
            VPres Ind Pl P1 Passive  _=> trw + "γ" +"όμαστε" ;   
            VPres Ind Pl P2 Passive  _ => trw +"γ" + "εστε" ;
            VPres Ind Pl P3 Passive  _ => trW + "γ" +"ονται" ;
            
            VPres _ Sg P1 Active  _ => fAw ;
            VPres _ Sg P2 Active  _ => fA + "ς" ;
            VPres _ Sg P3 Active  _ => fA + "ει" ;
            VPres _ Pl P1 Active  _=> fA + "με" ;
            VPres _ Pl P2 Active  _ => fA + "τε" ;
            VPres _ Pl P3 Active  _ =>  fA + "νε" ;

            VPres _ Sg P1 Passive  _ => fagwth + "ώ" ;
            VPres _ Sg P2 Passive  _ => fagwth + "είς" ;
            VPres _ Sg P3 Passive  _ => fagwth + "εί" ;
            VPres _ Pl P1 Passive  _ => fagwth + "ούμε" ;
            VPres _ Pl P2 Passive  _ => fagwth + "είτε" ;
            VPres _ Pl P3 Passive  _ => fagwth + "ούν" ;
            
            VPast _ Sg P1 Active Perf => Efaga ;
            VPast _ Sg P2 Active Perf=> Efag + "ες" ;
            VPast _ Sg P3 Active Perf => Efag + "ε" ;
            VPast _ Pl P1 Active Perf => fA  + "γ" +  "αμε" ;
            VPast _ Pl P2 Active Perf => fA  + "γ" + "ατε" ;
            VPast _ Pl P3 Active Perf => Efag + "αν" ;

            VPast _ Sg P1 Passive Perf => fagWth  + "ηκα" ;
            VPast _ Sg P2 Passive Perf => fagWth + "ηκες" ;
            VPast _ Sg P3 Passive Perf => fagWth + "ηκε" ;
            VPast _ Pl P1 Passive Perf => fagwth + "ήκαμε" ;
            VPast _ Pl P2 Passive Perf=> fagwth + "ήκατε" ;
            VPast _ Pl P3 Passive Perf => fagWth + "ηκαν" ;

            VPast _ Sg P1 Active Imperf => Etrwga ;
            VPast _ Sg P2 Active Imperf => Etrwg + "ες" ;
            VPast _ Sg P3 Active Imperf => Etrwg + "ε" ;
            VPast _ Pl P1 Active Imperf => trW + "γ"+ "αμε" ;
            VPast _ Pl P2 Active Imperf => trW + "γ" + "ατε" ;
            VPast _ Pl P3 Active Imperf => Etrwg + "αν" ;

            VPast _ Sg P1  Passive Imperf=> fag + "ν" + "όμουν" ;
            VPast _ Sg P2  Passive Imperf => fag + "ν" + "όσουν" ;
            VPast _ Sg P3  Passive Imperf => fag + "ν" + "όταν" ;
            VPast _ Pl P1  Passive Imperf => fag + "ν" + "όμασταν" ;
            VPast _ Pl P2  Passive Imperf=> fag + "ν" + "όσασταν" ;
            VPast _ Pl P3  Passive Imperf => fag + "ν" + "όντουσαν" ;
            
            VNonFinite Active       => fA + "ει" ;
            VNonFinite Passive       => fagwth + "εί" ; 

            VImperative Perf Sg Active=> fA + "ε" ;
            VImperative Perf Pl Active => fA + "τε" ;
            VImperative Imperf Sg  Active =>trW + "γ"+  "ε" ;
            VImperative Imperf Pl Active => trW + "γ"+  "ετε"  ;

            VImperative _  Sg Passive =>  " " ;
            VImperative _ Pl Passive => fagwth + "είτε" ;

            Gerund => trW + "γ"  + "οντας" ;

            Participle d  g n c => (regAdj part).s !d! g !n !c
            } 
            } ;


       VerbContrIrreg : (x1,_,_,_ : Str) -> Verb = \ trWw,fAw,Efaga,Etrwga-> 
        let
          trW = init  trWw;
          fA = init fAw;
          Efag = init  Efaga;
          Etrwg = init Etrwga;
          trw =mkVerbStem trW;
          fagWth = mkStem2 fAw;
          fagwth = mkVerbStem fagWth;
          fag = init fagwth;
          part= mkPartStem  fagwth;
       in 
        mkVerbContracIrreg  trWw fAw Efaga Etrwga trW  fA Efag Etrwg trw fagWth fagwth fag part;


  --------------------------------------------IRREGULAR VERBS --------------------------------------------------------------------
  --------------------------------------------------------------------------------------------------------------------------------
  

  ----------------Irregular verbs.Verbs with Contracted types, but also irregularities in the active dependent form------------------------
       mkVerbContracIrreg2 : (x1,_,_,_,_,_,_,_,_,_,_,_,_ : Str) -> Verb = \lEw, pW, eIpa, Elega, lE,  p, eIp, Eleg, lEg, leg, eipWth, eipwth,part ->
     {
      s = table {
            VPres Ind Sg P1 Active _ => lE + "ω" ;
            VPres Ind Sg P2 Active _ => lE + "ς" ;
            VPres Ind Sg P3 Active _=> lE + "ει" ;
            VPres Ind Pl P1 Active _ => lE + "με" ;
            VPres Ind Pl P2 Active _ => lE + "τε" ;
            VPres Ind Pl P3 Active _ => lE + "νε" ;

            VPres Ind Sg P1 Passive  _ => lEg  + "ομαι" ; 
            VPres Ind Sg P2 Passive  _ => lEg  +"εσαι" ;
            VPres Ind Sg P3 Passive  _=> lEg  +"εται" ;
            VPres Ind Pl P1 Passive  _=> leg  +"όμαστε" ;   
            VPres Ind Pl P2 Passive  _ => lEg  + "εστε" ;
            VPres Ind Pl P3 Passive  _ => lEg  +"ονται" ;
            
            VPres _ Sg P1 Active  _ => pW ;
            VPres _ Sg P2 Active  _ => p + "είς" ;
            VPres _ Sg P3 Active  _ => p + "εί" ;
            VPres _ Pl P1 Active  _=> p + "ούμε" ;
            VPres _ Pl P2 Active  _ => p + "είτε" ;
            VPres _ Pl P3 Active  _ =>  p + "ούν" ;

            VPres _ Sg P1 Passive  _ => eipwth + "ώ" ;
            VPres _ Sg P2 Passive  _ => eipwth + "είς" ;
            VPres _ Sg P3 Passive  _ => eipwth + "εί" ;
            VPres _ Pl P1 Passive  _ => eipwth + "ούμε" ;
            VPres _ Pl P2 Passive  _ => eipwth + "είτε" ;
            VPres _ Pl P3 Passive  _ => eipwth + "ούν" ;
            
            VPast _ Sg P1 Active Perf => eIpa ;
            VPast _ Sg P2 Active Perf=> eIp + "ες" ;
            VPast _ Sg P3 Active Perf => eIp + "ε" ;
            VPast _ Pl P1 Active Perf => eIp  +  "αμε" ;
            VPast _ Pl P2 Active Perf => eIp  + "ατε" ;
            VPast _ Pl P3 Active Perf => eIp + "αν" ;

            VPast _ Sg P1 Passive Perf => eipWth  + "ηκα" ;
            VPast _ Sg P2 Passive Perf => eipWth + "ηκες" ;
            VPast _ Sg P3 Passive Perf => eipWth + "ηκε" ;
            VPast _ Pl P1 Passive Perf => eipwth + "ήκαμε" ;
            VPast _ Pl P2 Passive Perf=> eipwth + "ήκατε" ;
            VPast _ Pl P3 Passive Perf => eipWth + "ηκαν" ;

            VPast _ Sg P1 Active Imperf => Elega ;
            VPast _ Sg P2 Active Imperf => Eleg + "ες" ;
            VPast _ Sg P3 Active Imperf => Eleg + "ε" ;
            VPast _ Pl P1 Active Imperf => lEg+ "αμε" ;
            VPast _ Pl P2 Active Imperf => lEg + "ατε" ;
            VPast _ Pl P3 Active Imperf => Eleg + "αν" ;

            VPast _ Sg P1  Passive Imperf=> leg  + "όμουν" ;
            VPast _ Sg P2  Passive Imperf => leg+ "όσουν" ;
            VPast _ Sg P3  Passive Imperf => leg +"όταν" ;
            VPast _ Pl P1  Passive Imperf => leg + "όμασταν" ;
            VPast _ Pl P2  Passive Imperf=> leg + "όσασταν" ;
            VPast _ Pl P3  Passive Imperf => leg + "όντουσαν" ;
            
            VNonFinite Active       => p + "εί" ;
            VNonFinite Passive       => eipwth + "εί" ; 

            VImperative Perf Sg Active=> p + "ές" ;
            VImperative Perf Pl Active => p + "είτε" ;
            VImperative Imperf Sg  Active =>lEg + "ε" ;
            VImperative Imperf Pl Active => lEg + "ετε"  ;

            VImperative _  Sg Passive =>  " " ;
            VImperative _ Pl Passive => eipwth + "είτε" ;

            Gerund =>lEg + "οντας" ;

            Participle d  g n c => (regAdj part).s !d! g !n !c
              } 
              } ;


    VerbContrIrreg2 : (x1,_,_,_ : Str) -> Verb = \lEw,pW,eIpa,Elega-> 
     let
        lE = init  lEw;
        p = init pW;
        eIp = init  eIpa;
        Eleg = init Elega;
        lEg = lE + "γ";
        leg = mkVerbStem lEg ;
        eipWth = mkStem5 pW;
        eipwth = mkVerbStem eipWth;
        part= mkPartStem  eipwth;
      in 
       mkVerbContracIrreg2  lEw pW eIpa Elega lE  p eIp Eleg lEg leg eipWth eipwth part;


mkVerbContracIrreg3 : (x1,_,_,_,_,_,_,_,_,_,_,_,_ : Str) -> Verb = \vlEpw, dW, eIda, Evlepa, vlEp, d, eId, Evlep, vlEp, vlep, eidWth, eidwth, part ->
     {
      s = table {
            VPres Ind Sg P1 Active _ => vlEpw ;
            VPres Ind Sg P2 Active _ => vlEp + "εις" ;
            VPres Ind Sg P3 Active _=> vlEp + "ει" ;
            VPres Ind Pl P1 Active _ => vlEp + "ουμε" ;
            VPres Ind Pl P2 Active _ => vlEp + "ετε" ;
            VPres Ind Pl P3 Active _ => vlEp + "ουν" ;

            VPres Ind Sg P1 Passive  _ => vlEp  + "ομαι" ; 
            VPres Ind Sg P2 Passive  _ => vlEp  +"εσαι" ;
            VPres Ind Sg P3 Passive  _=> vlEp  +"εται" ;
            VPres Ind Pl P1 Passive  _=> vlep  +"όμαστε" ;   
            VPres Ind Pl P2 Passive  _ => vlEp  + "εστε" ;
            VPres Ind Pl P3 Passive  _ => vlEp  +"ονται" ;
            
            VPres _ Sg P1 Active  _ => dW ;
            VPres _ Sg P2 Active  _ => d + "είς" ;
            VPres _ Sg P3 Active  _ => d + "εί" ;
            VPres _ Pl P1 Active  _=> d + "ούμε" ;
            VPres _ Pl P2 Active  _ => d + "είτε" ;
            VPres _ Pl P3 Active  _ =>  d + "ούν" ;

            VPres _ Sg P1 Passive  _ => eidwth + "ώ" ;
            VPres _ Sg P2 Passive  _ => eidwth + "είς" ;
            VPres _ Sg P3 Passive  _ => eidwth + "εί" ;
            VPres _ Pl P1 Passive  _ => eidwth + "ούμε" ;
            VPres _ Pl P2 Passive  _ => eidwth + "είτε" ;
            VPres _ Pl P3 Passive  _ => eidwth + "ούν" ;
            
            VPast _ Sg P1 Active Perf => eIda ;
            VPast _ Sg P2 Active Perf=> eId + "ες" ;
            VPast _ Sg P3 Active Perf => eId + "ε" ;
            VPast _ Pl P1 Active Perf => eId  +  "αμε" ;
            VPast _ Pl P2 Active Perf => eId  + "ατε" ;
            VPast _ Pl P3 Active Perf => eId + "αν" ;

            VPast _ Sg P1 Passive Perf => eidWth  + "ηκα" ;
            VPast _ Sg P2 Passive Perf => eidWth + "ηκες" ;
            VPast _ Sg P3 Passive Perf => eidWth + "ηκε" ;
            VPast _ Pl P1 Passive Perf => eidwth + "ήκαμε" ;
            VPast _ Pl P2 Passive Perf=> eidwth + "ήκατε" ;
            VPast _ Pl P3 Passive Perf => eidWth + "ηκαν" ;

            VPast _ Sg P1 Active Imperf => Evlepa ;
            VPast _ Sg P2 Active Imperf => Evlep + "ες" ;
            VPast _ Sg P3 Active Imperf => Evlep + "ε" ;
            VPast _ Pl P1 Active Imperf => vlEp+ "αμε" ;
            VPast _ Pl P2 Active Imperf => vlEp + "ατε" ;
            VPast _ Pl P3 Active Imperf => Evlep + "αν" ;

            VPast _ Sg P1  Passive Imperf=> vlep  + "όμουν" ;
            VPast _ Sg P2  Passive Imperf => vlep+ "όσουν" ;
            VPast _ Sg P3  Passive Imperf => vlep +"όταν" ;
            VPast _ Pl P1  Passive Imperf => vlep + "όμασταν" ;
            VPast _ Pl P2  Passive Imperf=> vlep + "όσασταν" ;
            VPast _ Pl P3  Passive Imperf => vlep + "όντουσαν" ;
            
            VNonFinite Active       => d + "εί" ;
            VNonFinite Passive       => eidwth + "εί" ; 

            VImperative Perf Sg Active=> d + "ές" ;
            VImperative Perf Pl Active => d + "είτε" ;
            VImperative Imperf Sg  Active =>vlEp + "ε" ;
            VImperative Imperf Pl Active => vlEp + "ετε"  ;

            VImperative _  Sg Passive =>  " " ;
            VImperative _ Pl Passive => eidwth + "είτε" ;

            Gerund =>vlEp + "οντας" ;

            Participle d  g n c => (regAdj part).s !d! g !n !c
              } 
              } ;

       VerbContrIrreg3 : (x1,_,_,_ : Str) -> Verb = \vlEpw,dW,eIda,Evlepa-> 
     let
        vlEp = init  vlEpw;
        d = init dW;
        eId = init  eIda;
        Evlep = init Evlepa;
        eid = mkVerbStem  eId;
        vlep  = mkVerbStem  vlEp;
        eidWth = mkStem5 dW;
        eidwth = mkVerbStem eidWth;
        part= mkPartStem  eidwth;
      in 
       mkVerbContracIrreg3  vlEpw dW eIda Evlepa vlEp d eId  Evlep  vlEp vlep eidWth eidwth part;




   -------------Verb  Contracted with no passive Perfective ----------------------
        mkVerbContracIrregNPassPerf : (x1,_,_,_,_,_,_,_,_,_ : Str) -> Verb = \pInw, piW, Ipia, Epina, pIn, pin,   pi, Ipi, Epin,part ->
     {
      s = table {
            VPres Ind Sg P1 Active _ => pIn + "ω" ;
            VPres Ind Sg P2 Active _ => pIn + "εις" ;
            VPres Ind Sg P3 Active _=> pIn + "ει" ;
            VPres Ind Pl P1 Active _ => pIn + "ουμε" ;
            VPres Ind Pl P2 Active _ => pIn + "ετε" ;
            VPres Ind Pl P3 Active _ => pIn + "ουν" ;

            VPres Ind Sg P1 Passive  _ => pIn  + "ομαι" ; 
            VPres Ind Sg P2 Passive  _ => pIn  +"εσαι" ;
            VPres Ind Sg P3 Passive  _=> pIn  +"εται" ;
            VPres Ind Pl P1 Passive  _=> pin  +"όμαστε" ;   
            VPres Ind Pl P2 Passive  _ => pIn  + "εστε" ;
            VPres Ind Pl P3 Passive  _ => pIn  +"ονται" ;
            
            VPres _ Sg P1 Active  _ => piW ;
            VPres _ Sg P2 Active  _ => pi + "είς" ;
            VPres _ Sg P3 Active  _ => pi + "εί" ;
            VPres _ Pl P1 Active  _=> pi + "ούμε" ;
            VPres _ Pl P2 Active  _ => pi + "είτε" ;
            VPres _ Pl P3 Active  _ =>  pi + "ούν" ;

            VPres _ Sg P1 Passive  _ => " " ;
            VPres _ Sg P2 Passive  _ => " "  ;
            VPres _ Sg P3 Passive  _ => " "  ;
            VPres _ Pl P1 Passive  _ => " "  ;
            VPres _ Pl P2 Passive  _ => " "  ;
            VPres _ Pl P3 Passive  _ => " " ;
            
            VPast _ Sg P1 Active Perf => Ipia ;
            VPast _ Sg P2 Active Perf=> Ipi + "ες" ;
            VPast _ Sg P3 Active Perf => Ipi + "ε" ;
            VPast _ Pl P1 Active Perf => Ipi  +  "αμε" ;
            VPast _ Pl P2 Active Perf => Ipi  + "ατε" ;
            VPast _ Pl P3 Active Perf => Ipi + "αν" ;

            VPast _ Sg P1 Passive Perf =>" "  ;
            VPast _ Sg P2 Passive Perf => " "  ;
            VPast _ Sg P3 Passive Perf => " " ;
            VPast _ Pl P1 Passive Perf => " "  ;
            VPast _ Pl P2 Passive Perf=> " "  ;
            VPast _ Pl P3 Passive Perf => " "  ;

            VPast _ Sg P1 Active Imperf => Epina ;
            VPast _ Sg P2 Active Imperf => Epin + "ες" ;
            VPast _ Sg P3 Active Imperf => Epin + "ε" ;
            VPast _ Pl P1 Active Imperf => pIn+ "αμε" ;
            VPast _ Pl P2 Active Imperf => pIn + "ατε" ;
            VPast _ Pl P3 Active Imperf => Epin + "αν" ;

            VPast _ Sg P1  Passive Imperf=> pin  + "όμουν" ;
            VPast _ Sg P2  Passive Imperf => pin+ "όσουν" ;
            VPast _ Sg P3  Passive Imperf => pin +"όταν" ;
            VPast _ Pl P1  Passive Imperf => pin + "όμασταν" ;
            VPast _ Pl P2  Passive Imperf=> pin + "όσασταν" ;
            VPast _ Pl P3  Passive Imperf => pin + "όντουσαν" ;
            
            VNonFinite Active       => pi + "εί" ;
            VNonFinite Passive       =>  " " ; 

            VImperative Perf Sg Active=> pi + "ές" ;
            VImperative Perf Pl Active => pi + "είτε" ;
            VImperative Imperf Sg  Active =>pIn+ "ε" ;
            VImperative Imperf Pl Active => pIn + "ετε"  ;

            VImperative _  Sg Passive =>  " " ;
            VImperative _ Pl Passive => " " ;

            Gerund =>pIn + "οντας" ;

            Participle d  g n c => (regAdj part).s !d! g !n !c
            }
           } ;


    VerbContrIrregNPassPerf : (x1,_,_,_ : Str) -> Verb = \pInw,piW,Ipia,Epina-> 
     let
        pIn = init  pInw;
        pi = init piW;
        Ipi = init  Ipia;
        Epin = init Epina;
        pin  = mkVerbStem  pIn ; 
        part= mkPartStem  piW;
      in 
       mkVerbContracIrregNPassPerf  pInw piW Ipia Epina pIn pin pi Ipi Epin part;


    mkVerbContracIrregNopassive : (x1,_,_,_,_,_,_,_,_,_,_,_,_: Str) -> Verb = \vgaInw, vgW, vgIka, Evgaina, vgaIn, vg,   vgIk, Evgain, Imp1,Imp2, Imp3, Imp4,part ->
     {
      s = table {
            VPres Ind Sg P1 Active _ => vgaIn + "ω" ;
            VPres Ind Sg P2 Active _ => vgaIn + "εις" ;
            VPres Ind Sg P3 Active _=> vgaIn + "ει" ;
            VPres Ind Pl P1 Active _ => vgaIn + "ουμε" ;
            VPres Ind Pl P2 Active _ => vgaIn + "ετε" ;
            VPres Ind Pl P3 Active _ => vgaIn + "ουν" ;

            VPres Ind Sg P1 Passive  _ => " " ; 
            VPres Ind Sg P2 Passive  _ => " "   ;
            VPres Ind Sg P3 Passive  _=> " "   ;
            VPres Ind Pl P1 Passive  _=> " "   ;   
            VPres Ind Pl P2 Passive  _ => " "  ;
            VPres Ind Pl P3 Passive  _ => " "   ;
            
            VPres _ Sg P1 Active  _ => vgW ;
            VPres _ Sg P2 Active  _ => vg + "είς" ;
            VPres _ Sg P3 Active  _ => vg + "εί" ;
            VPres _ Pl P1 Active  _=> vg + "ούμε" ;
            VPres _ Pl P2 Active  _ => vg + "είτε" ;
            VPres _ Pl P3 Active  _ =>  vg + "ούν" ;

            VPres _ Sg P1 Passive  _ => " " ;
            VPres _ Sg P2 Passive  _ => " "  ;
            VPres _ Sg P3 Passive  _ => " "  ;
            VPres _ Pl P1 Passive  _ => " "  ;
            VPres _ Pl P2 Passive  _ => " "  ;
            VPres _ Pl P3 Passive  _ => " " ;
            
            VPast _ Sg P1 Active Perf => vgIka ;
            VPast _ Sg P2 Active Perf=> vgIk + "ες" ;
            VPast _ Sg P3 Active Perf => vgIk + "ε" ;
            VPast _ Pl P1 Active Perf => vg +  "ήκαμε" ;
            VPast _ Pl P2 Active Perf => vg  + "ήκατε" ;
            VPast _ Pl P3 Active Perf => vgIk + "αν" ;

            VPast _ Sg P1 Passive Perf =>" "  ;
            VPast _ Sg P2 Passive Perf => " "  ;
            VPast _ Sg P3 Passive Perf => " " ;
            VPast _ Pl P1 Passive Perf => " "  ;
            VPast _ Pl P2 Passive Perf=> " "  ;
            VPast _ Pl P3 Passive Perf => " "  ;

            VPast _ Sg P1 Active Imperf => Evgaina ;
            VPast _ Sg P2 Active Imperf => Evgain + "ες" ;
            VPast _ Sg P3 Active Imperf => Evgain + "ε" ;
            VPast _ Pl P1 Active Imperf => vgaIn+ "αμε" ;
            VPast _ Pl P2 Active Imperf => vgaIn + "ατε" ;
            VPast _ Pl P3 Active Imperf => Evgain + "αν" ;

            VPast _ Sg P1  Passive Imperf=>" " ;
            VPast _ Sg P2  Passive Imperf => " " ;
            VPast _ Sg P3  Passive Imperf => " ";
            VPast _ Pl P1  Passive Imperf => " " ;
            VPast _ Pl P2  Passive Imperf=> " " ;
            VPast _ Pl P3  Passive Imperf => " " ;
            
            VNonFinite Active       => vg + "εί" ;
            VNonFinite Passive       =>  " " ; 

            VImperative Perf Sg Active=> Imp1 ;
            VImperative Perf Pl Active => Imp2 ;
            VImperative Imperf Sg  Active =>Imp3 ;
            VImperative Imperf Pl Active => Imp4  ;

            VImperative _  Sg Passive =>  " " ;
            VImperative _ Pl Passive => " " ;

            Gerund =>vgaIn + "οντας" ;

            Participle d  g n c => (regAdj part).s !d! g !n !c
           } 
          } ;



      ------Verbs with 2 syllables------
      VerbContracIrregNopassive : (x1,_,_,_,_,_ : Str) -> Verb = \vgaInw, vgW, vgIka, Evgaina, vgEs, part-> 
     let
        vgaIn = init  vgaInw;
        vg = init vgW;
        vgIk = init  vgIka;
        Evgain = init Evgaina ;
        Imp1 = vgEs  ;
        Imp2 =vg + "είτε" ;
        Imp3 =vgaIn+ "ε" ;
        Imp4 =vgaIn + "ετε"  ;
        part=part;
      in  
       mkVerbContracIrregNopassive  vgaInw vgW vgIka Evgaina vgaIn vg   vgIk Evgain   Imp1 Imp2 Imp3 Imp4 part;



  -----Verbs with more than two syllables -----
       VerbContracIrregNopassive2 : (x1,_,_,_,_,_ : Str) -> Verb = \provaInw, provW, proEvika, proEvaina, prOvaine,part-> 
     let
        provaIn = init  provaInw;
        prov = init provW;
        proEvik = init  proEvika;
        proEvain = init proEvaina ;
        Imp1 = prOvaine ;
        Imp2 =prov +"είτε" ;
        Imp3 = proEvain + "ε" ;
        Imp4 = provaIn + "ετε"  ;
        part=part ;
      in  
       mkVerbContracIrregNopassive  provaInw provW proEvika proEvaina provaIn prov proEvik proEvain  Imp1 Imp2 Imp3 Imp4 part;

     

             ------Contracted Verbs with no passive ----------
     mkVerbContrac2 : (x1,_,_,_,_,_,_,_,_,_,_: Str) -> Verb = \ftaIw, ftaIksw, Eftaiksa, Eftaiga, ftaI,  ftaIks, Eftaiks, Eftaig, Imp, Imp2,part->
      {
         s = table {
            VPres Ind Sg P1 Active _ => ftaI + "ω" ;
            VPres Ind Sg P2 Active _ => ftaI + "ς" ;
            VPres Ind Sg P3 Active _=> ftaI + "ει" ;
            VPres Ind Pl P1 Active _ => ftaI + "με" ;
            VPres Ind Pl P2 Active _ => ftaI + "τε" ;
            VPres Ind Pl P3 Active _ => ftaI + "νε" ;

            VPres Ind Sg P1 Passive  _ => " " ; 
            VPres Ind Sg P2 Passive  _ => " " ;
            VPres Ind Sg P3 Passive  _=>" " ;
            VPres Ind Pl P1 Passive  _=> " " ;   
            VPres Ind Pl P2 Passive  _ => " ";
            VPres Ind Pl P3 Passive  _ => " " ;
            
            VPres _ Sg P1 Active  _ => ftaIksw ;
            VPres _ Sg P2 Active  _ => ftaIks + "εις" ;
            VPres _ Sg P3 Active  _ => ftaIks + "ει" ;
            VPres _ Pl P1 Active  _=> ftaIks + "ουμε" ;
            VPres _ Pl P2 Active  _ => ftaIks + "ετε" ;
            VPres _ Pl P3 Active  _ => ftaIks + "ουν" ;

            VPres _ Sg P1 Passive  _ => " " ;
            VPres _ Sg P2 Passive  _ => " " ;
            VPres _ Sg P3 Passive  _ => " ";
            VPres _ Pl P1 Passive  _ => " ";
            VPres _ Pl P2 Passive  _ => " " ;
            VPres _ Pl P3 Passive  _ => " " ;
            
            VPast _ Sg P1 Active Perf => Eftaiksa ;
            VPast _ Sg P2 Active Perf=> Eftaiks + "ες" ;
            VPast _ Sg P3 Active Perf => Eftaiks+ "ε" ;
            VPast _ Pl P1 Active Perf => ftaIks + "αμε" ;
            VPast _ Pl P2 Active Perf => ftaIks + "ατε" ;
            VPast _ Pl P3 Active Perf => Eftaiks+ "αν" ;

            VPast _ Sg P1 Passive Perf => " " ;
            VPast _ Sg P2 Passive Perf => " " ;
            VPast _ Sg P3 Passive Perf => " " ;
            VPast _ Pl P1 Passive Perf => " ";
            VPast _ Pl P2 Passive Perf=> " " ;
            VPast _ Pl P3 Passive Perf => " " ;


            VPast _ Sg P1 Active Imperf => Eftaiga ;
            VPast _ Sg P2 Active Imperf => Eftaig + "ες" ;
            VPast _ Sg P3 Active Imperf => Eftaig + "ε" ;
            VPast _ Pl P1 Active Imperf => ftaI + mkContr ftaIw +"αμε" ;
            VPast _ Pl P2 Active Imperf => ftaI +mkContr ftaIw + "ατε" ;
            VPast _ Pl P3 Active Imperf => Eftaig + "αν" ;

            VPast _ Sg P1  Passive Imperf=> " " ;
            VPast _ Sg P2  Passive Imperf => " " ;
            VPast _ Sg P3  Passive Imperf => " " ;
            VPast _ Pl P1  Passive Imperf => " " ;
            VPast _ Pl P2  Passive Imperf=> " " ;
            VPast _ Pl P3  Passive Imperf => " " ;
            
            VNonFinite Active       => ftaIks + "ει" ;
            VNonFinite Passive       => " " ; 

            VImperative Perf Sg Active=> Imp +  "ε" ;
            VImperative Perf Pl Active => ftaIks +  "τε" ;
            VImperative Imperf Sg  Active => Imp2 + "ε" ;
            VImperative Imperf Pl Active =>  ftaI + "τε"  ;

            VImperative _  Sg Passive =>  " " ;
            VImperative _ Pl Passive => " " ;

            Gerund =>ftaI + mkContr ftaIw + "οντας" ;

            Participle d  g n c => (regAdj part).s !d! g !n !c
            } 
          } ;




   
      ---for Contracted verbs, more than two syllables----
    VerbContr2NoPassive : (x1,_,_,_,_ : Str) -> Verb = \ ftaIw, ftaIksw, Eftaiksa, Eftaiga, part-> 
     let
        ftaI = init ftaIw ;             
        ftaIks = init ftaIksw ;             
        Eftaiks = init Eftaiksa;            
        Eftaig = init Eftaiga; 
        Imp = ftaIks ;
        Imp2 = ftaI + mkContr ftaIw ;
        part= part;
      in 
       mkVerbContrac2 ftaIw ftaIksw Eftaiksa Eftaiga ftaI  ftaIks Eftaiks Eftaig Imp Imp2 part;




    ---------Deponent Verbs, they have the endings of passive voice, but they are active in meaning. Verbs in -άμαι, -ιέμαι -------
    mkVerbDeponent : (x1,_,_,_,_,_,_,_,_,_,_: Str) -> Verb = \koimAmai, koimithW, koimIthika, koimOmoun, koimA, koim, koimith, koimIth, koimI, Imp,part   ->
     {
      s = table {
            VPres Ind Sg P1 Active _ => koimA + "μαι" ;
            VPres Ind Sg P2 Active _ => koimA + "σαι"; 
            VPres Ind Sg P3 Active _=> koimA + "ται" ;
            VPres Ind Pl P1 Active _ => koim + "όμαστε" ;
            VPres Ind Pl P2 Active _ => koim + "όσαστε";
            VPres Ind Pl P3 Active _ => koim + "ούνται" ;

            VPres Ind Sg P1 Passive  _ =>" "  ; 
            VPres Ind Sg P2 Passive  _ => " " ;
            VPres Ind Sg P3 Passive  _=> " " ;
            VPres Ind Pl P1 Passive  _=> " " ;   
            VPres Ind Pl P2 Passive  _ => " " ;
            VPres Ind Pl P3 Passive  _ => " " ;
            
            VPres _ Sg P1 Active  _ => koimith + "ώ" ;
            VPres _ Sg P2 Active  _ => koimith + "είς" ;
            VPres _ Sg P3 Active  _ => koimith + "εί" ;
            VPres _ Pl P1 Active  _=> koimith + "ούμε" ;
            VPres _ Pl P2 Active  _ => koimith + "είτε" ;
            VPres _ Pl P3 Active  _ => koimith + "ούν" ;

            VPres _ Sg P1 Passive  _ => " ";
            VPres _ Sg P2 Passive  _ => " " ;
            VPres _ Sg P3 Passive  _ => " " ;
            VPres _ Pl P1 Passive  _ => " " ;
            VPres _ Pl P2 Passive  _ => " ";
            VPres _ Pl P3 Passive  _ => " " ;

            VPast _ Sg P1 Active Perf => koimIth  + "ηκα" ;
            VPast _ Sg P2 Active Perf=> koimIth + "ηκες" ;
            VPast _ Sg P3 Active Perf => koimIth + "ηκε" ;
            VPast _ Pl P1 Active Perf => koimith + "ήκαμε" ;
            VPast _ Pl P2 Active Perf => koimith + "ήκατε" ;
            VPast _ Pl P3 Active Perf => koimIth + "ηκαν" ;

            VPast _ Sg P1 Passive Perf => " " ;
            VPast _ Sg P2 Passive Perf => " " ;
            VPast _ Sg P3 Passive Perf => " ";
            VPast _ Pl P1 Passive Perf =>  " ";
            VPast _ Pl P2 Passive Perf=>" ";
            VPast _ Pl P3 Passive Perf => " ";

            VPast _ Sg P1 Active Imperf => koim + "όμουν" ;
            VPast _ Sg P2 Active Imperf => koim + "όσουν" ;
            VPast _ Sg P3 Active Imperf => koim + "όταν" ;
            VPast _ Pl P1 Active Imperf => koim + "όμασταν" ;
            VPast _ Pl P2 Active Imperf => koim + "όσασταν" ;
            VPast _ Pl P3 Active Imperf => koim + "όντουσαν" ;

            VPast _ Sg P1  Passive Imperf=> " " ;
            VPast _ Sg P2  Passive Imperf =>  " " ;
            VPast _ Sg P3  Passive Imperf => " " ;
            VPast _ Pl P1  Passive Imperf => " ";
            VPast _ Pl P2  Passive Imperf=> " " ;
            VPast _ Pl P3  Passive Imperf => " ";

            VNonFinite Active       =>  koimith + "εί" ; 
            VNonFinite Passive       => " " ; 

            VImperative Perf Sg Active=> Imp ;
            VImperative Perf Pl Active => koimith + "είτε" ;
            VImperative Imperf Sg  Active => " ";
            VImperative Imperf Pl Active => " " ;

            VImperative _  Sg Passive =>  " " ;
            VImperative _ Pl Passive => " " ;

            Gerund => " "  ;
            Participle d  g n c => (regAdj part).s !d! g !n !c
             } 
            };


    VerbDeponent : (x1,_,_,_,_,_ : Str) -> Verb = \variEmai, varethW, varEthika,variOmoun, varEsou,part-> 
      let
        variE = Predef.tk 3 variEmai ;
        vari = Predef.tk 4 variEmai ;           
        vareth = init varethW ;             
        varEth = Predef.tk 3 varEthika ;
        varE = init varEth ;
        Imp = varEsou ;
        part = part;
      in 
       mkVerbDeponent variEmai varethW varEthika variOmoun variE vari vareth   varEth varE Imp part;
        
      ---------Verbs in -όμαι -------
      mkVerbDeponent2 : (x1,_,_,_,_,_,_,_,_,_,_: Str) -> Verb = \noiAzomai, noiastW, noiAstika, noiazOmoun, noiAz, noiast, noiAst, noiaz, Imp, Imp2,part  ->
        {
          s = table {
            VPres Ind Sg P1 Active _ => noiAz + "ομαι" ;
            VPres Ind Sg P2 Active _ => noiAz + "εσαι"; 
            VPres Ind Sg P3 Active _=> noiAz + "εται" ;
            VPres Ind Pl P1 Active _ => noiaz + "όμαστε" ;
            VPres Ind Pl P2 Active _ => noiaz + "όσαστε";
            VPres Ind Pl P3 Active _ => noiAz + "ονται" ;

            VPres Ind Sg P1 Passive  _ =>" "  ; 
            VPres Ind Sg P2 Passive  _ => " " ;
            VPres Ind Sg P3 Passive  _=> " " ;
            VPres Ind Pl P1 Passive  _=> " " ;   
            VPres Ind Pl P2 Passive  _ => " " ;
            VPres Ind Pl P3 Passive  _ => " " ;
            
            VPres _ Sg P1 Active  _ =>  noiast + "ώ" ;
            VPres _ Sg P2 Active  _ =>  noiast + "είς" ;
            VPres _ Sg P3 Active  _ =>  noiast + "εί" ;
            VPres _ Pl P1 Active  _=>  noiast + "ούμε" ;
            VPres _ Pl P2 Active  _ =>  noiast + "είτε" ;
            VPres _ Pl P3 Active  _ =>  noiast + "ούν" ;

            VPres _ Sg P1 Passive  _ => " ";
            VPres _ Sg P2 Passive  _ => " " ;
            VPres _ Sg P3 Passive  _ => " " ;
            VPres _ Pl P1 Passive  _ => " " ;
            VPres _ Pl P2 Passive  _ => " ";
            VPres _ Pl P3 Passive  _ => " " ;

            VPast _ Sg P1 Active Perf => noiAst  + "ηκα" ;
            VPast _ Sg P2 Active Perf=> noiAst + "ηκες" ;
            VPast _ Sg P3 Active Perf => noiAst + "ηκε" ;
            VPast _ Pl P1 Active Perf => noiast + "ήκαμε" ;
            VPast _ Pl P2 Active Perf => noiast + "ήκατε" ;
            VPast _ Pl P3 Active Perf => noiAst + "ηκαν" ;

            VPast _ Sg P1 Passive Perf => " " ;
            VPast _ Sg P2 Passive Perf => " " ;
            VPast _ Sg P3 Passive Perf => " ";
            VPast _ Pl P1 Passive Perf =>  " ";
            VPast _ Pl P2 Passive Perf=>" ";
            VPast _ Pl P3 Passive Perf => " ";

            VPast _ Sg P1 Active Imperf => noiaz + "όμουν" ;
            VPast _ Sg P2 Active Imperf => noiaz + "όσουν" ;
            VPast _ Sg P3 Active Imperf => noiaz + "όταν" ;
            VPast _ Pl P1 Active Imperf => noiaz + "όμασταν" ;
            VPast _ Pl P2 Active Imperf => noiaz + "όσασταν" ;
            VPast _ Pl P3 Active Imperf => noiaz + "όντουσαν" ;

            VPast _ Sg P1  Passive Imperf=> " " ;
            VPast _ Sg P2  Passive Imperf =>  " " ;
            VPast _ Sg P3  Passive Imperf => " " ;
            VPast _ Pl P1  Passive Imperf => " ";
            VPast _ Pl P2  Passive Imperf=> " " ;
            VPast _ Pl P3  Passive Imperf => " ";

            VNonFinite Active       =>  noiast + "εί" ; 
            VNonFinite Passive       => " " ; 

            VImperative Perf Sg Active=> Imp ;
            VImperative Perf Pl Active => noiast + "είτε" ;
            VImperative Imperf Sg  Active => " ";
            VImperative Imperf Pl Active => Imp2 ;

            VImperative _  Sg Passive =>  " " ;
            VImperative _ Pl Passive => " " ;

            Gerund => " " ;

            Participle d  g n c => (regAdj part).s !d! g !n !c
             } 
            };



       VerbDeponent2 : (x1,_,_,_,_,_: Str) -> Verb = \noiAzomai, noiastW, noiAstika, noiazOmoun, noiAsou, part-> 
        let
          noiAz = Predef.tk 4 noiAzomai ;
          noiast = init noiastW ;             
          noiAst = Predef.tk 3 noiAstika ;
          noiaz = Predef.tk 5  noiazOmoun ;
          Imp = noiAsou ; 
          Imp2= noiAz + "εστε" ; 
          part = part;
        in 
          mkVerbDeponent2 noiAzomai noiastW noiAstika noiazOmoun noiAz noiast noiAst noiaz Imp Imp2 part;


       ---------Verbs in -ομαι -------
    mkVerbDeponent3 : (x1,_,_,_,_,_,_,_,_,_,_,_: Str) -> Verb = \gInomai, gInw, Egina, ginOmoun, gIn, gin, GIn, gIN, Egin ,  Imp, Imp2,part    ->
     {
        s = table {
            VPres Ind Sg P1 Active _ => gIn + "ομαι" ;
            VPres Ind Sg P2 Active _ => gIn + "εσαι"; 
            VPres Ind Sg P3 Active _=> gIn + "εται" ;
            VPres Ind Pl P1 Active _ => gin + "όμαστε" ;
            VPres Ind Pl P2 Active _ => gin + "όσαστε";
            VPres Ind Pl P3 Active _ => gIn + "ονται" ;

            VPres Ind Sg P1 Passive  _ =>" "  ; 
            VPres Ind Sg P2 Passive  _ => " " ;
            VPres Ind Sg P3 Passive  _=> " " ;
            VPres Ind Pl P1 Passive  _=> " " ;   
            VPres Ind Pl P2 Passive  _ => " " ;
            VPres Ind Pl P3 Passive  _ => " " ;
            
            VPres _ Sg P1 Active  _ =>  GIn + "ω" ;
            VPres _ Sg P2 Active  _ =>  GIn + "εις" ;
            VPres _ Sg P3 Active  _ =>  GIn + "ει" ;
            VPres _ Pl P1 Active  _=>  GIn + "ουμε" ;
            VPres _ Pl P2 Active  _ =>  GIn + "ετε" ;
            VPres _ Pl P3 Active  _ =>  GIn + "ουν" ;

            VPres _ Sg P1 Passive  _ => " ";
            VPres _ Sg P2 Passive  _ => " " ;
            VPres _ Sg P3 Passive  _ => " " ;
            VPres _ Pl P1 Passive  _ => " " ;
            VPres _ Pl P2 Passive  _ => " ";
            VPres _ Pl P3 Passive  _ => " " ;

            VPast _ Sg P1 Active Perf => Egin  + "α" ;
            VPast _ Sg P2 Active Perf=> Egin + "ες" ;
            VPast _ Sg P3 Active Perf => Egin + "ε" ;
            VPast _ Pl P1 Active Perf => gIN + "αμε" ;
            VPast _ Pl P2 Active Perf => gIN + "ατε" ;
            VPast _ Pl P3 Active Perf => Egin +  "αν" ;

            VPast _ Sg P1 Passive Perf => " " ;
            VPast _ Sg P2 Passive Perf => " " ;
            VPast _ Sg P3 Passive Perf => " ";
            VPast _ Pl P1 Passive Perf =>  " ";
            VPast _ Pl P2 Passive Perf=>" ";
            VPast _ Pl P3 Passive Perf => " ";

            VPast _ Sg P1 Active Imperf => gin + "όμουν" ;
            VPast _ Sg P2 Active Imperf => gin + "όσουν" ;
            VPast _ Sg P3 Active Imperf => gin + "όταν" ;
            VPast _ Pl P1 Active Imperf => gin + "όμασταν" ;
            VPast _ Pl P2 Active Imperf => gin + "όσασταν" ;
            VPast _ Pl P3 Active Imperf => gin + "όντουσαν" ;

            VPast _ Sg P1  Passive Imperf=> " " ;
            VPast _ Sg P2  Passive Imperf =>  " " ;
            VPast _ Sg P3  Passive Imperf => " " ;
            VPast _ Pl P1  Passive Imperf => " ";
            VPast _ Pl P2  Passive Imperf=> " " ;
            VPast _ Pl P3  Passive Imperf => " ";

            VNonFinite Active       =>  GIn + "ει" ; 
            VNonFinite Passive       => " " ; 

            VImperative Perf Sg Active=> Imp ;
            VImperative Perf Pl Active => Imp2 ;
            VImperative Imperf Sg  Active => " ";
            VImperative Imperf Pl Active => " " ;

            VImperative _  Sg Passive =>  " " ;
            VImperative _ Pl Passive => " " ;

            Gerund => " " ;

            Participle d  g n c => (regAdj part).s !d! g !n !c
            } 
            };


     -----For verbs in  -ομαι, not stressed present Conjuctive-----
      VerbDeponent3 : (x1,_,_,_,_,_,_ : Str) -> Verb = \gInomai, gInw, Egina, ginOmoun, gIne, gInete, part-> 
        let
          gIn = Predef.tk 4 gInomai ;
          gin = mkVerbStem gIn ;  
          gIN = gIn ;           
          Egin = init Egina ;
          ginO = Predef.tk 4  ginOmoun ;
          Imp = gIne ; 
          Imp2= gInete ;
          part = part; 
        in 
           mkVerbDeponent3 gInomai gInw Egina ginOmoun gIn gin gIn gIN Egin   Imp Imp2 part ;


       -----For verbs in  -ομαι, not stressed present Conjuctive, irregular cases like έρχομαι-----
       VerbDeponent4 : (x1,_,_,_,_,_,_ : Str) -> Verb = \Erxomai, Erthw, Irtha, erxOmoun, Ela, elAte,part-> 
        let
          Erx = Predef.tk 4 Erxomai ;
          Erth =  init Erthw ;             
          Irth = init Irtha ;
          erx = Predef.tk 5  erxOmoun ;
          Imp = Ela ; 
          Imp2= elAte ;
          part = part;   
        in 
          mkVerbDeponent3 Erxomai Erthw Irtha erxOmoun Erx erx  Erth Irth Irth   Imp Imp2 part ;


      VerbDeponent5 : (x1,_,_,_,_,_,_ : Str) -> Verb = \kAthomai, kathIsw, kAthisa, kathOmoun, kAthise, kathIste,part-> 
        let
          kAth = Predef.tk 4 kAthomai ;
          kathIs =  init kathIsw ;             
          kAthis = init kAthisa ;
          kath = Predef.tk 5  kathOmoun ;
          Imp = kAthise ; 
          Imp2= kathIste ;
          part = part;   
        in 
          mkVerbDeponent3 kAthomai kathIsw kAthisa kathOmoun kAth kath  kathIs kathIs kAthis   Imp Imp2 part ;


    mkVerbNoPassiveA : (x1,_,_,_,_,_,_,_,_,_,_,_,_,_: Str) -> Verb = \apotyxaInw, apotYxw, apEtyxa,apotYxaina,apotyxaIn,apotYx, apEtyx, apotYxain, Nonfinite, Imp1, Imp2, Imp3, Imp4,part   ->
     {
         s = table {
            VPres Ind Sg P1 Active _ => apotyxaIn + "ω" ;
            VPres Ind Sg P2 Active _ => apotyxaIn + "εις" ;
            VPres Ind Sg P3 Active _=> apotyxaIn + "ει" ;
            VPres Ind Pl P1 Active _ => apotyxaIn + "ουμε" ;
            VPres Ind Pl P2 Active _ => apotyxaIn + "ετε" ;
            VPres Ind Pl P3 Active _ => apotyxaIn + "ουν" ;

            VPres Ind Sg P1 Passive  _ => " " ; 
            VPres Ind Sg P2 Passive  _ => " "   ;
            VPres Ind Sg P3 Passive  _=> " "   ;
            VPres Ind Pl P1 Passive  _=> " "   ;   
            VPres Ind Pl P2 Passive  _ => " "  ;
            VPres Ind Pl P3 Passive  _ => " "   ;
            
            VPres _ Sg P1 Active  _ => apotYxw ;
            VPres _ Sg P2 Active  _ => apotYx + "εις" ;
            VPres _ Sg P3 Active  _ => apotYx + "ει" ;
            VPres _ Pl P1 Active  _=> apotYx + "ουμε" ;
            VPres _ Pl P2 Active  _ => apotYx + "ετε" ;
            VPres _ Pl P3 Active  _ =>  apotYx + "ουν" ;

            VPres _ Sg P1 Passive  _ => " " ;
            VPres _ Sg P2 Passive  _ => " "  ;
            VPres _ Sg P3 Passive  _ => " "  ;
            VPres _ Pl P1 Passive  _ => " "  ;
            VPres _ Pl P2 Passive  _ => " "  ;
            VPres _ Pl P3 Passive  _ => " " ;
            
            VPast _ Sg P1 Active Perf => apEtyxa ;
            VPast _ Sg P2 Active Perf=> apEtyx + "ες" ;
            VPast _ Sg P3 Active Perf => apEtyx + "ε" ;
            VPast _ Pl P1 Active Perf => apotYx  +  "αμε" ;
            VPast _ Pl P2 Active Perf => apotYx  + "ατε" ;
            VPast _ Pl P3 Active Perf => apEtyx + "αν" ;

            VPast _ Sg P1 Passive Perf =>" "  ;
            VPast _ Sg P2 Passive Perf => " "  ;
            VPast _ Sg P3 Passive Perf => " " ;
            VPast _ Pl P1 Passive Perf => " "  ;
            VPast _ Pl P2 Passive Perf=> " "  ;
            VPast _ Pl P3 Passive Perf => " "  ;

            VPast _ Sg P1 Active Imperf => apotYxaina ;
            VPast _ Sg P2 Active Imperf => apotYxain + "ες" ;
            VPast _ Sg P3 Active Imperf => apotYxain + "ε" ;
            VPast _ Pl P1 Active Imperf => apotyxaIn+ "αμε" ;
            VPast _ Pl P2 Active Imperf => apotyxaIn + "ατε" ;
            VPast _ Pl P3 Active Imperf => apotYxain + "αν" ;

            VPast _ Sg P1  Passive Imperf=>" " ;
            VPast _ Sg P2  Passive Imperf => " " ;
            VPast _ Sg P3  Passive Imperf => " ";
            VPast _ Pl P1  Passive Imperf => " " ;
            VPast _ Pl P2  Passive Imperf=> " " ;
            VPast _ Pl P3  Passive Imperf => " " ;
            
            VNonFinite Active       => Nonfinite ;
            VNonFinite Passive       =>  " " ; 

            VImperative Perf Sg Active=>   Imp1 ;
            VImperative Perf Pl Active =>   Imp2;
            VImperative Imperf Sg  Active =>  Imp3;
            VImperative Imperf Pl Active =>  Imp4 ;

            VImperative _  Sg Passive =>  " " ;
            VImperative _ Pl Passive => " " ;

            Gerund =>apotyxaIn + "οντας" ;
            Participle d  g n c => (regAdj part).s !d! g !n !c
            } 
            } ;



    VerbNoPassive : (x1,_,_,_,_,_ : Str) -> Verb = \apotyxaInw, apotYxw, apEtyxa,apotYxaina, apEtyxe,part-> 
      let
        apotyxaIn = init apotyxaInw ;             
        apotYx = init apotYxw ;             
        apEtyx = init apEtyxa ;            
        apotYxain = init apotYxaina ; 
        Nonfinite = apotYx + "ει" ;
        Imp1 = apEtyxe ;
        Imp2 = mkImper apotYx  ; 
        Imp3 = apotYxain+ "ε";
        Imp4  =  apotyxaIn + "ετε";
        part = part;   
      in 
       mkVerbNoPassiveA apotyxaInw apotYxw apEtyxa apotYxaina apotyxaIn apotYx apEtyx apotYxain Nonfinite Imp1 Imp2 Imp3 Imp4  part;

      ----verbs with 2 syllables ------ 
    VerbNoPassive1 : (x1,_,_,_,_ : Str) -> Verb = \mEnw, meInw, Emeina ,Emena,part -> 
      let
        mEn = init mEnw ;             
        meIn = init meInw ;             
        Emein = init Emeina ;            
        Emen = init Emena ; 
        Nonfinite = meIn + "ει" ;
        Imp1 = meIn + "ε" ;
        Imp2 = mkImper meIn   ; 
        Imp3 = mEn+ "ε";
        Imp4  =  mEn + "ετε";
      in 
       mkVerbNoPassiveA mEnw meInw Emeina Emena mEn meIn Emein  Emen Nonfinite Imp1 Imp2 Imp3 Imp4  part;

     
    VerbNoPassive2 : (x1,_,_,_,_,_ : Str) -> Verb = \anevaInw, anEvw, anEbika,anEvaina, anEva,part-> 
      let
        anevaIn = init anevaInw ;             
        anEv = init anEvw ;             
        anEbik = init anEbika ;            
        anEvain = init anEvaina ;
        Nonfinite = anEv + "ει" ; 
        Imp1 = anEva ;
        Imp2 = Predef.tk 3 anevaIn + "είτε" ; 
        Imp3 = anEvain+ "ε";
        Imp4  =  anevaIn + "ετε";  
      in 
       mkVerbNoPassiveA anevaInw anEvw anEbika anEvaina anevaIn anEv anEbik anEvain Nonfinite Imp1 Imp2 Imp3 Imp4 part ;



    ---For verbs that have more than 2 syllables in the present _ ------ 
    VerbNoPassive2syll : (x1,_,_,_,_ : Str) -> Verb = \thElw, thelIsw, thElisa ,Ithela,part -> 
      let
        thEl = init thElw ;             
        thelIs = init thelIsw ;             
        thElis = init thElisa ;            
        Ithel = init Ithela ; 
        Nonfinite = thelIs + "ει" ;
        Imp1 = thElis + "ε" ;
        Imp2 = mkImper thelIs   ; 
        Imp3 = thEl+ "ε";
        Imp4  =  thEl + "ετε" ;  
      in 
       mkVerbNoPassiveA thElw thelIsw thElisa Ithela thEl thelIs thElis Ithel  Nonfinite Imp1 Imp2 Imp3 Imp4  part;

    mkVerbNoPassiveB : (x1,_,_,_,_,_,_,_,_,_,_,_,_,_: Str) -> Verb = \dipsW, dipsAsw, dIpsasa,dipsoYsa ,dips,dipsAs, dIpsas, dipsoYs, Nonfinite, Imp1, Imp2, Imp3, Imp4,part   ->
      {
        s = table {
            VPres Ind Sg P1 Active _ => dips + "ώ" ;
            VPres Ind Sg P2 Active _ => dips + "άς" ;
            VPres Ind Sg P3 Active _=> dips + "ά" ;
            VPres Ind Pl P1 Active _ => dips + "άμε" ;
            VPres Ind Pl P2 Active _ => dips + "άτε" ;
            VPres Ind Pl P3 Active _ => dips + "ούν" ;

            VPres Ind Sg P1 Passive  _ => " " ; 
            VPres Ind Sg P2 Passive  _ => " "   ;
            VPres Ind Sg P3 Passive  _=> " "   ;
            VPres Ind Pl P1 Passive  _=> " "   ;   
            VPres Ind Pl P2 Passive  _ => " "  ;
            VPres Ind Pl P3 Passive  _ => " "   ;
            
            VPres _ Sg P1 Active  _ => dipsAsw ;
            VPres _ Sg P2 Active  _ => dipsAs + "εις" ;
            VPres _ Sg P3 Active  _ => dipsAs + "ει" ;
            VPres _ Pl P1 Active  _=> dipsAs + "ουμε" ;
            VPres _ Pl P2 Active  _ => dipsAs + "ετε" ;
            VPres _ Pl P3 Active  _ =>  dipsAs + "ουν" ;

            VPres _ Sg P1 Passive  _ => " " ;
            VPres _ Sg P2 Passive  _ => " "  ;
            VPres _ Sg P3 Passive  _ => " "  ;
            VPres _ Pl P1 Passive  _ => " "  ;
            VPres _ Pl P2 Passive  _ => " "  ;
            VPres _ Pl P3 Passive  _ => " " ;
            
            VPast _ Sg P1 Active Perf => dIpsasa ;
            VPast _ Sg P2 Active Perf=> dIpsas + "ες" ;
            VPast _ Sg P3 Active Perf => dIpsas + "ε" ;
            VPast _ Pl P1 Active Perf => dipsAs  +  "αμε" ;
            VPast _ Pl P2 Active Perf => dipsAs  + "ατε" ;
            VPast _ Pl P3 Active Perf => dIpsas + "αν" ;

            VPast _ Sg P1 Passive Perf =>" "  ;
            VPast _ Sg P2 Passive Perf => " "  ;
            VPast _ Sg P3 Passive Perf => " " ;
            VPast _ Pl P1 Passive Perf => " "  ;
            VPast _ Pl P2 Passive Perf=> " "  ;
            VPast _ Pl P3 Passive Perf => " "  ;

            VPast _ Sg P1 Active Imperf => dipsoYsa ;
            VPast _ Sg P2 Active Imperf => dipsoYs + "ες" ;
            VPast _ Sg P3 Active Imperf => dipsoYs + "ε" ;
            VPast _ Pl P1 Active Imperf => dipsoYs+ "αμε" ;
            VPast _ Pl P2 Active Imperf => dipsoYs + "ατε" ;
            VPast _ Pl P3 Active Imperf => dipsoYs + "αν" ;

            VPast _ Sg P1  Passive Imperf=>" " ;
            VPast _ Sg P2  Passive Imperf => " " ;
            VPast _ Sg P3  Passive Imperf => " ";
            VPast _ Pl P1  Passive Imperf => " " ;
            VPast _ Pl P2  Passive Imperf=> " " ;
            VPast _ Pl P3  Passive Imperf => " " ;
            
            VNonFinite Active       => Nonfinite ;
            VNonFinite Passive       =>  " " ; 

            VImperative Perf Sg Active=>   Imp1 ;
            VImperative Perf Pl Active =>   Imp2;
            VImperative Imperf Sg  Active =>  Imp3;
            VImperative Imperf Pl Active =>  Imp4 ;

            VImperative _  Sg Passive =>  " " ;
            VImperative _ Pl Passive => " " ;

            Gerund =>dips + "ώντας" ;
            Participle d  g n c => (regAdj part).s !d! g !n !c
            } 
          } ;


      VerbNoPassive3 : (x1,_,_,_,_,_: Str) -> Verb = \dipsW, dipsAsw, dIpsasa,dipsoYsa, dIpsa, part-> 
        let
          dips = init dipsW ;             
          dipsAs = init dipsAsw ;             
          dIpsas = init dIpsasa ;            
          dipsoYs = init dipsoYsa ;
          Nonfinite = dipsAs + "ει" ; 
          Imp1 = dIpsa ;
          Imp2 = dips+ "άτε" ; 
          Imp3 = dIpsas + "ε";
          Imp4  =  dipsAs + "τε";
          part = part;   
        in 
          mkVerbNoPassiveB dipsW dipsAsw dIpsasa dipsoYsa dips dipsAs dIpsas dipsoYs Nonfinite Imp1 Imp2 Imp3 Imp4 part ;




      mkVerbNoPassiveC : (x1,_,_,_,_,_,_,_,_,_,_,_,_,_,_: Str) -> Verb = \zW, zIsw, Ezisa,zoYsa, zIse ,z,zIs, Ezis, zoYs, Nonfinite, Imp1, Imp2, Imp3, Imp4 ,part  ->
        {
          s = table {
            VPres Ind Sg P1 Active _ => z + "ώ" ;
            VPres Ind Sg P2 Active _ => z + "είς" ;
            VPres Ind Sg P3 Active _=> z + "εί" ;
            VPres Ind Pl P1 Active _ => z + "ούμε" ;
            VPres Ind Pl P2 Active _ => z + "είτε" ;
            VPres Ind Pl P3 Active _ => z + "ούν" ;

            VPres Ind Sg P1 Passive  _ => " " ; 
            VPres Ind Sg P2 Passive  _ => " "   ;
            VPres Ind Sg P3 Passive  _=> " "   ;
            VPres Ind Pl P1 Passive  _=> " "   ;   
            VPres Ind Pl P2 Passive  _ => " "  ;
            VPres Ind Pl P3 Passive  _ => " "   ;
            
            VPres _ Sg P1 Active  _ => zIsw ;
            VPres _ Sg P2 Active  _ => zIs + "εις" ;
            VPres _ Sg P3 Active  _ => zIs + "ει" ;
            VPres _ Pl P1 Active  _=> zIs + "ουμε" ;
            VPres _ Pl P2 Active  _ => zIs+ "ετε" ;
            VPres _ Pl P3 Active  _ =>  zIs + "ουν" ;

            VPres _ Sg P1 Passive  _ => " " ;
            VPres _ Sg P2 Passive  _ => " "  ;
            VPres _ Sg P3 Passive  _ => " "  ;
            VPres _ Pl P1 Passive  _ => " "  ;
            VPres _ Pl P2 Passive  _ => " "  ;
            VPres _ Pl P3 Passive  _ => " " ;
            
            VPast _ Sg P1 Active Perf => Ezisa ;
            VPast _ Sg P2 Active Perf=> Ezis + "ες" ;
            VPast _ Sg P3 Active Perf => Ezis + "ε" ;
            VPast _ Pl P1 Active Perf => zIs  +  "αμε" ;
            VPast _ Pl P2 Active Perf => zIs  + "ατε" ;
            VPast _ Pl P3 Active Perf => Ezis + "αν" ;

            VPast _ Sg P1 Passive Perf =>" "  ;
            VPast _ Sg P2 Passive Perf => " "  ;
            VPast _ Sg P3 Passive Perf => " " ;
            VPast _ Pl P1 Passive Perf => " "  ;
            VPast _ Pl P2 Passive Perf=> " "  ;
            VPast _ Pl P3 Passive Perf => " "  ;

            VPast _ Sg P1 Active Imperf => zoYsa ;
            VPast _ Sg P2 Active Imperf => zoYs + "ες" ;
            VPast _ Sg P3 Active Imperf => zoYs + "ε" ;
            VPast _ Pl P1 Active Imperf => zoYs+ "αμε" ;
            VPast _ Pl P2 Active Imperf => zoYs + "ατε" ;
            VPast _ Pl P3 Active Imperf => zoYs + "αν" ;

            VPast _ Sg P1  Passive Imperf=>" " ;
            VPast _ Sg P2  Passive Imperf => " " ;
            VPast _ Sg P3  Passive Imperf => " ";
            VPast _ Pl P1  Passive Imperf => " " ;
            VPast _ Pl P2  Passive Imperf=> " " ;
            VPast _ Pl P3  Passive Imperf => " " ;
            
            VNonFinite Active       => Nonfinite ;
            VNonFinite Passive       =>  " " ; 

            VImperative Perf Sg Active=>   Imp1 ;
            VImperative Perf Pl Active =>   Imp2;
            VImperative Imperf Sg  Active =>  Imp3;
            VImperative Imperf Pl Active =>  Imp4 ;

            VImperative _  Sg Passive =>  " " ;
            VImperative _ Pl Passive => " " ;

            Gerund =>z + "ώντας" ;
            Participle d  g n c => (regAdj part).s !d! g !n !c
            } 
          } ;


      VerbNoPassive4 : (x1,_,_,_,_,_ : Str) -> Verb = \zW, zIsw, Ezisa,zoYsa , zIse, part-> 
      let
        z = init zW ;             
        zIs = init zIsw ;             
        Ezis = init Ezisa ;            
        zoYs = init zoYsa ;
        Nonfinite = zIs + "ει" ; 
        Imp1 = zIse ;
        Imp2 = z+ "είτε" ; 
        Imp3 = zIs + "ε";
        Imp4  =  zIs + "τε";
        part = part; 
      in 
       mkVerbNoPassiveC zW zIsw Ezisa zoYsa zIse  z zIs  Ezis zoYs Nonfinite Imp1 Imp2 Imp3 Imp4 part  ;


      -----more than 2 syllables------
       VerbNoPassive5 : (x1,_,_,_,_,_ : Str) -> Verb = \tharrW, tharrEpsw, thArrepsa,tharroYsa , thArrepse, part-> 
      let
        tharr = init tharrW ;             
        tharrEps = init tharrEpsw ;             
        thArreps = init thArrepsa ;            
        tharroYs = init tharroYsa ;
        Nonfinite = tharrEps + "ει" ; 
        Imp1 = thArrepse ;
        Imp2 = tharr + "είτε" ; 
        Imp3 = thArreps + "ε";
        Imp4  =  tharrEps + "τε";
        part = part; 
      in 
       mkVerbNoPassiveC tharrW tharrEpsw thArrepsa tharroYsa  thArrepse tharr tharrEps thArreps tharroYs Nonfinite Imp1 Imp2 Imp3 Imp4 part  ;



   



   
  ---------Irregular Verbs of Second Conjugation, no Passive Imperfective-----------------
        mkVerb2AIrreg : (x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13: Str) -> Verb = \anaklW, anaklAsw,anAklasa, anakloYsa, anakl, anaklAs, anAklas, anakloYs, De,anaklast, Imp, Imp2,part ->
          {
            s = table {
              VPres Ind Sg P1 Active _ => anaklW ;
              VPres Ind Sg P2 Active _ => anakl + "άς" ; 
              VPres Ind Sg P3 Active _=> anakl + "ά" ;
              VPres Ind Pl P1 Active _ => anakl+ "άμε" ;
              VPres Ind Pl P2 Active _ => anakl + "άτε" ;
              VPres Ind Pl P3 Active _ => anakl + "ούν" ;

              VPres Ind Sg P1 Passive  _ => anakl + "ώμαι" ; 
              VPres Ind Sg P2 Passive  _ => anakl + "άσαι" ;
              VPres Ind Sg P3 Passive  _=> anakl + "άται" ;
              VPres Ind Pl P1 Passive  _=> anakl + "όμαστε" ;   
              VPres Ind Pl P2 Passive  _ => anakl + "άστε" ;
              VPres Ind Pl P3 Passive  _ => anakl + "ώνται" ;
            
              VPres _ Sg P1 Active  _ => anaklAsw ;
              VPres _ Sg P2 Active  _ => anaklAs + "εις" ;  
              VPres _ Sg P3 Active  _ => anaklAs + "ει" ;
              VPres _ Pl P1 Active  _=> anaklAs + "ουμε" ;
              VPres _ Pl P2 Active  _ => anaklAs + "ετε" ;
              VPres _ Pl P3 Active  _ => anaklAs + "ουν" ;

              VPres _ Sg P1 Passive  _ => anaklast + "ώ" ;
              VPres _ Sg P2 Passive  _ => anaklast + "είς" ;
              VPres _ Sg P3 Passive  _ => anaklast + "εί" ;
              VPres _ Pl P1 Passive  _ => anaklast + "ούμε" ;
              VPres _ Pl P2 Passive  _ => anaklast + "είτε" ;
              VPres _ Pl P3 Passive  _ => anaklast + "ούν" ;

              VPast _ Sg P1 Active Perf => anAklasa ;
              VPast _ Sg P2 Active Perf=> anAklas + "ες" ;
              VPast _ Sg P3 Active Perf => anAklas + "ε" ;
              VPast _ Pl P1 Active Perf => anaklAs + "αμε" ;
              VPast _ Pl P2 Active Perf => anaklAs + "ατε" ;
              VPast _ Pl P3 Active Perf => anAklas + "αν" ;

              VPast _ Sg P1 Passive Perf => De  + "ηκα" ;
              VPast _ Sg P2 Passive Perf => De + "ηκες" ;
              VPast _ Sg P3 Passive Perf => De + "ηκε" ;
              VPast _ Pl P1 Passive Perf => anaklast + "ήκαμε" ;
              VPast _ Pl P2 Passive Perf=> anaklast + "ήκατε" ;
              VPast _ Pl P3 Passive Perf => De + "ηκαν" ;

              VPast _ Sg P1 Active Imperf => anakloYsa ;
              VPast _ Sg P2 Active Imperf => anakloYs + "ες" ;
              VPast _ Sg P3 Active Imperf => anakloYs + "ε" ;
              VPast _ Pl P1 Active Imperf => anakloYs + "αμε" ;
              VPast _ Pl P2 Active Imperf => anakloYs + "ατε" ;
              VPast _ Pl P3 Active Imperf => anakloYs + "αν" ;

              VPast _ Sg P1  Passive Imperf=> " " ;
              VPast _ Sg P2  Passive Imperf => " ";
              VPast _ Sg P3  Passive Imperf => " " ;
              VPast _ Pl P1  Passive Imperf => " " ;
              VPast _ Pl P2  Passive Imperf=> " ";
              VPast _ Pl P3  Passive Imperf => " " ;

              VNonFinite Active       => anaklAs + "ει" ; 
              VNonFinite Passive       => anaklast + "εί" ; 

              VImperative Perf Sg Active=> anAklas + "ε" ;
              VImperative Perf Pl Active => Imp ;
              VImperative Imperf Sg  Active => " " ;
              VImperative Imperf Pl Active => Imp2;

              VImperative _  Sg Passive => anaklAs + "ου" ;
              VImperative _ Pl Passive => anaklast + "είτε" ;

              Gerund => anakl + "ώντας" ;

             Participle d  g n c => (regAdj part).s !d! g !n !c
            } 
            };


      Verb2aIrreg : (x1,_,_,_,_ : Str) -> Verb = \anaklW, anaklAsw,anAklasa, anakloYsa, part-> 
        let
          anakl = init anaklW ;             
          anaklAs = init anaklAsw ;             
          anAklas = init anAklasa ;            
          anakloYs = init anakloYsa ;      
          De = mkStem4 anaklAs ;   
          anaklast = mkVerbStem De ;
          Imp = mkImper anaklAs ;
          part = mkPartStem  anaklast ;
          Imp2 =  anakl + "άτε" ;
          part = part; 
        in 
          mkVerb2AIrreg anaklW anaklAsw anAklasa anakloYsa anakl anaklAs anAklas anakloYs De anaklast Imp Imp2 part;

   
    
        -------------Verbs with no passive Imperfective ----------------------
      mkVerbNpperf : (x1,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_: Str) -> Verb = \plIttw, plIksw, Epliksa, Eplitta, plItt, plitt,   plIks, Epliks, Eplitt, plig,plIg, Imp, Imp2, Imp3,Imp4, ImpP, part ->
      {
          s = table {
            VPres Ind Sg P1 Active _ => plItt + "ω" ;
            VPres Ind Sg P2 Active _ => plItt + "εις" ;
            VPres Ind Sg P3 Active _=> plItt + "ει" ;
            VPres Ind Pl P1 Active _ => plItt + "ουμε" ;
            VPres Ind Pl P2 Active _ => plItt + "ετε" ;
            VPres Ind Pl P3 Active _ => plItt + "ουν" ;

            VPres Ind Sg P1 Passive  _ => plItt  + "ομαι" ; 
            VPres Ind Sg P2 Passive  _ => plItt  +"εσαι" ;
            VPres Ind Sg P3 Passive  _=> plItt  +"εται" ;
            VPres Ind Pl P1 Passive  _=> plitt  +"όμαστε" ;   
            VPres Ind Pl P2 Passive  _ => plItt  + "εστε" ;
            VPres Ind Pl P3 Passive  _ => plItt  +"ονται" ;
            
            VPres _ Sg P1 Active  _ => plIksw ;
            VPres _ Sg P2 Active  _ => plIks + "εις" ;
            VPres _ Sg P3 Active  _ => plIks + "ει" ;
            VPres _ Pl P1 Active  _=> plIks + "ουμε" ;
            VPres _ Pl P2 Active  _ => plIks + "ετε" ;
            VPres _ Pl P3 Active  _ =>  plIks + "ουν" ;

            VPres _ Sg P1 Passive  _ => plig + "ώ" ;
            VPres _ Sg P2 Passive  _ => plig + "είς" ;
            VPres _ Sg P3 Passive  _ => plig + "εί" ;
            VPres _ Pl P1 Passive  _ => plig + "ούμε" ;
            VPres _ Pl P2 Passive  _ => plig + "είτε" ;
            VPres _ Pl P3 Passive  _ => plig + "ούν" ;
            
            VPast _ Sg P1 Active Perf => Epliksa ;
            VPast _ Sg P2 Active Perf=> Epliks + "ες" ;
            VPast _ Sg P3 Active Perf => Epliks + "ε" ;
            VPast _ Pl P1 Active Perf => plIks  +  "αμε" ;
            VPast _ Pl P2 Active Perf => plIks  + "ατε" ;
            VPast _ Pl P3 Active Perf => Epliks + "αν" ;
   
            VPast _ Sg P1 Passive Perf => plIg  + "ηκα" ;
            VPast _ Sg P2 Passive Perf => plIg + "ηκες" ;
            VPast _ Sg P3 Passive Perf => plIg + "ηκε" ;
            VPast _ Pl P1 Passive Perf => plig + "ήκαμε" ;
            VPast _ Pl P2 Passive Perf=> plig + "ήκατε" ;
            VPast _ Pl P3 Passive Perf => plIg + "ηκαν" ;

            VPast _ Sg P1 Active Imperf => Eplitta ;
            VPast _ Sg P2 Active Imperf => Eplitt + "ες" ;
            VPast _ Sg P3 Active Imperf => Eplitt + "ε" ;
            VPast _ Pl P1 Active Imperf => plItt+ "αμε" ;
            VPast _ Pl P2 Active Imperf => plItt + "ατε" ;
            VPast _ Pl P3 Active Imperf => Eplitt + "αν" ;

            VPast _ Sg P1  Passive Imperf=> " " ;
            VPast _ Sg P2  Passive Imperf => " " ;
            VPast _ Sg P3  Passive Imperf => " " ;
            VPast _ Pl P1  Passive Imperf =>  " " ;
            VPast _ Pl P2  Passive Imperf=>  " ";
            VPast _ Pl P3  Passive Imperf => " ";
            
            VNonFinite Active       => plIks + "ει" ;
            VNonFinite Passive       => plig + "εί" ; 

            VImperative Perf Sg Active=> Imp3 ;
            VImperative Perf Pl Active => Imp ;
            VImperative Imperf Sg  Active => Imp4;
            VImperative Imperf Pl Active => Imp2;

            VImperative _  Sg Passive => ImpP ;
            VImperative _ Pl Passive => plig + "είτε" ;

            Gerund =>plItt + "οντας" ;

            Participle d  g n c => (regAdj part).s !d! g !n !c
             } 
           } ;


    VerbNpperf : (x1,_,_,_,_: Str) -> Verb = \plIttw, plIksw,Epliksa, Eplitta,part-> 
      let
        plItt = init plIttw ; 
        plitt = mkVerbStem plItt ;            
        plIks = init plIksw ;             
        Epliks = init Epliksa ;            
        Eplitt = init Eplitta ;      
        plIg = mkStem2 plIksw ;
        plig = mkVerbStem plIg ;
        Imp = mkImper plIks ;
        Imp2 =  plItt + "ετε" ;
        Imp3 =  plIks + "ε" ;
        Imp4 =  plItt + "ε" ;
        ImpP = plIks + "ου" ;
        part =part; 
      in 
      mkVerbNpperf plIttw plIksw Epliksa Eplitta plItt plitt   plIks Epliks Eplitt plig plIg Imp Imp2 Imp3 Imp4 ImpP part;


   VerbNpperf2 : (x1,_,_,_,_: Str) -> Verb = \petyxaInw, petYxw,pEtyxa, petYxaina, part-> 
      let
        petyxaIn = init petyxaInw ; 
        petyxainw = mkVerbStem petyxaInw ;            
        petYx = init petYxw ;             
        pEtyx = init pEtyxa ;            
        petYxain = init petYxaina ;      
        epitEyxth = mkStem2 petYxw ;
        epiteyxth = mkVerbStem epitEyxth ;
        Imp = mkImper petYx ;
        Imp2 =  petyxaIn + "ετε" ;
        Imp3 =  pEtyx + "ε" ;
        Imp4 =  petYxain + "ε" ;
        ImpP = mkImperPassive epitEyxth + "ου"  ;
        part =part; 
      in 
      mkVerbNpperf petyxaInw petYxw pEtyxa petYxaina petyxaIn petyxainw   petYx pEtyx petYxain epiteyxth epitEyxth Imp Imp2 Imp3 Imp4 ImpP part;
    
      
      auxVerb : Verb = mkAux "έχω" "είχα" "έχε" "έχετε" "έχων" ;


    Verbirreg_pigaInw : (x1,_,_,_: Str) -> Verb = \pigAinw, pAw, pIga,pIgaina    ->
      let
        pigAin = init pigAinw ;             
        pA = init pAw ;             
        pIg = init pIga;            
        pIgain = init pIgaina;      
        part= " " ;
      in 
     {
      s = table {
            VPres Ind Sg P1 Active _ => pigAin + "ω" ;
            VPres Ind Sg P2 Active _ => pigAin + "εις"  ;
            VPres Ind Sg P3 Active _=> pigAin + "ει"  ;
            VPres Ind Pl P1 Active _ => pigAin + "ουμε"  ;
            VPres Ind Pl P2 Active _ => pigAin + "ετε" ;
            VPres Ind Pl P3 Active _ => pigAin + "ουν"  ;

            VPres Ind Sg P1 Passive  _ => " " ; 
            VPres Ind Sg P2 Passive  _ => " "   ;
            VPres Ind Sg P3 Passive  _=> " "   ;
            VPres Ind Pl P1 Passive  _=> " "   ;   
            VPres Ind Pl P2 Passive  _ => " "  ;
            VPres Ind Pl P3 Passive  _ => " "   ;
            
            VPres _ Sg P1 Active  _ => pAw ;
            VPres _ Sg P2 Active  _ => pA + "ς" ;
            VPres _ Sg P3 Active  _ => pA + "ει" ;
            VPres _ Pl P1 Active  _=> pA + "με" ;
            VPres _ Pl P2 Active  _ => pA + "τε" ;
            VPres _ Pl P3 Active  _ =>  pA + "νε" ;

            VPres _ Sg P1 Passive  _ => " " ;
            VPres _ Sg P2 Passive  _ => " "  ;
            VPres _ Sg P3 Passive  _ => " "  ;
            VPres _ Pl P1 Passive  _ => " "  ;
            VPres _ Pl P2 Passive  _ => " "  ;
            VPres _ Pl P3 Passive  _ => " " ;
            
            VPast _ Sg P1 Active Perf => pIga ;
            VPast _ Sg P2 Active Perf=> pIg + "ες" ;
            VPast _ Sg P3 Active Perf => pIg + "ε" ;
            VPast _ Pl P1 Active Perf => pIg  +  "αμε" ;
            VPast _ Pl P2 Active Perf => pIg  + "ατε" ;
            VPast _ Pl P3 Active Perf => pIg + "αν" ;

            VPast _ Sg P1 Passive Perf =>" "  ;
            VPast _ Sg P2 Passive Perf => " "  ;
            VPast _ Sg P3 Passive Perf => " " ;
            VPast _ Pl P1 Passive Perf => " "  ;
            VPast _ Pl P2 Passive Perf=> " "  ;
            VPast _ Pl P3 Passive Perf => " "  ;

            VPast _ Sg P1 Active Imperf => pIgaina ;
            VPast _ Sg P2 Active Imperf => pIgain + "ες" ;
            VPast _ Sg P3 Active Imperf => pIgain + "ε" ;
            VPast _ Pl P1 Active Imperf => pigAin+ "αμε" ;
            VPast _ Pl P2 Active Imperf => pigAin + "ατε" ;
            VPast _ Pl P3 Active Imperf => pIgain + "αν" ;

            VPast _ Sg P1  Passive Imperf=>" " ;
            VPast _ Sg P2  Passive Imperf => " " ;
            VPast _ Sg P3  Passive Imperf => " ";
            VPast _ Pl P1  Passive Imperf => " " ;
            VPast _ Pl P2  Passive Imperf=> " " ;
            VPast _ Pl P3  Passive Imperf => " " ;
            
            VNonFinite Active       => pA + "ει" ;
            VNonFinite Passive       =>  " " ; 

            VImperative Perf Sg Active=>   pA + "νε" ;
            VImperative Perf Pl Active =>  pA + "τε" ;
            VImperative Imperf Sg  Active =>  pIgain + "ε";
            VImperative Imperf Pl Active =>  pigAin + "ετε" ;

            VImperative _  Sg Passive =>  " " ;
            VImperative _ Pl Passive => " " ;

            Gerund =>pigAin + "οντας" ;
            Participle d  g n c => (regAdj part).s !d! g !n !c    
            } 
            } ;



    -------A small number of verbs form their active or passive past by using endings in -ην. Mostly used in formal _texts.---------------------
    mkVerbIN : (x1,_,_,_,_,_,_,_,_,_,_,_,_,_,_: Str) -> Verb = \kathistW, katastIsw, katEstisa, kathistoYsa, kathist, katastIs,   katEstis, kathistoYs, kathIst, katast, katEst, Imp, Imp1, Imp2,  part ->
     {
      s = table {
            VPres Ind Sg P1 Active _ => kathist + "ώ" ;
            VPres Ind Sg P2 Active _ => kathist + "άς" ;
            VPres Ind Sg P3 Active _=> kathist + "ά" ;
            VPres Ind Pl P1 Active _ => kathist + "άμε" ;
            VPres Ind Pl P2 Active _ => kathist + "άτε" ;
            VPres Ind Pl P3 Active _ => kathist + "ούν" ;

            VPres Ind Sg P1 Passive  _ => kathIst  + "αμαι" ; 
            VPres Ind Sg P2 Passive  _ => kathIst  +"ασαι" ;
            VPres Ind Sg P3 Passive  _=> kathIst  +"αται" ;
            VPres Ind Pl P1 Passive  _=> kathist  +"άμεθα" ;   
            VPres Ind Pl P2 Passive  _ => kathIst  + "ασθε" ;
            VPres Ind Pl P3 Passive  _ => kathIst  +"ανται" ;
            
            VPres _ Sg P1 Active  _ => katastIsw ;
            VPres _ Sg P2 Active  _ => katastIs + "εις" ;
            VPres _ Sg P3 Active  _ => katastIs + "ει" ;
            VPres _ Pl P1 Active  _=> katastIs + "ουμε" ;
            VPres _ Pl P2 Active  _ => katastIs + "ετε" ;
            VPres _ Pl P3 Active  _ => katastIs + "ουν" ;

            VPres _ Sg P1 Passive  _ => katast + "ώ" ;
            VPres _ Sg P2 Passive  _ => katast + "είς" ;
            VPres _ Sg P3 Passive  _ => katast + "εί" ;
            VPres _ Pl P1 Passive  _ => katast + "ούμε" ;
            VPres _ Pl P2 Passive  _ => katast + "είτε" ;
            VPres _ Pl P3 Passive  _ => katast + "ούν" ;
            
            VPast _ Sg P1 Active Perf => katEstisa ;
            VPast _ Sg P2 Active Perf=> katEstis + "ες" ;
            VPast _ Sg P3 Active Perf => katEstis + "ε" ;
            VPast _ Pl P1 Active Perf => katastIs  +  "αμε" ;
            VPast _ Pl P2 Active Perf => katastIs  + "ατε" ;
            VPast _ Pl P3 Active Perf => katEstis + "αν" ;
   
            VPast _ Sg P1 Passive Perf => katEst  + "ην" ;
            VPast _ Sg P2 Passive Perf => katEst + "ης" ;
            VPast _ Sg P3 Passive Perf => katEst + "η" ;
            VPast _ Pl P1 Passive Perf => " " ;
            VPast _ Pl P2 Passive Perf=>  " " ;
            VPast _ Pl P3 Passive Perf => katEst + "ησαν" ;

            VPast _ Sg P1 Active Imperf => kathistoYsa ;
            VPast _ Sg P2 Active Imperf => kathistoYs + "ες" ;
            VPast _ Sg P3 Active Imperf => kathistoYs + "ε" ;
            VPast _ Pl P1 Active Imperf => kathistoYs+ "αμε" ;
            VPast _ Pl P2 Active Imperf => kathistoYs + "ατε" ;
            VPast _ Pl P3 Active Imperf => kathistoYs + "αν" ;

            VPast _ Sg P1  Passive Imperf=> " " ;
            VPast _ Sg P2  Passive Imperf => " " ;
            VPast _ Sg P3  Passive Imperf => " " ;
            VPast _ Pl P1  Passive Imperf =>  " " ;
            VPast _ Pl P2  Passive Imperf=>  " ";
            VPast _ Pl P3  Passive Imperf => " ";
            
            VNonFinite Active       => katastIs + "ει" ;
            VNonFinite Passive       => katast + "εί" ; 

            VImperative Perf Sg Active=> Imp ;
            VImperative Perf Pl Active => Imp1  ;
            VImperative Imperf Sg  Active => " ";
            VImperative Imperf Pl Active => Imp2;

            VImperative _  Sg Passive => katastIs + "ου" ;
            VImperative _ Pl Passive => katast + "είτε" ;

            Gerund =>katast + "ώντας" ;

            Participle d  g n c => (regAdj part).s !d! g !n !c
            } 
            } ;


    VerbIN : (x1,_,_,_,_: Str) -> Verb = \kathistW, katastIsw, katEstisa, kathistoYsa, katestimEnos-> 
      let
        kathist = init kathistW ;           
        katastIs = init katastIsw ;             
        katEstis = init katEstisa ;            
        kathistoYs = init kathistoYsa ;      
        kathIst = mkStem kathistW ;
        katast  = Predef.tk 2  katastIs ;
        katEst= Predef.tk 2  katEstis ;
        Imp = katEstis + "ε" ;
        Imp1 =  katastIs + "τε" ;
        Imp2 =  kathist + "άτε" ; 
        part = katestimEnos ;
      in 
      mkVerbIN kathistW katastIsw katEstisa kathistoYsa kathist katastIs   katEstis kathistoYs kathIst katast katEst Imp Imp1 Imp2  part;



      -----Verbs with a prepositional prefix and the auxiliary verb εχω--------------
     mkVerbExw : (x1,x2,x3,x4,x5,x6,x7,x8,x9,x10: Str) -> Verb = \parExw, parAsxw,pareIxa, parEx, parAsx, pareIx, parex, parasxeth, parasxEth, part->
     {
       s = table {
            VPres Ind Sg P1 Active _ => parExw ;
            VPres Ind Sg P2 Active _ => parEx + "εις" ; 
            VPres Ind Sg P3 Active _=> parEx + "ει" ;
            VPres Ind Pl P1 Active _ => parEx+ "ουμε" ;
            VPres Ind Pl P2 Active _ => parEx + "ετε" ;
            VPres Ind Pl P3 Active _ => parEx + "ουν" ;

            VPres Ind Sg P1 Passive  _ => parEx + "ομαι" ; 
            VPres Ind Sg P2 Passive  _ => parEx + "εσαι" ;
            VPres Ind Sg P3 Passive  _=> parEx + "εται" ;
            VPres Ind Pl P1 Passive  _=> parex + "όμαστε" ;   
            VPres Ind Pl P2 Passive  _ => parEx + "εστε" ;
            VPres Ind Pl P3 Passive  _ => parEx + "ονται" ;
            
            VPres _ Sg P1 Active  _ => parAsxw ;
            VPres _ Sg P2 Active  _ => parAsx + "εις" ;  
            VPres _ Sg P3 Active  _ => parAsx + "ει" ;
            VPres _ Pl P1 Active  _=> parAsx + "ουμε" ;
            VPres _ Pl P2 Active  _ => parAsx + "ετε" ;
            VPres _ Pl P3 Active  _ => parAsx + "ουν" ;

            VPres _ Sg P1 Passive  _ => parasxeth + "ώ" ;
            VPres _ Sg P2 Passive  _ => parasxeth + "είς" ;
            VPres _ Sg P3 Passive  _ => parasxeth + "εί" ;
            VPres _ Pl P1 Passive  _ => parasxeth + "ούμε" ;
            VPres _ Pl P2 Passive  _ => parasxeth + "είτε" ;
            VPres _ Pl P3 Passive  _ => parasxeth + "ούν" ;

            VPast _ Sg P1 Active Perf => pareIxa ;
            VPast _ Sg P2 Active Perf=> pareIx + "ες" ;
            VPast _ Sg P3 Active Perf => pareIx + "ε" ;
            VPast _ Pl P1 Active Perf => pareIx + "αμε" ;
            VPast _ Pl P2 Active Perf => pareIx + "ατε" ;
            VPast _ Pl P3 Active Perf => pareIx + "αν" ;

            VPast _ Sg P1 Passive Perf => parasxEth  + "ηκα" ;
            VPast _ Sg P2 Passive Perf => parasxEth + "ηκες" ;
            VPast _ Sg P3 Passive Perf => parasxEth + "ηκε" ;
            VPast _ Pl P1 Passive Perf => parasxeth + "ήκαμε" ;
            VPast _ Pl P2 Passive Perf=> parasxeth + "ήκατε" ;
            VPast _ Pl P3 Passive Perf => parasxEth + "ηκαν" ;

            VPast _ Sg P1 Active Imperf => pareIxa ;
            VPast _ Sg P2 Active Imperf => pareIx + "ες" ;
            VPast _ Sg P3 Active Imperf => pareIx + "ε" ;
            VPast _ Pl P1 Active Imperf => pareIx + "αμε" ;
            VPast _ Pl P2 Active Imperf => pareIx + "ατε" ;
            VPast _ Pl P3 Active Imperf => pareIx + "αν" ;

            VPast _ Sg P1  Passive Imperf=> parex + "όμουν" ;
            VPast _ Sg P2  Passive Imperf => parex + "όσουν" ;
            VPast _ Sg P3  Passive Imperf => parex + "όταν" ;
            VPast _ Pl P1  Passive Imperf => parex + "όμασταν" ;
            VPast _ Pl P2  Passive Imperf=> parex + "όσασταν" ;
            VPast _ Pl P3  Passive Imperf => parex + "όντουσαν" ;

            VNonFinite Active       => parEx + "ει" ; 
            VNonFinite Passive       => parasxeth + "εί" ; 

            VImperative Perf Sg Active=> " " ;
            VImperative Perf Pl Active => parAsx + "ετε";
            VImperative Imperf Sg  Active =>  " "  ;
            VImperative Imperf Pl Active => parex + "ετε" ;

            VImperative _  Sg Passive => " " ;
            VImperative _ Pl Passive => parasxeth + "είτε" ;

            Gerund => parEx + "οντας" ;

            Participle d  g n c => (regAdj part).s !d! g !n !c
             } 
            };



    VerbExw : (x1,_,_,_: Str) -> Verb = \parExw, parAsxw,pareIxa, parexOmenos-> 
      let
        parEx = init parExw ;           
        parAsx = init parAsxw ;             
        pareIx = init pareIxa ;            
        parex = mkVerbStem parEx ;      
        parasxEth = mkStem parExw ;
        parasxeth  = mkVerbStem parasxEth ;
        part = parexOmenos ;
      in 
      mkVerbExw parExw parAsxw pareIxa parEx parAsx pareIx parex parasxeth parasxEth  part;


    -----Verbs with a prepositional suffix and the auxiliary verb εχω--------------
    mkVerbExwNoPass : (x1,x2,x3,x4,x5,x6,x7: Str) -> Verb = \symmetExw, symmetAsxw, symmeteIxa, symmetEx, symmetAsx, symmeteIx,  part->
     {
      s = table {
            VPres Ind Sg P1 Active _ => symmetExw ;
            VPres Ind Sg P2 Active _ => symmetEx + "εις" ; 
            VPres Ind Sg P3 Active _=> symmetEx + "ει" ;
            VPres Ind Pl P1 Active _ => symmetEx+ "ουμε" ;
            VPres Ind Pl P2 Active _ => symmetEx + "ετε" ;
            VPres Ind Pl P3 Active _ => symmetEx + "ουν" ;

            VPres Ind Sg P1 Passive  _ => " " ; 
            VPres Ind Sg P2 Passive  _ => " " ;
            VPres Ind Sg P3 Passive  _=> " ";
            VPres Ind Pl P1 Passive  _=> " " ;   
            VPres Ind Pl P2 Passive  _ => " " ;
            VPres Ind Pl P3 Passive  _ => " ";
            
            VPres _ Sg P1 Active  _ => symmetAsxw ;
            VPres _ Sg P2 Active  _ => symmetAsx + "εις" ;  
            VPres _ Sg P3 Active  _ => symmetAsx + "ει" ;
            VPres _ Pl P1 Active  _=> symmetAsx + "ουμε" ;
            VPres _ Pl P2 Active  _ => symmetAsx + "ετε" ;
            VPres _ Pl P3 Active  _ => symmetAsx + "ουν" ;

            VPres _ Sg P1 Passive  _ => " " ;
            VPres _ Sg P2 Passive  _ => " " ;
            VPres _ Sg P3 Passive  _ => " " ;
            VPres _ Pl P1 Passive  _ => " "  ;
            VPres _ Pl P2 Passive  _ => " " ;
            VPres _ Pl P3 Passive  _ => " " ;

            VPast _ Sg P1 Active Perf => symmeteIxa ;
            VPast _ Sg P2 Active Perf=> symmeteIx + "ες" ;
            VPast _ Sg P3 Active Perf => symmeteIx + "ε" ;
            VPast _ Pl P1 Active Perf => symmeteIx + "αμε" ;
            VPast _ Pl P2 Active Perf => symmeteIx + "ατε" ;
            VPast _ Pl P3 Active Perf => symmeteIx + "αν" ;

            VPast _ Sg P1 Passive Perf => " ";
            VPast _ Sg P2 Passive Perf =>" " ;
            VPast _ Sg P3 Passive Perf => " " ;
            VPast _ Pl P1 Passive Perf => " ";
            VPast _ Pl P2 Passive Perf=> " " ;
            VPast _ Pl P3 Passive Perf => " " ;

            VPast _ Sg P1 Active Imperf => symmeteIxa ;
            VPast _ Sg P2 Active Imperf => symmeteIx + "ες" ;
            VPast _ Sg P3 Active Imperf => symmeteIx + "ε" ;
            VPast _ Pl P1 Active Imperf => symmeteIx + "αμε" ;
            VPast _ Pl P2 Active Imperf => symmeteIx + "ατε" ;
            VPast _ Pl P3 Active Imperf => symmeteIx + "αν" ;

            VPast _ Sg P1  Passive Imperf=> " " ;
            VPast _ Sg P2  Passive Imperf => " " ;
            VPast _ Sg P3  Passive Imperf =>" ";
            VPast _ Pl P1  Passive Imperf => " " ;
            VPast _ Pl P2  Passive Imperf=> " " ;
            VPast _ Pl P3  Passive Imperf => " ";

            VNonFinite Active       => symmetEx + "ει" ; 
            VNonFinite Passive       => " " ; 

            VImperative Perf Sg Active=> " " ;
            VImperative Perf Pl Active => symmetAsx + "ετε";
            VImperative Imperf Sg  Active =>  " "  ;
            VImperative Imperf Pl Active => symmetEx + "ετε" ;

            VImperative _  Sg Passive => " " ;
            VImperative _ Pl Passive => " ";

            Gerund => symmetEx + "οντας" ;

            Participle d  g n c => (regAdj part).s !d! g !n !c
             } 
            };



    VerbExwNoPass : (x1,_,_,_: Str) -> Verb = \symmetExw, symmetAsxw, symmeteIxa,symmetExon-> 
      let
        symmetEx = init symmetExw ;           
        symmetAsx = init symmetAsxw ;             
        symmeteIx = init symmeteIxa ; 
        part = symmetExon ;
      in 
        mkVerbExwNoPass symmetExw symmetAsxw symmeteIxa symmetEx symmetAsx symmeteIx  part;

    mkVerbAproswpo : (x1,x2,x3,x4: Str) -> Verb = \vrEchei, vrExei, Evrexe, Evreche->
     {
      s = table {
            VPres Ind Sg P1 Active _ => " " ;
            VPres Ind Sg P2 Active _ => " "  ; 
            VPres Ind Sg P3 Active _=> vrEchei ;
            VPres Ind Pl P1 Active _ => " "  ;
            VPres Ind Pl P2 Active _ => " "  ;
            VPres Ind Pl P3 Active _ => " "  ;

            VPres Ind Sg P1 Passive  _ => " " ; 
            VPres Ind Sg P2 Passive  _ => " " ;
            VPres Ind Sg P3 Passive  _=> " ";
            VPres Ind Pl P1 Passive  _=> " " ;   
            VPres Ind Pl P2 Passive  _ => " " ;
            VPres Ind Pl P3 Passive  _ => " ";
            
            VPres _ Sg P1 Active  _ => " "  ;
            VPres _ Sg P2 Active  _ => " "  ;  
            VPres _ Sg P3 Active  _ => vrExei ;
            VPres _ Pl P1 Active  _=> " " ;
            VPres _ Pl P2 Active  _ => " " ;
            VPres _ Pl P3 Active  _ => " " ;

            VPres _ Sg P1 Passive  _ => " " ;
            VPres _ Sg P2 Passive  _ => " " ;
            VPres _ Sg P3 Passive  _ => " " ;
            VPres _ Pl P1 Passive  _ => " "  ;
            VPres _ Pl P2 Passive  _ => " " ;
            VPres _ Pl P3 Passive  _ => " " ;

            VPast _ Sg P1 Active Perf => " " ;
            VPast _ Sg P2 Active Perf=> " " ;
            VPast _ Sg P3 Active Perf => Evrexe;
            VPast _ Pl P1 Active Perf => " " ;
            VPast _ Pl P2 Active Perf => " " ;
            VPast _ Pl P3 Active Perf => " " ;

            VPast _ Sg P1 Passive Perf => " ";
            VPast _ Sg P2 Passive Perf =>" " ;
            VPast _ Sg P3 Passive Perf => " " ;
            VPast _ Pl P1 Passive Perf => " ";
            VPast _ Pl P2 Passive Perf=> " " ;
            VPast _ Pl P3 Passive Perf => " " ;

            VPast _ Sg P1 Active Imperf => " " ;
            VPast _ Sg P2 Active Imperf => " " ;
            VPast _ Sg P3 Active Imperf => Evreche ;
            VPast _ Pl P1 Active Imperf => " " ;
            VPast _ Pl P2 Active Imperf => " " ;
            VPast _ Pl P3 Active Imperf => " " ;

            VPast _ Sg P1  Passive Imperf=> " " ;
            VPast _ Sg P2  Passive Imperf => " " ;
            VPast _ Sg P3  Passive Imperf =>" ";
            VPast _ Pl P1  Passive Imperf => " " ;
            VPast _ Pl P2  Passive Imperf=> " " ;
            VPast _ Pl P3  Passive Imperf => " ";

            VNonFinite Active       => vrExei ; 
            VNonFinite Passive       => " " ; 

            VImperative Perf Sg Active=> " " ;
            VImperative Perf Pl Active => "" ;
            VImperative Imperf Sg  Active =>  " "  ;
            VImperative Imperf Pl Active => " " ;

            VImperative _  Sg Passive => " " ;
            VImperative _ Pl Passive => " ";

            Gerund => "";

            Participle d  g n c => " "
             } 
            };


        mk_Prepei : (x1,x2: Str) -> Verb = \prEpei, Eprepe->
         {
            s = table {
              VPres Ind Sg P1 Active _ => prEpei ;
              VPres Ind Sg P2 Active _ => prEpei ; 
              VPres Ind Sg P3 Active _=> prEpei ;
              VPres Ind Pl P1 Active _ => prEpei  ;
              VPres Ind Pl P2 Active _ => prEpei ;
              VPres Ind Pl P3 Active _ => prEpei ;

              VPres Ind Sg P1 Passive  _ => " " ; 
              VPres Ind Sg P2 Passive  _ => " " ;
              VPres Ind Sg P3 Passive  _=> " ";
              VPres Ind Pl P1 Passive  _=> " " ;   
              VPres Ind Pl P2 Passive  _ => " " ;
              VPres Ind Pl P3 Passive  _ => " ";
            
              VPres _ Sg P1 Active  _ => prEpei  ;
              VPres _ Sg P2 Active  _ => prEpei ;  
              VPres _ Sg P3 Active  _ => prEpei ;
              VPres _ Pl P1 Active  _=> prEpei;
              VPres _ Pl P2 Active  _ => prEpei ;
              VPres _ Pl P3 Active  _ => prEpei ;

              VPres _ Sg P1 Passive  _ => " " ;
              VPres _ Sg P2 Passive  _ => " " ;
              VPres _ Sg P3 Passive  _ => " " ;
              VPres _ Pl P1 Passive  _ => " "  ;
              VPres _ Pl P2 Passive  _ => " " ;
              VPres _ Pl P3 Passive  _ => " " ;

              VPast _ Sg P1 Active Perf =>Eprepe ;
              VPast _ Sg P2 Active Perf=> Eprepe ;
              VPast _ Sg P3 Active Perf => Eprepe;
              VPast _ Pl P1 Active Perf => Eprepe;
              VPast _ Pl P2 Active Perf => Eprepe ;
              VPast _ Pl P3 Active Perf => Eprepe ;

              VPast _ Sg P1 Passive Perf => " ";
              VPast _ Sg P2 Passive Perf =>" " ;
              VPast _ Sg P3 Passive Perf => " " ;
              VPast _ Pl P1 Passive Perf => " ";
              VPast _ Pl P2 Passive Perf=> " " ;
              VPast _ Pl P3 Passive Perf => " " ;

              VPast _ Sg P1 Active Imperf => Eprepe ;
              VPast _ Sg P2 Active Imperf => Eprepe ;
              VPast _ Sg P3 Active Imperf => Eprepe ;
              VPast _ Pl P1 Active Imperf => Eprepe;
              VPast _ Pl P2 Active Imperf => Eprepe ;
              VPast _ Pl P3 Active Imperf => Eprepe ;

              VPast _ Sg P1  Passive Imperf=> " " ;
              VPast _ Sg P2  Passive Imperf => " " ;
              VPast _ Sg P3  Passive Imperf =>" ";
              VPast _ Pl P1  Passive Imperf => " " ;
              VPast _ Pl P2  Passive Imperf=> " " ;
              VPast _ Pl P3  Passive Imperf => " ";

              VNonFinite Active       => Eprepe ; 
              VNonFinite Passive       => " " ; 

              VImperative Perf Sg Active=> " " ;
              VImperative Perf Pl Active => "" ;
              VImperative Imperf Sg  Active =>  " "  ;
              VImperative Imperf Pl Active => " " ;

              VImperative _  Sg Passive => " " ;
              VImperative _ Pl Passive => " ";

              Gerund => "";

              Participle d  g n c => " "
              } 
              };



  }

