import FraCaSBankI

main = putStr . unlines $ ["ps \"@"++n++"\"; l -treebank "++s|(n,s@('(':_))<-bank]
