concrete NounMon of Noun = CatMon ** open ResMon, Prelude, ParadigmsMon, ExtraMon in {

 flags optimize=all_subs ; coding=utf8 ;

lin
 DetCN det cn = {
    s = \\rc => case <det.isPre,det.isDef> of {
                <True,True> => case rc of {
				Acc => det.s ++ cn.s ! Sg ! NAcc Definite ;
				_ => det.s ++ cn.s ! Sg ! toNCase rc Definite } ;
				<True,False> => case rc of {
				Acc => det.s ++ cn.s ! Sg ! NAcc Indefinite ;
				_ => det.s ++ cn.s ! Sg ! toNCase rc Indefinite } ;
	            _ => cn.s ! Sg ! NNom ++ det.sp ! rc 
                } ;
	n = Sg ;
	p = P3 ;
	isPron = False ;
	isDef = det.isDef
    } ;

 UsePron p = {
    s = \\rc => p.s ! PronCase rc ;
    n = p.n ;
	p = p.p ;
	isPron = True ;
	isDef = True
	} ;

 UsePN pn = {
    s = \\rc => pn.s ! rc ; 
    n = Sg ;
    p = P3 ;
    isPron = False ;
	isDef = True
	} ;

 PredetNP predet np = {
    s = \\rc => predet.s ++ np.s ! rc ;
    n = np.n ;
    p = np.p ;
    isPron = np.isPron ;
	isDef = predet.isDef
    } ;
	 
 PPartNP np v2 = {
    s = \\rc => v2.s ! VPART PPast Nom ++ np.s ! rc ;
    n = np.n ;
    p = np.p ;
    isPron = np.isPron ;
	isDef = np.isDef
    } ;
    
 RelNP np rs = { 
    s = \\rc => rs.s ! Attributive ++ np.s ! rc ;
    n = np.n ;
    p = np.p ;
    isPron = False ;
	isDef = np.isDef
    } ;

 AdvNP np adv = {
    s = \\rc => adv.s ++ np.s ! rc ;
    n = np.n ;
    p = np.p ;
    isPron = False ;
	isDef = np.isDef
    } ;
    
 DetQuant quant num = {
    s = quant.s ! Sg ++ num.s ;
    sp = \\rc => quant.sp ! num.n ! NNom ++ num.sp ! rc ;
    isNum = num.isNum ;
	isPoss = quant.isPoss ;
	isDef = True ;
    isPre = True
    } ;
     
 DetQuantOrd quant num ord = {
    s = quant.s ! Sg ++ num.s ++ ord.s ;
    sp = \\_ => quant.sp ! num.n ! NNom ++ num.s ++ ord.s ;
    isNum = num.isNum ;
	isPoss = quant.isPoss ;
	isDef = True ;
    isPre = True
    } ;
    
 DetNP det = {
    s = \\rc => det.sp ! rc ;
    n = Sg ;
    p = P3 ;
	isPron = False ;
	isDef = True
	} ;

 UseN,UseN2 = \noun -> {
    s = \\n,nc => noun.s ! SF n nc
    } ;
    
 PossPron p = {
    s = \\_ => p.s ! PronCase Gen ;
    sp = \\_,nc => p.s ! PronPoss (toRCase nc Definite) ; 
    isPoss = True ;
	isDef = True 
    } ;
   
 NumSg = {s = [] ; sp = \\_ => [] ; n = Sg ; isNum = False} ;
 NumPl = {s = [] ; sp = \\_ => [] ; n = Pl ; isNum = False} ;
 
 NumCard n = n ** {isNum = True} ;
 
 NumDigits,NumNumeral = \numeral -> {
    s = numeral.s ! NCard ;
    sp = \\_ => numeral.s ! NCard ;
    n = numeral.n 
    } ;
  
 OrdDigits, OrdNumeral = \d -> {s = d.s ! NOrd } ;
 
 AdNum a card = {
    s = a.s ++ card.s ;
    sp = \\rc => a.s ++ card.sp ! rc ;
    n = card.n 
    } ;
      
 OrdSuperl a = {
    s = (variants {"хамгийн"|"туйлын"} ++ a.s)
    } ;

-- Mongolian shows a complex system of marking definiteness. Demonstrative, anaphoric and possessive 
-- determiners are used to indicate definiteness. The definite noun phrases are obligatorily accusative 
-- case marked as direct objects. (http://www.ilg.uni-stuttgart.de/projekte/C2/publications/Guntsetseg.pdf)
 DefArt = {
    s = \\n => case n of {
        Sg => "энэ" ; 
        Pl => "эдгээр" 
        } ;
    sp = \\n,nc => case n of {
        Sg => case nc of {
		   NNom => "энэ" ;
           NInst => "үүгээр" ;
		   _ => (regN "үүн").s ! SF Sg nc
		   } ;
        Pl => (regN "эдгээр").s ! SF Sg nc 
		} ;
    isPoss = False ;
	isDef = True
    } ;
-- the numeral neg for ‘one’ in the function as an indefinite article (Givon 1981) 
 IndefArt = {
    s = \\n => case n of {
        Sg => "нэг" ;
        Pl => "нэжгээд"
        } ; 
    sp = \\n,nc => case n of {
	    Sg => (regN "аль нэг").s ! SF Sg nc ;
		Pl => (regN "нэжгээд").s ! SF Sg nc
		} ;
    isPoss = False ;
	isDef = False
    } ;
  
 MassNP cn = {
    s = \\rc => cn.s ! Sg ! (toNCase rc Definite) ;
    n = Sg ;
    p = P3 ;
    isPron = False ;
	isDef = True
    } ;

 Use2N3 n3 = {
    s = n3.s ;
    c2 = n3.c2
    } ;
	  
 Use3N3 n3 = {
    s = n3.s ;
    c2 = n3.c3
    } ;
	  
 ComplN2 n2 compl = {
    s = \\n,nc => appCompl n2.c2 compl.s ++ n2.s ! SF n nc
    } ;

 ComplN3 n3 compl = {
    s  = \\sf => appCompl n3.c2 compl.s ++ n3.s ! sf ;
    c2 = n3.c3
    } ;
  
 AdjCN ap cn = {
    s = \\n,nc => ap.s ++ cn.s ! n ! nc
    } ;
    
 RelCN cn rs = {
    s = \\n,nc => rs.s ! Attributive ++ cn.s ! n ! nc 
    } ;
    
 AdvCN cn adv = {
    s = \\n,nc => adv.s ++ cn.s ! n ! nc
	} ;
    
 SentCN cn s = {
    s = \\n,nc => s.s ++ cn.s ! n ! nc 
    } ;
    
 ApposCN cn np = {
    s = \\n,nc => np.s ! Nom ++ cn.s ! n ! nc
    } ;
    
}

