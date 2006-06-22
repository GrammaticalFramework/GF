resource ConjugNancy = open Prelude, TypesFre, MorphoFre in {

oper VerbeN = {s : VForm => Str} ;
oper mkNV : Verbe -> VerbeN = \ve -> 
  {s = ve} ;

oper conj : Str -> Verbe = conj1aimer ;  --- temp. default

oper v_nancy100inf : Str -> VerbeN = \ve -> {s = table {
  Inf => ve ;
  _ => nonExist
  }
} ;


oper v_nancy1 : Str -> VerbeN = \s -> mkNV (conjAvoir s) ;
oper v_nancy2 : Str -> VerbeN = \s -> mkNV (conjÊtre s) ;
-- 3-5 not used
oper v_nancy6 : Str -> VerbeN = \s -> mkNV (conj1aimer s) ;
oper v_nancy7 : Str -> VerbeN = \s -> mkNV (conj1placer s) ;
oper v_nancy8 : Str -> VerbeN = \s -> mkNV (conj1manger s) ;
oper v_nancy9 : Str -> VerbeN = \s -> mkNV (conj1peser s) ;
oper v_nancy10 : Str -> VerbeN = \s -> mkNV (conj1céder s) ;
oper v_nancy11 : Str -> VerbeN = \s -> mkNV (conj1jeter s) ;
oper v_nancy12 : Str -> VerbeN = \s -> mkNV (conj1jeter s) ;
oper v_nancy13 : Str -> VerbeN = \s -> mkNV (conj1aimer s) ;
oper v_nancy14 : Str -> VerbeN = \s -> mkNV (conj1assiéger s) ;
oper v_nancy15 : Str -> VerbeN = \s -> mkNV (conj1aimer s) ; --- ?
oper v_nancy16 : Str -> VerbeN = \s -> mkNV (conj1payer s) ;
oper v_nancy17 : Str -> VerbeN = \s -> mkNV (conj1payer s) ;
oper v_nancy18 : Str -> VerbeN = \s -> mkNV (conj1envoyer s) ;
oper v_nancy19 : Str -> VerbeN = \s -> mkNV (conj2finir s) ;
oper v_nancy20 : Str -> VerbeN = \s -> mkNV (conj2haïr s) ;
-- oper v_nancy21 : Str -> VerbeN = \s -> mkNV (conj s) ; -- not used
oper v_nancy22 : Str -> VerbeN = \s -> mkNV (conj3aller s) ;
oper v_nancy23 : Str -> VerbeN = \s -> mkNV (conj3tenir s) ;
oper v_nancy24 : Str -> VerbeN = \s -> mkNV (conj3quérir s) ;
oper v_nancy25 : Str -> VerbeN = \s -> mkNV (conj3sentir s) ;
oper v_nancy26 : Str -> VerbeN = \s -> mkNV (conj3vêtir s) ;
oper v_nancy27 : Str -> VerbeN = \s -> mkNV (conj3couvrir s) ;
oper v_nancy28 : Str -> VerbeN = \s -> mkNV (conj3cueillir s) ;
oper v_nancy29 : Str -> VerbeN = \s -> mkNV (conj3assaillir s) ;
oper v_nancy30 : Str -> VerbeN = \s -> mkNV (conj3faillir s) ;
oper v_nancy31 : Str -> VerbeN = \s -> mkNV (conj3bouillir s) ;
oper v_nancy32 : Str -> VerbeN = \s -> mkNV (conj3dormir s) ;
oper v_nancy33 : Str -> VerbeN = \s -> mkNV (conj3courir s) ;
oper v_nancy34 : Str -> VerbeN = \s -> mkNV (conj3mourir s) ;
oper v_nancy35 : Str -> VerbeN = \s -> mkNV (conj3sentir s) ;
oper v_nancy36 : Str -> VerbeN = \s -> mkNV (conj3fuir s) ;
oper v_nancy37 : Str -> VerbeN = \s -> mkNV (conj3ouïr s) ;
oper v_nancy38 : Str -> VerbeN = \s -> mkNV (conj3cevoir s) ;
oper v_nancy39 : Str -> VerbeN = \s -> mkNV (conj3voir s) ;
oper v_nancy40 : Str -> VerbeN = \s -> mkNV (conj3pourvoir s) ;
oper v_nancy41 : Str -> VerbeN = \s -> mkNV (conj3savoir s) ;
oper v_nancy42 : Str -> VerbeN = \s -> mkNV (conj3devoir s) ;
oper v_nancy43 : Str -> VerbeN = \s -> mkNV (conj3pouvoir s) ;
oper v_nancy44 : Str -> VerbeN = \s -> mkNV (conj3mouvoir s) ;
oper v_nancy45 : Str -> VerbeN = \s -> mkNV (conj3pleuvoir s) ;
oper v_nancy46 : Str -> VerbeN = \s -> mkNV (conj3falloir s) ;
oper v_nancy47 : Str -> VerbeN = \s -> mkNV (conj3valoir s) ;
oper v_nancy48 : Str -> VerbeN = \s -> mkNV (conj3vouloir s) ;
oper v_nancy49 : Str -> VerbeN = \s -> mkNV (conj3asseoir s) ;
oper v_nancy50 : Str -> VerbeN = \s -> mkNV (conj3messeoir s) ; --- ?
oper v_nancy51 : Str -> VerbeN = \s -> mkNV (conj3surseoir s) ;
oper v_nancy52 : Str -> VerbeN = \s -> mkNV (conj3choir s) ;
oper v_nancy53 : Str -> VerbeN = \s -> mkNV (conj3rendre s) ;
oper v_nancy54 : Str -> VerbeN = \s -> mkNV (conj3prendre s) ;
oper v_nancy55 : Str -> VerbeN = \s -> mkNV (conj3battre s) ;
oper v_nancy56 : Str -> VerbeN = \s -> mkNV (conj3mettre s) ;
oper v_nancy57 : Str -> VerbeN = \s -> mkNV (conj3peindre s) ;
oper v_nancy58 : Str -> VerbeN = \s -> mkNV (conj3joindre s) ;
oper v_nancy59 : Str -> VerbeN = \s -> mkNV (conj3craindre s) ;
oper v_nancy60 : Str -> VerbeN = \s -> mkNV (conj3vaincre s) ;
oper v_nancy61 : Str -> VerbeN = \s -> mkNV (conj3traire s) ;
oper v_nancy62 : Str -> VerbeN = \s -> mkNV (conj3faire s) ;
oper v_nancy63 : Str -> VerbeN = \s -> mkNV (conj3plaire s) ;
oper v_nancy64 : Str -> VerbeN = \s -> mkNV (conj3connaître s) ;
oper v_nancy65 : Str -> VerbeN = \s -> mkNV (conj3naître s) ;
oper v_nancy66 : Str -> VerbeN = \s -> mkNV (conj3paître s) ;
oper v_nancy67 : Str -> VerbeN = \s -> mkNV (conj3croître s) ;
oper v_nancy68 : Str -> VerbeN = \s -> mkNV (conj3croire s) ;
oper v_nancy69 : Str -> VerbeN = \s -> mkNV (conj3boire s) ;
oper v_nancy70 : Str -> VerbeN = \s -> mkNV (conj3clore s) ;
oper v_nancy71 : Str -> VerbeN = \s -> mkNV (conj3conclure s) ;
oper v_nancy72 : Str -> VerbeN = \s -> mkNV (conj3absoudre s) ;
oper v_nancy73 : Str -> VerbeN = \s -> mkNV (conj3coudre s) ;
oper v_nancy74 : Str -> VerbeN = \s -> mkNV (conj3moudre s) ;
oper v_nancy75 : Str -> VerbeN = \s -> mkNV (conj3suivre s) ;
oper v_nancy76 : Str -> VerbeN = \s -> mkNV (conj3vivre s) ;
oper v_nancy77 : Str -> VerbeN = \s -> mkNV (conj3lire s) ;
oper v_nancy78 : Str -> VerbeN = \s -> mkNV (conj3dire s) ;
oper v_nancy79 : Str -> VerbeN = \s -> mkNV (conj3rire s) ;
oper v_nancy80 : Str -> VerbeN = \s -> mkNV (conj3écrire s) ;
oper v_nancy81 : Str -> VerbeN = \s -> mkNV (conj3confire s) ;
oper v_nancy82 : Str -> VerbeN = \s -> mkNV (conj3cuire s) ;

-- 83-99 not used

oper v_nancy100 : Str -> VerbeN = \s -> mkNV (conj s) ; --- to do
oper v_nancy101 : Str -> VerbeN = \s -> mkNV (conj s) ; --- to do
}