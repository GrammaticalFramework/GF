--# -path=.:../scandinavian:../abstract:../../prelude

concrete SimpleSwe of Simple = CategoriesSwe ** SimpleI with
  (Categories = CategoriesSwe),
  (Rules = RulesSwe),
  (Structural = StructuralSwe),
  (Verbphrase = VerbphraseSwe)
  ;
