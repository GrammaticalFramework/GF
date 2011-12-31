-- Copyright (C) 2011 Nikita Frolov

-- The format specification can be found at
-- http://devel.cpl.upc.edu/freeling/svn/trunk/doc/tagsets/tagset-ru.html

-- Bugs in the specification:
-- Participle, 2nd field: case, not mood
-- Participle, 6th field: field, not person
-- Verb, persons can be denoted both with 'Pnumber' or just 'number'
-- Noun, 10th field can be absent

-- No, it wouldn't be simpler to implement this grammar with Parsec or another
-- parser combinator library.


module EaglesMatcher where

import qualified Data.Text as T
import Data.List
import qualified Data.Map as M

type Forms = M.Map T.Text T.Text

isOpenCat ('A':_) = True
isOpenCat ('N':_) = True
isOpenCat ('V':_) = True
isOpenCat ('D':_) = True
isOpenCat _       = False

noun forms (c, n) = findForm (matchNoun . T.unpack) forms
    where matchNoun ('N':_:c':n':_) = c == c' && n == n'
          matchNoun _ = False

adj forms d = findForm (matchAdj . T.unpack) forms
    where matchAdj ('A':'N':'S':'M':_:'F':d':_) = d == d
          matchAdj _ = False

verbPres forms (n, p) = findForm (matchPres . T.unpack) forms
    where matchPres ('V':'D':n':_:'P':'P':p':_:'A':_) = n == n' && p == p'
          matchPres ('V':'D':n':_:'F':'P':p':_:'A':_) = n == n' && p == p'
          matchPres ('V':'D':n':_:'P':'P':p':_) = n == n' && p == p'
          matchPres ('V':'D':n':_:'F':'P':p':_) = n == n' && p == p'
          matchPres _ = False

verbPast forms (n, g) = findForm (matchPast . T.unpack) forms
    where matchPast ('V':'D':n':g':'S':_:_:'A':_) = n == n' && g == g'
          matchPast _ = False

verbImp forms = findForm (matchImp . T.unpack) forms
    where matchImp ('V':'M':_) = True
          matchImp _ = False

verbInf forms = findForm (matchInf . T.unpack) forms
    where matchInf ('V':'I':_) = True
          matchInf _ = False

adv forms = findForm (matchAdv . T.unpack) forms
    where matchAdv ('D':d:_) = d == 'P'
          matchAdv _ = False

findForm match forms = case find match (M.keys forms) of
                         Just tag -> forms M.! tag
                         Nothing -> findForm (\ _ -> True) forms
