-- Structures special for French. These are not implemented in other
-- Romance languages.

abstract ExtraFreAbs = ExtraRomanceAbs - [ProDrop] ** {
  flags coding=utf8 ;

-- Notice: only direct (main-clause) questions are generated, and needed.

  fun
    EstcequeS     : S -> Utt ;          -- est-ce qu'il pleut
    EstcequeIAdvS : IAdv -> S -> Utt ;  -- où est-ce qu'il pleut

-- These also generate indirect (subordinate) questions.

    QueestcequeIP : IP ;    -- qu'est-ce (que/qui) 
    QuiestcequeIP : IP ;    -- qu'est-ce (que/qui)

-- This is needed for compositionality in library applications.

    EstcequeCl    : Cl -> QCl ;          -- est-ce qu'il pleut

-- Feminine variants of pronouns (those in $Structural$ are
-- masculine, which is the default when gender is unknown).

    i8fem_Pron : Pron ;
    these8fem_NP : NP ;
    they8fem_Pron : Pron ;
    this8fem_NP : NP ;
    those8fem_NP : NP ;

    we8fem_Pron : Pron ;
    whoPl8fem_IP : IP ;
    whoSg8fem_IP : IP ;

    youSg8fem_Pron : Pron ;
    youPl8fem_Pron : Pron ;
    youPol8fem_Pron : Pron ;

    ce_Pron : Pron ;

-- clitic adverbs

    AdvDatVP : VP -> VP ;  -- j'y vais
    AdvGenVP : VP -> VP ;  -- j'en vais


-- The determiner "tout" in the special use "tout nombre"

    tout_Det : Det ;

-- Polarity "ne" without "pas"

    PNegNe : Pol ;

-- alternative forms of questions

    EstcequeQuestCl : Cl -> QCl ; -- est-ce qu'il dort
    EstcequeQuestIAdvCl : IAdv -> Cl -> QCl ; -- où est-ce qu'il dort
    InvQuestCl : Cl -> QCl ;      -- dort-il
    InvQuestIAdvCl : IAdv -> Cl -> QCl ;      -- dort-il

    quel_IComp : IComp ; -- quelle est votre nationalité


}
