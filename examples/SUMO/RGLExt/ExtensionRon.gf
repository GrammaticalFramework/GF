concrete ExtensionRon of Extension = CatRon ** open MorphoRon, ResRon, ConjunctionRon, StructuralRon, Prelude, Coordination,ParamBasic, ParadigmsRon, NounRon in {


lincat 
    PolSentence = {s : SentForm => Polarity => Str ; flag : Flag};
    [CN] = {s1,s2 : Number => Species => ACase => Str; g : NGender; a : Animacy ; isComp : Bool} ;   
    StmtS = {s : Str};
lin 

VerbToNounV2 v2 = VerbToNoun v2 ** {c2 = v2.c2};


VerbToNoun vp = { s = \\n,sp,c => vp.s ! PPasse Masc n sp c ; 
                 g = NNeut ; a = Inanimate };         


VerbToGerundA vp = {s = \\af => vp.s ! Ger; 
                isPre = False
                };                  
              
VerbToParticipeA v = {s = \\af => case af of 
                     {AF g n sp c => v.s ! PPasse g n sp c;
                      AA => v.s ! PPasse Masc Sg Indef ANomAcc
                      };
                  isPre = False
                  };

mkPolSent cl = {s = \\f,b => cl.s ! DDir ! RPres ! Simul ! b ! Indic ;
                flag = NothingS ;
                lock_PolSentence = <>
               };
               
sentToNoun ps = heavyNP {s = \\_ => "\"" ++ ps.s ! Indep ! Pos ++ "\"";
                         a = agrP3 Masc Sg; hasClit = HasClit ; isComp = True ;
                         ss = "\"" ++ ps.s ! Indep ! Pos ++ "\""
                        };               
               
ConjCN conj ss = conjunctDistrTable3 Number Species ACase conj ss ** {
                g = ss.g; a = ss.a; isComp = ss.isComp; needsRefForm = False                
                };               


BaseCN x y ={
      s1 = \\n,sp,c => x.s ! n ! sp ! c ;
      s2 = \\n,sp,c => y.s ! n ! sp ! c ;   
      g  =  x.g; a = x.a ; isComp = x.isComp;
      needsRefForm = False};  

ConsCN xs x = consrTable3 Number Species ACase comma xs x ** {g = x.g; a = x.a; isComp = x.isComp; needsRefForm = False} ;               

at_Prep = mkPrep "la" Ac True;
per_Prep = mkPrep "per" Ac True;  

UsePolSentence p ps = {s = ps.s ! Indep ! p.p};

O1 = UsePN (mkPN "o1") ;    
O2 = UsePN (mkPN "o2") ; 
O3 = UsePN (mkPN "o3") ;      
O4 = UsePN (mkPN "o4") ;        
O5 = UsePN (mkPN "o5") ;
            
} 