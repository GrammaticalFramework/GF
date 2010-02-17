concrete ExtensionEng of Extension = CatEng ** open MorphoEng, ResEng, ConjunctionEng, StructuralEng, Prelude, ParadigmsEng, Coordination,ParamBasic in {


lincat 
    PolSentence = {s : SentForm => Polarity => Str ; flag : Flag};
    [CN] = {s1,s2 : Number => Case => Str ; g : Gender} ;   
    StmtS = {s : Str};
lin 

VerbToNounV2 vs = VerbToNoun vs ** {c2 = vs.c2};

VerbToNoun v = {s = \\_,_ => v.s ! VPresPart;
                g = Masc};
                                
VerbToGerundA v = {s = \\_ => v.s ! VPresPart};              

VerbToParticipeA v = {s = \\_ => v.s ! VPPart};

mkPolSent cl = {s = \\f,b => case b of 
                              {Pos => cl.s ! Pres ! Simul ! CPos ! ODir;
                               _   => cl.s ! Pres ! Simul ! CNeg False ! ODir};
                flag = NothingS ;
                lock_PolSentence = <>};
               
sentToNoun ps = {s = \\_ => "\"" ++ ps.s ! Indep ! Pos ++ "\"";
                 a = agrP3 Sg};               
               
ConjCN conj ss = conjunctDistrTable2 Number Case conj ss ** {g = ss.g};               

BaseCN x y ={s1 = \\n,c => x.s ! n ! c ;
             s2 = \\n,c => y.s ! n ! c ;   
             g  =  x.g} ;  

ConsCN xs x = consrTable2 Number Case comma xs x ** {g = Masc} ;               


UsePolSentence p ps = {s = ps.s ! Indep ! p.p};

at_Prep = mkPrep "at" ;
per_Prep = mkPrep "per" ;  

O1 = {s = \\_ => "o1" ;
      a = agrP3 Sg};

O2 = {s = \\_ => "o2" ;
      a = agrP3 Sg};

O3 = {s = \\_ => "o3" ;
      a = agrP3 Sg};
      
O4 = {s = \\_ => "o4" ;
      a = agrP3 Sg};      
      
O5 = {s = \\_ => "o5" ;
      a = agrP3 Sg};      

     
} 