incomplete concrete MarkupScand of Markup = CatScand, MarkHTMLX ** open ResScand in {

lin
  MarkupCN   m cn  = {s = \\n,d,c => appMark m (cn.s ! n ! d ! c) ; g = cn.g ; isMod = cn.isMod} ;
  MarkupNP   m np  = {s = \\c   => appMark m (np.s ! c) ; a = np.a ; isPron = np.isPron} ;
  MarkupAP   m ap  = {s = \\a   => appMark m (ap.s ! a) ; isPre = ap.isPre} ;
  MarkupAdv  m adv = {s =          appMark m adv.s} ;
  MarkupS    m s   = {s = \\o   => appMark m (s.s ! o)} ;
  MarkupUtt  m utt = {s =          appMark m utt.s} ;
  MarkupPhr  m phr = {s =          appMark m phr.s} ;
  MarkupText m txt = {s =          appMark m txt.s} ;

}