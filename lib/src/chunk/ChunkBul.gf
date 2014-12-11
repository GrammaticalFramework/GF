concrete ChunkBul of Chunk = CatBul, ExtensionsBul [VPS,VPI] ** 
  ChunkFunctor - [
     CN_Pl_Chunk, CN_Sg_Chunk, Conj_Chunk, IAdv_Chunk, IP_Chunk, Numeral_Nom_Chunk, SSlash_Chunk, Predet_Chunk, 
     emptyNP, Prep_Chunk
    ] 
    with (Syntax = SyntaxBul), (Extensions = ExtensionsBul) **
  open 
    SyntaxBul, (E = ExtensionsBul), Prelude, 
    ResBul, MorphoFunsBul, (P = ParadigmsBul) in {

lin VPI_Chunk vpi = {s = vpi.s ! {gn = GSg allGender ; p = P3}} ;

lin CN_Pl_Chunk, CN_Pl_Gen_Chunk = \cn -> {s = cn.s ! (NF Pl allSpecies | NFPlCount)} ;
lin CN_Sg_Chunk, CN_Sg_Gen_Chunk = \cn -> {s = cn.s ! (NF Sg allSpecies | NFSgDefNom)} ;
lin Conj_Chunk c = {s = c.s ++ linCoord ! c.conj};
lin IAdv_Chunk iadv = {s = iadv.s ! allQForm};
lin IP_Chunk ip = {s = ip.s ! (RSubj | RObj allCases | RVoc) ! allQForm};
lin Predet_Chunk predet = {s = predet.s ! allGenNum};
lin Numeral_Nom_Chunk, Numeral_Gen_Chunk = \num -> {s = num.s ! NCard allCardForm};
lin Prep_Chunk prep = prep;

lin NP_Acc_Chunk np = {s = np.s ! RObj allCases};
lin NP_Gen_Chunk np = {s = np.s ! RSubj};

oper
  emptyNP : NP = SyntaxBul.mkNP (P.mkPN [] Masc) ;


lin refl_SgP1_Chunk, refl_SgP2_Chunk, refl_SgP3_Chunk, refl_PlP1_Chunk,
    refl_PlP2_Chunk, refl_PlP3_Chunk =
       {s = reflClitics ! allCases}; 

lin neg_Chunk = {s = "не"};

lin copula_Chunk = {s = auxBe ! VPres allNumber allPerson};
lin copula_neg_Chunk = {s = "не" ++ auxBe ! VPres allNumber allPerson};
lin copula_inf_Chunk = {s = auxWould ! VPres allNumber allPerson};
lin past_copula_Chunk = {s = auxBe ! VAorist allNumber allPerson};
lin past_copula_neg_Chunk = {s = "не" ++ auxBe ! VAorist allNumber allPerson};
lin future_Chunk = {s = "ще"};
lin future_neg_Chunk = {s = "не ще"};
lin cond_Chunk = {s = auxWould ! VAorist allNumber allPerson} ;
lin cond_neg_Chunk = {s = "не" ++ auxWould ! VAorist allNumber allPerson} ;
lin perfect_Chunk = {s = "*"} ;
lin perfect_neg_Chunk = {s = "не" ++ "*"} ;
lin past_perfect_Chunk = {s = "*"} ;
lin past_perfect_neg_Chunk = {s = "не" ++ "*"} ;
lin SSlash_Chunk s = mkUtt <lin S {s = s.s ! agrP3 (GSg Masc) ++ s.c2.s} : S> ;

oper
  allAForm
    = ASg allGender allSpecies
    | ASgMascDefNom
    | APl allSpecies ;
  allGender = Masc | Fem | Neut ;
  allSpecies = Indef | Def ;
  allCases = Acc | Dat ;
  allQForm = QDir | QIndir ;
  allAnimacy = Human | NonHuman ;
  allCardForm =
       CFMasc allSpecies allAnimacy
     | CFMascDefNom   allAnimacy
     | CFFem  allSpecies
     | CFNeut allSpecies ;
  allGenNum = GSg allGender | GPl ;
  allNumber = Sg | Pl ;
  allPerson = P1 | P2 | P3 ;

}