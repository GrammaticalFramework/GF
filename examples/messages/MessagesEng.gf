--# -path=.:../phrasebook:present

concrete MessagesEng of Messages = 
  WordsEng - 
    [IMale, IFemale, YouFamMale, YouFamFemale, YouPolMale, YouPolFemale],
  GreetingsEng ** open
  SyntaxEng,
  ParadigmsEng,
  (Phr = PhrasebookEng)
  in {

lincat
  Message = Text ;
  Heading = Text ;
  Body = Text ;
  Ending = Text ;
  Statement = Text ;
  Recipient = NP ;
  Sender = NP ;
  Title = CN ;
  Role = Phr.NPPerson ;

lin
  Msg h b e = mkText h (mkText b e) ;
  
  HHello n = 
    mkText (strText "hello") (mkText (mkPhrase (mkUtt n)) (strText ",")) ;
  HDear n = 
    mkText (strText "dear") (mkText (mkPhrase (mkUtt n)) (strText ",")) ;
  
  BOne  p = p ;
  BMore p b = mkText p b ;

  ERegards n = mkText (strText "regards") (mkPhrase (mkUtt n)) ;

  SSentence s = mkText s ;
  SQuestion s = mkText s ;
  SGreeting s = mkText s exclMarkPunct ;

  RName n = n ;
  RTitle t n = mkNP (mkCN t n) ;
  SName n = n ;

  TMr = mkCN (mkN "Mr") ;
  TMs = mkCN (mkN "Ms") ;

  RI = Phr.IMale ;  -- gender and politeness don't matter in English
  RYou = Phr.YouFamMale ;

  PRole r = r ;

oper
  strText : Str -> Text = \s -> lin Text {s = s} ;
}