--# -path=.:englishExtended:abstract:common:
concrete BasicEng of Basic = CatEng - [Text] ** open DictLangEng, DictEng, ParadigmsEng, ResEng, Coordination, Prelude, ParamBasic, NounEng in {

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
  [El] = [NP];
  [Class] = [CN];
  Stmt = StmtS ;

lin 
  BaseClass = {s1,s2 = \\_,_ => "";   
               g  =  Neutr;
               lock_ListCN=<>};  
  ConsClass xs x = ConsCN xs x ;   
  
  BaseEl c = {s1,s2 = \\_ => "";
              a = agrP3 Sg;
              lock_ListNP=<>};
         
  ConsEl c xs x = ConsNP xs x ;     

  and f1 f2 = {s = \\f,c => f1.s ! Indep ! c ++ "and" ++ f2.s ! Indep ! c; flag = NothingS; lock_PolSentence = <>};
  or f1 f2 = {s = \\f,c => f1.s ! Indep ! c ++ "or" ++ f2.s ! Indep ! c; flag = NothingS; lock_PolSentence = <>};
  not f1 = {s = \\f => table {
                         Neg  => "it is not true that" ++ f1.s ! f ! Neg ; 
                         Pos  => f1.s ! Indep ! Neg
                       }; 
            flag = f1.flag;  
            lock_PolSentence = <>
           };
  impl f1 f2 = {s = \\f,c => "if" ++ f1.s ! Indep ! c ++ "then" ++ f2.s ! Indep ! c; flag = NothingS; lock_PolSentence = <>};

  equiv f1 f2 = {s = \\f,c => f1.s ! Indep ! c ++ "is" ++ "equivalent" ++ "to" ++ f2.s ! Indep ! c; flag = NothingS;
                 lock_PolSentence = <>};

  el c1 c2 i e = e; 
  var c1 c2 i e = UsePN e;

  exists C f = let np = DetCN (DetQuant IndefArt NumSg) C 
               in { s = \\form,c => case <form, f.flag> of {
                                      <Indep, ExistS _>    => "there" ++ "exists" ++ np.s ! Nom ++ f.$0 ++ f.s ! Attrib ! c ;
                                      <Attrib, ExistS One> => "and" ++ np.s ! Nom ++ f.$0 ++ f.s ! Attrib ! c ;
                                      <Attrib, ExistS _>   => "," ++ np.s ! Nom ++ f.$0 ++ f.s ! Attrib ! c ;
                                      <Indep,_>            => "there" ++ "exists" ++ np.s ! Nom ++ f.$0 ++ "such" ++ "that" ++ f.s ! Indep ! c ; 
                                      _                    => "and" ++ np.s ! Nom ++ f.$0 ++ "such" ++ "that" ++ f.s ! Indep ! c
                                    }; 
                    flag = case f.flag of {
                             ExistS _   => ExistS Many;
                             _        => ExistS One
                           };
                    lock_PolSentence=<>
                  };
              
  forall C f = { s = \\form, c => case <form,f.flag> of {
                                    <Indep,ForallS _>    => "for" ++ "every" ++ C.s ! Sg ! Nom ++ f.$0 ++  f.s ! Attrib ! c ;
                                    <Attrib,ForallS One> => "," ++ "every" ++ C.s ! Sg ! Nom ++ f.$0 ++ f.s ! Attrib ! c ;
                                    <Attrib, ForallS _>  => "," ++ "every" ++ C.s ! Sg ! Nom ++ f.$0 ++ f.s ! Attrib ! c ; 
                                    <Indep,ExistS _>     => "for" ++"every"++ C.s ! Sg ! Nom ++ f.$0 ++ f.s ! Indep ! c ;
                                    <Indep,_>            => "for" ++"every"++ C.s ! Sg ! Nom ++ f.$0 ++ "we"++"have" ++ "that" ++ f.s ! Indep ! c ;
                                    <Attrib,ExistS _>    => "and" ++ "every" ++ C.s ! Sg ! Nom ++ f.$0 ++ f.s ! Indep ! c;
                                     _                    => "and" ++ "every" ++ C.s ! Sg ! Nom ++ f.$0 ++ "we" ++ "have" ++ "that" ++f.s ! Indep ! c             };                         
                 flag = case f.flag of {
                          ForallS _   => ForallS Many;
                          _           => ForallS One
                        };
                 lock_PolSentence=<>
               };
 
  both c1 c2 = { s = \\c,n => c1.s ! c ! n ++ "and" ++ c2.s ! c ! n;
                 g = c2.g; lock_CN = <>
               };

  either c1 c2 = { s = \\c,n => c1.s ! c ! n ++ "or" ++ c2.s ! c ! n;
                   g = c2.g; lock_CN = <>
                 };

  KappaFn c ob2 = ApposCN (AdvCN (AdvCN (UseN class_N) (PrepNP part_Prep (DetCN (DetQuant IndefArt NumPl) c))) where_Adv) (sentToNoun ob2) ;

  desc c1 c2 i = c2 ;
  descClass c dc = c;                
  desc2desc c1 c2 i d = d;                

  subClassStm c1 c2 sc = lin StmtS (ss (c1. s ! Sg ! Nom ++ "is a subclass of" ++ c2.s ! Sg ! Nom)) ;
  instStm c i = lin StmtS (ss (i.s ! Nom ++ "is an instance of" ++ c.s ! Sg ! Nom)) ;
  formStm f = lin StmtS (ss (f.s ! Indep ! Pos)) ;

lindef
  Ind = \x -> {s = \\_ => x; a = agrP3 Sg; lock_NP = <>} ;
  El = \x -> {s = \\_ => x; a = agrP3 Sg; lock_NP = <>} ; 
  Class = \x -> {s = \\_,_ => x; g = Neutr; lock_CN =<>};         

};
