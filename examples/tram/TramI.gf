incomplete concrete TramI of Tram = open Multimodal, Symbol in {

flags startcat=Query ; lexer=textlit ;

lincat
  Query = Phr ;      -- top level, plain string
  Input = MS ;       -- two parallel sequences (text and clicks)
  Dep, Dest = MAdv ;
  Click = Point ;

lin
  QInput = PhrMS PPos ;

  GoFromTo x y = 
    MPredVP (DemNP (UsePron i_Pron)) 
      (MAdvVP (MAdvVP (MComplVV want_VV (MUseV go_V)) x) y) ;

  GoToFrom x y = 
    MPredVP (DemNP (UsePron i_Pron)) 
      (MAdvVP (MAdvVP (MComplVV want_VV (MUseV go_V)) x) y) ;

  ComeFrom x = 
    MPredVP (DemNP (UsePron i_Pron)) 
      (MAdvVP (MComplVV want_VV (MUseV go_V)) x) ;

  GoTo x = 
    MPredVP (DemNP (UsePron i_Pron)) 
      (MAdvVP (MComplVV want_VV (MUseV go_V)) x) ;

  DepClick    = here7from_MAdv ;
  DestClick   = here7to_MAdv ;
  DepHere     = DemAdv here7from_Adv ;
  DestHere    = DemAdv here7to_Adv ;
  DepNamed s  = MPrepNP from_Prep (DemNP (UsePN (SymbPN (MkSymb s)))) ;
  DestNamed s = MPrepNP to_Prep (DemNP (UsePN (SymbPN (MkSymb s)))) ;

  CCoord x y = {point = "(" ++ x.s ++ "," ++ y.s ++ ")" ; lock_Point = <>} ;

--  Place = DNP ;    -- name + click - not possible for "here"
--  PClick c = this_DNP c ;
--  PHere = DemNP this_NP ;
--  PNamed s = DemNP (UsePN (SymbPN s)) ;

----  FromThisPlace = 

}
