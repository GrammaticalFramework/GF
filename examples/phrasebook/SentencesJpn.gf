concrete SentencesJpn of Sentences = NumeralJpn ** 
  SentencesI - [
    VDrink,VEat,VRead,VWait,VWrite,
    phrasePlease, mkSentence, mkPhrase,
    NameNN, 
    PSentence, PQuestion, GObjectPlease,
    ACitizen, Citizenship, CitiNat, Nationality, NPNationality, mkNPNationality, PropCit, PCitizenship
   ]
with 
  (Syntax = SyntaxJpn),
--  (Symbolic = SymbolicJpn),
  (Lexicon = LexiconJpn) ** open SyntaxJpn, ParadigmsJpn in {

flags coding = utf8 ;

lincat

  Citizenship = NPCitizenship ;
  Nationality = NPNationality ;

lin 
  VDrink = v2toVP drink_V2 ; 
  VEat = v2toVP eat_V2 ;
  VRead = v2toVP read_V2 ;
  VWait = v2toVP wait_V2 ;
  VWrite = v2toVP write_V2 ; 

  NameNN = mkNP (mkPN "NN") ;

  PSentence s = mkText (mkPhr (mkUtt s)) | lin Text (mkPhr (mkUtt s)) ;  -- optional '.'
  PQuestion s = mkText (mkPhr (mkUtt s)) | lin Text (mkPhr (mkUtt s)) ;  -- optional '?'

  GObjectPlease o = lin Text (mkPhr noPConj (mkUtt o) please_Voc) | lin Text (mkPhr (mkUtt o)) ;

  ACitizen p n = mkCl p.name n.citizenship ;

  CitiNat n = {prop = n.prop ; citizenship = n.citizenship} ; 

  PropCit c = c.prop ;

  PCitizenship x = mkPhrase (mkUtt x.citizenship) ;

oper
  v2toVP : V2 -> VP = \v2 -> mkVP <lin V (v2 ** {needSubject = True}) : V> ; 

  phrasePlease : Utt -> Text = \u -> lin Text (mkPhr u) | lin Text (mkPhr noPConj u please_Voc) ;

  mkPhrase : Utt -> Text = \u -> lin Text (mkPhr u) ; -- no punctuation
  mkSentence : Utt -> Text = \t -> lin Text (postfixSS "." (mkPhr t) | (mkPhr t)) ; -- optional .
 
  NPCitizenship : Type = {prop : A ; citizenship : NP} ;

  NPNationality : Type = NPCitizenship ** {lang : NP ; country : NP} ;

  mkNPNationality : NP -> NP -> A -> NP -> NPNationality = \la,co,pro,ci ->
        {lang = la ; 
         country = co ;
         prop = pro ;
         citizenship = ci
        } ;

}
