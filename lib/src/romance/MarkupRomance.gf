--# -path=.:../abstract:../common

incomplete concrete MarkupRomance of Markup = CatRomance, MarkHTMLX ** {

lin
  MarkupCN   m cn  = cn ** {s = \\n => appMark m (cn.s ! n)} ;
  MarkupNP   m np  = np ** {s = \\c => {
                       c1 = appMark m (np.s ! c).c1 ;
                       c2 = appMark m (np.s ! c).c2 ;
                       comp = appMark m (np.s ! c).comp ;
                       ton = appMark m (np.s ! c).ton
		       }
		     } ;
  MarkupAP   m ap  = ap ** {s = \\a   => appMark m (ap.s ! a)} ;
  MarkupAdv  m adv = {s =          appMark m adv.s} ;
  MarkupS    m s   = {s =        \\md => appMark m (s.s ! md)} ;
  MarkupUtt  m utt = {s =          appMark m utt.s} ;
  MarkupPhr  m phr = {s =          appMark m phr.s} ;
  MarkupText m txt = {s =          appMark m txt.s} ;

}