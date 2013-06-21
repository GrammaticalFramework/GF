--# -path=.:abstract:common:prelude

concrete StructuralLav of Structural = CatLav ** open
  ResLav,
  ParadigmsLav,
  ParadigmsPronounsLav,
  NounLav,
  Prelude
in {

flags

  optimize = all ;
  coding = utf8 ;

lin

  language_title_Utt = ss "latviešu valoda" ;

  yes_Utt = ss "jā" ;
  no_Utt = ss "nē" ;

  every_Det = {
    s = (\\gend,c => (mkPronoun_Gend "ikviens").s ! gend ! Sg ! c) ;
    num = Sg ;
    defin = Indef ;
    pol = Pos
  } ;

  someSg_Det = {
    s = (\\gend,c => (mkPronoun_Gend "kāds").s ! gend ! Sg ! c) ;  --  TODO: lai atļautu arī tukšo, jāpieliek alternatīva: (\\_,_ => [])
    num = Sg ;
    defin = Indef ;
    pol = Pos
  } ;

  somePl_Det = {
    s = (\\gend,c => (mkPronoun_Gend "kāds").s ! gend ! Pl ! c) ;   --  TODO: lai atļautu arī tukšo, jāpieliek alternatīva: (\\_,_ => [])
    num = Pl ;
    defin = Indef ;
    pol = Pos
  } ;

  few_Det = {
    s = (\\gend,c => (mkPronoun_Gend "dažs").s ! gend ! Pl ! c) ;
    num = Pl ;
    defin = Indef ;
    pol = Pos
  } ;

  many_Det = {
    s = (\\gend,c => (mkPronoun_Gend "daudzs").s ! gend ! Pl ! c) ;  -- 'daudzs' izlocīsies korekti uz daudzskaitļa 'daudzi'; tomēr nesmuki...
    num = Pl ;
    defin = Indef ;
    pol = Pos
  } ;

  much_Det = {
    s = (\\gend,c => "daudz") ;  -- FIXME: piesaista ģenitīvu
    num = Sg ;
    defin = Indef ;
    pol = Pos
  } ;

  this_Quant = {
    s = (mkPronoun_ThisThat This).s ;
    defin = Def ;
    pol = Pos
  } ;

  that_Quant = {
    s = (mkPronoun_ThisThat That).s ;
    defin = Def ;
    pol = Pos
  } ;

  no_Quant = {
    s = (mkPronoun_Gend "neviens").s ;
    defin = Indef ;
    pol = Neg
  } ;

  -- P1

  i_Pron = mkPronoun_I Masc ;  -- See also: ExtraLav.i8fem_Pron

  we_Pron = mkPronoun_We Masc ;  -- See also: ExtraLav.we8fem_Pron

  -- P2

  youSg_Pron = mkPronoun_You_Sg Masc ;  -- See also: ExtraLav.youSg8fem_Pron

  youPol_Pron = mkPronoun_You_Pol Masc ;  -- See also: ExtraLav.youPol8fem_Pron

  youPl_Pron = mkPronoun_You_Pl Masc ;  -- See also: ExtraLav.youPl8fem_Pron

  -- P3

  he_Pron = {
    s = \\c => (mkPronoun_Gend "viņš").s ! Masc ! Sg ! c ;
    agr = AgrP3 Sg Masc ;
    poss = \\_,_,_ => "viņa" ;
    pol = Pos
  } ;

  she_Pron = {
    s = \\c => (mkPronoun_Gend "viņš").s ! Fem ! Sg ! c ;
    agr = AgrP3 Sg Fem ;
    poss = \\_,_,_ => "viņas" ;
    pol = Pos
  } ;

  they_Pron = mkPronoun_They Masc ;  -- See also: ExtraLav.they8fem_Pron

  it_Pron = mkPronoun_It_Sg Masc ;  -- See also: ExtraLav.it8fem_Pron

  -- Pronouns; their translation is very ambiguos...

  above_Prep = mkPrep "virs" Gen Dat ;
  after_Prep = mkPrep "pēc" Gen Dat ;
  before_Prep = mkPrep "pirms" Gen Dat ;
  behind_Prep = mkPrep "aiz" Gen Dat ;  -- taču "aiz" nav viennozīmīgi "behind"
  between_Prep = mkPrep "starp" Acc Dat ;
  during_Prep = mkPrep Loc ;
  for_Prep = mkPrep "priekš" Gen Dat ;
  from_Prep = mkPrep "no" Gen Dat ;
  in_Prep = mkPrep Loc ;
  in8front_Prep = mkPrep "priekšā" Dat Dat ;
  on_Prep = mkPrep "uz" Gen Dat ;
  through_Prep = mkPrep "caur" Acc Dat ;
  to_Prep = mkPrep "uz" Acc Dat ;  -- See also: ExtraLav.liidz_Prep, pie_Prep
  under_Prep = mkPrep "zem" Gen Dat ;
  with_Prep = mkPrep "ar" Acc Dat ;
  without_Prep = mkPrep "bez" Gen Dat ;
  
  by8agent_Prep = nom_Prep ; -- TODO: nom_Prep (default) vs. dat_Prep
  by8means_Prep = mkPrep "ar" Acc Dat ;
  except_Prep = mkPrep "izņemot" Acc Acc ; -- Acc - by default?
  part_Prep = mkPrep Gen ; --FIXME - vajadzētu vārdu secību otrādi - pirms paskaidrojamā vārda likt
  possess_Prep = mkPrep Gen ;  -- FIXME: vajadzētu vārdu secību otrādi - pirms paskaidrojamā vārda likt
  
  very_AdA = mkAdA "ļoti" ;
  almost_AdA = mkAdA "gandrīz" ;
  so_AdA = mkAdA "tik" ;
  too_AdA = mkAdA "pārāk" ;

  more_CAdv = (mkCAdv [] "nekā" Compar) | (mkCAdv "vairāk" "nekā" Posit) ;
  less_CAdv = mkCAdv "mazāk" "nekā" Posit ;
  as_CAdv = mkCAdv "tikpat" "kā" Posit ;

  here_Adv = mkAdv "šeit" ;
  there_Adv = mkAdv "tur" ;
  everywhere_Adv = mkAdv "visur" ;
  here7to_Adv = mkAdv ["uz šejieni"] ;
  here7from_Adv = mkAdv ["no šejienes"] ;
  there7to_Adv = mkAdv "uz turieni" ;
  there7from_Adv = mkAdv "no turienes" ;
  somewhere_Adv = mkAdv "kaut kur" ;
  quite_Adv = mkAdv "diezgan" ;

  and_Conj = mkConj "un" ;
  or_Conj = mkConj "vai" Sg ;
  if_then_Conj = mkConj "ja" "tad" ;

  but_PConj = ss "bet" ;
  otherwise_PConj = ss "citādi" ;
  therefore_PConj = ss "tāpēc" ;

  both7and_DConj = mkConj "gan" ("," ++ "gan"); -- FIXME: komati nav tā kā vajag
  either7or_DConj = mkConj ("vai" ++ "nu") ("," ++ "vai") Sg ; -- FIXME: komati nav tā kā vajag

  whoSg_IP = { -- FIXME: Fem
    s = table {
      Nom => "kurš" ;
      Gen => "kura" ;
      Dat => "kuram" ;
      Acc => "kuru" ;
      Loc => "kurā" ;
      ResLav.Voc => NON_EXISTENT
    } ;
    num = Sg
  } ;
  
  whoPl_IP = { -- FIXME: Fem
    s = table {
      Nom => "kuri" ;
      Gen => "kuru" ;
      Dat => "kuriem" ;
      Acc => "kurus" ;
      Loc => "kuros" ;
      ResLav.Voc => NON_EXISTENT
    } ;
    num = Pl
  } ;
  
  whatSg_IP = {
    s = table {
      Nom => "kas" ;
      Gen => "kā" ;
      Dat => "kam" ;
      Acc => "ko" ;
      Loc => "kur" ;
      ResLav.Voc => NON_EXISTENT
    } ;
    num = Sg
  } ;
  
  whatPl_IP = {
    s = table {
      Nom => "kas" ;
      Gen => "kā" ;
      Dat => "kam" ;
      Acc => "ko" ;
      Loc => "kur" ;
      ResLav.Voc => NON_EXISTENT
    } ;
    num = Pl
  } ;

  why_IAdv = ss "kāpēc" ;
  how_IAdv = ss "kā" ;
  how8much_IAdv = ss "cik" ;
  when_IAdv = ss "kad" ;
  where_IAdv = ss "kur" ;

  which_IQuant = {
    s = table {
      Masc => table { Sg => "kurš"; Pl => "kuri" } ;
      Fem => table { Sg => "kura"; Pl => "kuras" }
    }
  } ;

  how8many_IDet = {
    s = table { _ => "cik" } ;
    num = Pl
  } ;

  when_Subj = ss "kad" ;
  although_Subj = ss "kaut arī" ;
  because_Subj = ss "jo" ;
  if_Subj = ss "ja" ;
  that_Subj = ss "ka" ;

  all_Predet = { s = table { Masc => "visi" ; Fem => "visas" } } ; -- FIXME: cases
  only_Predet = { s = table { _ => "tikai"} } ;
  most_Predet = { s = table { _ => "vairums"} } ;

  almost_AdN = mkAdN "gandrīz" ;
  at_least_AdN = mkAdN "vismaz" ;
  at_most_AdN = mkAdN "ne vairāk kā" ;

  always_AdV = mkAdV "vienmēr" ;

  somebody_NP = UsePron (mkPronoun_Body "kāds" Pos) ;
  something_NP = UsePron (mkPronoun_Thing "kaut kas" Pos) ;
  everybody_NP = UsePron (mkPronoun_Body "ikviens" Pos) ;
  everything_NP = UsePron (mkPronoun_Thing "jebkas" Pos) ;
  nobody_NP = UsePron (mkPronoun_Body "neviens" Neg) ;
  nothing_NP = UsePron (mkPronoun_Thing "nekas" Neg) ;

  have_V2 = mkV2 (mkV "būt" Dat) nom_Prep ;
  --have_V3 = mkV3 (mkV "būt") Dat nom_Prep dat_Prep ;

  want_VV = mkVV (mkV "vēlēties" third_conjugation) ;
  can_VV = mkVV (mkV "varēt" third_conjugation) ;
  can8know_VV = mkVV (mkV "varēt" third_conjugation) ;
  must_VV = mkVV (mkV "vajadzēt" third_conjugation Dat) ;

  please_Voc = ss "lūdzu" ;

oper
  
  reflPron : Case => Str = table {
    Nom => NON_EXISTENT ;
    Gen => "sevis" ;
    Dat => "sev" ;
    Acc => "sevi" ;
    Loc => "sevī" ;
    ResLav.Voc => NON_EXISTENT
  } ;

  lai_Subj = ss "lai" ;
  kameer_Subj = ss "kamēr" ;

  {- Netiek izmantoti; to vietā sk. ExtraLav
  emptyPl_Det = {
    s : Gender => Case => Str = \\_,_ => [] ;
    num = Pl ;
    defin = Indef
  } ;
  emptySg_Det = { -- TODO: analoģiski kā emptyPl_Det
    s : Gender => Case => Str = \\_,_ => [] ;
    num = Sg ;
    defin = Indef
  } ;
  -}

}
