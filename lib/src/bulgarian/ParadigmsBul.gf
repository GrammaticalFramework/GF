--# -path=.:../abstract:../common:../prelude
--# -coding=cp1251

resource ParadigmsBul = MorphoFunsBul ** open
  Predef,
  Prelude,
  MorphoBul,
  CatBul
  in {
  flags coding=cp1251 ;

oper
  mkN001 : Str -> N ; -- numbers refer to Krustev, Bulg. Morph. in 187 Tables
  mkN001 base = {s = table {
                       NF Sg Indef => base ;
                       NF Sg Def   => base+"�" ;
                       NF Pl Indef => base+"���" ;
                       NF Pl Def   => base+"�����" ;
                       NFSgDefNom  => base+"��" ;
                       NFPlCount   => base+"�" ;
                       NFVocative  => base+"�"
                     } ;
                 rel = \\_ => base ; relPost = False ;
                 g = AMasc NonHuman ;
                 lock_N = <>
                } ;
  mkN002 : Str -> N ;
  mkN002 base = let v0 = tk 2 base;
                    v1 = last (base);
                    g  = AMasc NonHuman
                in {s = table {
                          NF Sg Indef => v0+"�"+v1 ;
                          NF Sg Def   => v0+"�"+v1+"�" ;
                          NF Pl Indef => v0+"�"+v1+"���" ;
                          NF Pl Def   => v0+"�"+v1+"�����" ;
                          NFSgDefNom  => v0+"�"+v1+"�" ;
                          NFPlCount   => v0+"�"+v1+"�" ;
                          NFVocative  => v0+"�"+v1
                        } ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   } ;
  mkN002a : Str -> N ;
  mkN002a base = let v0 = tk 2 base;
                     v1 = last (base);
                     g  = AMasc NonHuman
                 in {s = mkNoun (v0+"�"+v1)
                                (v0+"�"+v1+"���")
                                (v0+"�"+v1+"�")
                                (v0+"�"+v1)
                                g ;
                     rel = \\_ => base ; relPost = False ;
                     g   = g ;
                     lock_N = <>
                    } ;
  mkN003 : Str -> N ;
  mkN003 base = let v0 = tk 3 base;
                    v1 = last (base);
                    g  = AMasc NonHuman
                in {s = table {
                          NF Sg Indef => v0+"��"+v1 ;
                          NF Sg Def   => v0+"��"+v1+"�" ;
                          NF Pl Indef => v0+"��"+v1+"���" ;
                          NF Pl Def   => v0+"��"+v1+"�����" ;
                          NFSgDefNom  => v0+"��"+v1+"��" ;
                          NFPlCount   => v0+"��"+v1+"���" ;
                          NFVocative  => v0+"��"+v1
                        } ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   } ;
  mkN004 : Str -> N ;
  mkN004 base = let v0 = tk 4 base;
                    g  = AMasc NonHuman
                in {s = mkNoun (v0+"����")
                               (v0+"������")
                               (v0+"�����")
                               (v0+"����")
                               g;
                    rel = \\_ => base; relPost = False;
                    g   = g ;
                    lock_N = <>
                   } ;
  mkN005 : Str -> N ;
  mkN005 base = let v0 = base;
                    g  = AMasc NonHuman
                in {s = mkNoun (v0)
                               (v0+"���")
                               (v0+"�")
                               (v0)
                               g;
                    rel = \\_ => base; relPost = False;
                    g   = g ;
                    lock_N = <>
                   } ;
  mkN006 : Str -> N ;
  mkN006 base = let v0 = base;
                    g  = AMasc NonHuman
                in {s = mkNoun (v0)
                               (v0+"���")
                               (v0+"�")
                               (v0)
                               g;
                    rel = \\_ => base; relPost = False;
                    g   = g ;
                    lock_N = <>
                   } ;
  mkN007 : Str -> N ;
  mkN007 base = {s = table {
                       NF Sg Indef => base ;
                       NF Sg Def   => base+"�" ;
                       NF Pl Indef => base+"�" ;
                       NF Pl Def   => base+"���" ;
                       NFSgDefNom  => base+"��" ;
                       NFPlCount   => base+"�" ;
                       NFVocative  => base+"�"
                     } ;
                 rel = \\_ => base; relPost = False;
                 g   = AMasc NonHuman;
                 lock_N = <>
                } ;
  mkN007b : Str -> N ;
  mkN007b base = let v0 = base;
                     g  = AMasc NonHuman
                 in {s = mkNoun (v0)
                                (v0+"�")
                                (v0+"�")
                                (v0+"�")
                                g ;
                     rel = \\_ => base; relPost = False;
                     g   = g ;
                     lock_N = <>                     
                    } ;
  mkN007a : Str -> N ;
  mkN007a base = {s = table {
                       NF Sg Indef => base ;
                       NF Sg Def   => base+"�" ;
                       NF Pl Indef => base+"�" ;
                       NF Pl Def   => base+"���" ;
                       NFSgDefNom  => base+"��" ;
                       NFPlCount   => base+"�" ;
                       NFVocative  => base+"�"
                     } ;
                  rel = (mkA078 (base+"���")).s; relPost = False;
                  g   = AMasc Human ;
                  lock_N = <>
                 } ;
  mkN008 : Str -> N ;
  mkN008 base = let v0 = tk 2 base;
                    v1 = last base;
                    g  = AMasc NonHuman
                in {s = mkNoun (v0+"�"+v1)
                               (v0+v1+"�")
                               (v0+"�"+v1+"�")
                               (v0+"�"+v1+"�")
                               g ;
                    rel = \\_ => base; relPost = False;
                    g   = g ;
                    lock_N = <>
                   } ;
  mkN008b : Str -> N ;
  mkN008b base = let v0 = tk 2 base;
                     v1 = last (base);
                     g  = AMasc NonHuman
                 in {s = mkNoun (v0+"�"+v1)
                                (v0+v1+"�")
                                (v0+"�"+v1+"�")
                                (v0+"�"+v1+"�")
                                g ;
                     rel = \\_ => base ; relPost = False ;
                     g   = g ;
                     lock_N = <>
                    } ;
  mkN008c : Str -> N ;
  mkN008c base = let v0 = tk 2 base;
                     v1 = last (base);
                     g  = AMasc NonHuman
                 in {s = mkNoun (v0+"�"+v1)
                                (v0+v1+"�")
                                (v0+"�"+v1+"�")
                                (v0+v1+"�")
                                g ;
                     rel = \\_ => base ; relPost = False ;
                     g   = g ;
                     lock_N = <>
                    } ;
  mkN008a : Str -> N ;
  mkN008a base = let v0 = tk 2 base;
                     g  = AMasc Human
                 in {s = mkNoun (v0+"��")
                                (v0+"��")
                                (v0+"��")
                                (v0+"���")
                                g ;
                     rel = (mkA078 (v0+"���")).s ; relPost = False;
                     g   = g ;
                     lock_N = <>
                    } ;
  mkN009 : Str -> N ;
  mkN009 base = let v0 = tk 2 base;
                    v1 = last (base);
                    g  = AMasc NonHuman
                in {s = mkNoun (v0+"�"+v1)
                               (v0+v1+"�")
                               (v0+"�"+v1+"�")
                               (v0+v1+"�")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   } ;
  mkN009a : Str -> N ;
  mkN009a base = let v0 = tk 2 base;
                     g  = AMasc NonHuman
                 in {s = mkNoun (v0+"��")
                                (v0+"����")
                                (v0+"���")
                                (v0+"��")
                                g ;
                     rel = \\_ => base ; relPost = False ;
                     g   = g ;
                     lock_N = <>
                    } ;
  mkN010 : Str -> N ;
  mkN010 base = let v0 = tk 2 base;
                    g  = AMasc NonHuman
                in {s = mkNoun (v0+"��")
                               (v0+"��")
                               (v0+"��")
                               (v0+"��")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN011 : Str -> N ;
  mkN011 base = let v0 = tk 2 base;
                    g  = AMasc NonHuman
                in {s = table {
                          NF Sg Indef => v0+"��" ;
                          NF Sg Def   => v0+"��" ;
                          NF Pl Indef => v0+"��" ;
                          NF Pl Def   => v0+"����" ;
                          NFSgDefNom  => v0+"���" ;
                          NFPlCount   => v0+"��" ;
                          NFVocative  => v0+"��"
                        } ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN012 : Str -> N ;
  mkN012 base = let v0 = tk 3 base;
                    g  = AMasc NonHuman
                in {s = mkNoun (v0+"���")
                               (v0+"����")
                               (v0+"����")
                               (v0+"����")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN013 : Str -> N ;
  mkN013 base = let v0 = tk 2 base;
                    g  = AMasc Human
                in {s = mkNoun (v0+"��")
                               (v0+"���")
                               (v0+"���")
                               (v0+"���")
                               g ;
                    rel = (mkA078 (base+"����")).s; relPost = False;
                    g   = g ;
                    lock_N = <>
                   };
  mkN014 : Str -> N ;
  mkN014 base = let v0 = tk 1 base;
                    g  = AMasc NonHuman
                in {s = mkNoun (v0+"�")
                               (v0+"��")
                               (v0+"��")
                               (v0+"�")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN014a : Str -> N ;
  mkN014a base = let v0 = tk 1 base;
                     g  = AMasc Human
                 in {s = mkNoun (v0+"�")
                                (v0+"��")
                                (v0+"��")
                                (v0+"��")
                                g ;
                     rel = (mkA078 (v0+"�����")).s; relPost = False;
                     g   = g ;
                     lock_N = <>
                    };
  mkN015 : Str -> N ;
  mkN015 base = let v0 = tk 1 base;
                    g  = AMasc NonHuman
                in {s = mkNoun (v0+"�")
                               (v0+"��")
                               (v0+"��")
                               (v0+"��")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN015a : Str -> N ;
  mkN015a base = let v0 = tk 1 base;
                     g  = AMasc Human
                 in {s = mkNoun (v0+"�")
                                (v0+"��")
                                (v0+"��")
                                (v0+"��")
                                g ;
                     rel = \\_ => base ; relPost = False ;
                     g   = g ;
                     lock_N = <>
                    };
  mkN016 : Str -> N ;
  mkN016 base = let v0 = tk 1 base;
                    g  = AMasc NonHuman
                in {s = mkNoun (v0+"�")
                               (v0+"��")
                               (v0+"��")
                               (v0+"��")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN016a : Str -> N ;
  mkN016a base = let v0 = tk 1 base;
                     g  = AMasc NonHuman
                 in {s = mkNoun (v0+"�")
                                (v0+"��")
                                (v0+"��")
                                (v0+"��")
                                g ;
                     rel = \\_ => base ; relPost = False ;
                     g   = g ;
                     lock_N = <>
                    };
  mkN017 : Str -> N ;
  mkN017 base = let v0 = tk 1 base;
                    g  = AMasc NonHuman
                in {s = mkNoun (v0+"�")
                               (v0+"��")
                               (v0+"��")
                               (v0+"��")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN018 : Str -> N ;
  mkN018 base = let v0 = tk 2 base;
                    g  = AMasc NonHuman
                in {s = mkNoun (v0+"��")
                               (v0+"�")
                               (v0+"�")
                               (v0+"���")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN018a : Str -> N ;
  mkN018a base = let v0 = tk 2 base;
                     v1 = last (base);
                     g  = AMasc NonHuman
                 in {s = mkNoun (v0+"�"+v1)
                                (v0+"�")
                                (v0+"�")
                                (v0+"�"+v1+"�")
                                g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN019 : Str -> N ;
  mkN019 base = let v0 = tk 2 base;
                    g  = AMasc Human
                in {s = mkNoun (v0+"��")
                               (v0+"��")
                               (v0+"��")
                               (v0+"��")
                               g ;
                    rel = (mkA078 (v0+"���")).s; relPost = False;
                    g   = g ;
                    lock_N = <>
                   };
  mkN019a : Str -> N ;
  mkN019a base = let v0 = tk 2 base;
                     g  = AMasc NonHuman
                 in {s = mkNoun (v0+"��")
                                (v0+"���")
                                (v0+"���")
                                (v0+"�")
                                g ;
                     rel = \\_ => base ; relPost = False ;
                     g   = g ;
                     lock_N = <>
                    };
  mkN020 : Str -> N ;
  mkN020 base = let v0 = tk 3 base;
                    v1 = last (tk 2 base);
                    g  = AMasc Human
                in {s = mkNoun (v0+v1+"��")
                               (v0+"�"+v1+"��")
                               (v0+"�"+v1+"��")
                               (v0+v1+"���")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN021 : Str -> N ;
  mkN021 base = let v0 = tk 3 base;
                    g  = AMasc Human
                in {s = mkNoun (v0+"���")
                               (v0+"��")
                               (v0+"��")
                               (v0+"����")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN022 : Str -> N ;
  mkN022 base = let v0 = base;
                    g  = AMasc NonHuman
                in {s = mkNoun (v0)
                               (v0+"�")
                               (v0+"�")
                               (v0+"�")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN023 : Str -> N ;
  mkN023 base = let v0 = tk 2 base;
                    g  = AMasc Human
                in {s = mkNoun (v0+"��")
                               (v0+"�")
                               (v0+"�")
                               (v0+"���")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN024a : Str -> N ;
  mkN024a base = let v0 = tk 1 base;
                     g  = AMasc Human
                 in {s = mkNoun (v0+"�")
                                (v0+"��")
                                (v0+"��")
                                (v0+"��")
                                g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN024 : Str -> N ;
  mkN024 base = let v0 = base;
                    g  = AMasc Human
                in {s = mkNoun (v0)
                               (v0+"�")
                               (v0+"�")
                               (v0+"�")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN025 : Str -> N ;
  mkN025 base = let v0 = base;
                    g  = AMasc Human
                in {s = mkNoun (v0)
                               (v0+"�")
                               (v0+"�")
                               (v0+"�")
                               g ;
                    rel = (mkA078 (base+"���")).s; relPost = False;
                    g   = g ;
                    lock_N = <>
                   };
  mkN026 : Str -> N ;
  mkN026 base = let v0 = base;
                    g  = AMasc NonHuman
                in {s = mkNoun (v0)
                               (v0+"�����")
                               (v0+"�����")
                               (v0+"�")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN027 : Str -> N ;
  mkN027 base = let v0 = tk 2 base;
                    g  = AMasc NonHuman
                in {s = mkNoun (v0+"��")
                               (v0+"����")
                               (v0+"���")
                               (v0+"�")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN028 : Str -> N ;
  mkN028 base = let v0 = tk 1 base;
                    g  = AMasc NonHuman
                in {s = mkNoun (v0+"�")
                               (v0+"���")
                               (v0+"�")
                               (v0+"�")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN028a : Str -> N ;
  mkN028a base = let v0 = tk 1 base;
                     g  = AMasc NonHuman
                 in {s = mkNoun (v0+"�")
                                (v0+"����")
                                (v0+"�")
                                (v0+"��")
                                g ;
                     rel = \\_ => base ; relPost = False ;
                     g   = g ;
                     lock_N = <>
                    };
  mkN029 : Str -> N ;
  mkN029 base = let v0 = base;
                    g  = AMasc Human
                in {s = mkNoun (v0)
                               (v0+"����")
                               (v0+"����")
                               (v0+"��")
                               g ;
                    rel = (mkA078 (base+"���")).s; relPost = False;
                    g   = g ;
                    lock_N = <>
                   };
  mkN030 : Str -> N ;
  mkN030 base = let v0 = tk 2 base;
                    g  = AMasc NonHuman
                in {s = mkNoun (v0+"��")
                               (v0+"�����")
                               (v0+"���")
                               (v0+"�")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN031 : Str -> N ;
  mkN031 base = let v0 = base;
                    g  = AMasc NonHuman
                in {s = mkNoun (v0)
                               (v0+"�")
                               (v0+"�")
                               (v0+"�")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN031a : Str -> N ;
  mkN031a base = let v0 = base;
                     g  = AMasc Human
                 in {s = mkNoun (v0)
                                (v0+"�")
                                (v0+"�")
                                (v0+"�")
                                g ;
                     rel = (mkA078 (base+"���")).s ; relPost = False ;
                     g   = g ;
                     lock_N = <>
                    };
  mkN032 : Str -> N ;
  mkN032 base = let v0 = base ;
                    v1 = tk 1 base ;
                    g  = AMasc NonHuman
                in {s = mkNoun (v0)
                               (v1+"�")
                               (v1+"�")
                               (v0+"�")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN032a : Str -> N ;
  mkN032a base = let v0 = tk 1 base;
                     g  = AMasc Human
                 in {s = mkNoun (v0+"�")
                                (v0+"�")
                                (v0+"�")
                                (v0+"�")
                                g ;
                     rel = (mkA078 (base+"���")).s ; relPost = False ;
                     g   = g ;
                     lock_N = <>
                    };
  mkN033 : Str -> N ;
  mkN033 base = let v0 = tk 2 base;
                    g  = AMasc NonHuman
                in {s = mkNoun (v0+"��")
                               (v0+"��")
                               (v0+"���")
                               (v0+"���")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN034 : Str -> N ;
  mkN034 base = let v0 = tk 2 base;
                    g  = AMasc NonHuman
                in {s = mkNoun (v0+"��")
                               (v0+"��")
                               (v0+"���")
                               (v0+"�")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN035 : Str -> N ;
  mkN035 base = let v0 = base;
                    g  = AMasc NonHuman
                in {s = mkNoun (v0)
                               (v0+"�")
                               (v0+"�")
                               (v0+"�")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN035a : Str -> N ;
  mkN035a base = let v0 = base;
                     g  = AMasc Human
                 in {s = mkNoun (v0)
                                (v0+"�")
                                (v0+"�")
                                (v0+"�")
                                g ;
                     rel = (mkA078 (base+"���")).s ; relPost = False ;
                     g   = g ;
                     lock_N = <>                     
                    };
  mkN036 : Str -> N ;
  mkN036 base = let v0 = tk 1 base;
                    g  = AMasc NonHuman
                in {s = mkNoun (v0+"�")
                               (v0+"���")
                               (v0+"�")
                               (v0+"�")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN037 : Str -> N ;
  mkN037 base = let v0 = base;
                    g  = AMasc NonHuman
                in {s = mkNoun (v0)
                               (v0+"���")
                               (v0+"�")
                               (v0+"�")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN038 : Str -> N ;
  mkN038 base = let v0 = tk 1 base;
                    g  = AMasc Human
                in {s = mkNoun (v0+"�")
                               (v0+"�")
                               (v0+"�")
                               (v0+"�")
                               g ;
                    rel = (mkAdjective base (base+"��") (base+"��") base (base+"��") base (base+"��") (v0+"�") (v0+"���")).s ;
                    relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN039 : Str -> N ;
  mkN039 base = let v0 = tk 1 base;
                    g  = AMasc Human
                in {s = mkNoun (v0+"�")
                               (v0+"�")
                               (v0+"�")
                               (v0+"�o")
                               g ;
                    rel = (mkA078 (v0+"����")).s ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN040 : Str -> N ;
  mkN040 base = let v0 = tk 1 base;
                    g  = AMasc Human
                in {s = mkNoun (v0+"�")
                               (v0+"����")
                               (v0+"����")
                               (v0+"�")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN040a : Str -> N ;
  mkN040a base = let v0 = base;
                     g  = AMasc NonHuman
                 in {s = mkNoun (v0)
                                (v0+"�")
                                (v0+"�")
                                (v0+"�")
                                g ;
                     rel = \\_ => base ; relPost = False ;
                     g   = g ;
                     lock_N = <>
                    };
  mkN041 : Str -> N ;
  mkN041 base = let v0 = tk 1 base;
                    g  = AFem
                in {s = mkNoun (v0+"�")
                               (v0+"�")
                               (v0+"�")
                               (v0+"�")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN041a : Str -> N ;
  mkN041a base = let v0 = tk 1 base;
                     g  = AFem
                 in {s = mkNoun (v0+"�")
                                (v0+"�")
                                (v0+"�")
                                (v0+"�")
                                g ;
                     rel = \\_ => base ; relPost = False ;
                     g   = g ;
                     lock_N = <>
                    };
  mkN041b : Str -> N ;
  mkN041b base = let v0 = tk 1 base;
                     g  = AFem
                 in {s = mkNoun (v0+"�")
                                (v0+"�")
                                (v0+"�")
                                (v0+"�")
                                g ;
                     rel = \\_ => base ; relPost = False ;
                     g   = g ;
                     lock_N = <>
                   };
  mkN042 : Str -> N ;
  mkN042 base = let v0 = base;
                    g  = AFem
                in {s = mkNoun (v0)
                               (v0)
                               (v0)
                               (v0)
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                  };
  mkN043 : Str -> N ;
  mkN043 base = let v0 = tk 3 base;
                    v1 = last (tk 1 base);
                    g  = AFem
                in {s = mkNoun (v0+"�"+v1+"�")
                               (v0+"�"+v1+"�")
                               (v0+"�"+v1+"�")
                               (v0+"�")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                  };
  mkN043a : Str -> N ;
  mkN043a base = let v0 = tk 4 base;
                     v1 = last (tk 2 base);
                     g  = AFem
                 in {s = mkNoun (v0+"�"+v1+"��")
                                (v0+"�"+v1+"��")
                                (v0+"�"+v1+"��")
                                (v0+"�")
                                g ;
                     rel = \\_ => base ; relPost = False ;
                     g   = g ;
                     lock_N = <>
                    };
  mkN044 : Str -> N ;
  mkN044 base = let v0 = tk 1 base;
                    g  = AFem
                in {s = mkNoun (v0+"�")
                               (v0+"�")
                               (v0+"�")
                               (v0+"�")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                  };
  mkN045 : Str -> N ;
  mkN045 base = let v0 = tk 2 base;
                    g  = AFem
                in {s = mkNoun (v0+"��")
                               (v0+"��")
                               (v0+"��")
                               (v0+"��")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN046 : Str -> N ;
  mkN046 base = let v0 = tk 2 base;
                    g  = AFem
                in {s = mkNoun (v0+"��")
                               (v0+"��")
                               (v0+"��")
                               (v0+"��")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN047 : Str -> N ;
  mkN047 base = let v0 = tk 1 base;
                    g  = AFem
                in {s = mkNoun (v0+"�")
                               (v0+"�")
                               (v0+"�")
                               (v0+"�")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN048 : Str -> N ;
  mkN048 base = let v0 = tk 1 base;
                    g  = AFem
                in {s = mkNoun (v0+"�")
                               (v0+"�")
                               (v0+"�")
                               (v0+"��")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN049 : Str -> N ;
  mkN049 base = let v0 = base;
                    g  = AFem
                in {s = mkNoun (v0)
                               (v0+"�")
                               (v0+"�")
                               (v0)
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN050 : Str -> N ;
  mkN050 base = let v0 = tk 2 base;
                    g  = AFem
                in {s = mkNoun (v0+"��")
                               (v0+"��")
                               (v0+"��")
                               (v0+"��")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN051 : Str -> N ;
  mkN051 base = let v0 = tk 2 base;
                    v1 = last (base);
                    g  = AFem
                in {s = mkNoun (v0+"�"+v1)
                               (v0+v1+"�")
                               (v0+v1+"�")
                               (v0+"�"+v1)
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN052 : Str -> N ;
  mkN052 base = let v0 = tk 5 base;
                    g  = AFem
                in {s = mkNoun (v0+"�����")
                               (v0+"������")
                               (v0+"������")
                               (v0+"�����")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN052a : Str -> N ;
  mkN052a base = let v0 = tk 6 base;
                     g  = AFem
                 in {s = mkNoun (v0+"������")
                                (v0+"�������")
                                (v0+"�������")
                                (v0+"������")
                                g ;
                     rel = \\_ => base ; relPost = False ;
                     g   = g ;
                     lock_N = <>
                    };
  mkN053 : Str -> N ;
  mkN053 base = let v0 = tk 3 base;
                    v1 = last (base);
                    g  = AFem
                in {s = mkNoun (v0+"��"+v1)
                               (v0+"��"+v1+"�")
                               (v0+"��"+v1+"�")
                               (v0+"��"+v1)
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN054 : Str -> N ;
  mkN054 base = let v0 = tk 1 base;
                    g  = ANeut
                in {s = mkNoun (v0+"�")
                               (v0+"�")
                               (v0+"�")
                               (v0+"�")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN055 : Str -> N ;
  mkN055 base = let v0 = tk 1 base;
                    g  = ANeut
                in {s = mkNoun (v0+"�")
                               (v0+"�")
                               (v0+"�")
                               (v0+"�")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN056 : Str -> N ;
  mkN056 base = let v0 = tk 1 base;
                    g  = ANeut
                in {s = mkNoun (v0+"�")
                               (v0+"�")
                               (v0+"�")
                               (v0+"�")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN057 : Str -> N ;
  mkN057 base = let v0 = tk 3 base;
                    v1 = last (tk 1 base);
                    g  = ANeut
                in {s = mkNoun (v0+"�"+v1+"�")
                               (v0+"�"+v1+"�")
                               (v0+"�"+v1+"�")
                               (v0+"�"+v1+"�")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN057a : Str -> N ;
  mkN057a base = let v0 = tk 4 base;
                     g  = ANeut
                 in {s = mkNoun (v0+"����")
                                (v0+"����")
                                (v0+"����")
                                (v0+"����")
                                g ;
                     rel = \\_ => base ; relPost = False ;
                     g   = g ;
                     lock_N = <>
                    };
  mkN058 : Str -> N ;
  mkN058 base = let v0 = tk 3 base;
                    g  = ANeut
                in {s = mkNoun (v0+"���")
                               (v0+"���")
                               (v0+"���")
                               (v0+"���")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN059 : Str -> N ;
  mkN059 base = let v0 = tk 1 base;
                    g  = ANeut
                in {s = mkNoun (v0+"�")
                               (v0+"���")
                               (v0+"���")
                               (v0+"�")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN060 : Str -> N ;
  mkN060 base = let v0 = tk 1 base;
                    g  = ANeut
                in {s = mkNoun (v0+"�")
                               (v0+"���")
                               (v0+"���")
                               (v0+"�")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN061 : Str -> N ;
  mkN061 base = let v0 = tk 1 base;
                    g  = ANeut
                in {s = mkNoun (v0+"�")
                               (v0+"�")
                               (v0+"�")
                               (v0+"�")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN062 : Str -> N ;
  mkN062 base = let v0 = tk 1 base;
                    g  = ANeut
                in {s = mkNoun (v0+"�")
                               (v0+"�")
                               (v0+"�")
                               (v0+"�")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN063 : Str -> N ;
  mkN063 base = let v0 = tk 2 base;
                    g  = ANeut
                in {s = mkNoun (v0+"��")
                               (v0+"��")
                               (v0+"��")
                               (v0+"��")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN064 : Str -> N ;
  mkN064 base = let v0 = tk 2 base;
                    g  = ANeut
                in {s = mkNoun (v0+"��")
                               (v0+"��")
                               (v0+"��")
                               (v0+"��")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g;
                    lock_N = <>
                   };
  mkN065 : Str -> N ;
  mkN065 base = let v0 = base;
                    g  = ANeut
                in {s = mkNoun (v0)
                               (v0+"��")
                               (v0+"��")
                               (v0)
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN066 : Str -> N ;
  mkN066 base = let v0 = tk 1 base;
                    g  = ANeut
                in {s = mkNoun (v0+"�")
                               (v0+"�")
                               (v0+"�")
                               (v0+"�")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
 mkN067 : Str -> N ;
  mkN067 base = let v0 = tk 2 base;
                    g  = ANeut
                in {s = mkNoun (v0+"��")
                               (v0+"��")
                               (v0+"��")
                               (v0+"��")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN068 : Str -> N ;
  mkN068 base = let v0 = tk 1 base;
                    g  = ANeut
                in {s = mkNoun (v0+"�")
                               (v0+"�")
                               (v0+"�")
                               (v0+"�")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN069 : Str -> N ;
  mkN069 base = let v0 = base;
                    g  = ANeut
                in {s = mkNoun (v0)
                               (v0+"��")
                               (v0+"��")
                               (v0)
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN070 : Str -> N ;
  mkN070 base = let v0 = base;
                    g  = ANeut
                in {s = mkNoun (v0)
                               (v0+"��")
                               (v0+"��")
                               (v0)
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN071 : Str -> N ;
  mkN071 base = let v0 = tk 1 base;
                    g  = ANeut
                in {s = mkNoun (v0+"�")
                               (v0+"��")
                               (v0+"��")
                               (v0+"�")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN072 : Str -> N ;
  mkN072 base = let v0 = tk 1 base;
                    g  = ANeut
                in {s = mkNoun (v0+"�")
                               (v0+"�")
                               (v0+"�")
                               (v0+"�")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN073 : Str -> N ;
  mkN073 base = let v0 = base;
                    g  = ANeut
                in {s = mkNoun (v0)
                               (v0+"��")
                               (v0+"��")
                               (v0)
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN074 : Str -> N ;
  mkN074 base = let v0 = base
                in { s = table {
                           NF Sg _     => v0 ;
                           NF Pl Indef => v0 ;
                           NF Pl Def   => v0+"��" ;
                           NFSgDefNom  => v0 ;
                           NFPlCount   => v0 ;
                           NFVocative  => v0
                         } ;
                     rel = \\_ => base ; relPost = False ;
                     g = ANeut ;
                     lock_N = <>
                   } ;
  mkN075 : Str -> N ;
  mkN075 base = let v0 = base
                in { s = table {
                           NF Sg _     => Prelude.nonExist ;
                           NF Pl Indef => v0 ;
                           NF Pl Def   => v0+"��" ;
                           NFSgDefNom  => Prelude.nonExist ;
                           NFPlCount   => v0 ;
                           NFVocative  => v0
                         } ;
                     rel = \\_ => base ; relPost = False ;
                     g = ANeut ;
                     lock_N = <>
                   } ;
  mkN076 : Str -> N ;
  mkN076 base = let v0 = tk 1 base;
                    g  = ANeut
                in {s = mkNoun (v0+"�")
                               (v0+"���")
                               (v0+"���")
                               (v0+"�")
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkN077 : Str -> N ;
  mkN077 base = let v0 = base;
                    g  = AFem
                in {s = mkNoun (v0)
                               nonExist
                               nonExist
                               (v0)
                               g ;
                    rel = \\_ => base ; relPost = False ;
                    g   = g ;
                    lock_N = <>
                   };
  mkA076 : Str -> A ;
  mkA076 base = let v0 = base
                in mkAdjective (v0)
                               (v0+"��")
                               (v0+"���")
                               (v0+"�")
                               (v0+"���")
                               (v0+"�")
                               (v0+"���")
                               (v0+"�")
                               (v0+"���") ;
  mkA077 : Str -> A ;
  mkA077 base = let v0 = base
                in mkAdjective (v0)
                               (v0+"��")
                               (v0+"���")
                               (v0+"�")
                               (v0+"���")
                               (v0+"�")
                               (v0+"���")
                               (v0+"�")
                               (v0+"���") ;
  mkA078 : Str -> A ;
  mkA078 base = let v0 = tk 1 base
                in adjAdv (mkAdjective (v0+"�")
                                       (v0+"��")
                                       (v0+"���")
                                       (v0+"�")
                                       (v0+"���")
                                       (v0+"�")
                                       (v0+"���")
                                       (v0+"�")
                                       (v0+"���")) (v0+"�") ;
  mkA079 : Str -> A ;
  mkA079 base = let v0 = tk 2 base
                in mkAdjective (v0+"��")
                               (v0+"���")
                               (v0+"����")
                               (v0+"��")
                               (v0+"����")
                               (v0+"��")
                               (v0+"����")
                               (v0+"��")
                               (v0+"����") ;
  mkA080 : Str -> A ;
  mkA080 base = let v0 = tk 2 base;
                    v1 = last (base)
                in mkAdjective (v0+"�"+v1)
                               (v0+v1+"��")
                               (v0+v1+"���")
                               (v0+v1+"�")
                               (v0+v1+"���")
                               (v0+v1+"�")
                               (v0+v1+"���")
                               (v0+v1+"�")
                               (v0+v1+"���") ;
  mkA081 : Str -> A ;
  mkA081 base = let v0 = tk 2 base;
                    v1 = last (base)
                in mkAdjective (v0+"�"+v1)
                               (v0+"�"+v1+"��")
                               (v0+"�"+v1+"���")
                               (v0+"�"+v1+"�")
                               (v0+"�"+v1+"���")
                               (v0+"�"+v1+"�")
                               (v0+"�"+v1+"���")
                               (v0+"�"+v1+"�")
                               (v0+"�"+v1+"���") ;
  mkA082 : Str -> A ;
  mkA082 base = let v0 = tk 3 base;
                    v1 = last (base)
                in mkAdjective (v0+"��"+v1)
                               (v0+"��"+v1+"��")
                               (v0+"��"+v1+"���")
                               (v0+"��"+v1+"�")
                               (v0+"��"+v1+"���")
                               (v0+"��"+v1+"�")
                               (v0+"��"+v1+"���")
                               (v0+"��"+v1+"�")
                               (v0+"��"+v1+"���") ;
  mkA082a : Str -> A ;
  mkA082a base = let v0 = tk 5 base
                 in mkAdjective (v0+"�����")
                                (v0+"������")
                                (v0+"�������")
                                (v0+"�����")
                                (v0+"�������")
                                (v0+"�����")
                                (v0+"�������")
                                (v0+"�����")
                                (v0+"�������") ;
  mkA083 : Str -> A ;
  mkA083 base = let v0 = tk 4 base;
                    v1 = last (tk 2 base)
                in mkAdjective (v0+"�"+v1+"��")
                               (v0+"�"+v1+"���")
                               (v0+"�"+v1+"����")
                               (v0+"�"+v1+"��")
                               (v0+"�"+v1+"����")
                               (v0+"�"+v1+"��")
                               (v0+"�"+v1+"����")
                               (v0+"�"+v1+"��")
                               (v0+"�"+v1+"����") ;
  mkA084 : Str -> A ;
  mkA084 base = let v0 = tk 4 base;
                    v1 = last (tk 2 base)
                in mkAdjective (v0+"�"+v1+"��")
                               (v0+"�"+v1+"���")
                               (v0+"�"+v1+"����")
                               (v0+"�"+v1+"��")
                               (v0+"�"+v1+"����")
                               (v0+"�"+v1+"��")
                               (v0+"�"+v1+"����")
                               (v0+"�"+v1+"��")
                               (v0+"�"+v1+"����") ;
  mkA084a : Str -> A ;
  mkA084a base = let v0 = tk 5 base
                 in mkAdjective (v0+"�����")
                                (v0+"������")
                                (v0+"�������")
                                (v0+"�����")
                                (v0+"�������")
                                (v0+"�����")
                                (v0+"�������")
                                (v0+"�����")
                                (v0+"�������") ;
  mkA085 : Str -> A ;
  mkA085 base = let v0 = tk 2 base
                in mkAdjective (v0+"��")
                               (v0+"����")
                               (v0+"�����")
                               (v0+"���")
                               (v0+"�����")
                               (v0+"���")
                               (v0+"�����")
                               (v0+"���")
                               (v0+"�����") ;
  mkA086 : Str -> A ;
  mkA086 base = let v0 = base
                in mkAdjective (v0)
                               (v0+"��")
                               (v0+"���")
                               (v0+"�")
                               (v0+"���")
                               (v0+"��")
                               (v0+"����")
                               (v0+"�")
                               (v0+"���") ;
  mkA087 : Str -> A ;
  mkA087 base = let v0 = tk 1 base
                in mkAdjective (v0+"�")
                               (v0+"��")
                               (v0+"���")
                               (v0+"�")
                               (v0+"���")
                               (v0+"�")
                               (v0+"���")
                               (v0+"�")
                               (v0+"���") ;
  mkA088 : Str -> A ;
  mkA088 base = let v0 = tk 1 base
                in mkAdjective (v0+"�")
                               (v0+"��")
                               (v0+"���")
                               (v0+"�")
                               (v0+"���")
                               (v0+"�")
                               (v0+"���")
                               (v0+"�")
                               (v0+"���") ;
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
                in mkVerb (v0+"���")
                          (v0+"�")
                          (v0+"���")
                          (v0+"���")
                          (v0+"���")
                          (v0+"���")
                          (v0+"-")
                          (v0+"-")
                          (v0+"����")
                          (v0+"����") ;
  mkV143 : Str -> VTable ;
  mkV143 base = let v0 = tk 3 base
                in mkVerb (v0+"���")
                          (v0+"���")
                          (v0+"��")
                          (v0+"����")
                          (v0+"��")
                          (v0+"����")
                          (v0+"-")
                          (v0+"����")
                          (v0+"���")
                          (v0+"�����") ;
  mkV144 : Str -> VTable ;
  mkV144 base = let v0 = tk 1 base
                in mkVerb (v0+"�")
                          (v0+"�")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"-")
                          (v0+"-")
                          (v0+"-")
                          (v0+"���") ;
  mkV145 : Str -> VTable ;
  mkV145 base = let v0 = tk 2 base;
                    v1 = last (tk 1 base)
                in mkVerb (v0+v1+"�")
                          (v0+v1+"�")
                          (v0+v1+"��")
                          (v0+v1+"��")
                          (v0+"�")
                          (v0+v1+"��")
                          (v0+v1+"��")
                          (v0+v1+"��")
                          (v0+v1+"�")
                          (v0+v1+"���") ;
  mkV145a : Str -> VTable ;
  mkV145a base = let v0 = tk 3 base;
                     v1 = last (tk 2 base)
                 in mkVerb (v0+v1+"��")
                           (v0+v1+"��")
                           (v0+v1+"���")
                           (v0+v1+"���")
                           (v0+v1+"���")
                           (v0+v1+"���")
                           (v0+v1+"���")
                           (v0+v1+"���")
                           (v0+v1+"��")
                           (v0+v1+"����") ;
  mkV145b : Str -> VTable ;
  mkV145b base = let v0 = tk 2 base
                 in mkVerb (v0+"��")
                           (v0+"��")
                           (v0+"���")
                           (v0+"���")
                           (v0+"��")
                           (v0+"���")
                           (v0+"-")
                           (v0+"���")
                           (v0+"��")
                           (v0+"����") ;
  mkV146 : Str -> VTable ;
  mkV146 base = let v0 = tk 2 base
                in mkVerb (v0+"��")
                          (v0+"��")
                          (v0+"���")
                          (v0+"���")
                          (v0+"���")
                          (v0+"���")
                          (v0+"-")
                          (v0+"-")
                          (v0+"��")
                          (v0+"����") ;
  mkV146a : Str -> VTable ;
  mkV146a base = let v0 = tk 3 base
                 in mkVerb (v0+"���")
                           (v0+"���")
                           (v0+"����")
                           (v0+"����")
                           (v0+"���")
                           (v0+"����")
                           (v0+"-")
                           (v0+"-")
                           (v0+"���")
                           (v0+"�����") ;
  mkV147 : Str -> VTable ;
  mkV147 base = let v0 = tk 3 base
                in mkVerb (v0+"���")
                          (v0+"���")
                          (v0+"����")
                          (v0+"����")
                          (v0+"����")
                          (v0+"����")
                          (v0+"-")
                          (v0+"-")
                          (v0+"��")
                          (v0+"�����") ;
  mkV148 : Str -> VTable ;
  mkV148 base = let v0 = tk 2 base
                in mkVerb (v0+"��")
                          (v0+"��")
                          (v0+"���")
                          (v0+"���")
                          (v0+"���")
                          (v0+"���")
                          (v0+"���")
                          (v0+"���")
                          (v0+"��")
                          (v0+"����") ;
  mkV149 : Str -> VTable ;
  mkV149 base = let v0 = tk 3 base
                in mkVerb (v0+"���")
                          (v0+"���")
                          (v0+"����")
                          (v0+"����")
                          (v0+"����")
                          (v0+"����")
                          (v0+"����")
                          (v0+"-")
                          (v0+"���")
                          (v0+"�����") ;
  mkV150 : Str -> VTable ;
  mkV150 base = let v0 = tk 1 base
                in mkVerb (v0+"�")
                          (v0+"�")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"-")
                          (v0+"�")
                          (v0+"���") ;
  mkV150a : Str -> VTable ;
  mkV150a base = let v0 = tk 1 base
                 in mkVerb (v0+"�")
                           (v0+"�")
                           (v0+"��")
                           (v0+"��")
                           (v0+"��")
                           (v0+"��")
                           (v0+"-")
                           (v0+"-")
                           (v0+"�")
                           (v0+"���") ;
  mkV151 : Str -> VTable ;
  mkV151 base = let v0 = tk 1 base
                in mkVerb (v0+"�")
                          (v0+"�")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"�")
                          (v0+"���") ;
  mkV152 : Str -> VTable ;
  mkV152 base = let v0 = tk 1 base
                in mkVerb (v0+"�")
                          (v0+"�")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"-")
                          (v0+"�")
                          (v0+"���") ;
  mkV152a : Str -> VTable ;
  mkV152a base = let v0 = tk 4 base
                 in mkVerb (v0+"����")
                           (v0+"����")
                           (v0+"�����")
                           (v0+"�����")
                           (v0+"�����")
                           (v0+"�����")
                           (v0+"�����")
                           (v0+"-")
                           (v0+"����")
                           (v0+"������") ;
  mkV153 : Str -> VTable ;
  mkV153 base = let v0 = tk 3 base
                in mkVerb (v0+"���")
                          (v0+"���")
                          (v0+"����")
                          (v0+"����")
                          (v0+"����")
                          (v0+"����")
                          (v0+"����")
                          (v0+"-")
                          (v0+"���")
                          (v0+"�����") ;
  mkV154 : Str -> VTable ;
  mkV154 base = let v0 = tk 1 base
                in mkVerb (v0+"�")
                          (v0+"�")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"�")
                          (v0+"���") ;
  mkV155 : Str -> VTable ;
  mkV155 base = let v0 = tk 2 base
                in mkVerb (v0+"��")
                          (v0+"��")
                          (v0+"���")
                          (v0+"���")
                          (v0+"���")
                          (v0+"���")
                          (v0+"���")
                          (v0+"���")
                          (v0+"��")
                          (v0+"����") ;
  mkV156 : Str -> VTable ;
  mkV156 base = let v0 = tk 2 base
                in mkVerb (v0+"��")
                          (v0+"��")
                          (v0+"���")
                          (v0+"���")
                          (v0+"���")
                          (v0+"���")
                          (v0+"���")
                          (v0+"-")
                          (v0+"��")
                          (v0+"����") ;
  mkV157 : Str -> VTable ;
  mkV157 base = let v0 = tk 3 base
                in mkVerb (v0+"���")
                          (v0+"���")
                          (v0+"����")
                          (v0+"����")
                          (v0+"����")
                          (v0+"����")
                          (v0+"����")
                          (v0+"����")
                          (v0+"���")
                          (v0+"�����") ;
  mkV158 : Str -> VTable ;
  mkV158 base = let v0 = tk 2 base
                in mkVerb (v0+"��")
                          (v0+"��")
                          (v0+"���")
                          (v0+"���")
                          (v0+"���")
                          (v0+"���")
                          (v0+"���")
                          (v0+"���")
                          (v0+"��")
                          (v0+"����") ;
  mkV159 : Str -> VTable ;
  mkV159 base = let v0 = tk 2 base
                in mkVerb (v0+"��")
                          (v0+"��")
                          (v0+"���")
                          (v0+"���")
                          (v0+"���")
                          (v0+"���")
                          (v0+"���")
                          (v0+"���")
                          (v0+"��")
                          (v0+"����") ;
  mkV160 : Str -> VTable ;
  mkV160 base = let v0 = tk 2 base
                in mkVerb (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"���")
                          (v0+"��")
                          (v0+"���")
                          (v0+"��")
                          (v0+"���")
                          (v0+"��")
                          (v0+"����") ;
  mkV160a : Str -> VTable ;
  mkV160a base = let v0 = tk 2 base
                 in mkVerb (v0+"��")
                           (v0+"��")
                           (v0+"��")
                           (v0+"���")
                           (v0+"��")
                           (v0+"���")
                           (v0+"��")
                           (v0+"���")
                           (v0+"��")
                           (v0+"����") ;
  mkV161 : Str -> VTable ;
  mkV161 base = let v0 = tk 1 base
                in mkVerb (v0+"�")
                          (v0+"�")
                          (v0+"�")
                          (v0+"��")
                          (v0+"�")
                          (v0+"��")
                          (v0+"�")
                          (v0+"��")
                          (v0+"�")
                          (v0+"���") ;
  mkV161a : Str -> VTable ;
  mkV161a base = let v0 = tk 1 base
                 in mkVerb (v0+"�")
                           (v0+"�")
                           (v0+"�")
                           (v0+"��")
                           (v0+"�")
                           (v0+"��")
                           (v0+"�")
                           (v0+"��")
                           (v0+"�")
                           (v0+"���") ;
  mkV162 : Str -> VTable ;
  mkV162 base = let v0 = tk 1 base
                in mkVerb (v0+"�")
                          (v0+"�")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"�")
                          (v0+"���") ;
  mkV163 : Str -> VTable ;
  mkV163 base = let v0 = tk 1 base
                in mkVerb (v0+"�")
                          (v0+"�")
                          (v0+"�")
                          (v0+"��")
                          (v0+"�")
                          (v0+"��")
                          (v0+"�")
                          (v0+"��")
                          (v0+"�")
                          (v0+"���") ;
  mkV164 : Str -> VTable ;
  mkV164 base = let v0 = tk 2 base
                in mkVerb (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"���")
                          (v0+"��")
                          (v0+"���")
                          (v0+"��")
                          (v0+"���")
                          (v0+"��")
                          (v0+"����") ;
  mkV165 : Str -> VTable ;
  mkV165 base = let v0 = tk 1 base
                in mkVerb (v0+"�")
                          (v0+"�")
                          (v0+"��")
                          (v0+"��")
                          (v0+"-")
                          (v0+"��")
                          (v0+"-")
                          (v0+"��")
                          (v0+"�")
                          (v0+"���") ;
  mkV166 : Str -> VTable ;
  mkV166 base = let v0 = tk 2 base
                in mkVerb (v0+"��")
                          (v0+"��")
                          (v0+"���")
                          (v0+"���")
                          (v0+"���")
                          (v0+"���")
                          (v0+"-")
                          (v0+"���")
                          (v0+"-")
                          (v0+"����") ;
  mkV167 : Str -> VTable ;
  mkV167 base = let v0 = tk 2 base
                in mkVerb (v0+"��")
                          (v0+"��")
                          (v0+"���")
                          (v0+"���")
                          (v0+"���")
                          (v0+"���")
                          (v0+"���")
                          (v0+"���")
                          (v0+"��")
                          (v0+"����") ;
  mkV168 : Str -> VTable ;
  mkV168 base = let v0 = tk 1 base
                in mkVerb (v0+"�")
                          (v0+"��")
                          (v0+"���")
                          (v0+"���")
                          (v0+"�")
                          (v0+"���")
                          (v0+"���")
                          (v0+"-")
                          (v0+"�")
                          (v0+"����") ;
  mkV169 : Str -> VTable ;
  mkV169 base = let v0 = tk 1 base
                in mkVerb (v0+"�")
                          (v0+"��")
                          (v0+"���")
                          (v0+"���")
                          (v0+"�")
                          (v0+"���")
                          (v0+"���")
                          (v0+"���")
                          (v0+"�")
                          (v0+"����") ;
  mkV170 : Str -> VTable ;
  mkV170 base = let v0 = tk 3 base
                in mkVerb (v0+"���")
                          (v0+"���")
                          (v0+"���")
                          (v0+"����")
                          (v0+"���")
                          (v0+"����")
                          (v0+"���")
                          (v0+"����")
                          (v0+"���")
                          (v0+"�����") ;
  mkV171 : Str -> VTable ;
  mkV171 base = let v0 = tk 2 base
                in mkVerb (v0+"��")
                          (v0+"��")
                          (v0+"�")
                          (v0+"���")
                          (v0+"�")
                          (v0+"���")
                          (v0+"�")
                          (v0+"-")
                          (v0+"��")
                          (v0+"����") ;
  mkV172 : Str -> VTable ;
  mkV172 base = let v0 = tk 4 base
                in mkVerb (v0+"����")
                          (v0+"����")
                          (v0+"���")
                          (v0+"�����")
                          (v0+"���")
                          (v0+"�����")
                          (v0+"�����")
                          (v0+"�����")
                          (v0+"����")
                          (v0+"������") ;
  mkV173 : Str -> VTable ;
  mkV173 base = let v0 = tk 1 base
                in mkVerb (v0+"�")
                          (v0+"�")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"�")
                          (v0+"���") ;
  mkV174 : Str -> VTable ;
  mkV174 base = let v0 = tk 1 base
                in mkVerb (v0+"�")
                          (v0+"�")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"�")
                          (v0+"���") ;
  mkV175 : Str -> VTable ;
  mkV175 base = let v0 = tk 1 base
                in mkVerb (v0+"�")
                          (v0+"�")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"�")
                          (v0+"���") ;
  mkV176 : Str -> VTable ;
  mkV176 base = let v0 = tk 1 base
                in mkVerb (v0+"�")
                          (v0+"�")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"�")
                          (v0+"���") ;
  mkV177 : Str -> VTable ;
  mkV177 base = let v0 = tk 1 base
                in mkVerb (v0+"�")
                          (v0+"�")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"�")
                          (v0+"���") ;
  mkV178 : Str -> VTable ;
  mkV178 base = let v0 = tk 1 base
                in mkVerb (v0+"�")
                          (v0+"�")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"������")
                          (v0+"��")
                          (v0+"�")
                          (v0+"���") ;
  mkV179 : Str -> VTable ;
  mkV179 base = let v0 = tk 4 base
                in mkVerb (v0+"����")
                          (v0+"����")
                          (v0+"�����")
                          (v0+"�����")
                          (v0+"�����")
                          (v0+"�����")
                          (v0+"�����")
                          (v0+"�����")
                          (v0+"���")
                          (v0+"������") ;
  mkV180 : Str -> VTable ;
  mkV180 base = let v0 = tk 1 base
                in mkVerb (v0+"�")
                          (v0+"�")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"-")
                          (v0+"��")
                          (v0+"�")
                          (v0+"���") ;
  mkV181 : Str -> VTable ;
  mkV181 base = let v0 = tk 2 base
                in mkVerb (v0+"��")
                          (v0+"��")
                          (v0+"���")
                          (v0+"���")
                          (v0+"���")
                          (v0+"���")
                          (v0+"���")
                          (v0+"-")
                          (v0+"�")
                          (v0+"����") ;
  mkV182 : Str -> VTable ;
  mkV182 base = let v0 = tk 1 base
                in mkVerb (v0+"�")
                          (v0+"�")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"-")
                          (v0+"��")
                          (v0+"�")
                          (v0+"���") ;
  mkV183 : Str -> VTable ;
  mkV183 base = let v0 = tk 3 base
                in mkVerb (v0+"���")
                          (v0+"���")
                          (v0+"����")
                          (v0+"����")
                          (v0+"����")
                          (v0+"����")
                          (v0+"����")
                          (v0+"����")
                          (v0+"���")
                          (v0+"�����") ;
  mkV184 : Str -> VTable ;
  mkV184 base = let v0 = tk 3 base
                in mkVerb (v0+"���")
                          (v0+"���")
                          (v0+"���")
                          (v0+"����")
                          (v0+"���")
                          (v0+"����")
                          (v0+"���")
                          (v0+"����")
                          (v0+"���")
                          (v0+"�����") ;
  mkV185 : Str -> VTable ;
  mkV185 base = let v0 = tk 3 base
                in mkVerb (v0+"���")
                          (v0+"���")
                          (v0+"���")
                          (v0+"����")
                          (v0+"���")
                          (v0+"����")
                          (v0+"���")
                          (v0+"����")
                          (v0+"���")
                          (v0+"�����") ;
  mkV186 : Str -> VTable ;
  mkV186 base = let v0 = tk 2 base
                in mkVerb (v0+"��")
                          (v0+"�")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"���") ;
  mkV187 : Str -> VTable ;
  mkV187 base = let v0 = tk 2 base
                in mkVerb (v0+"��")
                          (v0+"�")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"���") ;
  mkV188 : Str -> VTable ;
  mkV188 base = let v0 = tk 2 base
                in mkVerb (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"��")
                          (v0+"���") ;

  adjAdv : A -> Str -> A =
    \a,adv -> a ** {adv = adv} ;
}
