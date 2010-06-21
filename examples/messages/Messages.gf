abstract Messages = 
  Words - [IMale, IFemale, YouFamMale, YouFamFemale, YouPolMale, YouPolFemale],
  Greetings ** {

flags startcat = Message ;

cat
  Message ;
  Heading ;
  Body ;
  Ending ;
  Statement ;
  Recipient ;
  Sender ;
  Title ;
  Role ;

fun
  Msg : Heading -> Body -> Ending -> Message ;
  
  HHello : Recipient -> Heading ;
  HDear  : Recipient -> Heading ;
  
  BOne  : Statement -> Body ;
  BMore : Statement -> Body -> Body ;

  ERegards : Sender -> Ending ;

  SSentence : Sentence -> Statement ;
  SQuestion : Question -> Statement ;
  SGreeting : Greeting -> Statement ;

  RName  : Name -> Recipient ;
  RTitle : Title -> Name -> Recipient ;
  SName  : Name -> Sender ;

  TMr  : Title ;
  TMs  : Title ;

  RI   : Role ;   -- generic: Gender and Politeness from context
  RYou : Role ;

  PRole : Role -> Person ;

}