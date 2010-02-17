--# -path=.:../romance:../common:../abstract:../prelude:
concrete ExtensionFre of Extension = CatFre ** open MorphoFre, Prelude, Coordination,ParamBasic, ResFre, GrammarFre, ParadigmsFre in {


lincat 
    PolSentence = {s : SentForm => Polarity => Str ; flag : Flag};
    [CN] = {s1,s2 : Number => Str ; g : Gender} ;  
    SS = {s : Str};
   
    

lin 

VerbToNoun v = {s = \\_ => v.s ! (VInfin True);
                g = Masc};

VerbToNounV2 v2 = VerbToNoun v2 ** {c2 = v2.c2};

VerbToGerundA v = {s = \\_,af => case af of
                              {AF g n => v.s ! VGer; -- need more data for feminine and plural forms 
                               AA     => "en" ++ v.s ! VGer  
                              };
                   isPre = False};

VerbToParticipeA v = {s = \\_,af => case af of 
                              {AF g n => v.s ! (VPart g n);
                               AA     => "en" ++ v.s ! VGer
                              }; 
                      isPre = False} ;  

mkPolSent cl = {s = \\f,b => cl.s ! DDir ! RPres ! Simul ! b ! Indic ;
                flag = NothingS ;
                lock_PolSentence = <>
               };                      

sentToNoun ps = heavyNP {s = \\_ => "\"" ++ ps.s ! Indep ! Pos ++ "\"";
                         a = agrP3 Masc Sg
                        };     

at_Prep = mkPreposition "à" ;
per_Prep = mkPreposition "per" ;                                    
                         
ConjCN conj ss = conjunctDistrTable Number conj ss ** {
                g = ss.g                
                };               

BaseCN x y ={
      s1 = \\n => x.s ! n ;
      s2 = \\n => y.s ! n ;   
      g  =  x.g};  

ConsCN xs x = consrTable Number comma xs x ** {g = x.g} ;
               
UsePolSentence p ps = {s = ps.s ! Indep ! p.p};

O1 = UsePN (mkPN "o1") ; 
O2 = UsePN (mkPN "o2") ; 
O3 = UsePN (mkPN "o3") ;      
O4 = UsePN (mkPN "o4") ;       
O5 = UsePN (mkPN "o5") ;
           
 
            
} 