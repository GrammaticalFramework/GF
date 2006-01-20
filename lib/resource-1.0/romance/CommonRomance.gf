----1 Auxiliary operations common for Romance languages
--
-- This module contains operations that are shared by the Romance
-- languages. The complete set of auxiliary operations needed to
-- implement [Test Test.html] is defined in [ResRomance ResRomance.html],
-- which depends on [DiffRomance DiffRomance.html].
--

resource CommonRomance = ParamRomance ** open Prelude in {

  flags optimize=all ;

  oper
    genForms : Str -> Str -> Gender => Str = \bon,bonne ->
      table {
        Masc => bon ; 
        Fem => bonne
        } ; 

    aagrForms : (x1,_,_,x4 : Str) -> (AAgr => Str) = \tout,toute,tous,toutes ->
      table {
        {g = g ; n = Sg} => genForms tout toute ! g ;
        {g = g ; n = Pl} => genForms tous toutes ! g
        } ;

    Noun = {s : Number => Str ; g : Gender} ;

    VP : Type = {
      s : VPForm => {
        fin : Agr  => Str ;             -- ai  
        inf : AAgr => Str               -- dit 
        } ;
      agr   : VPAgr ;                   -- dit/dite dep. on verb, subj, and clitic
      neg   : Polarity => (Str * Str) ; -- ne-pas
      clit1 : Agr => Str ;              -- se
      clit2 : Str ;                     -- lui
      comp  : Agr => Str ;              -- content(e) ; à ma mère ; hier
      ext   : Str ;                     -- que je dors
      } ;

    appVPAgr : VPAgr -> AAgr -> AAgr = \vp,agr -> 
      case vp of {
        VPAgrNone   => aagr Masc Sg ;
        VPAgrSubj   => agr ;
        VPAgrClit a => a
        } ;

  param
    VPAgr = 
       VPAgrNone                    -- elle a dormi 
     | VPAgrSubj                    -- elle est partie, elle s'est vue
     | VPAgrClit                    -- elle les a vues
         {g : Gender ; n : Number} ;

}

