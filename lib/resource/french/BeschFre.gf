resource BeschFre = open Prelude, TypesFre, MorphoFre in {

oper VerbeN = {s : VF => Str} ;
oper mkNV : Verbe -> VerbeN = \ve -> {s = vvf ve} ;

oper conj : Str -> Verbe = conj1aimer ;  --- temp. default

oper v_nancy100inf : Str -> VerbeN = \ve -> {s = table {
  VInfin => ve ;
  _ => nonExist
  }
} ;


oper v_besch1 : Str -> VerbeN = \s -> mkNV (conjAvoir s) ;
oper v_besch2 : Str -> VerbeN = \s -> mkNV (conjÊtre s) ;
-- 3-5 not used
oper v_besch6 : Str -> VerbeN = \s -> mkNV (conj1aimer s) ;
oper v_besch7 : Str -> VerbeN = \s -> mkNV (conj1placer s) ;
oper v_besch8 : Str -> VerbeN = \s -> mkNV (conj1manger s) ;
oper v_besch9 : Str -> VerbeN = \s -> mkNV (conj1peser s) ;
oper v_besch10 : Str -> VerbeN = \s -> mkNV (conj1céder s) ;
oper v_besch11 : Str -> VerbeN = \s -> mkNV (conj1jeter s) ;
oper v_besch12 : Str -> VerbeN = \s -> mkNV (conj1jeter s) ;
oper v_besch13 : Str -> VerbeN = \s -> mkNV (conj1aimer s) ;
oper v_besch14 : Str -> VerbeN = \s -> mkNV (conj1assiéger s) ;
oper v_besch15 : Str -> VerbeN = \s -> mkNV (conj1aimer s) ; --- ?
oper v_besch16 : Str -> VerbeN = \s -> mkNV (conj1payer s) ;
oper v_besch17 : Str -> VerbeN = \s -> mkNV (conj1payer s) ;
oper v_besch18 : Str -> VerbeN = \s -> mkNV (conj1envoyer s) ;
oper v_besch19 : Str -> VerbeN = \s -> mkNV (conj2finir s) ;
oper v_besch20 : Str -> VerbeN = \s -> mkNV (conj2haïr s) ;
-- oper v_besch21 : Str -> VerbeN = \s -> mkNV (conj s) ; -- not used
oper v_besch22 : Str -> VerbeN = \s -> mkNV (conj3aller s) ;
oper v_besch23 : Str -> VerbeN = \s -> mkNV (conj3tenir s) ;
oper v_besch24 : Str -> VerbeN = \s -> mkNV (conj3quérir s) ;
oper v_besch25 : Str -> VerbeN = \s -> mkNV (conj3sentir s) ;
oper v_besch26 : Str -> VerbeN = \s -> mkNV (conj3vêtir s) ;
oper v_besch27 : Str -> VerbeN = \s -> mkNV (conj3couvrir s) ;
oper v_besch28 : Str -> VerbeN = \s -> mkNV (conj3cueillir s) ;
oper v_besch29 : Str -> VerbeN = \s -> mkNV (conj3assaillir s) ;
oper v_besch30 : Str -> VerbeN = \s -> mkNV (conj3faillir s) ;
oper v_besch31 : Str -> VerbeN = \s -> mkNV (conj3bouillir s) ;
oper v_besch32 : Str -> VerbeN = \s -> mkNV (conj3dormir s) ;
oper v_besch33 : Str -> VerbeN = \s -> mkNV (conj3courir s) ;
oper v_besch34 : Str -> VerbeN = \s -> mkNV (conj3mourir s) ;
oper v_besch35 : Str -> VerbeN = \s -> mkNV (conj3sentir s) ;
oper v_besch36 : Str -> VerbeN = \s -> mkNV (conj3fuir s) ;
oper v_besch37 : Str -> VerbeN = \s -> mkNV (conj3ouïr s) ;
oper v_besch38 : Str -> VerbeN = \s -> mkNV (conj3cevoir s) ;
oper v_besch39 : Str -> VerbeN = \s -> mkNV (conj3voir s) ;
oper v_besch40 : Str -> VerbeN = \s -> mkNV (conj3pourvoir s) ;
oper v_besch41 : Str -> VerbeN = \s -> mkNV (conj3savoir s) ;
oper v_besch42 : Str -> VerbeN = \s -> mkNV (conj3devoir s) ;
oper v_besch43 : Str -> VerbeN = \s -> mkNV (conj3pouvoir s) ;
oper v_besch44 : Str -> VerbeN = \s -> mkNV (conj3mouvoir s) ;
oper v_besch45 : Str -> VerbeN = \s -> mkNV (conj3pleuvoir s) ;
oper v_besch46 : Str -> VerbeN = \s -> mkNV (conj3falloir s) ;
oper v_besch47 : Str -> VerbeN = \s -> mkNV (conj3valoir s) ;
oper v_besch48 : Str -> VerbeN = \s -> mkNV (conj3vouloir s) ;
oper v_besch49 : Str -> VerbeN = \s -> mkNV (conj3asseoir s) ;
oper v_besch50 : Str -> VerbeN = \s -> mkNV (conj3messeoir s) ; --- ?
oper v_besch51 : Str -> VerbeN = \s -> mkNV (conj3surseoir s) ;
oper v_besch52 : Str -> VerbeN = \s -> mkNV (conj3choir s) ;
oper v_besch53 : Str -> VerbeN = \s -> mkNV (conj3rendre s) ;
oper v_besch54 : Str -> VerbeN = \s -> mkNV (conj3prendre s) ;
oper v_besch55 : Str -> VerbeN = \s -> mkNV (conj3battre s) ;
oper v_besch56 : Str -> VerbeN = \s -> mkNV (conj3mettre s) ;
oper v_besch57 : Str -> VerbeN = \s -> mkNV (conj3peindre s) ;
oper v_besch58 : Str -> VerbeN = \s -> mkNV (conj3joindre s) ;
oper v_besch59 : Str -> VerbeN = \s -> mkNV (conj3craindre s) ;
oper v_besch60 : Str -> VerbeN = \s -> mkNV (conj3vaincre s) ;
oper v_besch61 : Str -> VerbeN = \s -> mkNV (conj3traire s) ;
oper v_besch62 : Str -> VerbeN = \s -> mkNV (conj3faire s) ;
oper v_besch63 : Str -> VerbeN = \s -> mkNV (conj3plaire s) ;
oper v_besch64 : Str -> VerbeN = \s -> mkNV (conj3connaître s) ;
oper v_besch65 : Str -> VerbeN = \s -> mkNV (conj3naître s) ;
oper v_besch66 : Str -> VerbeN = \s -> mkNV (conj3paître s) ;
oper v_besch67 : Str -> VerbeN = \s -> mkNV (conj3croître s) ;
oper v_besch68 : Str -> VerbeN = \s -> mkNV (conj3croire s) ;
oper v_besch69 : Str -> VerbeN = \s -> mkNV (conj3boire s) ;
oper v_besch70 : Str -> VerbeN = \s -> mkNV (conj3clore s) ;
oper v_besch71 : Str -> VerbeN = \s -> mkNV (conj3conclure s) ;
oper v_besch72 : Str -> VerbeN = \s -> mkNV (conj3absoudre s) ;
oper v_besch73 : Str -> VerbeN = \s -> mkNV (conj3coudre s) ;
oper v_besch74 : Str -> VerbeN = \s -> mkNV (conj3moudre s) ;
oper v_besch75 : Str -> VerbeN = \s -> mkNV (conj3suivre s) ;
oper v_besch76 : Str -> VerbeN = \s -> mkNV (conj3vivre s) ;
oper v_besch77 : Str -> VerbeN = \s -> mkNV (conj3lire s) ;
oper v_besch78 : Str -> VerbeN = \s -> mkNV (conj3dire s) ;
oper v_besch79 : Str -> VerbeN = \s -> mkNV (conj3rire s) ;
oper v_besch80 : Str -> VerbeN = \s -> mkNV (conj3écrire s) ;
oper v_besch81 : Str -> VerbeN = \s -> mkNV (conj3confire s) ;
oper v_besch82 : Str -> VerbeN = \s -> mkNV (conj3cuire s) ;

-- 83-99 not used

oper v_besch100 : Str -> VerbeN = \s -> mkNV (conj s) ; --- to do
oper v_besch101 : Str -> VerbeN = \s -> mkNV (conj s) ; --- to do
}