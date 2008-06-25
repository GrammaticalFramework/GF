cat
  S ; Cl ; NP ; VP ; CN ; AP ; Det ; N ; A ; V ; V2 ; T ;

fun
  UseCl   : T  -> Cl -> S ;
  PredVP  : NP -> VP -> Cl ;
  DetCN   : Det -> CN -> NP ;
  ModCN   : CN -> AP -> CN ;
  ComplV2 : V2 -> NP -> VP ;
  ComplAP : AP -> VP ;

  UseV : V -> VP ;
  UseA : A -> AP ;
  UseN : N -> CN ;

  Pres, Past : T ;

param
  Number = Sg | Pl ;
  Gender = Masc | Fem ;
  Case   = Nom | Acc | Dat ;
  Tense  = TPres | TPast ;
oper
  Agr    = {g : Gender ; n : Number} ;
  
lincat
  S  = {s : Str} ;
  Cl = {s : Tense => Str} ;
  VP = {s : Agr => {verb : Tense => Str ; compl : Str}} ;
  NP = {s : Case => Str ; a : Agr} ;
  CN, N = {s : Number => Case => Str ; g : Gender} ;
  AP, A = {s : Gender => Number => Case => Str} ;
  Det = {s : Gender => Case => Str ; n : Number} ;
  V  = {s : Tense => Number => Str} ;
  V2 = {s : Tense => Number => Str ; c : Case} ;
  T = {s : Str ; t : Tense} ;

lin
  UseCl t cl   = {s = cl.s ! t.t} ;
  PredVP np vp = 
    let vps = vp.s ! np.a 
    in
    {s = \\t => np.s ! Nom ++ vps.compl ++ vps.verb ! t} ;

  DetCN det cn = {
    s = \\c => det.s ! cn.g ! c ++ cn.s ! det.n ! c ;
    a = {g = cn.g ; n = det.n}
    } ;

  ModCN cn ap = {
    s = \\n,c => cn.s ! n ! c ++ ap.s ! cn.g ! n ! c ;
    g = cn.g
    } ;

  ComplAP ap = {
    s = \\a => {
      verb = \\t => copula.s ! t ! a.n ;
      compl = ap.s ! a.g ! a.n ! Nom
      }
    } ;
    
  ComplV2 v np = {
    s = \\a => {
      verb = \\t => v.s ! t ! a.n ;
      compl = np.s ! v.c
      }
    } ;

  UseA a = a ;
  UseN n = n ;

  UseV v = {
    s = \\a => {
      verb = \\t => v.s ! t ! a.n ;
      compl = []
      }
    } ;

  Pres = {s = [] ; t = TPres} ;
  Past = {s = [] ; t = TPast} ;

oper 
  copula : {s : Tense => Number => Str} = 
    mkV "est" "sunt" "fuit" "fuerunt" ;

  mkV : (est,sunt,fuit,fuerunt : Str) -> {s : Tense => Number => Str} = 
    \est,sunt,fuit,fuerunt -> {
      s = \\t,n => case <t,n> of {
        <TPres,Sg> => est ;
        <TPres,Pl> => sunt ;
        <TPast,Sg> => fuit ;
        <TPast,Pl> => fuerunt
        }
      } ;

----------- Lexical functions

oper
  Noun : Type = {s : Number => Case => Str ; g : Gender} ;
  Adjective : Type = {s : Gender => Number => Case => Str} ;
  Verb : Type = {s : Tense => Number => Str} ;

  mkN : (x1,_,_,_,_,x6 : Str) -> Gender -> Noun = 
    \romus,romum,romo,romi,romos,romis,g -> {
      s = table {
        Sg => table {
          Nom => romus ;
          Acc => romum ;
          Dat => romo
          } ;
        Pl => table {
          Nom => romi ;
          Acc => romos ;
          Dat => romis
          }
        } ;
      g = g
      } ;

  regN : Str -> Noun = \romus -> case romus of {
    rom + "us" => mkN 
      romus (rom + "um") (rom + "o") (rom + "i") (rom + "os") (rom + "is") Masc ; 
    aula@(aul + "a") => mkN 
      aula (aula + "m") (aula + "e") (aula + "e") (aula + "s") (aul + "is") Fem
    } ; 

  mkA : (_,_ : Noun) -> Adjective = \bonus,bona -> {
      s = table {
        Masc => bonus.s ;
        Fem  => bona.s
        }
      } ;

  regA : Str -> Adjective = \bonus -> case bonus of {
    bon + "us" => mkA (regN bonus) (regN (bon + "a"))
    } ;

  regV : Str -> Verb = \amare -> case amare of {
    ama + "re" => mkV (ama + "t") (ama + "nt") (ama + "vi") (ama + "verunt")
    } ;

------------ Lexicon

fun
  Cantare : V ;
  Amare, Placere : V2 ;
  Servus, Puella : N ;
  Albus : A ;

  Hic, Hi : Det ;

lin 
  Cantare = regV "cantare" ;
  Amare = regV "amare" ** {c = Acc} ;
  Placere = regV "placere" ** {c = Dat} ;
  Servus = regN "servus" ;
  Puella = regN "puella" ;
  Albus = regA "albus" ;

  Hic = {s = \\g,c => hic.s ! g ! Sg ! c ; n = Sg} ;
  Hi  = {s = \\g,c => hic.s ! g ! Pl ! c ; n = Pl} ;

oper
  hic : Adjective = mkA 
    (mkN "hic"  "hunc" "huic" "hi"  "hos" "his" Masc)
    (mkN "haec" "hanc" "huic" "hae" "has" "his" Fem) ;
