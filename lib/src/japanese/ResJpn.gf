resource ResJpn = open Prelude in {

flags coding = utf8 ;

param
  Number      = Sg | Pl ;
  Style       = Plain | Resp ;
  Animateness = Anim | Inanim ;
  Mood        = Ind | Con ;
  TTense      = TPres | TPast | TFut ;
  Polarity    = Pos | Neg ;
  VerbGroup   = Gr1 | Gr2 | Suru | Kuru ;
  ModSense    = Abil | Oblig | Wish ;
  Speaker     = Me | SomeoneElse ;
  Particle    = Wa | Ga ;
  Anteriority = Simul | Anter ;
  NumeralType = EndZero | EndNotZero | SingleDigit ;
  DTail       = T1 | T2 | T3 ;
  ConjType    = And | Or | Both ;
  SubjType    = That | If | OtherSubj ;
  VocType     = VocPres | Please | VocAbs ;
  UttType     = Imper | ImpPolite | NoImp ;

oper

  NP          : Type = {s : Style => Str ; prepositive : Style => Str ; needPart : Bool ; 
                        changePolar : Bool ; meaning : Speaker ; anim : Animateness} ;
  VP          : Type = {verb : Speaker => Animateness => Style => TTense => Polarity => Str ; 
                        a_stem, i_stem : Speaker => Animateness => Style => Str ; 
                        te, ba : Speaker => Animateness => Style => Polarity => Str ;
                        prep : Str ; obj : Style => Str ; prepositive : Style => Str ;
                        needSubject : Bool} ;
                        
  Noun        : Type = {s : Number => Style => Str ; anim : Animateness ; 
                        counter : Str ; counterReplace : Bool ; counterTsu : Bool} ;
  PropNoun    : Type = {s : Style => Str ; anim : Animateness} ;
  Adj         : Type = {pred : Style => TTense => Polarity => Str ; attr, dropNaEnging : Str ;
                        te, ba, adv : Polarity => Str} ; 
  Adj2        : Type = {pred : Style => TTense => Polarity => Str ; attr, dropNaEnging,  
                        prep : Str ; te, ba, adv : Polarity => Str} ; 
  Adverb      : Type = {s : Style => Str ; prepositive : Bool} ;
  Pronoun     : Type = {s : Style => Str ; Pron1Sg : Bool ; anim : Animateness} ;
  Determiner  : Type = {quant : Style => Str ; postpositive : Str ; num : Str ; n : Number ; 
                        inclCard : Bool ; sp : Style => Str ; no : Bool ; tenPlus : Bool} ;
  Num         : Type = {s : Str ; postpositive : Str ; n : Number ; inclCard : Bool ; 
                        tenPlus : Bool} ;
  Preposition : Type = {s : Str ; null : Str} ;
  Verb        : Type = {s : Style => TTense => Polarity => Str ; a_stem, i_stem : Str ; 
                        te, ba : Polarity => Str ; needSubject : Bool} ;
  Verb2       : Type = {s, pass : Style => TTense => Polarity => Str ; a_stem, i_stem, pass_a_stem, 
                        pass_i_stem, prep : Str ; te, ba, pass_te, pass_ba : Polarity => Str} ;
  Verb3       : Type = {s : Speaker => Style => TTense => Polarity => Str ; a_stem, i_stem : 
                        Speaker => Str ; te, ba : Speaker => Polarity => Str ; prep1, prep2 : Str} ;
  VV          : Type = {s : Speaker => Style => TTense => Polarity => Str ; a_stem, i_stem : 
                        Speaker => Str ; te, ba : Speaker => Polarity => Str ; sense : ModSense} ;
  Conjunction : Type = {s : Str ; null : Str ; type : ConjType} ;
  Subjunction : Type = {s : Str ; type : SubjType} ;
                       
  mkNoun : Str -> Str -> Str -> Str -> Animateness -> Str -> Bool -> Bool -> Noun = 
    \man1,man2,man3,man4,a,c,b1,b2 -> {
      s = table {
        Sg => table {
          Plain => man1 ;
          Resp => man2
          } ;
        Pl => table {
          Plain => man3 ;
          Resp => man4
          }
        } ;
      anim = a ;
      counter = c ;
      counterReplace = b1 ;
      counterTsu = b2
    } ;
    
  regNoun : Str -> Animateness -> Str -> Bool -> Bool -> Noun = \s,a,c,b1,b2 -> 
    mkNoun s s s s a c b1 b2 ;
  
  styleNoun : Str -> Str -> Animateness -> Str -> Bool -> Bool -> Noun = \kane,okane,a,c,b1,b2 ->
    mkNoun kane okane kane okane a c b1 b2 ;
  
  numberNoun : Str -> Animateness -> Str -> Bool -> Str -> Bool -> Noun = \n,a,c,b1,pl,b2 -> 
    mkNoun n n pl pl a c b1 b2 ;
  
  regAdj : Str -> Adj = \a -> case a of {
    chiisa + "い"     => i_mkAdj a ;
    ooki + ("な"|"の") => na_mkAdj a
    } ;

  i_mkAdj : Str -> Adj = \chiisai -> 
    let
      chiisa = init chiisai ;     
    in {
    pred = table {
      Resp => table {
        (TPres|TFut) => table {
          Pos => chiisai ++ "です" ;
          Neg => chiisa + "くありません"
          } ;
        TPast => table {
          Pos => chiisa + "かったです" ;
          Neg => chiisa + "くありませんでした"
          }
        } ;
      Plain => table {
        (TPres|TFut) => table {
          Pos => chiisai ;
          Neg => chiisa + "くない"
          } ;
        TPast => table {
          Pos => chiisa + "かった" ;
          Neg => chiisa + "くなかった" 
          }
        }
      } ;
    attr = chiisai ;
    te = table { 
      Pos => chiisa + "くて" ;
      Neg => chiisa + "くなくて" 
      } ;
    ba = table { 
      Pos => chiisa + "ければ" ; 
      Neg => chiisa + "くなければ" 
      } ;
    adv = table { 
      Pos => chiisa + "く" ;
      Neg => chiisa + "くなく"
      } ;
    dropNaEnging = chiisai
    } ;  
  
  na_mkAdj : Str -> Adj = \ookina -> 
    let
      ooki = init ookina    
    in {
    pred = \\st,t,p => ooki ++ mkCopula.s ! st ! t ! p ;
    attr = ookina ;
    te = table { 
      Pos => ooki + "で" ;
      Neg => ooki + "ではなくて"
      } ;
    ba = \\p => ooki ++ mkCopula.ba ! p ;
    adv = table { 
      Pos => ooki + "に" ;
      Neg => ooki + "ではなく" 
      } ;
    dropNaEnging = ooki
    } ; 
    
  VerbalA : Str -> Str -> Adj = \kekkonshiteiru,kikonno -> 
    let
      kekkonshite = Predef.tk 2 kekkonshiteiru    
    in {
    pred = \\st,t,p => kekkonshite ++ mkExistV.verb ! SomeoneElse ! Anim ! st ! t ! p ;
    attr = kikonno ;
    te = \\p => kekkonshite ++ mkExistV.te ! SomeoneElse ! Anim ! Resp ! p ;
    ba = \\p => kekkonshite ++ mkExistV.ba ! SomeoneElse ! Anim ! Resp ! p ;
    adv = table { 
      Pos => init kikonno + "で" ;
      Neg => init kikonno + "ではなく"
      } ;
    dropNaEnging = init kikonno
    } ; 
  
  mkVerb : Str -> VerbGroup -> Verb = 
    \yomu,gr -> 
    let
      yoma = mk_a_stem yomu gr ;
      yomi = mk_i_stem yomu gr ;
      yonda = mk_plain_past yomu gr ;
    in {
    s = table {
      Resp => table {
        (TPres|TFut) => table {
          Pos => yomi + "ます" ;
          Neg => yomi + "ません"
          } ;
        TPast => table {
          Pos => yomi + "ました" ;
          Neg => yomi + "ませんでした"
          }
        } ;
      Plain => table {
        (TPres|TFut) => table {
          Pos => yomu ;
          Neg => yoma + "ない"
          } ;
        TPast => table {
          Pos => yonda ;
          Neg => yoma + "なかった"
          }
        }
      } ;
    te = table {
      Pos => case yonda of {
        yon + "だ" => yon + "で" ;
        yon + "た" => yon + "て"
        } ;
      Neg => yoma + "ないで" 
      } ;
    a_stem = yoma ;
    i_stem = yomi ;
    ba = table {
      Pos => mkBaForm yomu gr ;
      Neg => yoma + "なければ"
      } ;
    needSubject = True
    } ;
      
  mkVerb2 : Str -> Str -> VerbGroup -> Verb2 = 
    \yomu,p,gr -> 
    let
      yoma = mk_a_stem yomu gr ;
    in {
      s = (mkVerb yomu gr).s ;
      te = (mkVerb yomu gr).te ;
      a_stem = yoma ;
      i_stem = mk_i_stem yomu gr ;
      ba = (mkVerb yomu gr).ba ;
      prep = p ;
      pass = table {
        Resp => table {
          (TPres|TFut) => table {
            Pos => case gr of {
              Gr1  => yoma + "れます" ;
              Gr2  => yoma + "られます" ;
              Suru => Predef.tk 2 yomu + "されます" ;
              Kuru => "来られます"
              } ;
            Neg => case gr of {
              Gr1  => yoma + "れません" ;
              Gr2  => yoma + "られません" ;
              Suru => Predef.tk 2 yomu + "されません" ;
              Kuru => "来られません"
              }
            } ;
          TPast => table {
            Pos => case gr of {
              Gr1  => yoma + "れました" ;
              Gr2  => yoma + "られました" ;
              Suru => Predef.tk 2 yomu + "されました" ;
              Kuru => "来られました"
              } ;
            Neg => case gr of {
              Gr1  => yoma + "れませんでした" ;
              Gr2  => yoma + "られませんでした" ;
              Suru => Predef.tk 2 yomu + "されませんでした" ;
              Kuru => "来られませんでした" 
              }
            }
          } ;
        Plain => table {
          (TPres|TFut) => table {
            Pos => case gr of {
              Gr1  => yoma + "れる" ;
              Gr2  => yoma + "られる" ;
              Suru => Predef.tk 2 yomu + "される" ;
              Kuru => "来られる"
              } ;
            Neg => case gr of {
              Gr1  => yoma + "れない" ;
              Gr2  => yoma + "られない" ;
              Suru => Predef.tk 2 yomu + "されない" ;
              Kuru => "来られない"
              }
            } ;
          TPast => table {
            Pos => case gr of {
              Gr1  => yoma + "れた" ;
              Gr2  => yoma + "られた" ;
              Suru => Predef.tk 2 yomu + "された" ;
              Kuru => "来られた"
              } ;
            Neg => case gr of {
              Gr1  => yoma + "れなかった" ;
              Gr2  => yoma + "られなかった" ;
              Suru => Predef.tk 2 yomu + "されなかった" ;
              Kuru => "来られなかった"
              }
            }
          }
        } ;
      pass_te = table {
        Pos => case gr of {
          Gr1  => yoma + "れて" ;
          Gr2  => yoma + "られて" ;
          Suru => Predef.tk 2 yomu + "されて" ;
          Kuru => "来られて"
          } ;
        Neg => case gr of {
          Gr1  => yoma + "れないで" ;
          Gr2  => yoma + "られないで" ;
          Suru => Predef.tk 2 yomu + "されないで" ;
          Kuru => "来られないで"
          } 
        } ;
      pass_a_stem = case gr of {
        Gr1  => yoma + "れ" ;
        Gr2  => yoma + "られ" ;
        Suru => Predef.tk 2 yomu + "され" ;
        Kuru => "来られ"
        } ;
      pass_i_stem = case gr of {
        Gr1  => yoma + "れ" ;
        Gr2  => yoma + "られ" ;
        Suru => Predef.tk 2 yomu + "され" ;
        Kuru => "来られ"
        } ;
      pass_ba = table {
        Pos => case gr of {
          Gr1  => yoma + "れれば" ;
          Gr2  => yoma + "られれば" ;
          Suru => Predef.tk 2 yomu + "されれば" ;
          Kuru => "来られれば"
          } ;
        Neg => case gr of {
          Gr1  => yoma + "れなければ" ;
          Gr2  => yoma + "られなければ" ;
          Suru => Predef.tk 2 yomu + "されなければ" ;
          Kuru => "来られなければ"
          } 
        } ;
      needSubject = True
      } ;
                        
  mkVerb3 : Str -> Str -> Str -> VerbGroup -> Verb3 = 
    \uru,p1,p2,gr -> {
      s = \\sp => (mkVerb uru gr).s ;
      te = \\sp => (mkVerb uru gr).te ;
      a_stem = \\sp => mk_a_stem uru gr ;
      i_stem = \\sp => mk_i_stem uru gr ;
      ba = \\sp => (mkVerb uru gr).ba ;
      prep1 = p1 ;
      prep2 = p2
    } ;
  
  mkCopula = {
    s = table {
      Resp => table {
        (TPres|TFut) => table {
          Pos => "です" ;
          Neg => "ではありません" 
          } ;
        TPast => table {
          Pos => "でした" ;
          Neg => "ではありませんでした"
          }
        } ;
      Plain => table {
        (TPres|TFut) => table {
          Pos => "だ" ;
          Neg => "ではない"
          } ;
        TPast => table {
          Pos => "だった" ;
          Neg => "ではなかった"
          }
        }
      } ; 
    te = table {
      Pos => "だって" ;
      Neg => "ではなくて"
      } ;
    ba = table {
      Pos => "であれば" ;
      Neg => "でなければ"
      }
    } ;
  
  mkExistV : VP = {
    verb = \\sp => table {
      Anim => \\st,t,p => (mkVerb "いる" Gr2).s ! st ! t ! p ;
      Inanim => table { 
        Resp => table {
          (TPres|TFut) => table {
            Pos => "あります" ;
            Neg => "ありません"
            } ;
          TPast => table {
            Pos => "ありました" ;
            Neg => "ありませんでした"
            }
          } ;
        Plain => table {
          (TPres|TFut) => table {
            Pos => "ある" ;
            Neg => "ない"
            } ;
          TPast => table {
            Pos => "あった" ;
            Neg => "なかった"
            }
          }
        } 
      } ;
    te = \\sp => table {
      Anim => \\st => table {
        Pos => "いて" ;
        Neg => "いないで"
        } ;
      Inanim => \\st => table {
        Pos => "あって" ;
        Neg => "ないで"
        }
      } ;
    a_stem = \\sp => table {
      Anim => \\st => "い" ;
      Inanim => \\st => ""
      } ;
    i_stem = \\sp => table {
      Anim => \\st => "い" ;
      Inanim => \\st => "あり"
      } ;
    ba = \\sp => table {
      Anim => \\st => table {
        Pos => "いれば" ;
        Neg => "いなければ"
        } ;
      Inanim => \\st => table {
        Pos => "あれば" ;
        Neg => "なければ"
        }
      } ;
    prep = [] ;
    prepositive, obj = \\st => [] ;
    needSubject = True
    } ;
          
  mkWant : VV = {
    s = table {
      Me => \\st,t,p => (i_mkAdj "たい").pred ! st ! t ! p ;
      SomeoneElse => \\st,t,p => "たがって" ++ (mkVerb "いる" Gr2).s ! st ! t ! p 
      } ;
    te = table {
      Me => table {
        Pos => "たくて" ;
        Neg => "たくなくて"
        } ;
      SomeoneElse => table {
        Pos => "たがっていて" ;
        Neg => "たがっていないで"
        }
      } ;
    a_stem = table {
      Me => "たいで" ;
      SomeoneElse => "たがってい" 
      } ;
    i_stem = table {
      Me => "たいで" ;
      SomeoneElse => "たがってい"
      } ;
    ba = table {
      Me => table {
        Pos => "たければ" ;
        Neg => "たくなければ"
        } ;
      SomeoneElse => table {
        Pos => "たがっていれば" ;
        Neg => "たがっていなければ"
        }
      } ;
    sense = Wish
    } ;
  
  mkCan : VV = {
    s = \\sp,st,t,p => (mkVerb "できる" Gr2).s ! st ! t ! p ;
    te = \\sp => table {
      Pos => "できて" ;
      Neg => "できないで" 
      } ;
    a_stem, i_stem = \\sp => "でき" ;
    ba = \\sp => table {
      Pos => "できれば" ;
      Neg => "できなければ" 
      } ;
    sense = Abil
    } ;
  
  mkMust : VV = {
    s = \\sp,st,t,p => (mkVerb "なる" Gr1).s ! st ! t ! Neg ;
    te = \\sp,p => "ならなくて" ;
    a_stem = \\sp => "なら" ;
    i_stem = \\sp => "なり" ;
    ba = \\sp,p => "ならなければ" ;
    sense = Oblig
    } ;

  mkGive : Verb3 = {
    s = table {
      Me => \\st,t,p => (mkVerb "呉れる" Gr2).s ! st ! t ! p ;  -- "kureru"
      SomeoneElse => \\st,t,p => (mkVerb "上げる" Gr2).s ! st ! t ! p  -- "ageru"
      } ;
    te = table {
      Me => (mkVerb "呉れる" Gr2).te ;
      SomeoneElse => (mkVerb "上げる" Gr2).te
      } ;
    a_stem, i_stem = table {
      Me => "呉れ" ;
      SomeoneElse => "上げ" 
      } ;
    ba = table {
      Me => (mkVerb "呉れる" Gr2).ba ;
      SomeoneElse => (mkVerb "上げる" Gr2).ba
      } ;
    prep1 = "に" ;
    prep2 = "を" 
    } ;

  mkGo : Verb = {
    s = table {
      Resp => (mkVerb "行く" Gr1).s ! Resp ; 
      Plain => table {
        (TPres|TFut) => (mkVerb "行く" Gr1).s ! Plain ! TPres ;
        TPast => table {
          Pos => "行った" ;
          Neg => "行かなかった"
          }
        }
      } ;
    te = table {
      Pos => "行って" ;
      Neg => "行かないで" 
      } ;
    a_stem = "行か" ;
    i_stem = "行き" ;
    ba = (mkVerb "行く" Gr1).ba ;
    needSubject = True
    } ;

  mkNum : Str -> Number -> Num = \s,n -> {
    s = s ;
    postpositive = [] ;
    n = n ;
    inclCard = False ;
    tenPlus = False
    } ;
  
  regPron : Str -> Bool -> Animateness -> Pronoun = \kare,b,a -> {
    s = \\st => kare ;
    Pron1Sg = b ;
    anim = a
    } ;    
  
  mkDet : Str -> Str -> Number -> Determiner = \q,sp,n -> {
    quant = \\st => q ;
    postpositive = [] ;
    num = [] ;
    n = n ;
    inclCard = False ;
    sp = \\st => sp ;
    no = False ;
    tenPlus = False
    } ;
                       
  stylePron : Str -> Str -> Bool -> Animateness -> Pronoun = \boku,watashi,b,a -> {
    s = table {
      Plain => boku ;
      Resp => watashi
      } ;
    Pron1Sg = b ;
    anim = a
    } ;    
    
  regPN : Str -> PropNoun = \paris -> {
    s = table {
      Plain => paris ;
      Resp => paris
      } ;
    anim = Inanim
    } ;
  
  personPN : Str -> Str -> PropNoun = \jon,jonsan -> {
    s = table {
      Plain => jon ;
      Resp => jonsan
      } ;
    anim = Anim
    } ;
  
  mkAdv : Str -> Adverb = \adv -> {
    s = \\st => adv ; 
    prepositive = False
    } ;
  
  mkNP : Str -> Bool -> Bool -> Animateness -> NP = \np,b1,b2,a -> {
    s = \\st => np ; 
    prepositive = \\st => [] ;
    needPart = b1 ; 
    changePolar = b2 ; 
    meaning = SomeoneElse ; 
    anim = a
    } ;
  
  mkConj : Str -> ConjType -> Conjunction = \c,t -> {
    s = c ;
    null = "" ;
    type = t
    } ;
    
  mkPrep : Str -> Preposition = \p -> {
    s = p ;
    null = "" ;
    } ;

  mkSubj : Str -> SubjType -> Subjunction = \s,t -> {
    s = s ;
    type = t ;
    } ;

  mk_a_stem : Str -> VerbGroup -> Str = \neru,gr ->
    case gr of {
      Gr1 => case last neru of {
        "る" => init neru + "ら" ;
        "す" => init neru + "さ" ;
        "く" => init neru + "か" ;
        "ぐ" => init neru + "が" ;
        "む" => init neru + "ま" ;
        "ぬ" => init neru + "な" ;
        "ぶ" => init neru + "ば" ;
        "つ" => init neru + "た" ;
        _    => init neru + "わ"
        } ;
      (Gr2 | Kuru) => init neru ;
      Suru => Predef.tk 2 neru + "し"
    } ;

  mk_i_stem : Str -> VerbGroup -> Str = \neru,gr ->
    case gr of {
      Gr1 => case last neru of {
        "る" => init neru + "り" ;
        "す" => init neru + "し" ;
        "く" => init neru + "き" ;
        "ぐ" => init neru + "ぎ" ;
        "む" => init neru + "み" ;
        "ぬ" => init neru + "に" ;
        "ぶ" => init neru + "び" ;
        "つ" => init neru + "ち" ;
        _    => init neru + "い"
        } ;
      (Gr2 | Kuru) => init neru ;
      Suru => Predef.tk 2 neru + "し"
    } ;

  mk_plain_past : Str -> VerbGroup -> Str = \neru,gr ->
    case gr of {
      Gr1 => case last neru of {
        "る" => init neru + "った" ;
        "す" => init neru + "した" ;
        "く" => init neru + "いた" ;
        "ぐ" => init neru + "いだ" ;
        "む" => init neru + "んだ" ;
        "ぬ" => init neru + "んだ" ;
        "ぶ" => init neru + "んだ" ;
        "つ" => init neru + "った" ;
        _    => init neru + "った"
        } ;
      (Gr2 | Kuru) => init neru + "た" ;
      Suru => Predef.tk 2 neru + "した"
    } ;

  mkBaForm : Str -> VerbGroup -> Str = \neru,gr ->
    case last neru of {
      "る" => init neru + "れば" ;
      "す" => init neru + "せば" ;
      "く" => init neru + "けば" ;
      "ぐ" => init neru + "げば" ;
      "む" => init neru + "めば" ;
      "ぬ" => init neru + "ねば" ;
      "ぶ" => init neru + "べば" ;
      "つ" => init neru + "てば" ;
      _    => init neru + "えば"
    } ;
      
  mkFirst : Adj = {
    pred = \\st,t,p => "一番目" ++ mkCopula.s ! st ! t ! p ;
    attr = "一番目の" ; 
    te = \\p => "一番目" ++ mkCopula.te ! p ;
    ba = \\p => "一番目" ++ mkCopula.ba ! p ;
    adv = table {
      Pos => "一番目" ;
      Neg => "一番目ではなく"
      } ;
    dropNaEnging = "一番目"
    } ;
                 
  mkRain : Verb = {
    s = \\st,t,p => "雨が" ++ (mkVerb "降る" Gr1).s ! st ! t ! p ;  -- "ame ga furu"
    te = table {
      Pos => "雨が降って" ;
      Neg => "雨が降らないで" 
      } ;
    a_stem = "雨が降ら" ;
    i_stem = "雨が降り" ;
    ba = table {
      Pos => "雨が降れば" ;
      Neg => "雨が降らなければ"
      } ;
    needSubject = False
    } ;
}

