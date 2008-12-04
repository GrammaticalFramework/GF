abstract Letter = {

--1 An Abstract Syntax for Business and Love Letters
--
-- This file defines the abstract syntax of a grammar set whose concrete syntax
-- has so far been written to five languages: English, Finnish, French, Russian,
-- and Swedish. 
--
-- The main category of the grammar is $Letter$. The other categories are
-- parts of the letter.

flags startcat=Letter ;

cat 
  Letter ; 
  Recipient ; Author ; 
  Message ; 
  Heading ; Ending ; 
  Mode ; Sentence ; NounPhrase ; Position ;

-- There is just one top-level letter structure.

fun
  MkLetter : Heading -> Message -> Ending -> Letter ;

-- The heading consists of a greeting of the recipient. The $JustHello$
-- function will actually suppress the name (and title) of the recipient,
-- but the $Recipient$ argument keeps track of the gender and number.

  DearRec   : Recipient -> Heading ; 
  PlainRec  : Recipient -> Heading ;
  HelloRec  : Recipient -> Heading ;
  JustHello : Recipient -> Heading ;

-- A message is a sentence with of without a *mode*, which is either 
-- regret or honour.

  ModeSent  : Mode -> Sentence -> Message ;
  PlainSent : Sentence -> Message ;

  Honour, Regret : Mode ;

-- The ending is either formal or informal. It does not currently depend on
-- the heading: making it so would eliminate formality mismatches between
-- the heading and the ending.

  FormalEnding   : Author -> Ending ;
  InformalEnding : Author -> Ending ;

-- The recipient is either a colleague, colleagues, or darling.
-- It can also be a named person. The gender distinction is made
-- because there are things in the body of the letter that depend on it.

  ColleagueHe, ColleagueShe   : Recipient ;
  ColleaguesHe, ColleaguesShe : Recipient ;
  DarlingHe, DarlingShe       : Recipient ;

  NameHe, NameShe : String -> Recipient ;

-- For the author, there is likewise a fixed set of titles, plus the named author.
-- Gender distinctions could be useful even here, for the same reason as with
-- $Recipient$. Notice that the rendering of $Spouse$ will depend on the
-- gender of the recipient.

  President, Mother, Spouse, Dean : Author ;
  Name      : String -> Author ;

-- As for the message body, no much choice is yet available: one can say that
-- the recipient is promoted to some position, that someone has gone bankrupt,
-- or that the author loves the recipient.

  BePromoted : Position -> Sentence ;
  GoBankrupt : NounPhrase -> Sentence ;
  ILoveYou   : Sentence ;

  Competitor   : NounPhrase ;
  Company      : NounPhrase ;
  OurCustomers : NounPhrase ;

  Senior : Position ;
  ProjectManager : Position ;

}
