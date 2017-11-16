--# -path=.:../abstract:../common

concrete MarkupGer of Markup = CatGer, MarkHTMLX ** {

lin
  MarkupCN   m cn  = cn ** {s = \\a,n,c => appMark m (cn.s ! a ! n ! c)} ; --- other fields e.g ext intact
  MarkupNP   m np  = np ** {s = \\c     => appMark m (np.s ! c)} ;
  MarkupAP   m ap  = ap ** {s = \\a     => appMark m (ap.s ! a)} ;
  MarkupAdv  m adv = {s =          appMark m adv.s} ;
  MarkupS    m s   = {s = \\o   => appMark m (s.s ! o)} ;
  MarkupUtt  m utt = {s =          appMark m utt.s} ;
  MarkupPhr  m phr = {s =          appMark m phr.s} ;
  MarkupText m txt = {s =          appMark m txt.s} ;

}

