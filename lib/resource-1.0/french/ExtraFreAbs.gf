-- Structures special for French. These are not implemented in other
-- Romance languages.

abstract ExtraFreAbs = ExtraRomanceAbs ** {

-- Notice: only direct (main-clause) questions are generated, and needed.

  fun
    EstcequeS     : S -> Utt ;          -- est-ce qu'il pleut
    EstcequeIAdvS : IAdv -> S -> Utt ;  -- où est-ce qu'il pleut

-- These also generate indirect (subordinate) questions.

    QueestcequeIP : IP ;    -- qu'est-ce (que/qui) 
    QuiestcequeIP : IP ;    -- qu'est-ce (que/qui) 

}
