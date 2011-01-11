--# -path=.:present

concrete ComputersEng of Computers = CommentsEng ** 
    open SyntaxEng, ParadigmsEng in {
  lin
    Computer = mkCN (mkN "computer") ;
    HardDisk = mkCN (mkA "hard") (mkN "disk") ;
    Efficient = mkAP (mkA "efficient") ;
    Slow = mkAP (mkA "slow") ;
}
