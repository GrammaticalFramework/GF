-- Structures special for Norwegian. These are not implemented in other
-- Scandinavian languages.

abstract ExtraNorAbs = ExtraScandAbs ** {

  fun
    PossNPPron : NP -> Pron -> NP ;   -- bilen min

}