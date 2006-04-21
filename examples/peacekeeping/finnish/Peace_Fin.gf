--# -path=.:..:present:prelude

concrete Peace_Fin of Peace = 
  PeaceSyntax_Fin, PeaceLexCommon_Fin, 
  PeaceLexExt_Fin, PeacePhrases_Fin
  ** {

  flags startcat = PhraseWritten ; 
	optimize = all_subs ;
}
