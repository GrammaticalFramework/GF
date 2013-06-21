--# -path=.:../abstract:../common:../prelude

concrete RelativeLav of Relative = CatLav ** open
  ResLav,
  VerbLav,
  Prelude
in {

flags
  optimize = all_subs ;
  coding = utf8 ;

lin
  RelCl cl = { s = \\m,p,_ => "ka" ++ cl.s ! m ! p } ;

  -- RP -> VP -> RCl
  RelVP rp vp = mkRelClause rp vp ;

oper

  -- TODO: PassV2 verbs jāsaskaņo ar objektu, nevis subjektu (by8means_Prep: AgP3 Sg Masc) - done?
  mkRelClause : RP -> CatLav.VP -> RCl = \rp,vp ->  
    let subjInTopic : Bool = case <vp.voice, vp.leftVal> of {
      <Act,  Nom> => True ;
      <Act,  _  > => False ;
      <Pass, Acc> => False ;
      <Pass, _  > => True
    }
    in lin RCl {
      s = \\mood,pol,agr =>
        case mood of {         -- subject
          Deb _ _ => rp.s ! Masc ! Dat ;  --# notpresent
          _       => rp.s ! Masc ! vp.leftVal
        } ++
        case subjInTopic of {  -- verb
          True  => buildVerb vp.v mood pol (AgrP3 (fromAgr agr).num (fromAgr agr).gend) Pos vp.rightPol ;
          False => buildVerb vp.v mood pol vp.rightAgr                                  Pos vp.rightPol
        } ++
        vp.compl ! agr         -- object(s), complements, adverbial modifiers
    } ;

lin
  -- FIXME: vārdu secība - nevis 'kas mīl viņu' bet 'kas viņu mīl' (?)
  -- FIXME: Masc varētu nebūt labi
  RelSlash rp slash = {
    s = \\m,p,ag => slash.prep.s ++ rp.s ! Masc ! (slash.prep.c ! Sg) ++  slash.s ! m ! p
  } ;

  -- FIXME: placeholder
  -- TODO: jātestē, kautkas nav labi ar testpiemēru
  FunRP p np rp = {
    s = \\g,c => p.s ++ rp.s ! g ! c ++ np.s ! (p.c ! (fromAgr np.agr).num)
  } ;

  IdRP = {
    s = \\_ => table {
      Nom => "kas" ;
      Gen => "kā" ;
      Dat => "kam" ;
      Acc => "ko" ;
      Loc => "kur" ;
      ResLav.Voc => NON_EXISTENT
    }
  } ;

}
