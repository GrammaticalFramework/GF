
module LexGF where

import Alex
import ErrM

pTSpec p = PT p . TS    

mk_LString p = PT p . eitherResIdent T_LString 

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
 | T_LString String

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
    B "let" (B "data" (B "Type" (B "Str" (B "PType" (B "Lin" N N) N) (B "Tok" (B "Strs" N N) N)) (B "cat" (B "case" (B "abstract" N N) N) (B "concrete" N N))) (B "in" (B "fn" (B "flags" (B "def" N N) N) (B "grammar" (B "fun" N N) N)) (B "instance" (B "incomplete" (B "include" N N) N) (B "interface" N N)))) (B "pre" (B "open" (B "lindef" (B "lincat" (B "lin" N N) N) (B "of" (B "lintype" N N) N)) (B "param" (B "out" (B "oper" N N) N) (B "pattern" N N))) (B "transfer" (B "reuse" (B "resource" (B "printname" N N) N) (B "table" (B "strs" N N) N)) (B "where" (B "variants" (B "union" N N) N) (B "with" N N))))

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

tokens_acts = [("ident",ident),("int",int),("mk_LString",mk_LString),("pTSpec",pTSpec),("string",string)]

tokens_lx :: [(Bool, [(Int,String,[Int],Maybe((Char,Char),[(Char,Bool)]),Maybe Int)], Int, ((Char,Char),[(Char,Int)]))]
tokens_lx = [lx__0_0,lx__1_0,lx__2_0,lx__3_0,lx__4_0,lx__5_0,lx__6_0,lx__7_0,lx__8_0,lx__9_0,lx__10_0,lx__11_0,lx__12_0,lx__13_0,lx__14_0,lx__15_0,lx__16_0,lx__17_0,lx__18_0,lx__19_0,lx__20_0,lx__21_0]
lx__0_0 :: (Bool, [(Int,String,[Int],Maybe((Char,Char),[(Char,Bool)]),Maybe Int)], Int, ((Char,Char),[(Char,Int)]))
lx__0_0 = (False,[],-1,(('\t','\255'),[('\t',10),('\n',10),('\v',10),('\f',10),('\r',10),(' ',10),('!',14),('"',18),('$',14),('\'',15),('(',14),(')',14),('*',11),('+',13),(',',14),('-',1),('.',14),('/',14),('0',21),('1',21),('2',21),('3',21),('4',21),('5',21),('6',21),('7',21),('8',21),('9',21),(':',14),(';',14),('<',14),('=',12),('>',14),('?',14),('@',14),('A',17),('B',17),('C',17),('D',17),('E',17),('F',17),('G',17),('H',17),('I',17),('J',17),('K',17),('L',17),('M',17),('N',17),('O',17),('P',17),('Q',17),('R',17),('S',17),('T',17),('U',17),('V',17),('W',17),('X',17),('Y',17),('Z',17),('[',14),('\\',14),(']',14),('_',14),('a',17),('b',17),('c',17),('d',17),('e',17),('f',17),('g',17),('h',17),('i',17),('j',17),('k',17),('l',17),('m',17),('n',17),('o',17),('p',17),('q',17),('r',17),('s',17),('t',17),('u',17),('v',17),('w',17),('x',17),('y',17),('z',17),('{',4),('|',14),('}',14),('\192',17),('\193',17),('\194',17),('\195',17),('\196',17),('\197',17),('\198',17),('\199',17),('\200',17),('\201',17),('\202',17),('\203',17),('\204',17),('\205',17),('\206',17),('\207',17),('\208',17),('\209',17),('\210',17),('\211',17),('\212',17),('\213',17),('\214',17),('\216',17),('\217',17),('\218',17),('\219',17),('\220',17),('\221',17),('\222',17),('\223',17),('\224',17),('\225',17),('\226',17),('\227',17),('\228',17),('\229',17),('\230',17),('\231',17),('\232',17),('\233',17),('\234',17),('\235',17),('\236',17),('\237',17),('\238',17),('\239',17),('\240',17),('\241',17),('\242',17),('\243',17),('\244',17),('\245',17),('\246',17),('\248',17),('\249',17),('\250',17),('\251',17),('\252',17),('\253',17),('\254',17),('\255',17)]))
lx__1_0 :: (Bool, [(Int,String,[Int],Maybe((Char,Char),[(Char,Bool)]),Maybe Int)], Int, ((Char,Char),[(Char,Int)]))
lx__1_0 = (True,[(3,"pTSpec",[],Nothing,Nothing)],-1,(('-','>'),[('-',2),('>',14)]))
lx__2_0 :: (Bool, [(Int,String,[Int],Maybe((Char,Char),[(Char,Bool)]),Maybe Int)], Int, ((Char,Char),[(Char,Int)]))
lx__2_0 = (False,[],2,(('\n','\n'),[('\n',3)]))
lx__3_0 :: (Bool, [(Int,String,[Int],Maybe((Char,Char),[(Char,Bool)]),Maybe Int)], Int, ((Char,Char),[(Char,Int)]))
lx__3_0 = (True,[(0,"",[],Nothing,Nothing)],-1,(('0','0'),[]))
lx__4_0 :: (Bool, [(Int,String,[Int],Maybe((Char,Char),[(Char,Bool)]),Maybe Int)], Int, ((Char,Char),[(Char,Int)]))
lx__4_0 = (True,[(3,"pTSpec",[],Nothing,Nothing)],-1,(('-','-'),[('-',5)]))
lx__5_0 :: (Bool, [(Int,String,[Int],Maybe((Char,Char),[(Char,Bool)]),Maybe Int)], Int, ((Char,Char),[(Char,Int)]))
lx__5_0 = (False,[],5,(('-','-'),[('-',8)]))
lx__6_0 :: (Bool, [(Int,String,[Int],Maybe((Char,Char),[(Char,Bool)]),Maybe Int)], Int, ((Char,Char),[(Char,Int)]))
lx__6_0 = (False,[],5,(('-','}'),[('-',8),('}',7)]))
lx__7_0 :: (Bool, [(Int,String,[Int],Maybe((Char,Char),[(Char,Bool)]),Maybe Int)], Int, ((Char,Char),[(Char,Int)]))
lx__7_0 = (True,[(1,"",[],Nothing,Nothing)],5,(('-','-'),[('-',8)]))
lx__8_0 :: (Bool, [(Int,String,[Int],Maybe((Char,Char),[(Char,Bool)]),Maybe Int)], Int, ((Char,Char),[(Char,Int)]))
lx__8_0 = (False,[],5,(('-','}'),[('-',6),('}',9)]))
lx__9_0 :: (Bool, [(Int,String,[Int],Maybe((Char,Char),[(Char,Bool)]),Maybe Int)], Int, ((Char,Char),[(Char,Int)]))
lx__9_0 = (True,[(1,"",[],Nothing,Nothing)],-1,(('0','0'),[]))
lx__10_0 :: (Bool, [(Int,String,[Int],Maybe((Char,Char),[(Char,Bool)]),Maybe Int)], Int, ((Char,Char),[(Char,Int)]))
lx__10_0 = (True,[(2,"",[],Nothing,Nothing)],-1,(('\t',' '),[('\t',10),('\n',10),('\v',10),('\f',10),('\r',10),(' ',10)]))
lx__11_0 :: (Bool, [(Int,String,[Int],Maybe((Char,Char),[(Char,Bool)]),Maybe Int)], Int, ((Char,Char),[(Char,Int)]))
lx__11_0 = (True,[(3,"pTSpec",[],Nothing,Nothing)],-1,(('*','*'),[('*',14)]))
lx__12_0 :: (Bool, [(Int,String,[Int],Maybe((Char,Char),[(Char,Bool)]),Maybe Int)], Int, ((Char,Char),[(Char,Int)]))
lx__12_0 = (True,[(3,"pTSpec",[],Nothing,Nothing)],-1,(('>','>'),[('>',14)]))
lx__13_0 :: (Bool, [(Int,String,[Int],Maybe((Char,Char),[(Char,Bool)]),Maybe Int)], Int, ((Char,Char),[(Char,Int)]))
lx__13_0 = (True,[(3,"pTSpec",[],Nothing,Nothing)],-1,(('+','+'),[('+',14)]))
lx__14_0 :: (Bool, [(Int,String,[Int],Maybe((Char,Char),[(Char,Bool)]),Maybe Int)], Int, ((Char,Char),[(Char,Int)]))
lx__14_0 = (True,[(3,"pTSpec",[],Nothing,Nothing)],-1,(('0','0'),[]))
lx__15_0 :: (Bool, [(Int,String,[Int],Maybe((Char,Char),[(Char,Bool)]),Maybe Int)], Int, ((Char,Char),[(Char,Int)]))
lx__15_0 = (False,[],15,(('\'','\''),[('\'',16)]))
lx__16_0 :: (Bool, [(Int,String,[Int],Maybe((Char,Char),[(Char,Bool)]),Maybe Int)], Int, ((Char,Char),[(Char,Int)]))
lx__16_0 = (True,[(4,"mk_LString",[],Nothing,Nothing)],-1,(('0','0'),[]))
lx__17_0 :: (Bool, [(Int,String,[Int],Maybe((Char,Char),[(Char,Bool)]),Maybe Int)], Int, ((Char,Char),[(Char,Int)]))
lx__17_0 = (True,[(5,"ident",[],Nothing,Nothing)],-1,(('\'','\255'),[('\'',17),('0',17),('1',17),('2',17),('3',17),('4',17),('5',17),('6',17),('7',17),('8',17),('9',17),('A',17),('B',17),('C',17),('D',17),('E',17),('F',17),('G',17),('H',17),('I',17),('J',17),('K',17),('L',17),('M',17),('N',17),('O',17),('P',17),('Q',17),('R',17),('S',17),('T',17),('U',17),('V',17),('W',17),('X',17),('Y',17),('Z',17),('_',17),('a',17),('b',17),('c',17),('d',17),('e',17),('f',17),('g',17),('h',17),('i',17),('j',17),('k',17),('l',17),('m',17),('n',17),('o',17),('p',17),('q',17),('r',17),('s',17),('t',17),('u',17),('v',17),('w',17),('x',17),('y',17),('z',17),('\192',17),('\193',17),('\194',17),('\195',17),('\196',17),('\197',17),('\198',17),('\199',17),('\200',17),('\201',17),('\202',17),('\203',17),('\204',17),('\205',17),('\206',17),('\207',17),('\208',17),('\209',17),('\210',17),('\211',17),('\212',17),('\213',17),('\214',17),('\216',17),('\217',17),('\218',17),('\219',17),('\220',17),('\221',17),('\222',17),('\223',17),('\224',17),('\225',17),('\226',17),('\227',17),('\228',17),('\229',17),('\230',17),('\231',17),('\232',17),('\233',17),('\234',17),('\235',17),('\236',17),('\237',17),('\238',17),('\239',17),('\240',17),('\241',17),('\242',17),('\243',17),('\244',17),('\245',17),('\246',17),('\248',17),('\249',17),('\250',17),('\251',17),('\252',17),('\253',17),('\254',17),('\255',17)]))
lx__18_0 :: (Bool, [(Int,String,[Int],Maybe((Char,Char),[(Char,Bool)]),Maybe Int)], Int, ((Char,Char),[(Char,Int)]))
lx__18_0 = (False,[],18,(('\n','\\'),[('\n',-1),('"',20),('\\',19)]))
lx__19_0 :: (Bool, [(Int,String,[Int],Maybe((Char,Char),[(Char,Bool)]),Maybe Int)], Int, ((Char,Char),[(Char,Int)]))
lx__19_0 = (False,[],-1,(('"','t'),[('"',18),('\'',18),('\\',18),('n',18),('t',18)]))
lx__20_0 :: (Bool, [(Int,String,[Int],Maybe((Char,Char),[(Char,Bool)]),Maybe Int)], Int, ((Char,Char),[(Char,Int)]))
lx__20_0 = (True,[(6,"string",[],Nothing,Nothing)],-1,(('0','0'),[]))
lx__21_0 :: (Bool, [(Int,String,[Int],Maybe((Char,Char),[(Char,Bool)]),Maybe Int)], Int, ((Char,Char),[(Char,Int)]))
lx__21_0 = (True,[(7,"int",[],Nothing,Nothing)],-1,(('0','9'),[('0',21),('1',21),('2',21),('3',21),('4',21),('5',21),('6',21),('7',21),('8',21),('9',21)]))

