--# -path=.:present

concrete ClassesEng of Classes = open SyntaxEng, ParadigmsEng in {

lincat
  Command = Utt ;
  Kind = CN ;
  Class = {} ;
  Instance = {} ;
  Action = V2 ;
  Device = NP ;

lin
  Act _ _ _ a d = mkUtt (mkImp a d) ;
  The k = mkNP the_Det k ;

  Light = mkCN (mkN "light") ;
  Fan = mkCN (mkN "fan") ;
  Switchable, Dimmable = <> ;
  
  SwitchOn = mkV2 (mkV "on" (mkV "switch")) ;
  SwitchOff = mkV2 (mkV "off" (mkV "switch")) ;
  Dim = mkV2 (mkV "dim") ;

  switchable_Light = <> ;
  switchable_Fan = <> ;
  dimmable_Light = <> ;

}
