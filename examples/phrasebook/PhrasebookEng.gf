--# -path=.:present

concrete PhrasebookEng of Phrasebook = 
  GreetingsEng,
  WordsEng ** open 
    SyntaxEng,
    Prelude in {

flags 
  language = en_US ;

}
