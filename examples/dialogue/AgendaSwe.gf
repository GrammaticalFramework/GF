--# -path=.:multimodal:alltenses:prelude

concrete AgendaSwe of Agenda = 
  DialogueSwe, WeekdaySwe ** open MultiSwe, ParadigmsSwe, IrregSwe in {

  lin
    Day       = UseN (regN "dag") ;
    Meeting   = UseN (regGenN "möte" neutrum) ;
    Add       = dirV3 (partV lägga_V "till") (mkPreposition "på") ;
    Remove    = dirV2 (partV taga_V "bort") ;
    Interrupt = avbryta_V ;
   
    day = UsePN ;

}

