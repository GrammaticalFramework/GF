concrete StructuralGre of Structural = CatGre ** 
  open  ResGre, ParadigmsGre, MakeStructuralGre, BeschGre, 
   Prelude in {

  flags coding = utf8 ;




  lin

  above_Prep = mkPreposition "πάνω από" ;
  after_Prep = mkPreposition "μετά από" ;
  all_Predet =  { s = \\n,g,c => (regAdj "όλος").s ! Posit ! g ! n ! c };
  almost_AdA, almost_AdN  = ss "σχεδόν" ;
  although_Subj = ss "παρόλο που" ** {m = Ind} ;
  always_AdV = ss "πάντα" ;
  and_Conj = {s1 = [] ; s2 = "και" ; n = Pl} ;
  because_Subj = ss "επειδή" ** {m = Ind} ;
  before_Prep = mkPreposition "πρίν από" ;
  behind_Prep = mkPreposition "πίσω από"  ;
  between_Prep = mkPreposition2 "ανάμεσα";
  both7and_DConj = {s1,s2 = "και" ; n = Pl} ;
  but_PConj = ss "αλλά" ;
  by8agent_Prep = mkPreposition  "από";
  by8means_Prep = mkPreposition  "από";
  can8know_VV = mkVV (v_VerbNoPassive5 "μπορώ" "μπορέσω" "μπόρεσα" "μπορούσα" "μπόρεσε" " " ) ;
  can_VV = mkVV (v_VerbNoPassive5 "μπορώ" "μπορέσω" "μπόρεσα" "μπορούσα" "μπόρεσε" " " ) ; 
  during_Prep =   mkPreposition3 "κατα τη διάρκεια" ;
  either7or_DConj = mkConj "είτε" "ή" plural ; 

  every_Det = let kathenas : ResGre.Gender =>  ResGre.Case =>  Str =  \\g,c =>  case <g,c> of { 
            <Masc| Change,Nom |Vocative> => "ο καθένας"; 
            <Masc| Change,Gen|CPrep P_Dat> => "του καθενός" ; 
            <Masc| Change, Acc |CPrep P_se | CPrep PNul> => prepCase c ++ "τον καθένα"  ; 
            <Fem,Nom |Vocative |Acc |CPrep P_se | CPrep PNul> => prepCase c ++ "η καθεμία"; 
            <Fem,Gen|CPrep P_Dat > => "της καθεμίας" ; 
            <Neut,Nom |Vocative |Acc |CPrep P_se | CPrep PNul> =>  prepCase c ++"το καθένα"; 
            <Neut,Gen|CPrep P_Dat > => "του καθενός" 
            }; in {
        s  = \\_,c => prepCase c ++ "κάθε" ;
        sp = kathenas ;
        n = Sg ; 
        isNeg = False
        } ;

  everybody_NP = nppolPos (mkDeterminer "όλοι" "όλων" "όλους" "όλες" "όλων" "όλες" "όλα" "όλων" "όλα" "όλα" "όλων" "όλα"  Pl) ;
  everything_NP = makeNP  "τα πάντα" "των πάντων" "στα πάντα" Pl Neut ;
  everywhere_Adv = ss "παντού" ;

  few_Det ={s,sp = \\g,c => case <g,c> of { 
            <Masc,Nom |Vocative> => "λίγοι"; 
            <Masc,Gen|CPrep P_Dat> => "λίγων" ; 
            <Masc ,Acc |CPrep P_se | CPrep PNul> =>prepCase c ++"λίγους" ;  
            <Fem,Nom |Vocative |Acc |CPrep P_se | CPrep PNul> => prepCase c ++"λίγες"; 
            <Fem,Gen|CPrep P_Dat > => "λίγων" ; 
            <Neut| Change,Nom |Vocative |Acc |CPrep P_se | CPrep PNul> => prepCase c ++"λίγα"; 
            <Neut| Change,Gen|CPrep P_Dat > => "λίγων" 
            }; 
        n= Pl;
        isNeg = False
        } ;

  for_Prep = mkPreposition "για" ;
  from_Prep = mkPreposition "από"  ;
  he_Pron = mkPron "αυτός" "του" "τον" "αυτόν" "αυτού" Masc Sg P3 ;
  here_Adv = ss "εδώ" ;
  here7to_Adv = ss "ως εδώ" ;
  here7from_Adv = ss "από εδώ " ;
  how_IAdv = ss "πώς" ;
  how8much_IAdv = ss "πόσο" ;
  how8many_IDet = mkDeterminer "πόσοι" "πόσων" "πόσους" "πόσες" "πόσων" "πόσες" "πόσα" "πόσων" "πόσα" "πόσα" "πόσων" "πόσα" Pl ;
  i_Pron  = mkPron "εγώ" "μου" "με" "εμένα"  "εμού" Masc Sg P1 ;
  if_Subj = ss "αν" ** {m = Ind};
  in8front_Prep = mkPreposition "μπροστά από";
  in_Prep = complPrepSe;
  it_Pron  = mkPron "αυτό" "του" "το" "αυτό" "αυτού" Neut  Sg P3 ;
  less_CAdv = {s,s2="λιγότερο"; p= "από"  ; c= CPrep PNul ; lock_CAdv = <>}  ;

  many_Det =  {s,sp = \\g,c => case <g,c> of { 
        <Masc,Nom |Vocative> => "πολλοί"; 
        <Masc |Fem | Neut |Change,Gen|CPrep P_Dat> => "πολλών" ; 
        <Masc ,Acc |CPrep P_se | CPrep PNul> =>prepCase c ++ "πολλούς" ;  
        <Fem,Nom |Vocative |Acc |CPrep P_se | CPrep PNul> => prepCase c ++"πολλές"; 
        <Neut| Change,Nom |Vocative |Acc |CPrep P_se | CPrep PNul> => prepCase c ++"πολλά"
        }; 
      n= Pl;
      isNeg = False
      } ;

  more_CAdv = {s="πιό"; s2 = "πάνω" ; p="από"  ; c= CPrep PNul}  ;
  most_Predet = { s = \\n,g,c => artDef  g n c ++  (regAdj "περισσότερος").s ! Posit ! g ! n ! c };

  much_Det = {s,sp = \\g,c => case <g,c> of{ 
            <Masc| Change,Nom> => "πολύς"; 
            <Masc| Change,Gen|CPrep P_Dat> => "πόλύ" ; 
            <Masc| Change,Acc |CPrep P_se | CPrep PNul> => prepCase c ++"πολύ" ; 
            <Masc| Change,Vocative> => "πολύ" ; 
            <Fem,Nom |Vocative |Acc |CPrep P_se | CPrep PNul> =>prepCase c ++ "πολλή"; 
            <Fem,Gen|CPrep P_Dat > => "πολλής" ; 
            <Neut,Nom |Vocative |Acc |CPrep P_se | CPrep PNul> => prepCase c ++"πολύ"; 
            <Neut,Gen|CPrep P_Dat > => "πολύ"  
              };  
            n= Sg; 
            isNeg = False 
            } ;

  must_VV = mkVV (v_mk_Prepei  "πρέπει"  "έπρεπε" ** {lock_V = <>});
  no_Utt = ss "όχι" ;
  on_Prep = complPrepSe ;
  only_Predet =let mono : Number =>Gender=> Case =>  Str=  \\n,g,c =>  case <n,g,c> of {<_,_,_> => prepCase c ++ "μόνο" }  in { s = mono} ;
  or_Conj = {s1 = [] ; s2 = "ή" ; n = Sg} ;
  otherwise_PConj = ss "αλλιώς" ;
  part_Prep = complGen ;
  please_Voc = ss "παρακαλώ" ;
  possess_Prep = complGen ;
  quite_Adv = ss "αρκετά" ;
  she_Pron = mkPron "αυτή" "της" "την" "αυτήν" "αυτής" Fem  Sg P3 ;
  so_AdA = ss "τόσο" ;

  someSg_Det = {s,sp = \\g,c => case <g,c> of { 
            <Masc| Change,Nom> => "κάποιος"; 
            <Masc| Change,Gen|CPrep P_Dat> => "κάποιου" ; 
            <Masc| Change,Acc |CPrep P_se | CPrep PNul> =>prepCase c ++ "κάποιον" ; 
            <Masc| Change,Vocative> => "κάποιε" ; 
            <Fem,Nom |Vocative |Acc |CPrep P_se | CPrep PNul> => prepCase c ++"κάποια"; 
            <Fem,Gen|CPrep P_Dat > => "κάποιας" ; 
            <Neut,Nom |Vocative |Acc |CPrep P_se | CPrep PNul> => prepCase c ++"κάποιο"; 
            <Neut,Gen|CPrep P_Dat > => "κάποιου"  
            };  
          n= Sg; 
          isNeg = False 
         } ;

  somePl_Det =  {s,sp = \\g,c => case <g,c> of { 
            <Masc,Nom |Vocative> => "κάποιοι"; 
            <Masc |Fem | Neut |Change,Gen|CPrep P_Dat> => "κάποιων" ; 
            <Masc ,Acc |CPrep P_se | CPrep PNul> => prepCase c ++"κάποιους" ;  
            <Fem,Nom |Vocative |Acc |CPrep P_se | CPrep PNul> => prepCase c ++"κάποιες"; 
            <Neut| Change,Nom |Vocative |Acc |CPrep P_se | CPrep PNul> => prepCase c ++"κάποια"
            }; 
          n= Pl; 
          isNeg = False 
          } ;

  somebody_NP =  nppolPos (mkDeterminer "κάποιος" "κάποιου" "κάποιον" "κάποια" "κάποιας" "κάποια" "κάποιο" "κάποιου" "κάποιο" "κάποιος" "κάποιου" "κάποιον" Sg  ) ;
  something_NP = makeNP "κάτι" Sg Neut False ;
  somewhere_Adv = ss "κάπου" ;
  that_Quant = { s = \\_,g,n,c => prepCase c ++ (regAdj "εκείνος").s ! Posit ! g ! n ! c ++ artDef g n c ; sp =\\g,n,c =>  (regAdj "εκείνος").s ! Posit ! g ! n ! c  ; isNeg =False };
  that_Subj = ss "οτι" ** {m = Ind} ;
  there_Adv = ss "εκεί" ;
  there7to_Adv = ss "ως εκεί" ;
  there7from_Adv = ss "απο εκεί";
  therefore_PConj = ss "γι'αυτό" ;
  they_Pron = mkPron "αυτοί" "τους" "τους"  "αυτούς" "αυτών" Masc Pl P3 ;

  this_Quant = { 
                s =\\_,g,n,c => prepCase c ++ (regAdj "αυτός").s ! Posit ! g ! n ! c ++ artDef g n c ; 
                sp =\\g,n,c =>  (regAdj "αυτός").s ! Posit ! g ! n ! c  ;  
                isNeg =False
                };

  through_Prep = mkPrep4 "μέσω";
  to_Prep = complPrepSe ;
  too_AdA = ss "υπερβολικά" ;
  under_Prep = mkPreposition "κάτω από" ;
  very_AdA = ss "πολύ" ;
  want_VV =  mkVV (VerbNoPassive2syll "θέλω" "θελήσω" "θέλησα" "ήθελα" "ηθελημένος" ** {lock_V = <>})  ; 
  we_Pron = mkPron "εμείς" "μας" "μας" "εμάς" "ημών" Masc Pl P1 ;
  whatPl_IP = {s = \\g,c => prepCase c ++ "τι" ; n= Pl; a = a}   where {a = aagr Masc Pl} ;
  whatSg_IP = {s = \\g,c => prepCase c ++ "τι" ; n= Sg; a = a}  where {a = aagr Masc Sg} ;
  when_IAdv = ss "πότε" ;
  when_Subj = ss "όταν" ** {m =Con} ;
  where_IAdv = ss "που" ;
  
  which_IQuant = {s =  \\n,g,c =>  case <n,g,c> of {
      <Sg,Masc | Change,Nom |Vocative> => "ποιός"; 
      <Sg,Masc | Change,Gen|CPrep P_Dat> => "ποιού" ; 
      <Sg, Masc | Change ,Acc |CPrep P_se | CPrep PNul> => prepCase c ++ "ποιόν"  ; 
      <Sg,Fem,Nom |Vocative |Acc |CPrep P_se | CPrep PNul> => prepCase c ++ "ποιά"; 
      <Sg,Fem,Gen|CPrep P_Dat > => "ποιάς" ; 
      <Sg,Neut,Nom |Vocative |Acc |CPrep P_se | CPrep PNul> =>  prepCase c ++"ποιό"; 
      <Sg,Neut,Gen|CPrep P_Dat > => "ποιού" ;
      <Pl,Masc,Nom |Vocative> => "ποιoί"; 
      <Pl,Masc,Gen|CPrep P_Dat> => "ποιών" ; 
      <Pl, Masc| Change, Acc|CPrep P_se | CPrep PNul> => prepCase c ++ "ποιούς"  ; 
      <Pl,Fem,Nom |Vocative |Acc |CPrep P_se | CPrep PNul> => prepCase c ++ "ποιές"; 
      <Pl,Fem,Gen|CPrep P_Dat > => "ποιών" ; 
      <Pl,Neut | Change,Nom |Vocative |Acc |CPrep P_se | CPrep PNul> =>  prepCase c ++"ποιά"; 
      <Pl,Neut | Change,Gen|CPrep P_Dat > => "ποιών" } 
     } ;

 whoSg_IP = {s = \\g,c => case <g,c> of { 
                <Masc | Change ,Nom> =>prepCase c ++ "ποιός"  ;
                <Fem ,Nom | Acc |CPrep P_se | CPrep PNul > =>prepCase c ++ "ποιά"  ;
                <Neut ,Nom | Acc | CPrep P_se | CPrep PNul > =>prepCase c ++ "ποιό"  ;
                <Fem ,Gen> =>prepCase c ++"ποιάς"  ;
                <Neut | Change | Masc,Gen> => prepCase c ++"ποιού"  ;
                <Masc ,Acc |CPrep P_se | CPrep PNul > => prepCase c ++"ποιόν" ;
                _ => " "
                  }; 
          a = {g = Masc ; n = Sg} ;
          n=Sg
          };

 whoPl_IP = {s = \\g,c => case <g,c> of {
                  <Masc ,Nom> => prepCase c ++"ποιοί"  ;
                  <Fem ,Nom | Acc | CPrep P_se | CPrep PNul > => prepCase c ++ "ποιές"  ;
                  <Neut| Change ,Nom | Acc | CPrep P_se | CPrep PNul > => prepCase c ++"ποιά"  ;
                  <Fem | Neut | Change | Masc,Gen> => prepCase c ++"ποιών"  ;
                  <Masc,Acc | CPrep P_se | CPrep PNul > => prepCase c ++"ποιούς" ;
                  _ => " "
                  }; 
          a = {g = Masc ; n = Pl} ;
          n=Pl
          };

  why_IAdv = ss "γιατί" ;
  with_Prep = mkPreposition "με" ;
  without_Prep = mkPreposition "χωρίς"  ;
  yes_Utt = ss "ναι" ;
  youSg_Pron = mkPron "εσύ" "σου" "σε" "εσένα" "εσού" Masc Sg P2 ; 
  youPl_Pron = mkPron "εσείς" "σας" "σας" "εσάς" "υμών" Masc Pl P2 ;
  youPol_Pron = mkPron "εσείς" "σας" "σας" "εσάς" "υμών" Masc Pl P2 ;

  no_Quant = let kanenas : ResGre.Gender => ResGre.Number => ResGre.Case =>  Str =  \\g,n,c =>  case <g,n,c> of {
            <Masc| Change,Sg,Nom |Vocative> => "κανένας"; 
            <Masc| Change,Sg,Gen|CPrep P_Dat> => "κανενός" ; 
            <Masc| Change,Sg, Acc |CPrep P_se | CPrep PNul> => prepCase c ++ "κανέναν"  ; 
            <Fem,Sg,Nom |Vocative |Acc |CPrep P_se | CPrep PNul> => prepCase c ++ "καμία"; 
            <Fem,Sg,Gen|CPrep P_Dat > => "καμιάς" ; 
            <Neut,Sg,Nom |Vocative |Acc |CPrep P_se | CPrep PNul> =>  prepCase c ++"κανένα"; 
            <Neut,Sg,Gen|CPrep P_Dat > => "κανενός" ;
            <_,Pl,_> => " " }; 
          in {
              s = \\_ => kanenas ;
              sp = kanenas ;
              isNeg = True
              } ;

  not_Predet = let oxi : Number =>Gender=> Case =>  Str=  \\n,g,c =>  case <n,g,c> of {<_,_,_> => prepCase c ++ "όχι" }  in { s = oxi} ;
  if_then_Conj = {s1 = "αν" ; s2 = "τότε" ; n = Sg ; lock_Conj = <>} ;
  at_least_AdN = ss "τουλάχιστον" ;
  at_most_AdN = ss "το πολύ" ;
  nobody_NP = nppolNeg (mkDeterminer "κανένας" "κανενός" "κανέναν" "καμία" "καμιάς" "καμία" "κανένα" "κανενός" "κανένα" "κανένας" "κανενός" "κανέναν" Sg) ;
  nothing_NP = makeNP "τίποτα" Sg Neut True;
  except_Prep = mkPreposition "εκτός απο";
  as_CAdv = {s,s2="τόσο"; p="όσο"  ; c= Nom}  ;
  have_V2 = dirV2 (mkAux "έχω" "είχα" "έχε" "έχετε" "έχων" ** {lock_V = <>}) ;
  lin language_title_Utt = ss "Ελληνικά" ;

}

