--# -path=.:resource-0.6/english:resource-0.6/abstract:prelude

incomplete concrete MP3I of MP3 = open Structural, Lexicon in {

  flags startcat=Move ;

  lincat
    Move = Phr ;
    Song = NP ;

  lin
    Play song = ImperOne (ImperVP (PosVG (PredTV play song))) ;
    CanPlay  song = QuestPhrase (QuestVP ThouNP (PosVG (PredVV CanVV (PredTV play song)))) ;
    WantPlay song = IndicPhrase (PredVP INP (PosVG (PredVV WantVV (PredTV play song)))) ;
    WhichPlay = QuestPhrase (IntVP (NounIPOne (UseN song)) (PosVG (PredPassV (VTrans play)))) ;

    ThisSong = DetNP ThisDet (UseN song) ;
    This = ThisNP ;

    Yesterday = yesterday ;

----    MkSong : String -> Song ;

}
