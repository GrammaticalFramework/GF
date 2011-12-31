-- Copyright (C) 2011 Nikita Frolov

-- An early version of the parser that requires somewhat more memory. Kept for
-- nostalgic reasons.

module EaglesParser where

import qualified Data.Text as T
import Data.List
import qualified Data.Map as M

type Forms = M.Map Tag T.Text

data Tag = A Case Number Gender Animacy Form Degree Extra Obscene
    | Adv Degree Extra Obscene
    | AdvPron Extra
    | Ord Case Number Gender Animacy
    | AdjPron Case Number Gender Animacy Extra
    | Frag Extra
    | Conj Extra
    | Inter Extra Obscene
    | Num Case Number Gender Animacy Extra
    | Part Extra
    | Prep Extra
    | N Case Number Gender Animacy Name Extra Obscene
    | Pron Case Number Gender Animacy Extra
    | V Mood Number Gender Tense Person Aspect Voice Trans Extra Obscene
    | P Case Number Gender Tense Form Aspect Voice Trans Extra Obscene
      deriving (Show, Ord, Eq)

parseTag :: T.Text -> Tag
parseTag tag = case (T.unpack tag) of {
      ('A':c:n:g:a:f:cmp:e:o:[]) -> A (readCase c) (readNumber n)
                                   (readGender g) (readAnimacy a)
                                   (readForm f) (readDegree cmp)
                                   (readExtra e) (readObscene o) ;
      ('D':cmp:e:o:[]) -> Adv (readDegree cmp)
                         (readExtra e) (readObscene o) ;
      ('P':e:[]) -> AdvPron (readExtra e) ;
      ('Y':c:n:g:a:[]) -> Ord (readCase c) (readNumber n)
                         (readGender g) (readAnimacy a) ;
      ('R':c:n:g:a:e:[]) -> AdjPron (readCase c) (readNumber n)
                           (readGender g) (readAnimacy a) (readExtra e) ;
      ('M':e:[]) -> Frag (readExtra e) ;
      ('C':e:[]) -> Conj (readExtra e) ;
      ('J':e:o:[]) -> Inter (readExtra e) (readObscene o) ;
      ('Z':c:n:g:a:e:[]) -> Num (readCase c) (readNumber n)
                           (readGender g) (readAnimacy a) (readExtra e) ;
      ('T':e:[]) -> Part (readExtra e) ;
      ('B':e:[]) -> Prep (readExtra e) ;
      ('N':_:c:n:g:a:name:e:o:_:[]) -> N (readCase c) (readNumber n)
                                      (readGender g) (readAnimacy a)
                                      (readName name)
                                      (readExtra e) (readObscene o) ;
      ('N':_:c:n:g:a:name:e:o:[]) -> N (readCase c) (readNumber n)
                                      (readGender g) (readAnimacy a)
                                      (readName name)
                                      (readExtra e) (readObscene o) ;
      ('E':c:n:g:a:e:[]) -> Pron (readCase c) (readNumber n)
                          (readGender g) (readAnimacy a) (readExtra e) ;
      ('V':m:n:g:t:'P':p:a:v:tr:e:o:[]) -> V (readMood m) (readNumber n)
                                          (readGender g) (readTense t)
                                          (readPerson p) (readAspect a)
                                          (readVoice v) (readTrans tr)
                                          (readExtra e) (readObscene o) ;
      ('V':m:n:g:t:'0':a:v:tr:e:o:[]) -> V (readMood m) (readNumber n)
                                        (readGender g) (readTense t)
                                        NP (readAspect a)
                                        (readVoice v) (readTrans tr)
                                        (readExtra e) (readObscene o) ;
      ('V':m:n:g:t:p:a:v:tr:e:o:[]) -> V (readMood m) (readNumber n)
                                          (readGender g) (readTense t)
                                          (readPerson p) (readAspect a)
                                          (readVoice v) (readTrans tr)
                                          (readExtra e) (readObscene o) ;
      ('Q':c:n:g:t:f:a:v:tr:e:o:[]) -> P (readCase c) (readNumber n)
                                       (readGender g) (readTense t)
                                       (readForm f) (readAspect a)
                                       (readVoice v) (readTrans tr)
                                       (readExtra e) (readObscene o) ;
      _ -> error $ "Parse error: " ++ T.unpack tag }

data Case = Nom | Gen | Dat | Acc | Inst | Prepos | Partit | Loc | Voc | NC
      deriving (Show, Ord, Eq)

readCase 'N' = Nom
readCase 'G' = Gen
readCase 'D' = Dat
readCase 'F' = Acc
readCase 'C' = Inst
readCase 'O' = Prepos
readCase 'P' = Partit
readCase 'L' = Loc
readCase 'V' = Voc
readCase '0' = NC

data Number = Sg | Pl | NN deriving (Show, Ord, Eq)

readNumber 'S' = Sg
readNumber 'P' = Pl
readNumber '0' = NN

data Gender = Masc | Fem | Neut | Common | NG deriving (Show, Ord, Eq)

readGender 'F' = Fem
readGender 'M' = Masc
readGender 'A' = Neut
readGender 'C' = Common
readGender '0' = NG

data Animacy = Animate | Inanimate | NA deriving (Show, Ord, Eq)

readAnimacy 'A' = Animate
readAnimacy 'I' = Inanimate
readAnimacy '0' = NA

data Form = Short | Full | NF deriving (Show, Ord, Eq)

readForm 'S' = Short
readForm 'F' = Full
readForm '0' = NF

data Degree = Pos | Comp | Super | ND deriving (Show, Ord, Eq)

readDegree 'E' = Super
readDegree 'C' = Comp
readDegree 'P' = Pos
readDegree '0' = ND

data Extra = Introductory | Difficult | Distorted | Predicative
           | Colloquial | Rare | Abbreviation | Obsolete | NE deriving (Show, Ord, Eq)

readExtra 'P' = Introductory
readExtra 'D' = Difficult
readExtra 'V' = Distorted
readExtra 'R' = Predicative
readExtra 'I' = Colloquial
readExtra 'A' = Rare
readExtra 'B' = Abbreviation
readExtra 'E' = Obsolete
readExtra '0' = NE

data Obscene = Obscene | NO deriving (Show, Ord, Eq)

readObscene 'H' = Obscene
readObscene '0' = NO

data Name = Topo | Proper | Patro | Family | NNa deriving (Show, Ord, Eq)

readName 'G' = Topo
readName 'N' = Proper
readName 'S' = Patro
readName 'F' = Family
readName '0' = NNa

data Mood = Gerund | Inf | Ind | Imp | NM deriving (Show, Ord, Eq)

readMood 'G' = Gerund
readMood 'I' = Inf
readMood 'D' = Ind
readMood 'M' = Imp
readMood '0' = NM

data Tense = Pres | Fut | Past | NT deriving (Show, Ord, Eq)

readTense 'P' = Pres
readTense 'F' = Fut
readTense 'S' = Past
readTense '0' = NT

data Person = P1 | P2 | P3 | NP deriving (Show, Ord, Eq)

readPerson '1' = P1
readPerson '2' = P2
readPerson '3' = P3

data Aspect = Perf | Imperf | NAs deriving (Show, Ord, Eq)

readAspect 'F' = Perf
readAspect 'N' = Imperf
readAspect '0' = NAs

data Voice = Act | Pass | NV deriving (Show, Ord, Eq)

readVoice 'A' = Act
readVoice 'S' = Pass
readVoice '0' = NV

data Trans = Trans | Intrans | NTr deriving (Show, Ord, Eq)

readTrans 'M' = Trans
readTrans 'A' = Intrans
readTrans '0' = NTr

isOpenCat :: Tag -> Bool
isOpenCat (A _ _ _ _ _ _ _ _)     = True
isOpenCat (N _ _ _ _ _ _ _)       = True
isOpenCat (V _ _ _ _ _ _ _ _ _ _) = True
isOpenCat (Adv _ _ _)             = True
isOpenCat _                       = False

noun :: Forms -> (Case, Number) -> T.Text
noun forms (c, n) = findForm matchNoun forms
    where matchNoun (N c' n' _ _ _ _ _) = c == c' && n == n'
          matchNoun _ = False

adj :: Forms -> Degree -> T.Text
adj forms d = findForm matchAdj forms
    where matchAdj (A _ _ _ _ _ d' _ _) = d == d
          matchAdj _ = False

verbPres :: Forms -> (Number, Person) -> T.Text
verbPres forms (n, p) = findForm matchPres forms
    where matchPres (V Ind n' _ Pres p' _ Act _ _ _) = n == n' && p == p'
          matchPres _ = False

verbPast :: Forms -> (Number, Gender) -> T.Text
verbPast forms (n, g) = findForm matchPast forms
    where matchPast (V Ind n' g' Past _ _ Act _ _ _) = n == n' && g == g'
          matchPast _ = False

verbImp :: Forms -> T.Text
verbImp forms = findForm matchImp forms
    where matchImp (V Imp _ _ _ _ _ _ _ _ _) = True
          matchImp _ = False

verbInf :: Forms -> T.Text
verbInf forms = findForm matchInf forms
    where matchInf (V Inf _ _ _ _ _ _ _ _ _) = True
          matchInf _ = False

adv :: Forms -> T.Text
adv forms = findForm matchAdv forms
    where matchAdv (Adv d _ _) = d == Pos
          matchAdv _ = False

findForm match forms = case find match (M.keys forms) of
                         Just tag -> forms M.! tag
                         Nothing -> findForm (\ _ -> True) forms