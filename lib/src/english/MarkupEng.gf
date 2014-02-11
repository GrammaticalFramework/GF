--# -path=.:../abstract:../common

concrete MarkupEng of Markup = CatEng, MarkHTMLX ** {

lin
  MarkupCN   m cn  = {s = \\n,c => appMark m (cn.s ! n ! c) ; g = cn.g} ;
  MarkupNP   m np  = {s = \\c   => appMark m (np.s ! c) ; a = np.a} ;
  MarkupAP   m ap  = {s = \\a   => appMark m (ap.s ! a) ; isPre = ap.isPre} ;
  MarkupAdv  m adv = {s =          appMark m adv.s} ;
  MarkupS    m s   = {s =          appMark m s.s} ;
  MarkupUtt  m utt = {s =          appMark m utt.s} ;
  MarkupPhr  m phr = {s =          appMark m phr.s} ;
  MarkupText m txt = {s =          appMark m txt.s} ;

}