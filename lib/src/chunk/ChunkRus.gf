concrete ChunkRus of Chunk = CatRus, ExtensionsRus [VPS,VPI] ** 
  ChunkFunctor - [
     CN_Pl_Chunk, CN_Sg_Chunk, Conj_Chunk, IP_Chunk, Numeral_Nom_Chunk, Predet_Chunk, Prep_Chunk, VPS_Chunk, UseVC, emptyNP
    ] 
    with (Syntax = SyntaxRus), (Extensions = ExtensionsRus) **
  open 
    SyntaxRus, (E = ExtensionsRus), Prelude, 
    ResRus, (P = ParadigmsRus) in {

lin VPI_Chunk vpi = {s = vpi.s} ;
lin CN_Pl_Chunk, CN_Pl_Gen_Chunk = \cn -> {s = cn.nounpart ! NF Pl allCases allSizes ++ cn.relcl ! Pl ! allCases} ;
lin CN_Sg_Chunk, CN_Sg_Gen_Chunk = \cn -> {s = cn.nounpart ! NF Sg allCases allSizes ++ cn.relcl ! Sg ! allCases} ;
lin Conj_Chunk c = {s = c.s1 | c.s2 };
lin IP_Chunk ip = {s = ip.s ! (PF allCases allAfterPrep allPossessive)};
lin Predet_Chunk predet = {s = predet.s ! AF allCases allAnimacy allGenNum};
lin Numeral_Nom_Chunk, Numeral_Gen_Chunk = \num -> {s = num.s ! allGender ! allAnimacy ! allCases };
lin Prep_Chunk prep = { s = prep.s };

lin NP_Acc_Chunk np = { s = np.s ! PF Acc allAfterPrep allPossessive } ;
lin NP_Gen_Chunk np = { s = np.s ! PF Acc allAfterPrep allPossessive } ;

oper
  emptyNP : NP = lin NP {s = \\_ => ""; n = allNumber; p = allPerson; g=PNoGen; anim = allAnimacy; pron=False} ;

lin refl_SgP1_Chunk, refl_SgP2_Chunk, refl_SgP3_Chunk, refl_PlP1_Chunk,
    refl_PlP2_Chunk, refl_PlP3_Chunk =
       {s = sam.s ! allCases}; 

lin neg_Chunk = variants {};

lin copula_Chunk = { s = "является" | "являются" | "являешься" | "являемся" | "являемся" | "являетесь"} ;
lin copula_neg_Chunk = { s = "не является" | "не являются" | "не являешься" | "не являемся" | "не являемся" | "не являетесь"} ;
lin copula_inf_Chunk = variants {} ;
lin past_copula_Chunk = { s = "был" | "были" | "была" | "было" } ;
lin past_copula_neg_Chunk = { s = "не был" | "не были" | "не была" | "не было" } ;
lin future_Chunk = { s = "буду" | "будем" | "будешь" | "будете" | "будет" | "будут" } ;
lin future_neg_Chunk = { s = "не буду" | "не будем" | "не будешь" | "не будете" | "не будет" | "не будут" } ;
lin cond_Chunk = variants {} ;
lin cond_neg_Chunk = variants {} ;
lin perfect_Chunk = variants {} ;
lin perfect_neg_Chunk = variants {} ;
lin past_perfect_Chunk = variants {} ;
lin past_perfect_neg_Chunk = variants {} ;

oper
  allGender  = Masc | Fem | Neut ;
  allCases   = Nom | Gen | Dat | Acc | Inst | Prepos PrepOther ;
  allQForm   = QDir | QIndir ;
  allAnimacy = Animate | Inanimate ;
  allGenNum  = GSg allGender | GPl ;
  allNumber  = Sg | Pl ;
  allPerson  = P1 | P2 | P3 ;
  allSizes   = nom | nompl | sgg | plg ;
  allAfterPrep = Yes | No ;
  allPossessive = NonPoss | Poss (GSg allGender | GPl) ;

}
