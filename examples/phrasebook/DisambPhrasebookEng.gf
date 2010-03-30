--# -path=.:present

concrete DisambPhrasebookEng of Phrasebook = PhrasebookEng - [Polite,Familiar] **  
  open 
    (R = Roles) in {
lin
  Polite   = {s = "(polite)"   ; p = R.PPolite} ;
  Familiar = {s = "(familiar)" ; p = R.PFamiliar} ;

}
