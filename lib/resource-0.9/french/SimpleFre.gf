--# -path=.:../romancs:../abstract:../../prelude

concrete SimpleFre of Simple = CategoriesFre ** SimpleI with
  (Categories = CategoriesFre),
  (Rules = RulesFre),
  (Structural = StructuralFre),
  (Verbphrase = VerbphraseFre)
  ;
