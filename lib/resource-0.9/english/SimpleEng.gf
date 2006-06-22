--# -path=.:../abstract:../../prelude

concrete SimpleEng of Simple = CategoriesEng ** SimpleI with
  (Categories = CategoriesEng),
  (Rules = RulesEng),
  (Structural = StructuralEng),
  (Verbphrase = VerbphraseEng)
  ;
