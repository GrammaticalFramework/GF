
module LexGFC where

import Alex
import ErrM

pTSpec p = PT p . TS    

ident  p = PT p . eitherResIdent TV 

string p = PT p . TL . unescapeInitTail 

int    p = PT p . TI    


data Tok =
   TS String     -- reserved words
 | TL String     -- string literals
 | TI String     -- integer literals
 | TV String     -- identifiers
 | TD String     -- double precision float literals
 | TC String     -- character literals

 deriving (Eq,Show)

data Token = 
   PT  Posn Tok
 | Err Posn
  deriving Show

tokenPos (PT (Pn _ l _) _ :_) = "line " ++ show l
tokenPos (Err (Pn _ l _) :_) = "line " ++ show l
tokenPos _ = "end of file"

prToken t = case t of
  PT _ (TS s) -> s
  PT _ (TI s) -> s
  PT _ (TV s) -> s
  PT _ (TD s) -> s
  PT _ (TC s) -> s
  _ -> show t

tokens:: String -> [Token]
tokens inp = scan tokens_scan inp

tokens_scan:: Scan Token
tokens_scan = load_scan (tokens_acts,stop_act) tokens_lx
        where
        stop_act p ""  = []
        stop_act p inp = [Err p]

eitherResIdent :: (String -> Tok) -> String -> Tok
eitherResIdent tv s = if isResWord s then (TS s) else (tv s) where
  isResWord s = isInTree s $
    B "lin" (B "concrete" (B "abstract" (B "Type" (B "Str" N N) N) (B "cat" N N)) (B "fun" (B "flags" (B "data" N N) N) (B "in" N N))) (B "param" (B "open" (B "of" (B "lincat" N N) N) (B "oper" N N)) (B "table" (B "resource" (B "pre" N N) N) (B "variants" N N)))

data BTree = N | B String BTree BTree deriving (Show)

isInTree :: String -> BTree -> Bool
isInTree x tree = case tree of
  N -> False
  B a left right
   | x < a  -> isInTree x left
   | x > a  -> isInTree x right
   | x == a -> True

unescapeInitTail :: String -> String
unescapeInitTail = unesc . tail where
  unesc s = case s of
    '\\':c:cs | elem c ['\"', '\\', '\''] -> c : unesc cs
    '\\':'n':cs  -> '\n' : unesc cs
    '\\':'t':cs  -> '\t' : unesc cs
    '"':[]    -> []
    c:cs      -> c : unesc cs
    _         -> []

tokens_acts = [("ident",ident),("int",int),("pTSpec",pTSpec),("string",string)]

tokens_lx :: [(Bool, [(Int,String,[Int],Maybe((Char,Char),[(Char,Bool)]),Maybe Int)], Int, ((Char,Char),[(Char,Int)]))]
tokens_lx = [lx__0_0,lx__1_0,lx__2_0,lx__3_0,lx__4_0,lx__5_0,lx__6_0,lx__7_0,lx__8_0,lx__9_0,lx__10_0,lx__11_0]
lx__0_0 :: (Bool, [(Int,String,[Int],Maybe((Char,Char),[(Char,Bool)]),Maybe Int)], Int, ((Char,Char),[(Char,Int)]))
lx__0_0 = (False,[],-1,(('\t','\255'),[('\t',1),('\n',1),('\v',1),('\f',1),('\r',1),(' ',1),('!',6),('"',8),('$',6),('(',6),(')',6),('*',2),('+',5),(',',6),('-',3),('.',6),('/',6),('0',11),('1',11),('2',11),('3',11),('4',11),('5',11),('6',11),('7',11),('8',11),('9',11),(':',6),(';',6),('<',6),('=',4),('>',6),('?',6),('@',6),('A',7),('B',7),('C',7),('D',7),('E',7),('F',7),('G',7),('H',7),('I',7),('J',7),('K',7),('L',7),('M',7),('N',7),('O',7),('P',7),('Q',7),('R',7),('S',7),('T',7),('U',7),('V',7),('W',7),('X',7),('Y',7),('Z',7),('[',6),('\\',6),(']',6),('_',6),('a',7),('b',7),('c',7),('d',7),('e',7),('f',7),('g',7),('h',7),('i',7),('j',7),('k',7),('l',7),('m',7),('n',7),('o',7),('p',7),('q',7),('r',7),('s',7),('t',7),('u',7),('v',7),('w',7),('x',7),('y',7),('z',7),('{',6),('|',6),('}',6),('\192',7),('\193',7),('\194',7),('\195',7),('\196',7),('\197',7),('\198',7),('\199',7),('\200',7),('\201',7),('\202',7),('\203',7),('\204',7),('\205',7),('\206',7),('\207',7),('\208',7),('\209',7),('\210',7),('\211',7),('\212',7),('\213',7),('\214',7),('\216',7),('\217',7),('\218',7),('\219',7),('\220',7),('\221',7),('\222',7),('\223',7),('\224',7),('\225',7),('\226',7),('\227',7),('\228',7),('\229',7),('\230',7),('\231',7),('\232',7),('\233',7),('\234',7),('\235',7),('\236',7),('\237',7),('\238',7),('\239',7),('\240',7),('\241',7),('\242',7),('\243',7),('\244',7),('\245',7),('\246',7),('\248',7),('\249',7),('\250',7),('\251',7),('\252',7),('\253',7),('\254',7),('\255',7)]))
lx__1_0 :: (Bool, [(Int,String,[Int],Maybe((Char,Char),[(Char,Bool)]),Maybe Int)], Int, ((Char,Char),[(Char,Int)]))
lx__1_0 = (True,[(0,"",[],Nothing,Nothing)],-1,(('\t',' '),[('\t',1),('\n',1),('\v',1),('\f',1),('\r',1),(' ',1)]))
lx__2_0 :: (Bool, [(Int,String,[Int],Maybe((Char,Char),[(Char,Bool)]),Maybe Int)], Int, ((Char,Char),[(Char,Int)]))
lx__2_0 = (False,[],-1,(('*','*'),[('*',6)]))
lx__3_0 :: (Bool, [(Int,String,[Int],Maybe((Char,Char),[(Char,Bool)]),Maybe Int)], Int, ((Char,Char),[(Char,Int)]))
lx__3_0 = (False,[],-1,(('>','>'),[('>',6)]))
lx__4_0 :: (Bool, [(Int,String,[Int],Maybe((Char,Char),[(Char,Bool)]),Maybe Int)], Int, ((Char,Char),[(Char,Int)]))
lx__4_0 = (True,[(1,"pTSpec",[],Nothing,Nothing)],-1,(('>','>'),[('>',6)]))
lx__5_0 :: (Bool, [(Int,String,[Int],Maybe((Char,Char),[(Char,Bool)]),Maybe Int)], Int, ((Char,Char),[(Char,Int)]))
lx__5_0 = (True,[(1,"pTSpec",[],Nothing,Nothing)],-1,(('+','+'),[('+',6)]))
lx__6_0 :: (Bool, [(Int,String,[Int],Maybe((Char,Char),[(Char,Bool)]),Maybe Int)], Int, ((Char,Char),[(Char,Int)]))
lx__6_0 = (True,[(1,"pTSpec",[],Nothing,Nothing)],-1,(('0','0'),[]))
lx__7_0 :: (Bool, [(Int,String,[Int],Maybe((Char,Char),[(Char,Bool)]),Maybe Int)], Int, ((Char,Char),[(Char,Int)]))
lx__7_0 = (True,[(2,"ident",[],Nothing,Nothing)],-1,(('\'','\255'),[('\'',7),('0',7),('1',7),('2',7),('3',7),('4',7),('5',7),('6',7),('7',7),('8',7),('9',7),('A',7),('B',7),('C',7),('D',7),('E',7),('F',7),('G',7),('H',7),('I',7),('J',7),('K',7),('L',7),('M',7),('N',7),('O',7),('P',7),('Q',7),('R',7),('S',7),('T',7),('U',7),('V',7),('W',7),('X',7),('Y',7),('Z',7),('_',7),('a',7),('b',7),('c',7),('d',7),('e',7),('f',7),('g',7),('h',7),('i',7),('j',7),('k',7),('l',7),('m',7),('n',7),('o',7),('p',7),('q',7),('r',7),('s',7),('t',7),('u',7),('v',7),('w',7),('x',7),('y',7),('z',7),('\192',7),('\193',7),('\194',7),('\195',7),('\196',7),('\197',7),('\198',7),('\199',7),('\200',7),('\201',7),('\202',7),('\203',7),('\204',7),('\205',7),('\206',7),('\207',7),('\208',7),('\209',7),('\210',7),('\211',7),('\212',7),('\213',7),('\214',7),('\216',7),('\217',7),('\218',7),('\219',7),('\220',7),('\221',7),('\222',7),('\223',7),('\224',7),('\225',7),('\226',7),('\227',7),('\228',7),('\229',7),('\230',7),('\231',7),('\232',7),('\233',7),('\234',7),('\235',7),('\236',7),('\237',7),('\238',7),('\239',7),('\240',7),('\241',7),('\242',7),('\243',7),('\244',7),('\245',7),('\246',7),('\248',7),('\249',7),('\250',7),('\251',7),('\252',7),('\253',7),('\254',7),('\255',7)]))
lx__8_0 :: (Bool, [(Int,String,[Int],Maybe((Char,Char),[(Char,Bool)]),Maybe Int)], Int, ((Char,Char),[(Char,Int)]))
lx__8_0 = (False,[],8,(('\n','\\'),[('\n',-1),('"',10),('\\',9)]))
lx__9_0 :: (Bool, [(Int,String,[Int],Maybe((Char,Char),[(Char,Bool)]),Maybe Int)], Int, ((Char,Char),[(Char,Int)]))
lx__9_0 = (False,[],-1,(('"','t'),[('"',8),('\'',8),('\\',8),('n',8),('t',8)]))
lx__10_0 :: (Bool, [(Int,String,[Int],Maybe((Char,Char),[(Char,Bool)]),Maybe Int)], Int, ((Char,Char),[(Char,Int)]))
lx__10_0 = (True,[(3,"string",[],Nothing,Nothing)],-1,(('0','0'),[]))
lx__11_0 :: (Bool, [(Int,String,[Int],Maybe((Char,Char),[(Char,Bool)]),Maybe Int)], Int, ((Char,Char),[(Char,Int)]))
lx__11_0 = (True,[(4,"int",[],Nothing,Nothing)],-1,(('0','9'),[('0',11),('1',11),('2',11),('3',11),('4',11),('5',11),('6',11),('7',11),('8',11),('9',11)]))

