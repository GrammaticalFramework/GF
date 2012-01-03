-- AllMlt.gf: common grammar plus language-dependent extensions
--
-- Maltese Resource Grammar Library
-- John J. Camilleri, 2011
-- Licensed under LGPL

--# -path=.:prelude:../abstract:../common

abstract AllMltAbs =
  Lang,
  IrregMltAbs,
  ExtraMltAbs
  ** {} ;

{-
  IrregMltAbs-[
    blow_V,burn_V,come_V,dig_V,fall_V,fly_V,freeze_V,go_V,lie_V,run_V,
    sew_V,sing_V,sit_V,sleep_V,spit_V,stand_V,swell_V,swim_V,think_V],
-}
