--# -path=.:../abstract:../common:../../prelude

concrete RelativeRus of Relative = CatRus ** open ResRus, MorphoRus in {

  flags optimize=all_subs ; coding=utf8 ;

  lin

    RelCl A =   {s = \\b,clf,gn,c, anim => 
     takoj.s ! AF c anim gn ++ "что" ++ A.s !b!clf};

    RelVP kotoruj gulyaet =
    { s = \\b,clf,gn, c, anim =>  let { nu = numGNum gn } in
      kotoruj.s ! gn ! c ! anim ++ gulyaet.s2 ++ gulyaet.s ! clf ! gn !P3 ++ 
       gulyaet.s3 ! genGNum gn ! nu
    } ;


-- Preposition stranding: "that we are looking at". Pied-piping is
-- deferred to $ExtRus.gf$ ("at which we are looking").

    RelSlash kotoruj yaVizhu =
    {s = \\b,clf,gn, _ , anim => yaVizhu.s2 ++ 
         kotoruj.s ! gn ! yaVizhu.c ! anim 
         ++ yaVizhu.s!b!clf 
    } ;

    FunRP p mama kotoruj =
    {s = \\gn,c, anim => let {nu = numGNum gn} in
           mama.s ! PF c No NonPoss ++  
           p.s ++ kotoruj.s !  gn ! p.c ! anim
    } ;

    IdRP ={ s  = \\gn, c, anim => 
     kotorujDet.s ! (AF c anim gn )} ;
}

