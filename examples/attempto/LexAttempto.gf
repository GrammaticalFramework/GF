interface LexAttempto = open Syntax in {

oper
  possible_A : A ;
  necessary_A : A ;
  own_A : A ;
  have_VV : VV ;
  provably_Adv : Adv ;
  provable_A : A ;
  false_A : A ;
  such_A : A ;

  genitiveNP : NP -> CN -> NP ;

--  m_Unit : Unit ;
--  l_Unit : Unit ;
--  kg_Unit : Unit ;

  each_Det : Det ;

}
