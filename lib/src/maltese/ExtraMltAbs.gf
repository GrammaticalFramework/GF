-- ExtraMltAbs.gf: abstract grammar for extra stuff
--
-- Maltese GF Resource Grammar
-- John J. Camilleri 2011 -- 2013
-- Licensed under LGPL

abstract ExtraMltAbs = Cat, Extra [Pron, ProDrop] ** {

  fun
    -- SlashV2a : V2 -> VPSlash ; -- love (it)
    SlashVa : V -> VPSlash ; -- jump (it)

    -- VasV2 : V -> V2 ; --- too general for my liking

}
