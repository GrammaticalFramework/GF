concrete VerbHeb of Verb = CatHeb ** open Prelude, ResHeb in {

  flags optimize=all_subs ; flags coding=utf8 ; 

 lin

   UseV = predV ;

   ComplSlash vp np = insertObj np vp;

   SlashV2a v = predVc v  ; --predV v ** {c2 = v.c2} ;

   VPSlashPrep vp prep = vp ** {
      c2 = {s = prep.s ; c = prep.c ; isDir = False} } ;
}
