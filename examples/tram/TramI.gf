incomplete concrete TramI of Tram = open Multimodal, Math in {

flags startcat=Query ; lexer=textlit ;

lincat
  Dep, Dest = DAdv ;
  Query = Phr ;      -- top level, plain string
  Input = MS ;       -- two parallel sequences (text and clicks)
  Click = Point ;

lin
  QInput i = SentMS PPos i ;

  GoFromTo x y = 
    ModDemV want_VV go_V (DemNP i_NP) 
      (ConsDAdv x (ConsDAdv y BaseDAdv)) ;

  GoToFrom x y = 
    ModDemV want_VV go_V (DemNP i_NP) 
      (ConsDAdv x (ConsDAdv y BaseDAdv)) ;

  ComeFrom x = 
    ModDemV want_VV come_V (DemNP i_NP) 
      (ConsDAdv x BaseDAdv) ;

  GoTo x = 
    ModDemV want_VV go_V (DemNP i_NP) 
      (ConsDAdv x BaseDAdv) ;

  DepClick c = here7from_DAdv c ;
  DestClick c = here7to_DAdv c ;
  DepHere = DemAdv here7from_Adv ;
  DestHere = DemAdv here7to_Adv ;
  DepNamed s = PrepDNP from_Prep (DemNP (UsePN (SymbPN s))) ;
  DestNamed s = PrepDNP to_Prep (DemNP (UsePN (SymbPN s))) ;

  CCoord x y = {s5 = "(" ++ x.s ++ "," ++ y.s ++ ")" ; lock_Point = <>} ;

--  Place = DNP ;    -- name + click - not possible for "here"
--  PClick c = this_DNP c ;
--  PHere = DemNP this_NP ;
--  PNamed s = DemNP (UsePN (SymbPN s)) ;

}
