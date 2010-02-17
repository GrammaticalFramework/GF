--# -path=.:french:romance:abstract:prelude:common
concrete BasicFre of Basic = CatFre - [Text] ** open DictLangFre, CommonRomance, Prelude, ParamBasic,Coordination, ParamX, ResFre,ParadigmsFre in{

lincat 
 Class = CN ;
 El = NP ;
 Ind = NP ;
 Var = PN ;
 SubClass = {} ;
 SubClassC = {} ;
 Inherits = {} ;
 Desc = CN ;
 Formula = PolSentence;
 [El] = {s1,s2 : Case => Str ; a : Agr};
 [Class] = {s1,s2 : Number => Str ; g : Gender};
 Stmt = SS;

 lin 
BaseClass = {s1,s2 = \\_ => "";   
             g  =  Masc} ;
             
ConsClass xs x = consrTable Number comma xs x ** {g = x.g} ;   

BaseEl c = {s1,s2 = \\_ => "";
          a = agrP3 Masc Sg};   

ConsEl cl x xs = {
      s1 = \\c => (x.s ! c).comp ++ comma ++ xs.s1 ! c ;  
      s2 = \\c => xs.s2 ! c ;  
      a = conjAgr x.a xs.a 
      } ;
       
and f1 f2 = {s = \\f,c => f1.s ! Indep ! c ++ "et" ++ f2.s ! Indep ! c; flag = NothingS; lock_PolSentence = <>};
or f1 f2 = {s = \\f,c => f1.s ! Indep ! c ++ "ou" ++ f2.s ! Indep ! c; flag = NothingS; lock_PolSentence = <>};
not f1 = {s = \\f,c => case c of 
                        {Pos => f1.s ! Indep ! Neg ; 
                         _   => f1.s ! Indep ! Pos };
         flag = NothingS; lock_PolSentence = <>};
impl f1 f2 = {s = \\f,c => "si" ++ f1.s ! Indep ! c ++ "alors" ++ f2.s ! Indep ! c; flag = NothingS; lock_PolSentence = <>};
equiv f1 f2 = {s = \\f,c => f1.s ! Indep ! c ++ "est" ++ "equivalent" ++ "à" ++ f2.s ! Indep ! c; flag = NothingS;
               lock_PolSentence = <>};

               
var c1 c2 i e = let np = UsePN e in
               {s = np.s;
                a = agrP3 c1.g Sg;
                hasClit = False; lock_NP = <>};               
               
el c1 c2 i e = e ; 

exists C f = let np = DetCN (DetQuant IndefArt NumSg) C ; 
                 tel = case C.g of
                           {Masc => "tel";
                            _    => "telle"
                           }
                 in 
                {s = \\form,c => case <form, f.flag> of 
                           { <Indep, ExistS _> => "il" ++ "existe" ++ (np.s ! Nom).comp ++ f.$0 ++ f.s ! Attrib ! c ;
                            <Attrib, ExistS One> => "et" ++ (np.s ! Nom).comp ++ f.$0 ++ f.s ! Attrib ! c ;
                            <Attrib, ExistS _> => "," ++ (np.s ! Nom).comp ++ f.$0 ++ f.s ! Attrib ! c ;
                            <Indep,_> => "il" ++ "existe" ++ (np.s ! Nom).comp ++ f.$0 ++ tel ++ "que" ++ f.s ! Indep ! c ; 
                             _      => "et" ++ (np.s ! Nom).comp ++ f.$0 ++ tel ++ "que" ++ f.s ! Indep ! c }; 
              flag = case f.flag of 
                       {ExistS _   => ExistS Many;
                        _        => ExistS One };
              lock_PolSentence=<>};
                         
forall C f = {s = \\form, c => case <form,f.flag> of
                         {<Indep,ForallS _> => "pour" ++ "chaque" ++ C.s ! Sg  ++ f.$0 ++  f.s ! Attrib ! c ;
                          <Attrib,ForallS One> => "," ++ "chaque" ++ C.s ! Sg  ++ f.$0 ++ f.s ! Attrib ! c ;
                          <Attrib, ForallS _> => "," ++ "chaque" ++ C.s ! Sg ++ f.$0 ++ f.s ! Attrib ! c ; 
                          <Indep,ExistS _> => "pour" ++"chaque"++ C.s ! Sg ++ f.$0 ++ f.s ! Indep ! c ;
                          <Indep,_> => "pour" ++"chaque"++ C.s ! Sg ++ f.$0 ++ "il"++ "y" ++ "a" ++ "que" ++ f.s ! Indep ! c ;
                          <Attrib,ExistS _> => "et" ++ "chaque" ++ C.s ! Sg ++ f.$0 ++ f.s ! Indep ! c;
                          _ => "and" ++ "every" ++ C.s ! Sg ++ f.$0 ++ "il" ++ "y" ++ "a" ++ "que" ++f.s ! Indep ! c             };                         
              flag = case f.flag of 
                        {ForallS _   => ForallS Many;
                         _         => ForallS One };
              lock_PolSentence=<>};                 
              
         

both c1 c2 = {s = \\n => c1.s ! n ++ "et" ++ c2.s ! n;
             g = c2.g; lock_CN = <>};

         
either c1 c2 = {s = \\n => c1.s ! n ++ "ou" ++ c2.s ! n;
                g = c2.g; lock_CN = <>};         

desc c1 c2 i = c2 ;
descClass c dc = c;                
desc2desc c1 c2 i d = d;                

subClassStm c1 c2 sc = ss (c1. s ! Sg ++ "est" ++ "une" ++ "sous-classe" ++ "de" ++ c2.s ! Sg) ;
instStm c i = ss ((i.s ! Nom).comp ++ "est" ++ "une" ++ "instance" ++ "de" ++ c.s ! Sg) ;
formStm f = ss (f.s ! Indep ! Pos) ;
subClassCStm c1 c2 constr sc= ss (c1.s ! Sg  ++ "est" ++ "une" ++ "sous-classe" ++ "de" ++ c2.s ! Sg ++ "avec" ++ constr.s ! Indep ! Pos) ;
 

-- lindef 

lindef Ind =  \x -> heavyNP {s = \\_ => x ; a = agrP3 Masc Sg} ;
                    
lindef El = \x -> heavyNP {s = \\_ => x ; a = agrP3 Masc Sg} ;
                    
lindef Class = \x -> {s = \\n => x;
                      g = Masc; lock_CN =<>}; 
                  
 };