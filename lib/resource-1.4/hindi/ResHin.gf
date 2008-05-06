--# -path=.:../abstract:../common:../../prelude
--
--1 Hindi auxiliary operations.
--
-- This module contains operations that are needed to make the
-- resource syntax work. 

resource ResHin = ParamX ** open Prelude in {

  flags optimize=all ;

  param 
    Case = Dir | Obl | Voc ;
    Gender = Masc | Fem ;

  oper
    Noun = {s : Number => Case => Str ; g : Gender} ;

    mkNoun : (x1,_,_,_,_,x6 : Str) -> Gender -> Noun = \sd,so,sv,pd,po,pv,g -> {
      s = table Number [table Case [sd;so;sv] ; table Case [pd;po;pv]] ;
      g = g
      } ;

    reggNoun : Str -> Gender -> Noun = \s,g -> case <s,g> of {
      <-(_ + ("a:" | "i:")), Fem> => mkNoun s s s (s + "e~") (s + "o~") (s + "o") Fem ; 
      _ => regNoun s ** {g = g}
      } ; 

    regNoun : Str -> Noun = \s -> case s of {
      x + "iya:" => mkNoun s s       s   (x + "iya:~") (x + "iyo*") (x + "iyo") Fem ;
      x + "a:"   => mkNoun s (x + "e") (x + "e") (x + "e") (x + "o*") (x + "o") Masc ;
      x + "i:"   => mkNoun s s       s   (x + "iya:~") (x + "iyo*") (x + "iyo") Fem ;
      _          => mkNoun s s       s         s           (s + "o*") (s + "o") Masc
      } ; 


    Adjective = {s : Gender => Number => Case => Str} ;

    mkAdjective : (x1,x2,x3 : Str) -> Adjective = \smd,sm,f -> {
      s = \\g,n,c => case <g,n,c> of {
        <Masc,Sg,Dir> => smd ;
        <Masc>        => sm ;
        _             => f 
        }
      } ;

    regAdjective : Str -> Adjective = \s -> case s of {
      acch + "a:" => mkAdjective s (acch + "e") (acch + "i:") ;
      _ => mkAdjective s s s
      } ;

  param 
    VForm = 
       VInf
     | VStem
     | VImpf Gender Number
     | VPerf Gender Number
     | VSubj Number Person
     | VFut  Number Person Gender
     | VReq
     | VImp
     | VReqFut
     ;

  oper
    Verb = {s : VForm => Str} ;

    mkVerb : (x1,_,_,_,_,_,_,_,_,_,_,_,_,_,x15 : Str) -> Verb = 
      \inf,stem,ims,imp,ifs,ifp,pms,pmp,pfs,pfp,ss1,ss2,sp2,sp3,r -> {
        s = 
        let ga : Number -> Gender -> Str = \n,g -> (regAdjective "ga:").s ! g ! n ! Dir 
        in table {
          VInf => inf ;
          VStem => stem ;
          VImpf Masc Sg => ims ;
          VImpf Masc Pl => imp ;
          VImpf Fem  Sg => ifs ;
          VImpf Fem  Pl => ifp ;
          VPerf Masc Sg => pms ;
          VPerf Masc Pl => pmp ;
          VPerf Fem  Sg => pfs ;
          VPerf Fem  Pl => pfp ;
          VSubj Sg   P1 => ss1 ; 
          VSubj Sg   _  => ss2 ; 
          VSubj Pl   P2 => sp2 ; 
          VSubj Pl   _  => sp3 ;
          VFut  Sg   P1 g => ss1 + ga Sg g ; 
          VFut  Sg   _  g => ss2 + ga Sg g ; 
          VFut  Pl   P2 g => sp2 + ga Pl g ; 
          VFut  Pl   _  g => sp3 + ga Pl g ;
          VReq  => r ;
          VImp  => stem + "o" ;
          VReqFut => stem + "iega:"
          }
        } ;

    regVerb : Str -> Verb = \cal -> mkVerb
      (cal + "na:") cal
      (cal + "ta:") (cal + "te") (cal + "ti:") (cal + "ti:")
      (cal + "a:")  (cal + "e")  (cal + "i:")  (cal + "i:*")
      (cal + "u:~") (cal + "e")  (cal + "o")   (cal + "e*") 
      (cal + "ie") ;

  param
    CTense = CPresent | CPast | CFuture ;
  oper 
    copula : CTense -> Number -> Person -> Gender -> Str = \t,n,p,g -> 
      case <t,n,p,g> of {
        <CPresent,Sg,P1,_   > => "hu:~" ;
        <CPresent,Sg,P2,_   > => "hE" ;
        <CPresent,Sg,P3,_   > => "hE" ;
        <CPresent,Pl,P1,_   > => "hE*" ;
        <CPresent,Pl,P2,_   > => "ho" ;
        <CPresent,Pl,P3,_   > => "hE*" ;
        <CPast,   Sg,_ ,Masc> => "Ta:" ;
        <CPast,   Sg,_ ,Fem > => "Ti:" ;
        <CPast,   Pl,_ ,Masc> => "Te" ;
        <CPast,   Pl,_ ,Fem > => "Ti:*" ;
        <CFuture, Sg,P1,Masc> => "hu:*ga:" ;
        <CFuture, Sg,P1,Fem > => "hu:*gi:" ;
        <CFuture, Sg,_ ,Masc> => "hoga:" ;
        <CFuture, Sg,_ ,Fem > => "hogi:" ;
        <CFuture, Pl,P2,Masc> => "hoge" ;
        <CFuture, Pl,_ ,Masc> => "ho*ge" ;
        <CFuture, Pl,P2,Fem > => "hogi:" ;
        <CFuture, Pl,_ ,Fem > => "ho*gi:"
        } ;

  param
    PronCase = PCase Case | PObj | PPoss ;
  oper
    personalPronoun : Person -> Number -> {s : PronCase => Str} = \p,n -> 
      case <p,n> of {
        <P1,Sg> => {s = table PronCase ["mE*"  ; "muJ" ; "muJe"   ; "mera:"]} ;
        <P1,Pl> => {s = table PronCase ["ham"  ; "ham" ; "hame*"  ; "hama:ra:"]} ;
        <P2,Sg> => {s = table PronCase ["tu:"  ; "tuJ" ; "tuJe"   ; "tera:"]} ;
        <P2,Pl> => {s = table PronCase ["tum"  ; "tum" ; "tumhe*" ; "tumha:ra:"]} ;
        <P3,Sg> => {s = table PronCase ["vah"  ; "us"  ; "use"    ; "uska:"]} ;
        <P3,Pl> => {s = table PronCase ["ve"   ; "un"  ; "unhe*"  ; "unka:"]}
        } ;

  -- the Hindi verb phrase

---    CTense = CPresent | CPast | CFuture ;

      

  param
    VPHTense = 
       VPGenPres  -- impf hum       nahim    "I go"
     | VPImpPast  -- impf Ta        nahim    "I went"
     | VPContPres -- stem raha hum  nahim    "I am going"
     | VPContPast -- stem raha Ta   nahim    "I was going"
     | VPPerf     -- perf           na/nahim "I went"
     | VPPerfPres -- perf hum       na/nahim "I have gone"
     | VPPerfPast -- perf Ta        na/nahim "I had gone"          
     | VPSubj     -- subj           na       "I may go"
     | VPFut      -- fut            na/nahim "I shall go"
     ;

    VPHForm = 
       VPTense VPHTense Agr -- 9 * 12
     | VPReq
     | VPImp
     | VPReqFut
     | VPInf
     | VPStem
     ;

    VType = VIntrans | VTrans ;

  oper
    VPH : Type = {
      s    : Bool => VPHForm => {fin, inf, neg : Str} ;
      obj  : Str ;
      subj : VType ;
      comp : Agr => Str
      } ; 

    predV : Verb -> VPH = \verb -> {
      s = \\b,vh => 
       let 
         na = if_then_Str b [] "na" ;
         nahim = if_then_Str b [] "nahim" ;
       in
       case vh of {
         VPTense VPGenPres (Ag g n p) => 
           {fin = copula CPresent n p g ; inf = verb.s ! VImpf g n ; neg = nahim} ;
         VPTense VPImpPast (Ag g n p) => 
           {fin = copula CPast n p g ; inf = verb.s ! VImpf g n ; neg = nahim} ;
         VPTense VPPerf (Ag g n _) => 
           {fin = verb.s ! VPerf g n ; inf = [] ; neg = nahim} ;
         VPTense VPPerfPres (Ag g n p) => 
           {fin = copula CPresent n p g ; inf = verb.s ! VPerf g n ; neg = nahim} ;
         VPTense VPPerfPast (Ag g n p) => 
           {fin = copula CPast n p g ; inf = verb.s ! VPerf g n ; neg = nahim} ;
         VPTense VPSubj (Ag _ n p) => {fin = verb.s ! VSubj n p ; inf = [] ; neg = na} ;
         VPTense VPFut (Ag g n p) => {fin = verb.s ! VFut n p g ; inf = [] ; neg = na} ;
         VPInf => {fin = verb.s ! VStem ; inf = [] ; neg = na} ;
         _ => {fin = verb.s ! VStem ; inf = [] ; neg = na}
         } ;
      obj = [] ;
      subj = VIntrans ;
      comp = \\_ => []
      } ;

    VPHSlash = VPH ** {c2 : Compl} ;

    Clause : Type = {s : VPHTense => Bool => Str} ;

    Compl : Type = {s : Str ; c : VType} ;

    insertObject : NP -> VPHSlash -> VPH = \np,vp -> {
      s = \\b,vh => case <vp.c2.c,vh> of {
        <VTrans, VPTense VPPerf _> => 
          vp.s ! b ! VPTense VPPerf np.a ;  -- ergative: agr to object
        _ => vp.s ! b ! vh
        } ;
      obj = vp.obj ++ np.s ! NPC Obl ++ vp.c2.s ;
      subj = vp.c2.c ;
      comp = vp.comp 
      } ;

  param
    Agr = Ag Gender Number Person ;
    NPCase = NPC Case | NPErg ;

  oper
    agrP3 : Gender -> Number -> Agr = \g,n -> Ag g n P3 ;

    npcase2case : NPCase -> Case = \npc -> case npc of {
      NPC c => c ;
      NPErg => Obl
      } ;

    toNP : (Case => Str) -> NPCase -> Str = \pn, npc -> case npc of {
      NPC c => pn ! c ;
      NPErg => pn ! Obl ++ "ne"
      } ;

    NP : Type = {s : NPCase => Str ; a : Agr} ;

    mkClause : NP -> VPH -> Clause = \np,vp -> {
      s = \\vt,b => 
        let 
          vps = vp.s ! b ! VPTense vt np.a ;
          subj = case <vp.subj,vt> of {
            <VTrans,VPPerf> => NPErg ;
            _ => NPC Dir
            }
        in
        np.s ! subj ++ vp.obj ++ vp.comp ! np.a ++ vps.neg ++ vps.inf ++ vps.fin
      } ;


}
