--1 Questions and interrogative pronouns

abstract Question = Cat ** {

-- A question can be formed from a clause ('yes-no question') or
-- with an interrogative.

  fun
    QuestCl     : Cl -> QCl ;                  -- does John walk
    QuestVP     : IP -> VP -> QCl ;            -- who walks
    QuestSlash  : IP -> Slash -> QCl ;         -- who does John love
    QuestIAdv   : IAdv -> Cl -> QCl ;          -- why does John walk
    QuestIComp  : IComp -> NP -> QCl ;         -- where is John

-- Interrogative pronouns can be formed with interrogative
-- determiners. 

    IDetCN  : IDet -> Num -> Ord -> CN -> IP;  -- which five best songs
    AdvIP   : IP -> Adv -> IP ;                -- who in Europe

    PrepIP  : Prep -> IP -> IAdv ;             -- with whom

    CompIAdv : IAdv -> IComp ;                 -- where


-- More $IP$, $IDet$, and $IAdv$ are defined in
-- [Structural Structural.html].

}
