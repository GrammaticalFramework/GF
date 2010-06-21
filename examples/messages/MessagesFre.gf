--# -path=.:../phrasebook:present

concrete MessagesFre of Messages = 
  WordsFre - 
    [IMale, IFemale, YouFamMale, YouFamFemale, YouPolMale, YouPolFemale],
  GreetingsFre ** 
 open
  SyntaxFre,
  ParadigmsFre,
  Prelude,
  (Phr = PhrasebookFre)
 in {

lincat
  Message = Text ;
  Heading = {s : Text ; g : Gender ; isPol : Bool} ;
  Body = {s : Gender => Gender => Bool => Text} ;
  Ending = {s : Text ; g : Gender} ;
  Statement = {s : Gender => Gender => Bool => Text} ;
  Recipient = NP ;
  Sender = NP ;
  Title = CN ;
  Role = Phr.NPPerson ;

lin
  Msg h b e = mkText h.s (mkText (b.s ! h.g ! e.g ! h.isPol) e.s) ;
  
  HHello n = {
    s = mkText (strText "bonjour") (mkText (mkPhrase (mkUtt n)) (strText ",")) ;
    g = n.a.g ; ----Res
    isPol = n.isPol ----Res
    } ;
  HDear r = { 
    s = mkText 
      (mkPhrase (mkUtt (mkCN (prefixA (mkA "cher")) (nameCN r)))) 
      (strText ",") ;
    g = r.a.g ; ----Res
    isPol = r.isPol ----Res
    } ;

  BOne  p = p ;
  BMore s b = {s = \\i,y,p => mkText (s.s ! i ! y ! p) (b.s ! i ! y ! p)} ;

  ERegards n = {
    s = mkText (strText "avec salutations") (mkPhrase (mkUtt n)) ;
    g = n.a.g ----Res
    } ;

  SSentence s = {s = \\i,y,p => mkText s} ;
  SQuestion s = {s = \\i,y,p => mkText s} ;
  SGreeting s = {s = \\i,y,p => mkText s exclMarkPunct} ;

  RName n = n ; 
  RTitle t n = cnNP (mkCN t n) ;
  SName n = n ;

  TMr = mkCN (mkN "monsieur" "messieurs" masculine) ;
  TMs = mkCN (mkN "madame" "mesdames" feminine) ;

  RI = Phr.IMale ;
  RYou = Phr.YouFamMale ;

  PRole r = r ;

oper
  strText : Str -> Text = \s -> lin Text {s = s} ;


---- TODO in RG and its API

  nameCN : NP -> CN = \n -> mkCN (mkN "") n ;
  cnNP : CN -> NP = \cn -> mkNP (mkPN (cn.s ! singular) cn.g) ;

}