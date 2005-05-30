--# -path=dialogue:resource/*:prelude

concrete DialogueEng of Dialogue = DialogueI with
  (Resource = ResourceEng),
  (Basic = BasicEng),
  (DialogueParam = DialogueParamEng) ;
