--# -path=.:romanian:abstract:prelude:common
concrete BasicRon of Basic = CatRon - [Text] ** open DictLangRon,ResRon, Prelude, ParamBasic,Coordination, ParadigmsRon in{
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
 Stmt = StmtS ;
 [El] = {s1,s2 : NCase => Str ; a : Agr; nForm : NForm};
 [Class] = {s1,s2 : Number => Species => ACase => Str; g : NGender; a : Animacy ; isComp : Bool};
 
 lin 
BaseClass = {s1,s2 = \\_,_,_ => "";   
             g  =  NNeut; a = Inanimate; isComp = False} ;
             
ConsClass xs x = consrTable3 Number Species ACase comma xs x ** {g = x.g; a = x.a; isComp = x.isComp} ;   
   
 
BaseEl c = {s1,s2 = \\_ => "";
          a = agrP3 Masc Sg; nForm = HasRef False};   
 
ConsEl cl x xs = {
      s1 = \\c => (x.s ! c).comp ++ comma ++ xs.s1 ! c ;  
      s2 = \\c => xs.s2 ! c ;  
      a = conjAgr x.a xs.a ;
      nForm = case x.nForm of 
                  {HasClit => xs.nForm ;
                   _       => HasRef False}
      } ;

 
and f1 f2 = {s = \\f,c => f1.s ! Indep ! c ++ "şi" ++ f2.s ! Indep ! c; flag = NothingS; lock_PolSentence = <>};
or f1 f2 = {s = \\f,c => f1.s ! Indep ! c ++ "sau" ++ f2.s ! Indep ! c; flag = NothingS; lock_PolSentence = <>};
not f1 = {s = \\f,c => case c of 
                        {Pos => f1.s ! Indep ! Neg ; 
                         _   => f1.s ! Indep ! Pos };
         flag = NothingS; lock_PolSentence = <>};
impl f1 f2 = {s = \\f,c => f1.s ! Indep ! c ++ "implică" ++ f2.s ! Indep ! c; flag = NothingS; lock_PolSentence = <>};
equiv f1 f2 = {s = \\f,c => f1.s ! Indep ! c ++ "este" ++ "echivalent" ++ "cu" ++ f2.s ! Indep ! c; flag = NothingS;
               lock_PolSentence = <>};

el c1 c2 i e = e ; 
 
var c1 c2 i e = let np = UsePN e in
               {s = np.s;
                a = agrP3 (agrGender c1.g Sg) Sg; indForm = np.indForm ;
                nForm = np.nForm; ss = np.ss; isComp = np.isComp ; isPronoun = False;
                lock_NP = <>}; 
           
exists C f = let np = DetCN (DetQuant IndefArt NumSg) C 
                 in 
                {s = \\form,c => case <form, f.flag> of 
                           { <Indep, ExistS _> => "există" ++ (np.s ! No).comp ++ f.$0 ++ f.s ! Attrib ! c ;
                            <Attrib, ExistS One> => "şi" ++ (np.s ! No).comp ++ f.$0 ++ f.s ! Attrib ! c ;
                            <Attrib, ExistS _> => "," ++ (np.s ! No).comp ++ f.$0 ++ f.s ! Attrib ! c ;
                            <Indep,_> => "există" ++ (np.s ! No).comp ++ f.$0 ++ "astfel" ++ "ca" ++ f.s ! Indep ! Pos ; 
                             _      => "şi" ++ (np.s ! No).comp ++ f.$0 ++ "astfel" ++ "ca" ++ f.s ! Indep ! Pos }; 
              flag = case f.flag of 
                       {ExistS _   => ExistS Many;
                        _        => ExistS One };
              lock_PolSentence=<>};
                        
              
              
forall C f = {s = \\form, c => case <form,f.flag> of
                         {<Indep,ForallS _> => "pentru" ++ "orice" ++ C.s ! Sg ! Indef ! ANomAcc ++ f.$0 ++  f.s ! Attrib ! c ;
                          <Attrib,ForallS One > => "şi" ++ "orice" ++ C.s ! Sg ! Indef ! ANomAcc ++ f.$0 ++ f.s ! Attrib ! c ;
                          <Attrib, ForallS _> => "," ++ "orice" ++ C.s ! Sg ! Indef ! ANomAcc ++ f.$0 ++ f.s ! Attrib ! c ;
                          <Indep,ExistS _> => "pentru" ++"orice"++ C.s ! Sg ! Indef ! ANomAcc ++ f.$0 ++ f.s ! Indep ! c ;
                          <Indep,_> => "pentru" ++"orice"++ C.s ! Sg ! Indef ! ANomAcc ++ f.$0 ++ "avem" ++ "că" ++ f.s ! Indep ! c ;
                          <Attrib,ExistS _> => "şi" ++ "orice" ++ C.s ! Sg ! Indef ! ANomAcc ++ f.$0 ++ f.s ! Indep ! c;
                          _ => "şi" ++ "orice" ++ C.s ! Sg ! Indef ! ANomAcc ++ f.$0 ++ "avem" ++ "că" ++f.s ! Indep ! c             };                         
              flag = case f.flag of 
                        {ForallS _   => ForallS Many;
                         _         => ForallS One };
              lock_PolSentence=<>};              
 
both c1 c2 = {s = \\c,sp,n => c1.s ! c ! sp ! n ++ "şi" ++ c2.s ! c ! sp ! n;
             g = c2.g; a = case c1.a of 
                            {Inanimate => Inanimate;
                             _         => c2.a };                            
             isComp = orB c1.isComp c2.isComp; lock_CN = <>};

         
either c1 c2 = {s = \\c,sp,n => c1.s ! c ! sp ! n ++ "sau" ++ c2.s ! c ! sp ! n;
                g = c2.g; a = case c1.a of 
                             {Inanimate => Inanimate;
                              _         => c2.a };
                isComp = orB c1.isComp c2.isComp; lock_CN = <>};         
                
subClassStm c1 c2 sc = ss (c1. s ! Sg ! Def ! ANomAcc ++ "este" ++ "o" ++ "subclasã" ++ "a" ++ c2.s ! Sg ! Def ! AGenDat) ;
instStm c i = ss ((i.s ! No).comp ++ "este" ++ "o" ++ "instanþiere" ++ "a" ++ c.s ! Sg ! Def ! AGenDat) ;
formStm f = ss (f.s ! Indep ! Pos) ;
subClassCStm c1 c2 constr sc= ss (c1.s ! Sg ! Def ! ANomAcc ++ "este" ++ "o" ++ "subclasã" ++ "a" ++ c2.s ! Sg ! Def ! AGenDat ++ "unde" ++ constr.s ! Indep ! Pos) ;
                
                
desc c1 c2 i = c2 ;
descClass c dc = c;                
desc2desc c1 c2 i d = d;                
-- lindef 

lindef Ind = \x -> mkNP x ("lui" ++ x) x Sg Masc;
                    
lindef El = \x -> mkNP x ("lui" ++ x) x Sg Masc; 
                    
lindef Class = \x -> {s = \\n,sp,c => case c of 
                                  {AGenDat => "lui" ++ x ;
                                   _       => x};
                      g = NMasc; a = Animate; isComp=False; lock_CN =<>}; 
                   
 };