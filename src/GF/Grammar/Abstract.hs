----------------------------------------------------------------------
-- |
-- Module      : Abstract
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/02/18 19:21:12 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.3 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module Abstract (

module Grammar,
module Values,
module Macros,
module Ident,
module MMacros,
module PrGrammar,

Grammar

 ) where

import Grammar
import Values
import Macros
import Ident
import MMacros
import PrGrammar

type Grammar = SourceGrammar ---



