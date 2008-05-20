module GF.GFCC.CId (
  module GF.GFCC.Raw.AbsGFCCRaw,
  prCId,
  cId
  ) where

import GF.GFCC.Raw.AbsGFCCRaw (CId(CId))

prCId :: CId -> String
prCId (CId s) = s

cId :: String -> CId
cId = CId

