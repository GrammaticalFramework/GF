resource ParadigmsBul = MorphoFunsBul ** open
  Predef,
  Prelude,
  MorphoBul,
  CatBul
  in {
  flags coding=cp1251 ;

oper
  mkN001 : Str -> N ;
  mkN001 base = let v0 = base
                in mkNoun (v0)
                          (v0+"ове")
                          (v0+"а")
                          (v0+"-")
                          DMasc ;
  mkN002 : Str -> N ;
  mkN002 base = let v0 = tk 2 base;
                    v1 = last (base)
                in mkNoun (v0+"я"+v1)
                          (v0+"е"+v1+"ове")
                          (v0+"я"+v1+"а")
                          (v0+"-")
                          DMasc ;
  mkN002a : Str -> N ;
  mkN002a base = let v0 = tk 2 base;
                     v1 = last (base)
                 in mkNoun (v0+"я"+v1)
                           (v0+"е"+v1+"ове")
                           (v0+"я"+v1+"а")
                           (v0+"-")
                           DMasc ;
  mkN003 : Str -> N ;
  mkN003 base = let v0 = tk 3 base;
                    v1 = last (base)
                in mkNoun (v0+"ръ"+v1)
                          (v0+"ър"+v1+"ове")
                          (v0+"ър"+v1+"а")
                          (v0+"-")
                          DMasc ;
  mkN004 : Str -> N ;
  mkN004 base = let v0 = tk 4 base
                in mkNoun (v0+"ятър")
                          (v0+"етрове")
                          (v0+"ятъра")
                          (v0+"-")
                          DMasc ;
  mkN005 : Str -> N ;
  mkN005 base = let v0 = base
                in mkNoun (v0)
                          (v0+"ове")
                          (v0+"а")
                          (v0+"-")
                          DMasc ;
  mkN006 : Str -> N ;
  mkN006 base = let v0 = base
                in mkNoun (v0)
                          (v0+"ове")
                          (v0+"а")
                          (v0+"-")
                          DMasc ;
  mkN007 : Str -> N ;
  mkN007 base = let v0 = base
                in mkNoun (v0)
                          (v0+"и")
                          (v0+"а")
                          (v0+"-")
                          DMasc ;
  mkN007b : Str -> N ;
  mkN007b base = let v0 = base
                 in mkNoun (v0)
                           (v0+"и")
                           (v0+"а")
                           (v0+"о")
                           DMasc ;
  mkN007a : Str -> N ;
  mkN007a base = let v0 = base
                 in mkNoun (v0)
                           (v0+"и")
                           (v0+"а")
                           (v0+"е")
                           DMascPersonal ;
  mkN008 : Str -> N ;
  mkN008 base = let v0 = tk 2 base;
                    v1 = last (base)
                in mkNoun (v0+"е"+v1)
                          (v0+v1+"и")
                          (v0+"е"+v1+"а")
                          (v0+"-")
                          DMasc ;
  mkN008a : Str -> N ;
  mkN008a base = let v0 = tk 2 base
                 in mkNoun (v0+"ец")
                           (v0+"ци")
                           (v0+"-")
                           (v0+"ецо")
                           DMasc ;
  mkN009 : Str -> N ;
  mkN009 base = let v0 = tk 2 base;
                    v1 = last (base)
                in mkNoun (v0+"ъ"+v1)
                          (v0+v1+"и")
                          (v0+"ъ"+v1+"а")
                          (v0+v1+"е")
                          DMasc ;
  mkN009a : Str -> N ;
  mkN009a base = let v0 = tk 2 base
                 in mkNoun (v0+"ър")
                           (v0+"рове")
                           (v0+"ъра")
                           (v0+"-")
                           DMasc ;
  mkN010 : Str -> N ;
  mkN010 base = let v0 = tk 2 base
                in mkNoun (v0+"ър")
                          (v0+"ри")
                          (v0+"ра")
                          (v0+"-")
                          DMasc ;
  mkN011 : Str -> N ;
  mkN011 base = let v0 = tk 2 base
                in mkNoun (v0+"ъм")
                          (v0+"ми")
                          (v0+"ъма")
                          (v0+"-")
                          DMasc ;
  mkN012 : Str -> N ;
  mkN012 base = let v0 = tk 3 base
                in mkNoun (v0+"рък")
                          (v0+"ърци")
                          (v0+"-")
                          (v0+"ърко")
                          DMasc ;
  mkN013 : Str -> N ;
  mkN013 base = let v0 = tk 2 base
                in mkNoun (v0+"ец")
                          (v0+"йци")
                          (v0+"-")
                          (v0+"ецо")
                          DMasc ;
  mkN014 : Str -> N ;
  mkN014 base = let v0 = tk 1 base
                in mkNoun (v0+"к")
                          (v0+"ци")
                          (v0+"ка")
                          (v0+"-")
                          DMasc ;
  mkN014a : Str -> N ;
  mkN014a base = let v0 = tk 1 base
                 in mkNoun (v0+"к")
                           (v0+"ци")
                           (v0+"ка")
                           (v0+"ко")
                           DMasc ;
  mkN015 : Str -> N ;
  mkN015 base = let v0 = tk 1 base
                in mkNoun (v0+"г")
                          (v0+"зи")
                          (v0+"га")
                          (v0+"-")
                          DMasc ;
  mkN016 : Str -> N ;
  mkN016 base = let v0 = tk 1 base
                in mkNoun (v0+"х")
                          (v0+"си")
                          (v0+"ха")
                          (v0+"-")
                          DMasc ;
  mkN017 : Str -> N ;
  mkN017 base = let v0 = tk 1 base
                in mkNoun (v0+"к")
                          (v0+"ни")
                          (v0+"ка")
                          (v0+"-")
                          DMasc ;
  mkN018 : Str -> N ;
  mkN018 base = let v0 = tk 2 base
                in mkNoun (v0+"ин")
                          (v0+"и")
                          (v0+"-")
                          (v0+"ино")
                          DMasc ;
  mkN018a : Str -> N ;
  mkN018a base = let v0 = tk 2 base;
                     v1 = last (base)
                 in mkNoun (v0+"и"+v1)
                           (v0+"и")
                           (v0+"-")
                           (v0+"-")
                           DMasc ;
  mkN019 : Str -> N ;
  mkN019 base = let v0 = tk 2 base
                in mkNoun (v0+"ък")
                          (v0+"ци")
                          (v0+"-")
                          (v0+"ко")
                          DMasc ;
  mkN019a : Str -> N ;
  mkN019a base = let v0 = tk 2 base
                 in mkNoun (v0+"ек")
                           (v0+"йци")
                           (v0+"ека")
                           (v0+"-")
                           DMasc ;
  mkN020 : Str -> N ;
  mkN020 base = let v0 = tk 3 base;
                    v1 = last (tk 2 base)
                in mkNoun (v0+v1+"ец")
                          (v0+"ъ"+v1+"ци")
                          (v0+"-")
                          (v0+v1+"ецо")
                          DMasc ;
  mkN021 : Str -> N ;
  mkN021 base = let v0 = tk 3 base
                in mkNoun (v0+"чин")
                          (v0+"ци")
                          (v0+"-")
                          (v0+"чино")
                          DMasc ;
  mkN022 : Str -> N ;
  mkN022 base = let v0 = base
                in mkNoun (v0)
                          (v0+"а")
                          (v0+"а")
                          (v0+"-")
                          DMasc ;
  mkN023 : Str -> N ;
  mkN023 base = let v0 = tk 2 base
                in mkNoun (v0+"ин")
                          (v0+"а")
                          (v0+"-")
                          (v0+"ине")
                          DMasc ;
  mkN024a : Str -> N ;
  mkN024a base = let v0 = tk 1 base
                 in mkNoun (v0+"з")
                           (v0+"зе")
                           (v0+"-")
                           (v0+"же")
                           DMasc ;
  mkN024 : Str -> N ;
  mkN024 base = let v0 = base
                in mkNoun (v0)
                          (v0+"е")
                          (v0+"е")
                          (v0+"о")
                          DMascPersonal ;
  mkN025 : Str -> N ;
  mkN025 base = let v0 = base
                in mkNoun (v0)
                          (v0+"я")
                          (v0+"-")
                          (v0+"е")
                          DMascPersonal ;
  mkN026 : Str -> N ;
  mkN026 base = let v0 = base
                in mkNoun (v0)
                          (v0+"илища")
                          (v0+"а")
                          (v0+"-")
                          DMasc ;
  mkN027 : Str -> N ;
  mkN027 base = let v0 = tk 2 base
                in mkNoun (v0+"ец")
                          (v0+"овце")
                          (v0+"еца")
                          (v0+"-")
                          DMasc ;
  mkN028 : Str -> N ;
  mkN028 base = let v0 = tk 1 base
                in mkNoun (v0+"й")
                          (v0+"еве")
                          (v0+"я")
                          (v0+"-")
                          DMasc ;
  mkN028a : Str -> N ;
  mkN028a base = let v0 = tk 1 base
                 in mkNoun (v0+"й")
                           (v0+"йове")
                           (v0+"я")
                           (v0+"-")
                           DMasc ;
  mkN029 : Str -> N ;
  mkN029 base = let v0 = base
                in mkNoun (v0)
                          (v0+"ьове")
                          (v0+"-")
                          (v0+"ко")
                          DMasc ;
  mkN030 : Str -> N ;
  mkN030 base = let v0 = tk 2 base
                in mkNoun (v0+"ън")
                          (v0+"ньове")
                          (v0+"ъня")
                          (v0+"-")
                          DMasc ;
  mkN031 : Str -> N ;
  mkN031 base = let v0 = base
                in mkNoun (v0)
                          (v0+"и")
                          (v0+"я")
                          (v0+"-")
                          DMasc ;
  mkN031a : Str -> N ;
  mkN031a base = let v0 = base
                 in mkNoun (v0)
                           (v0+"и")
                           (v0+"я")
                           (v0+"ю")
                           DMascPersonal ;
  mkN032 : Str -> N ;
  mkN032 base = let v0 = tk 1 base
                in mkNoun (v0+"й")
                          (v0+"и")
                          (v0+"я")
                          (v0+"-")
                          DMasc ;
  mkN032a : Str -> N ;
  mkN032a base = let v0 = tk 1 base
                 in mkNoun (v0+"й")
                           (v0+"и")
                           (v0+"я")
                           (v0+"ю")
                           DMascPersonal ;
  mkN033 : Str -> N ;
  mkN033 base = let v0 = tk 2 base
                in mkNoun (v0+"ен")
                          (v0+"ни")
                          (v0+"ена")
                          (v0+"-")
                          DMasc ;
  mkN034 : Str -> N ;
  mkN034 base = let v0 = tk 2 base
                in mkNoun (v0+"ът")
                          (v0+"ти")
                          (v0+"ътя")
                          (v0+"-")
                          DMasc ;
  mkN035 : Str -> N ;
  mkN035 base = let v0 = base
                in mkNoun (v0)
                          (v0+"е")
                          (v0+"я")
                          (v0+"-")
                          DMasc ;
  mkN035a : Str -> N ;
  mkN035a base = let v0 = base
                 in mkNoun (v0)
                           (v0+"е")
                           (v0+"я")
                           (v0+"ю")
                           DMascPersonal ;
  mkN036 : Str -> N ;
  mkN036 base = let v0 = tk 1 base
                in mkNoun (v0+"й")
                          (v0+"ища")
                          (v0+"я")
                          (v0+"-")
                          DMasc ;
  mkN037 : Str -> N ;
  mkN037 base = let v0 = base
                in mkNoun (v0)
                          (v0+"ища")
                          (v0+"я")
                          (v0+"-")
                          DMasc ;
  mkN038 : Str -> N ;
  mkN038 base = let v0 = tk 1 base
                in mkNoun (v0+"а")
                          (v0+"и")
                          (v0+"-")
                          (v0+"а")
                          DMascPersonal ;
  mkN039 : Str -> N ;
  mkN039 base = let v0 = tk 1 base
                in mkNoun (v0+"я")
                          (v0+"и")
                          (v0+"-")
                          (v0+"-")
                          DMasc ;
  mkN040 : Str -> N ;
  mkN040 base = let v0 = tk 1 base
                in mkNoun (v0+"о")
                          (v0+"овци")
                          (v0+"-")
                          (v0+"о")
                          DMasc ;
  mkN040a : Str -> N ;
  mkN040a base = let v0 = base
                 in mkNoun (v0)
                           (v0+"-")
                           (v0+"-")
                           (v0+"-")
                           DMasc ;
  mkN041 : Str -> N ;
  mkN041 base = let v0 = tk 1 base
                in mkNoun (v0+"а")
                          (v0+"и")
                          (v0+"и")
                          (v0+"-")
                          DFem ;
  mkN041a : Str -> N ;
  mkN041a base = let v0 = tk 1 base
                 in mkNoun (v0+"а")
                           (v0+"и")
                           (v0+"и")
                           (v0+"о")
                           DFem ;
  mkN041b : Str -> N ;
  mkN041b base = let v0 = tk 1 base
                 in mkNoun (v0+"а")
                           (v0+"и")
                           (v0+"и")
                           (v0+"е")
                           DFem ;
  mkN042 : Str -> N ;
  mkN042 base = let v0 = base
                in mkNoun (v0)
                          (v0)
                          (v0)
                          (v0+"-")
                          DFem ;
  mkN043 : Str -> N ;
  mkN043 base = let v0 = tk 3 base;
                    v1 = last (tk 1 base)
                in mkNoun (v0+"я"+v1+"а")
                          (v0+"е"+v1+"и")
                          (v0+"е"+v1+"и")
                          (v0+"-")
                          DFem ;
  mkN043a : Str -> N ;
  mkN043a base = let v0 = tk 4 base;
                     v1 = last (tk 2 base)
                 in mkNoun (v0+"я"+v1+"ка")
                           (v0+"е"+v1+"ки")
                           (v0+"е"+v1+"ки")
                           (v0+"-")
                           DFem ;
  mkN044 : Str -> N ;
  mkN044 base = let v0 = tk 1 base
                in mkNoun (v0+"а")
                          (v0+"е")
                          (v0+"е")
                          (v0+"-")
                          DFem ;
  mkN045 : Str -> N ;
  mkN045 base = let v0 = tk 2 base
                in mkNoun (v0+"ка")
                          (v0+"це")
                          (v0+"це")
                          (v0+"-")
                          DFem ;
  mkN046 : Str -> N ;
  mkN046 base = let v0 = tk 2 base
                in mkNoun (v0+"га")
                          (v0+"зе")
                          (v0+"зе")
                          (v0+"-")
                          DFem ;
  mkN047 : Str -> N ;
  mkN047 base = let v0 = tk 1 base
                in mkNoun (v0+"я")
                          (v0+"и")
                          (v0+"и")
                          (v0+"-")
                          DFem ;
  mkN048 : Str -> N ;
  mkN048 base = let v0 = tk 1 base
                in mkNoun (v0+"я")
                          (v0+"е")
                          (v0+"е")
                          (v0+"ьо")
                          DFem ;
  mkN049 : Str -> N ;
  mkN049 base = let v0 = base
                in mkNoun (v0)
                          (v0+"и")
                          (v0+"и")
                          (v0+"-")
                          DFem ;
  mkN050 : Str -> N ;
  mkN050 base = let v0 = tk 2 base
                in mkNoun (v0+"ен")
                          (v0+"ни")
                          (v0+"ни")
                          (v0+"-")
                          DFem ;
  mkN051 : Str -> N ;
  mkN051 base = let v0 = tk 2 base;
                    v1 = last (base)
                in mkNoun (v0+"ъ"+v1)
                          (v0+v1+"и")
                          (v0+v1+"и")
                          (v0+"-")
                          DFem ;
  mkN052 : Str -> N ;
  mkN052 base = let v0 = tk 5 base
                in mkNoun (v0+"ялост")
                          (v0+"ялости")
                          (v0+"ялости")
                          (v0+"-")
                          DFem ;
  mkN052a : Str -> N ;
  mkN052a base = let v0 = tk 6 base
                 in mkNoun (v0+"ярност")
                           (v0+"ярности")
                           (v0+"ярности")
                           (v0+"-")
                           DFem ;
  mkN053 : Str -> N ;
  mkN053 base = let v0 = tk 3 base;
                    v1 = last (base)
                in mkNoun (v0+"ръ"+v1)
                          (v0+"ър"+v1+"и")
                          (v0+"ър"+v1+"и")
                          (v0+"-")
                          DFem ;
  mkN054 : Str -> N ;
  mkN054 base = let v0 = tk 1 base
                in mkNoun (v0+"о")
                          (v0+"а")
                          (v0+"а")
                          (v0+"о")
                          DNeut ;
  mkN055 : Str -> N ;
  mkN055 base = let v0 = tk 1 base
                in mkNoun (v0+"о")
                          (v0+"а")
                          (v0+"а")
                          (v0+"о")
                          DNeut ;
  mkN056 : Str -> N ;
  mkN056 base = let v0 = tk 1 base
                in mkNoun (v0+"о")
                          (v0+"а")
                          (v0+"а")
                          (v0+"о")
                          DNeut ;
  mkN057 : Str -> N ;
  mkN057 base = let v0 = tk 3 base;
                    v1 = last (tk 1 base)
                in mkNoun (v0+"я"+v1+"о")
                          (v0+"е"+v1+"а")
                          (v0+"е"+v1+"а")
                          (v0+"я"+v1+"о")
                          DNeut ;
  mkN057a : Str -> N ;
  mkN057a base = let v0 = tk 4 base
                 in mkNoun (v0+"ясто")
                           (v0+"еста")
                           (v0+"еста")
                           (v0+"ясто")
                           DNeut ;
  mkN058 : Str -> N ;
  mkN058 base = let v0 = tk 3 base
                in mkNoun (v0+"яно")
                          (v0+"ена")
                          (v0+"ена")
                          (v0+"яно")
                          DNeut ;
  mkN059 : Str -> N ;
  mkN059 base = let v0 = tk 1 base
                in mkNoun (v0+"о")
                          (v0+"ене")
                          (v0+"ене")
                          (v0+"о")
                          DNeut ;
  mkN060 : Str -> N ;
  mkN060 base = let v0 = tk 1 base
                in mkNoun (v0+"о")
                          (v0+"еса")
                          (v0+"еса")
                          (v0+"о")
                          DNeut ;
  mkN061 : Str -> N ;
  mkN061 base = let v0 = tk 1 base
                in mkNoun (v0+"о")
                          (v0+"а")
                          (v0+"а")
                          (v0+"о")
                          DNeut ;
  mkN062 : Str -> N ;
  mkN062 base = let v0 = tk 1 base
                in mkNoun (v0+"о")
                          (v0+"и")
                          (v0+"и")
                          (v0+"о")
                          DNeut ;
  mkN063 : Str -> N ;
  mkN063 base = let v0 = tk 2 base
                in mkNoun (v0+"ко")
                          (v0+"чи")
                          (v0+"чи")
                          (v0+"ко")
                          DNeut ;
  mkN064 : Str -> N ;
  mkN064 base = let v0 = tk 2 base
                in mkNoun (v0+"хо")
                          (v0+"ши")
                          (v0+"ши")
                          (v0+"хо")
                          DNeut ;
  mkN065 : Str -> N ;
  mkN065 base = let v0 = base
                in mkNoun (v0)
                          (v0+"та")
                          (v0+"та")
                          (v0)
                          DNeut ;
  mkN066 : Str -> N ;
  mkN066 base = let v0 = tk 1 base
                in mkNoun (v0+"е")
                          (v0+"а")
                          (v0+"а")
                          (v0+"е")
                          DNeut ;
  mkN067 : Str -> N ;
  mkN067 base = let v0 = tk 2 base
                in mkNoun (v0+"те")
                          (v0+"ца")
                          (v0+"ца")
                          (v0+"те")
                          DNeut ;
  mkN068 : Str -> N ;
  mkN068 base = let v0 = tk 1 base
                in mkNoun (v0+"е")
                          (v0+"я")
                          (v0+"я")
                          (v0+"е")
                          DNeut ;
  mkN069 : Str -> N ;
  mkN069 base = let v0 = base
                in mkNoun (v0)
                          (v0+"на")
                          (v0+"на")
                          (v0)
                          DNeut ;
  mkN070 : Str -> N ;
  mkN070 base = let v0 = base
                in mkNoun (v0)
                          (v0+"са")
                          (v0+"са")
                          (v0)
                          DNeut ;
  mkN071 : Str -> N ;
  mkN071 base = let v0 = tk 1 base
                in mkNoun (v0+"е")
                          (v0+"ия")
                          (v0+"ия")
                          (v0+"е")
                          DNeut ;
  mkN072 : Str -> N ;
  mkN072 base = let v0 = tk 1 base
                in mkNoun (v0+"е")
                          (v0+"я")
                          (v0+"я")
                          (v0+"е")
                          DNeut ;
  mkN073 : Str -> N ;
  mkN073 base = let v0 = base
                in mkNoun (v0)
                          (v0+"та")
                          (v0+"та")
                          (v0)
                          DNeut ;
  mkN074 : Str -> N ;
  mkN074 base = let v0 = tk 1 base
                in mkNoun (v0+"-")
                          (v0)
                          (v0)
                          (v0+"-")
                          DNeut ;
  mkN075 : Str -> N ;
  mkN075 base = let v0 = tk 1 base
                in mkNoun (v0+"-")
                          (v0)
                          (v0)
                          (v0+"-")
                          DNeut ;
  mkA076 : Str -> A ;
  mkA076 base = let v0 = base
                in mkAdjective (v0)
                               (v0+"ия")
                               (v0+"ият")
                               (v0+"а")
                               (v0+"ата")
                               (v0+"о")
                               (v0+"ото")
                               (v0+"и")
                               (v0+"ите") ;
  mkA077 : Str -> A ;
  mkA077 base = let v0 = base
                in mkAdjective (v0)
                               (v0+"ия")
                               (v0+"ият")
                               (v0+"а")
                               (v0+"ата")
                               (v0+"е")
                               (v0+"ето")
                               (v0+"и")
                               (v0+"ите") ;
  mkA078 : Str -> A ;
  mkA078 base = let v0 = tk 1 base
                in adjAdv (mkAdjective (v0+"и")
                                       (v0+"ия")
                                       (v0+"ият")
                                       (v0+"а")
                                       (v0+"ата")
                                       (v0+"о")
                                       (v0+"ото")
                                       (v0+"и")
                                       (v0+"ите")) (v0+"и") ;
  mkA079 : Str -> A ;
  mkA079 base = let v0 = tk 2 base
                in mkAdjective (v0+"ен")
                               (v0+"ния")
                               (v0+"ният")
                               (v0+"на")
                               (v0+"ната")
                               (v0+"но")
                               (v0+"ното")
                               (v0+"ни")
                               (v0+"ните") ;
  mkA080 : Str -> A ;
  mkA080 base = let v0 = tk 2 base;
                    v1 = last (base)
                in mkAdjective (v0+"ъ"+v1)
                               (v0+v1+"ия")
                               (v0+v1+"ият")
                               (v0+v1+"а")
                               (v0+v1+"ата")
                               (v0+v1+"о")
                               (v0+v1+"ото")
                               (v0+v1+"и")
                               (v0+v1+"ите") ;
  mkA081 : Str -> A ;
  mkA081 base = let v0 = tk 2 base;
                    v1 = last (base)
                in mkAdjective (v0+"я"+v1)
                               (v0+"е"+v1+"ия")
                               (v0+"е"+v1+"ият")
                               (v0+"я"+v1+"а")
                               (v0+"я"+v1+"ата")
                               (v0+"я"+v1+"о")
                               (v0+"я"+v1+"ото")
                               (v0+"е"+v1+"и")
                               (v0+"е"+v1+"ите") ;
  mkA082 : Str -> A ;
  mkA082 base = let v0 = tk 3 base;
                    v1 = last (base)
                in mkAdjective (v0+"ръ"+v1)
                               (v0+"ър"+v1+"ия")
                               (v0+"ър"+v1+"ият")
                               (v0+"ър"+v1+"а")
                               (v0+"ър"+v1+"ата")
                               (v0+"ър"+v1+"о")
                               (v0+"ър"+v1+"ото")
                               (v0+"ър"+v1+"и")
                               (v0+"ър"+v1+"ите") ;
  mkA082a : Str -> A ;
  mkA082a base = let v0 = tk 5 base
                 in mkAdjective (v0+"ързък")
                                (v0+"ръзкия")
                                (v0+"ръзкият")
                                (v0+"ръзка")
                                (v0+"ръзката")
                                (v0+"ръзко")
                                (v0+"ръзкото")
                                (v0+"ръзки")
                                (v0+"ръзките") ;
  mkA083 : Str -> A ;
  mkA083 base = let v0 = tk 4 base;
                    v1 = last (tk 2 base)
                in mkAdjective (v0+"я"+v1+"ък")
                               (v0+"е"+v1+"кия")
                               (v0+"е"+v1+"кият")
                               (v0+"я"+v1+"ка")
                               (v0+"я"+v1+"ката")
                               (v0+"я"+v1+"ко")
                               (v0+"я"+v1+"кото")
                               (v0+"е"+v1+"ки")
                               (v0+"е"+v1+"ките") ;
  mkA084 : Str -> A ;
  mkA084 base = let v0 = tk 4 base;
                    v1 = last (tk 2 base)
                in mkAdjective (v0+"е"+v1+"ен")
                               (v0+"е"+v1+"ния")
                               (v0+"е"+v1+"ният")
                               (v0+"я"+v1+"на")
                               (v0+"я"+v1+"ната")
                               (v0+"я"+v1+"но")
                               (v0+"я"+v1+"ното")
                               (v0+"е"+v1+"ни")
                               (v0+"е"+v1+"ните") ;
  mkA084a : Str -> A ;
  mkA084a base = let v0 = tk 5 base
                 in mkAdjective (v0+"естен")
                                (v0+"естния")
                                (v0+"естният")
                                (v0+"ястна")
                                (v0+"ястната")
                                (v0+"ястно")
                                (v0+"ястнота")
                                (v0+"естни")
                                (v0+"естните") ;
  mkA085 : Str -> A ;
  mkA085 base = let v0 = tk 2 base
                in mkAdjective (v0+"ен")
                               (v0+"йния")
                               (v0+"йният")
                               (v0+"йна")
                               (v0+"йната")
                               (v0+"йно")
                               (v0+"йното")
                               (v0+"йни")
                               (v0+"йните") ;
  mkA086 : Str -> A ;
  mkA086 base = let v0 = base
                in mkAdjective (v0)
                               (v0+"ия")
                               (v0+"ият")
                               (v0+"я")
                               (v0+"ята")
                               (v0+"ьо")
                               (v0+"ьото")
                               (v0+"и")
                               (v0+"ите") ;
  mkA087 : Str -> A ;
  mkA087 base = let v0 = tk 1 base
                in mkAdjective (v0+"и")
                               (v0+"ия")
                               (v0+"ият")
                               (v0+"а")
                               (v0+"ата")
                               (v0+"е")
                               (v0+"ето")
                               (v0+"и")
                               (v0+"ите") ;
  mkA088 : Str -> A ;
  mkA088 base = let v0 = tk 1 base
                in mkAdjective (v0+"и")
                               (v0+"ия")
                               (v0+"ият")
                               (v0+"я")
                               (v0+"ята")
                               (v0+"е")
                               (v0+"ето")
                               (v0+"и")
                               (v0+"ите") ;
  mkA089 : Str -> A ;
  mkA089 base = let v0 = tk 1 base
                in mkAdjective (v0+"-")
                               (v0+"ия")
                               (v0+"ият")
                               (v0+"-")
                               (v0+"ата")
                               (v0+"-")
                               (v0+"ото")
                               (v0+"-")
                               (v0+"ите") ;
  mkA089a : Str -> A ;
  mkA089a base = let v0 = base
                 in mkAdjective (v0)
                                (v0)
                                (v0)
                                (v0)
                                (v0)
                                (v0)
                                (v0)
                                (v0)
                                (v0) ;
  mkV142 : Str -> VTable ;
  mkV142 base = let v0 = tk 3 base
                in mkVerb (v0+"съм")
                          (v0+"е")
                          (v0+"бях")
                          (v0+"бях")
                          (v0+"бил")
                          (v0+"бил")
                          (v0+"-")
                          (v0+"-")
                          (v0+"бъди") ;
  mkV143 : Str -> VTable ;
  mkV143 base = let v0 = tk 3 base
                in mkVerb (v0+"ъда")
                          (v0+"ъде")
                          (v0+"их")
                          (v0+"ъдех")
                          (v0+"ил")
                          (v0+"ъдел")
                          (v0+"-")
                          (v0+"ъдещ")
                          (v0+"ъди") ;
  mkV144 : Str -> VTable ;
  mkV144 base = let v0 = tk 1 base
                in mkVerb (v0+"а")
                          (v0+"е")
                          (v0+"ях")
                          (v0+"ях")
                          (v0+"ял")
                          (v0+"ял")
                          (v0+"-")
                          (v0+"-")
                          (v0+"-") ;
  mkV145 : Str -> VTable ;
  mkV145 base = let v0 = tk 2 base;
                    v1 = last (tk 1 base)
                in mkVerb (v0+v1+"а")
                          (v0+v1+"е")
                          (v0+v1+"ох")
                          (v0+v1+"ях")
                          (v0+"л")
                          (v0+v1+"ял")
                          (v0+v1+"ен")
                          (v0+v1+"ящ")
                          (v0+v1+"и") ;
  mkV145a : Str -> VTable ;
  mkV145a base = let v0 = tk 3 base;
                     v1 = last (tk 2 base)
                 in mkVerb (v0+v1+"са")
                           (v0+v1+"се")
                           (v0+v1+"сох")
                           (v0+v1+"сях")
                           (v0+v1+"съл")
                           (v0+v1+"сял")
                           (v0+v1+"сен")
                           (v0+v1+"сящ")
                           (v0+v1+"си") ;
  mkV145b : Str -> VTable ;
  mkV145b base = let v0 = tk 2 base
                 in mkVerb (v0+"та")
                           (v0+"те")
                           (v0+"тох")
                           (v0+"тях")
                           (v0+"ъл")
                           (v0+"тял")
                           (v0+"-")
                           (v0+"тящ")
                           (v0+"ти") ;
  mkV146 : Str -> VTable ;
  mkV146 base = let v0 = tk 2 base
                in mkVerb (v0+"да")
                          (v0+"де")
                          (v0+"дох")
                          (v0+"дех")
                          (v0+"шъл")
                          (v0+"дел")
                          (v0+"-")
                          (v0+"-")
                          (v0+"ди") ;
  mkV146a : Str -> VTable ;
  mkV146a base = let v0 = tk 3 base
                 in mkVerb (v0+"йда")
                           (v0+"йде")
                           (v0+"йдох")
                           (v0+"йдех")
                           (v0+"шъл")
                           (v0+"йдел")
                           (v0+"-")
                           (v0+"-")
                           (v0+"йди") ;
  mkV147 : Str -> VTable ;
  mkV147 base = let v0 = tk 3 base
                in mkVerb (v0+"яза")
                          (v0+"езе")
                          (v0+"язох")
                          (v0+"езех")
                          (v0+"язъл")
                          (v0+"езел")
                          (v0+"-")
                          (v0+"-")
                          (v0+"ез") ;
  mkV148 : Str -> VTable ;
  mkV148 base = let v0 = tk 2 base
                in mkVerb (v0+"ка")
                          (v0+"че")
                          (v0+"кох")
                          (v0+"чех")
                          (v0+"къл")
                          (v0+"чел")
                          (v0+"чен")
                          (v0+"чащ")
                          (v0+"чи") ;
  mkV149 : Str -> VTable ;
  mkV149 base = let v0 = tk 3 base
                in mkVerb (v0+"ека")
                          (v0+"ече")
                          (v0+"якох")
                          (v0+"ечех")
                          (v0+"якъл")
                          (v0+"ечел")
                          (v0+"ечен")
                          (v0+"-")
                          (v0+"ечи") ;
  mkV150 : Str -> VTable ;
  mkV150 base = let v0 = tk 1 base
                in mkVerb (v0+"а")
                          (v0+"е")
                          (v0+"ях")
                          (v0+"ях")
                          (v0+"ял")
                          (v0+"ял")
                          (v0+"ян")
                          (v0+"-")
                          (v0+"и") ;
  mkV150a : Str -> VTable ;
  mkV150a base = let v0 = tk 1 base
                 in mkVerb (v0+"а")
                           (v0+"е")
                           (v0+"ях")
                           (v0+"ях")
                           (v0+"ял")
                           (v0+"ял")
                           (v0+"-")
                           (v0+"-")
                           (v0+"и") ;
  mkV151 : Str -> VTable ;
  mkV151 base = let v0 = tk 1 base
                in mkVerb (v0+"а")
                          (v0+"е")
                          (v0+"ах")
                          (v0+"ях")
                          (v0+"ал")
                          (v0+"ял")
                          (v0+"ящ")
                          (v0+"ан")
                          (v0+"и") ;
  mkV152 : Str -> VTable ;
  mkV152 base = let v0 = tk 1 base
                in mkVerb (v0+"а")
                          (v0+"е")
                          (v0+"ах")
                          (v0+"ех")
                          (v0+"ал")
                          (v0+"ел")
                          (v0+"ат")
                          (v0+"-")
                          (v0+"и") ;
  mkV152a : Str -> VTable ;
  mkV152a base = let v0 = tk 4 base
                 in mkVerb (v0+"ягна")
                           (v0+"егне")
                           (v0+"ягнах")
                           (v0+"ягнех")
                           (v0+"ягнал")
                           (v0+"ягнел")
                           (v0+"ягнат")
                           (v0+"-")
                           (v0+"егни") ;
  mkV153 : Str -> VTable ;
  mkV153 base = let v0 = tk 3 base
                in mkVerb (v0+"яна")
                          (v0+"ене")
                          (v0+"янах")
                          (v0+"енех")
                          (v0+"янал")
                          (v0+"енел")
                          (v0+"янат")
                          (v0+"-")
                          (v0+"ени") ;
  mkV154 : Str -> VTable ;
  mkV154 base = let v0 = tk 1 base
                in mkVerb (v0+"я")
                          (v0+"е")
                          (v0+"ах")
                          (v0+"ех")
                          (v0+"ал")
                          (v0+"ел")
                          (v0+"ан")
                          (v0+"ещ")
                          (v0+"и") ;
  mkV155 : Str -> VTable ;
  mkV155 base = let v0 = tk 2 base
                in mkVerb (v0+"ча")
                          (v0+"че")
                          (v0+"ках")
                          (v0+"чех")
                          (v0+"кал")
                          (v0+"чел")
                          (v0+"-")
                          (v0+"чещ")
                          (v0+"чи") ;
  mkV156 : Str -> VTable ;
  mkV156 base = let v0 = tk 2 base
                in mkVerb (v0+"жа")
                          (v0+"же")
                          (v0+"зах")
                          (v0+"жех")
                          (v0+"зал")
                          (v0+"жел")
                          (v0+"зан")
                          (v0+"-")
                          (v0+"жи") ;
  mkV157 : Str -> VTable ;
  mkV157 base = let v0 = tk 3 base
                in mkVerb (v0+"ежа")
                          (v0+"еже")
                          (v0+"язах")
                          (v0+"ежех")
                          (v0+"язал")
                          (v0+"ежел")
                          (v0+"язан")
                          (v0+"ежещ")
                          (v0+"ежи") ;
  mkV158 : Str -> VTable ;
  mkV158 base = let v0 = tk 2 base
                in mkVerb (v0+"жа")
                          (v0+"же")
                          (v0+"гах")
                          (v0+"жех")
                          (v0+"гал")
                          (v0+"жел")
                          (v0+"ган")
                          (v0+"жещ")
                          (v0+"жи") ;
  mkV159 : Str -> VTable ;
  mkV159 base = let v0 = tk 2 base
                in mkVerb (v0+"ша")
                          (v0+"ше")
                          (v0+"сах")
                          (v0+"шех")
                          (v0+"сал")
                          (v0+"шел")
                          (v0+"сан")
                          (v0+"шещ")
                          (v0+"ши") ;
  mkV160 : Str -> VTable ;
  mkV160 base = let v0 = tk 2 base
                in mkVerb (v0+"ея")
                          (v0+"ее")
                          (v0+"ях")
                          (v0+"еех")
                          (v0+"ял")
                          (v0+"еел")
                          (v0+"ян")
                          (v0+"еещ")
                          (v0+"ей") ;
  mkV160a : Str -> VTable ;
  mkV160a base = let v0 = tk 2 base
                 in mkVerb (v0+"ея")
                           (v0+"ее")
                           (v0+"ах")
                           (v0+"еех")
                           (v0+"ал")
                           (v0+"еел")
                           (v0+"ан")
                           (v0+"еещ")
                           (v0+"ей") ;
  mkV161 : Str -> VTable ;
  mkV161 base = let v0 = tk 1 base
                in mkVerb (v0+"я")
                          (v0+"е")
                          (v0+"х")
                          (v0+"ех")
                          (v0+"л")
                          (v0+"ел")
                          (v0+"н")
                          (v0+"ещ")
                          (v0+"й") ;
  mkV161a : Str -> VTable ;
  mkV161a base = let v0 = tk 1 base
                 in mkVerb (v0+"я")
                           (v0+"е")
                           (v0+"х")
                           (v0+"ех")
                           (v0+"л")
                           (v0+"ел")
                           (v0+"т")
                           (v0+"ещ")
                           (v0+"й") ;
  mkV162 : Str -> VTable ;
  mkV162 base = let v0 = tk 1 base
                in mkVerb (v0+"я")
                          (v0+"е")
                          (v0+"ях")
                          (v0+"ех")
                          (v0+"ял")
                          (v0+"ел")
                          (v0+"-")
                          (v0+"ещ")
                          (v0+"й") ;
  mkV163 : Str -> VTable ;
  mkV163 base = let v0 = tk 1 base
                in mkVerb (v0+"я")
                          (v0+"е")
                          (v0+"х")
                          (v0+"ех")
                          (v0+"л")
                          (v0+"ел")
                          (v0+"т")
                          (v0+"ещ")
                          (v0+"й") ;
  mkV164 : Str -> VTable ;
  mkV164 base = let v0 = tk 2 base
                in mkVerb (v0+"ея")
                          (v0+"ее")
                          (v0+"ях")
                          (v0+"еех")
                          (v0+"ял")
                          (v0+"еел")
                          (v0+"ят")
                          (v0+"еещ")
                          (v0+"ей") ;
  mkV165 : Str -> VTable ;
  mkV165 base = let v0 = tk 1 base
                in mkVerb (v0+"а")
                          (v0+"е")
                          (v0+"ох")
                          (v0+"ех")
                          (v0+"-")
                          (v0+"ел")
                          (v0+"-")
                          (v0+"ещ")
                          (v0+"и") ;
  mkV166 : Str -> VTable ;
  mkV166 base = let v0 = tk 2 base
                in mkVerb (v0+"га")
                          (v0+"же")
                          (v0+"жах")
                          (v0+"жех")
                          (v0+"гъл")
                          (v0+"жел")
                          (v0+"-")
                          (v0+"жещ")
                          (v0+"-") ;
  mkV167 : Str -> VTable ;
  mkV167 base = let v0 = tk 2 base
                in mkVerb (v0+"ка")
                          (v0+"че")
                          (v0+"ках")
                          (v0+"чех")
                          (v0+"кал")
                          (v0+"чел")
                          (v0+"кан")
                          (v0+"чещ")
                          (v0+"чи") ;
  mkV168 : Str -> VTable ;
  mkV168 base = let v0 = tk 1 base
                in mkVerb (v0+"м")
                          (v0+"де")
                          (v0+"дох")
                          (v0+"дях")
                          (v0+"л")
                          (v0+"дял")
                          (v0+"ден")
                          (v0+"-")
                          (v0+"й") ;
  mkV169 : Str -> VTable ;
  mkV169 base = let v0 = tk 1 base
                in mkVerb (v0+"м")
                          (v0+"де")
                          (v0+"дох")
                          (v0+"дях")
                          (v0+"л")
                          (v0+"дял")
                          (v0+"ден")
                          (v0+"дещ")
                          (v0+"ж") ;
  mkV170 : Str -> VTable ;
  mkV170 base = let v0 = tk 3 base
                in mkVerb (v0+"ера")
                          (v0+"ере")
                          (v0+"рах")
                          (v0+"ерях")
                          (v0+"рал")
                          (v0+"ерял")
                          (v0+"ран")
                          (v0+"ерящ")
                          (v0+"ери") ;
  mkV171 : Str -> VTable ;
  mkV171 base = let v0 = tk 2 base
                in mkVerb (v0+"ма")
                          (v0+"ме")
                          (v0+"х")
                          (v0+"мех")
                          (v0+"л")
                          (v0+"мел")
                          (v0+"т")
                          (v0+"-")
                          (v0+"ми") ;
  mkV172 : Str -> VTable ;
  mkV172 base = let v0 = tk 4 base
                in mkVerb (v0+"ълна")
                          (v0+"ълне")
                          (v0+"лех")
                          (v0+"ълнех")
                          (v0+"лел")
                          (v0+"ълнел")
                          (v0+"ълнат")
                          (v0+"ълнещ")
                          (v0+"ълни") ;
  mkV173 : Str -> VTable ;
  mkV173 base = let v0 = tk 1 base
                in mkVerb (v0+"я")
                          (v0+"и")
                          (v0+"их")
                          (v0+"ех")
                          (v0+"ил")
                          (v0+"ел")
                          (v0+"ен")
                          (v0+"ещ")
                          (v0+"и") ;
  mkV174 : Str -> VTable ;
  mkV174 base = let v0 = tk 1 base
                in mkVerb (v0+"я")
                          (v0+"и")
                          (v0+"их")
                          (v0+"ях")
                          (v0+"ил")
                          (v0+"ял")
                          (v0+"ен")
                          (v0+"ящ")
                          (v0+"и") ;
  mkV175 : Str -> VTable ;
  mkV175 base = let v0 = tk 1 base
                in mkVerb (v0+"я")
                          (v0+"и")
                          (v0+"их")
                          (v0+"ях")
                          (v0+"ил")
                          (v0+"ял")
                          (v0+"ен")
                          (v0+"ящ")
                          (v0+"й") ;
  mkV176 : Str -> VTable ;
  mkV176 base = let v0 = tk 1 base
                in mkVerb (v0+"а")
                          (v0+"и")
                          (v0+"их")
                          (v0+"ех")
                          (v0+"ил")
                          (v0+"ел")
                          (v0+"ен")
                          (v0+"ещ")
                          (v0+"и") ;
  mkV177 : Str -> VTable ;
  mkV177 base = let v0 = tk 1 base
                in mkVerb (v0+"я")
                          (v0+"и")
                          (v0+"ях")
                          (v0+"ях")
                          (v0+"ял")
                          (v0+"ял")
                          (v0+"ян")
                          (v0+"ящ")
                          (v0+"и") ;
  mkV178 : Str -> VTable ;
  mkV178 base = let v0 = tk 1 base
                in mkVerb (v0+"а")
                          (v0+"и")
                          (v0+"ах")
                          (v0+"ех")
                          (v0+"ал")
                          (v0+"ел")
                          (v0+"-")
                          (v0+"ащ")
                          (v0+"и") ;
  mkV179 : Str -> VTable ;
  mkV179 base = let v0 = tk 4 base
                in mkVerb (v0+"ържа")
                          (v0+"ържи")
                          (v0+"ържах")
                          (v0+"ържех")
                          (v0+"ържал")
                          (v0+"ържел")
                          (v0+"ържан")
                          (v0+"ържащ")
                          (v0+"ръж") ;
  mkV180 : Str -> VTable ;
  mkV180 base = let v0 = tk 1 base
                in mkVerb (v0+"я")
                          (v0+"и")
                          (v0+"ях")
                          (v0+"ях")
                          (v0+"ял")
                          (v0+"ял")
                          (v0+"-")
                          (v0+"ящ")
                          (v0+"й") ;
  mkV181 : Str -> VTable ;
  mkV181 base = let v0 = tk 2 base
                in mkVerb (v0+"дя")
                          (v0+"ди")
                          (v0+"дях")
                          (v0+"дех")
                          (v0+"дял")
                          (v0+"дел")
                          (v0+"дян")
                          (v0+"-")
                          (v0+"ж") ;
  mkV182 : Str -> VTable ;
  mkV182 base = let v0 = tk 1 base
                in mkVerb (v0+"я")
                          (v0+"и")
                          (v0+"ах")
                          (v0+"ях")
                          (v0+"ал")
                          (v0+"ял")
                          (v0+"-")
                          (v0+"ящ")
                          (v0+"и") ;
  mkV183 : Str -> VTable ;
  mkV183 base = let v0 = tk 3 base
                in mkVerb (v0+"ежа")
                          (v0+"ежи")
                          (v0+"язах")
                          (v0+"ежех")
                          (v0+"язал")
                          (v0+"ежел")
                          (v0+"язан")
                          (v0+"ежещ")
                          (v0+"ежи") ;
  mkV184 : Str -> VTable ;
  mkV184 base = let v0 = tk 3 base
                in mkVerb (v0+"еля")
                          (v0+"ели")
                          (v0+"лях")
                          (v0+"елех")
                          (v0+"лял")
                          (v0+"елел")
                          (v0+"лян")
                          (v0+"елещ")
                          (v0+"ели") ;
  mkV185 : Str -> VTable ;
  mkV185 base = let v0 = tk 3 base
                in mkVerb (v0+"оля")
                          (v0+"оли")
                          (v0+"лах")
                          (v0+"олех")
                          (v0+"лал")
                          (v0+"олел")
                          (v0+"лан")
                          (v0+"олещ")
                          (v0+"оли") ;
  mkV186 : Str -> VTable ;
  mkV186 base = let v0 = tk 2 base
                in mkVerb (v0+"ам")
                          (v0+"а")
                          (v0+"ах")
                          (v0+"ах")
                          (v0+"ал")
                          (v0+"ал")
                          (v0+"ан")
                          (v0+"ащ")
                          (v0+"ай") ;
  mkV187 : Str -> VTable ;
  mkV187 base = let v0 = tk 2 base
                in mkVerb (v0+"ям")
                          (v0+"я")
                          (v0+"ях")
                          (v0+"ях")
                          (v0+"ял")
                          (v0+"ял")
                          (v0+"ян")
                          (v0+"ящ")
                          (v0+"яй") ;

  adjAdv : A -> Str -> A =
    \a,adv -> {s = a.s; adv = adv; lock_A=<>} ;
}