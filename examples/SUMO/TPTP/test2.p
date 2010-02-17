include('TPTP/MergeAx.p').
include('TPTP/Mid_level_ontologyAx.p').
 
fof (conj2, conjecture,
   ( ! [X] : 
   (hasType(type_AnimacyAttribute, X) => hasType(type_Attribute, X)))). 