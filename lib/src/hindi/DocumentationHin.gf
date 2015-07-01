concrete DocumentationHin of Documentation = CatHin ** open
  ResHin,
  CommonHindustani,
  HTML 
in {

lincat
  Inflection = {t : Str; s1,s2 : Str} ;
  Document = {s : Str} ;
  Tag = {s : Str} ;

lin
  InflectionN, InflectionN2, InflectionN3 = \noun -> {
    t  = "n" ;
    s1 = heading1 ("Noun" ++
         case noun.g of {
           Masc => "(Masc)" ;
           Fem  => "(Fem)"
         });
    s2 = frameTable (
           tr (th ""    ++ th "sg"                ++ th "pl") ++
           tr (th "dir" ++ td (noun.s ! Sg ! Dir) ++ td (noun.s ! Pl ! Dir)) ++
           tr (th "obl" ++ intagAttr "td" "rowspan=2" (noun.s ! Sg ! Obl) ++ td (noun.s ! Pl ! Obl)) ++
           tr (th "voc" ++ td (noun.s ! Pl ! CommonHindustani.Voc))
         )
    } ;

  InflectionA, InflectionA2 = \adj -> {
    t  = "a" ;
    s1 = heading1 "Adjective" ;
    s2 = heading2 "Positive" ++
         forms Posit ++
         heading2 "Comparative" ++
         forms Compar ++
         heading2 "Superlative" ++
         forms Superl
    } where {
        forms : Degree -> Str = \degree ->
          frameTable (
            tr (intagAttr "th" "colspan=2" "" ++ th "sg" ++ th "pl") ++
            tr (intagAttr "th" "rowspan=3" "masc" ++
                th "dir" ++ td (adj.s ! Sg ! Masc ! Dir ! degree) ++ td (adj.s ! Pl ! Masc ! Dir ! degree)) ++
            tr (th "obl" ++ intagAttr "td" "rowspan=2" (adj.s ! Sg ! Masc ! Obl ! degree) ++ td (adj.s ! Pl ! Masc ! Obl ! degree)) ++
            tr (th "voc" ++ td (adj.s ! Pl ! Masc ! CommonHindustani.Voc ! degree)) ++
            tr (intagAttr "th" "rowspan=3" "fem" ++
                th "dir" ++ td (adj.s ! Sg ! Fem ! Dir ! degree) ++ td (adj.s ! Pl ! Fem ! Dir ! degree)) ++
            tr (th "obl" ++ intagAttr "td" "rowspan=2" (adj.s ! Sg ! Fem ! Obl ! degree) ++ td (adj.s ! Pl ! Fem ! Obl ! degree)) ++
            tr (th "voc" ++ td (adj.s ! Pl ! Fem ! CommonHindustani.Voc ! degree))
          ) ;
    };

  InflectionAdv = \adv -> {
    t  = "adv" ;
    s1 = heading1 "Adverb" ;
    s2 = frameTable (
            tr (th "masc" ++ td (adv.s ! Masc)) ++
            tr (th "fem"  ++ td (adv.s ! Fem))
          )
    } ;

  InflectionPrep = \prep -> {
    t  = "prep" ;
    s1 = heading1 "Preposition" ;
    s2 = frameTable (
            tr (th "masc" ++ td (prep.s ! Masc)) ++
            tr (th "fem"  ++ td (prep.s ! Fem))
          )
    } ;

  InflectionV, InflectionV2, InflectionV3,
  InflectionV2A, InflectionV2Q, InflectionV2S, InflectionV2V,
  InflectionVA, InflectionVQ, InflectionVS, InflectionVV = \verb -> {
    t  = "v" ;
    s1 = heading1 "Verb" ;
    s2 = heading2 "Root" ++
         paragraph (verb.s ! Root) ++
         heading2 "Present" ++
         forms Imperf ++
         heading2 "Past" ++
         forms CommonHindustani.Subj ++
         heading2 "Past Perfect" ++
         forms Perf ++
         heading2 "Infinitive" ++
         frameTable (
           tr (th ""    ++ td (verb.s ! Inf)) ++
           tr (th "obl" ++ td (verb.s ! Inf_Obl)) ++
           tr (th "fem" ++ td (verb.s ! Inf_Fem))
         )
    } where {
        forms : VTense -> Str = \tense ->
          frameTable (
            tr (intagAttr "th" "colspan=2" "" ++ th "masc" ++ th "fem") ++
            tr (intagAttr "th" "rowspan=6" "sg" ++ 
                th "1.p"          ++ td (verb.s ! VF tense Pers1 Sg Masc) ++ 
                                     td (verb.s ! VF tense Pers1 Sg Fem)) ++
            tr (th "2.p casual"   ++ td (verb.s ! VF tense Pers2_Casual   Sg Masc) ++ 
                                     td (verb.s ! VF tense Pers2_Casual   Sg Fem)) ++
            tr (th "2.p familiar" ++ td (verb.s ! VF tense Pers2_Familiar Sg Masc) ++ 
                                     td (verb.s ! VF tense Pers2_Familiar Sg Fem)) ++
            tr (th "2.p respect"  ++ td (verb.s ! VF tense Pers2_Respect  Sg Masc) ++ 
                                     td (verb.s ! VF tense Pers2_Familiar Sg Fem)) ++
            tr (th "3.p near"     ++ td (verb.s ! VF tense Pers3_Near     Sg Masc) ++ 
                                     td (verb.s ! VF tense Pers3_Near     Sg Fem)) ++
            tr (th "3.p distant"  ++ td (verb.s ! VF tense Pers3_Distant  Sg Masc) ++ 
                                     td (verb.s ! VF tense Pers3_Distant  Sg Fem)) ++
            tr (intagAttr "th" "rowspan=6" "pl" ++
                th "1.p"          ++ td (verb.s ! VF tense Pers1 Pl Masc) ++ 
                                     td (verb.s ! VF tense Pers1 Pl Fem)) ++
            tr (th "2.p casual"   ++ td (verb.s ! VF tense Pers2_Casual   Pl Masc) ++ 
                                     td (verb.s ! VF tense Pers2_Casual   Pl Fem)) ++
            tr (th "2.p familiar" ++ td (verb.s ! VF tense Pers2_Familiar Pl Masc) ++ 
                                     td (verb.s ! VF tense Pers2_Familiar Pl Fem)) ++
            tr (th "2.p respect"  ++ td (verb.s ! VF tense Pers2_Respect  Pl Masc) ++ 
                                     td (verb.s ! VF tense Pers2_Familiar Pl Fem)) ++
            tr (th "3.p near"     ++ td (verb.s ! VF tense Pers3_Near     Pl Masc) ++ 
                                     td (verb.s ! VF tense Pers3_Near     Pl Fem)) ++
            tr (th "3.p distant"  ++ td (verb.s ! VF tense Pers3_Distant  Pl Masc) ++ 
                                     td (verb.s ! VF tense Pers3_Distant  Pl Fem))
          )
    } ;

lin
  MkDocument b i e = {s = i.s1 ++ "<p style=\"font-size:20px\">"++b.s++"</p>" ++ i.s2 ++ paragraph e.s} ;
  MkTag i = {s = i.t} ;

}
