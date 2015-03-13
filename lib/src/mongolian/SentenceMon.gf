--# -path=.:../abstract:../common:../prelude

concrete SentenceMon of Sentence = CatMon ** open Prelude, ResMon in {

 flags optimize=all_subs ; coding=utf8 ;

lin

-- Clauses
 
 PredVP np vp = (mkClause np.s np.n vp.vt Nom vp) ;
 
 PredSCVP sc vp = (mkClause (\\_ => sc.s) Sg vp.vt Nom vp) ;

-- Imperatives

 ImpVP vp = {s = \\pol,f => 
    let 
     neg  = case pol of {
        Neg => (variants {"битгий" ; "бүү"}) ;
          _ => []
        } 
    in 
    case f of {
      ImpF n False => case n of {
        Sg => "чи" ++ neg ++ (vp.s ! VPImper pol False).fin ;
         _ => "та нар" ++ neg ++ (vp.s ! VPImper pol False).fin } ;
      ImpF _ True => "та" ++ neg ++ (vp.s ! VPImper pol True).fin
      }
    } ;
     
-- Clauses missing object noun phrases
    
 SlashVP np vp = (mkClause np.s np.n vp.vt Nom vp) ** {c2 = vp.c2} ;
 
 AdvSlash slash adv = {
  s = \\t,ant,pol,styp => slash.s ! t ! ant ! pol ! styp ++ adv.s ;
  c2 = slash.c2
  } ;
   
 SlashPrep cl prep = cl ** {c2 = prep} ;
  
 SlashVS np vs slash =  
        (mkClause np.s np.n vs.vt Nom
            (insertEmbedCompl (slash.s ++ "") (predV vs))) ** {c2 = slash.c2} ;

-- Sentences 

-- The particle "нь" is used often as a subject indicator. 
-- It sets off what precedes it as the subject (Hangin 1968:46).

 EmbedS s = {
    s = s.s ! Part Subject
    } ;
    
 EmbedQS qs = {
    s = qs.s ! QIndir ++ "гэдэг нь"
    } ;
    
 EmbedVP vp = {
    s = infVP vp Nom ++ "нь"
    } ;
    
 UseCl t p cl = {
    s = \\_ => t.s ++ p.s ++ cl.s ! t.t ! t.a ! p.p ! Part Subject
    } ;
    
 UseQCl t p cl = {
    s = \\q => t.s ++ p.s ++ cl.s ! t.t ! t.a ! p.p ! q
    } ;
    
 UseRCl t p rcl = {
    s = table {
	ComplSubj => t.s ++ p.s ++ rcl.s ! t.t ! t.a ! p.p ! (Part Subject) ;
    ComplObj => t.s ++ p.s ++ rcl.s ! t.t ! t.a ! p.p ! (Part Object) ; 
	ComplAdv => t.s ++ p.s ++ rcl.s ! t.t ! t.a ! p.p ! (Part Adverbiale) ;
	Attributive => t.s ++ p.s ++ rcl.s ! t.t ! t.a ! p.p ! (Part Rel) ;
	NoSubj => t.s ++ p.s ++ rcl.s ! t.t ! t.a ! p.p ! (Part emptySubject)
	} ;
	existSubject = rcl.existSubject
} ;
   
 UseSlash t p cl = {
    s = t.s ++ p.s ++ cl.s ! t.t ! t.a ! p.p ! Main ;
    c2 = cl.c2 
    } ;
  
-- An adverb can be added to the beginning of a sentence.

 AdvS a s = {
    s = \\_ => a.s ++ s.s ! Main
    } ;
 ExtAdvS a s = {s = \\stype => a.s ++ "," ++ s.s ! stype} ;
 
-- A sentence can be modified by a relative clause referring to its contents.

 RelS s rs = case rs.existSubject of {
    True => {s = \\_ => rs.s ! ComplSubj ++ s.s ! Main} ;
	False => {s = \\_ => rs.s ! NoSubj ++ s.s ! Main}
    } ;

-- Subjunctive clauses

 SSubjS xs subj ys = case subj.isPre of {
    True => {s = \\_ => subj.s ++ xs.s ! (Sub Condl) ++ ys.s ! Main} ;
	False => {s = \\_ => xs.s ! Main ++ subj.s ++ ys.s ! Main} 
    } ; 
 
}

