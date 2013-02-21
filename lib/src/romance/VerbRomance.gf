incomplete concrete VerbRomance of Verb = 
  CatRomance ** open Prelude, CommonRomance, ResRomance in {

  flags optimize=all_subs ;

  lin
    UseV = predV ;

    ComplVV v vp = 
      insertComplement (\\a => prepCase v.c2.c ++ infVP vp a) (predV v) ;
    ComplVS v s  = insertExtrapos (\\b => conjThat ++ s.s ! (v.m ! b)) (predV v) ;
    ComplVQ v q  = insertExtrapos (\\_ => q.s ! QIndir) (predV v) ;
    ComplVA v ap = 
      insertComplement (\\a => let agr = complAgr a in ap.s ! AF agr.g agr.n) (predV v) ;

    SlashV2a v = mkVPSlash v.c2 (predV v) ;

    Slash2V3 v np = mkVPSlash v.c3 (insertObject v.c2 np (predV v)) ;
    Slash3V3 v np = mkVPSlash v.c2 (insertObject v.c3 np (predV v)) ;

    SlashV2V v vp = 
      mkVPSlash v.c2
       (insertComplement 
         (\\a => prepCase v.c3.c ++ infVP vp a) 
         (predV v)) ; 

    SlashV2S v s = 
      mkVPSlash v.c2
       (insertExtrapos 
         (\\b => conjThat ++ s.s ! Indic) ---- mood
         (predV v)) ; 

    SlashV2Q v q = 
      mkVPSlash v.c2
       (insertExtrapos 
         (\\_ => q.s ! QIndir)
         (predV v)) ; 

    {- ---- lincat should be fixed
    SlashV2A v ap = 

      let af = case v.c3.isDir of {
        True => AF np.a.g np.a.n ;  -- ... bleues
        _ => AF Masc Sg             -- il les peint en bleu
        }
    -}

    SlashV2A v ap = 
      let af = AF Masc Sg
      in
      mkVPSlash v.c2
        (insertComplement 
          (\\_ => v.c3.s ++ prepCase v.c3.c ++ ap.s ! af)
          (predV v)) ;

    ComplSlash vp np = insertObject vp.c2 np vp ;

    ReflVP v = case v.c2.isDir of {
      True  => insertRefl v ;
      False => insertComplement 
                 (\\a => let agr = verbAgr a in v.c2.s ++ reflPron agr.n  agr.p v.c2.c) v
      } ;

    SlashVV v vp = 
      mkVPSlash vp.c2
        (insertComplement (\\a => prepCase v.c2.c ++ infVP vp a) (predV v)) ;

    SlashV2VNP v np vp = 
      mkVPSlash vp.c2
       (insertComplement 
         (\\a => prepCase v.c3.c ++ infVP vp a) 
         (insertObject v.c2 np (predV v))) ; 

    UseComp comp = insertComplement comp.s (predV copula) ;

    UseCopula = predV copula ;

    CompAP ap = {s = \\ag => let agr = complAgr ag in ap.s ! AF agr.g agr.n} ;
    CompCN cn = { s = \\ag => 
      let agr = complAgr ag in 
      artIndef cn.g agr.n Nom ++ cn.s ! agr.n
      }; --- RE 7/12/2010 -- AR added indef 2/8/2011
    CompNP np = {s = \\_  => (np.s ! Nom).ton} ;
    CompAdv a = {s = \\_  => a.s} ;

    AdvVP vp adv = insertAdv adv.s vp ;
    AdVVP adv vp = insertAdV adv.s vp ;

    PassV2 v = insertComplement 
      (\\a => let agr = complAgr a in v.s ! VPart agr.g agr.n) (predV auxPassive) ;

    VPSlashPrep vp prep = vp ** {
      c2 = {s = prep.s ; c = prep.c ; isDir = False}
      } ;
}

