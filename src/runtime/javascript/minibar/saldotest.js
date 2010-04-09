
var Saldo_ws_url = "http://spraakbanken.gu.se/ws/saldo-ws/";
//var Saldo_ff_url = Saldo_ws_url+"ff/json+remember_completions/";
var Saldo_lid_url = Saldo_ws_url+"lid/json";

var ordlista=[];
var current="";

function start_saldotest() {
  appendChildren(element("saldotest"),
		 [button("Slumpa","random_word()"),
		  button("Rensa","clear_all()"),
		  button("⌫","delete_last()"),
		  button("Ordlista","show_ordlista()"),
		  button("Visa tänkbara drag","show_moves()"),
		  button("Gör ett drag","make_a_move()"),
		  button("Visa prefix","show_prefixes()"),
		  div_id("surface"),
		  div_id("words"),
		  div_id("translations")])
  clear_all();
}

function random_word() {
  jsonp(Saldo_lid_url+"+show_random/rnd?"+Math.random());
}

function show_random(lid) {
  var lex=lid.lex;
  reset_all(lex.substring(0,lex.indexOf('.')));
}

function clear_all() { reset_all(""); }

function reset_all(s) {
  current=s;
  element("surface").innerHTML=s;
  element("translations").innerHTML="";
  get_completions();
}

function delete_last() {
  var len=current.length;
  if(len>0) {
    current=current.substring(0,len-1);
    var s=element("surface");
    s.innerHTML=current;
    element("translations").innerHTML="";
    get_completions();
  }
}

function with_completions(s,cont) {
  var c=ordlista[s];
  if(c && c.a) cont(c);
  else {
    //if(c) alert("c already has fields"+field_names(c));
    ordlista[s]={put: function(c) { ordlista[s]=c; cont(c); }};
    var url=Saldo_ws_url+"ff/json+ordlista[\""+s+"\"].put/"+encodeURIComponent(s);
    jsonp(url,"");
  }
}

function get_completions() {
  with_completions(current,show_completions);
}

function word(s) {
  var w=span_class("word",text(s));
  if(s==" ") w.innerHTML="&nbsp;";
  w.setAttribute("onclick",'extend_current("'+s+'")');
  return w;
}

function extend_current(s) {
  current+=s;
  element("words").innerHTML="";
  element("surface").innerHTML=current;
  get_completions();
}

function show_completions(saldo_ff) {
  var box=element("words");
  box.innerHTML="";
  //var c=saldo_ff.c.split("");
  var c=filter(allowed,saldo_ff.c);
  sort(c);
  for(var i=0;i<c.length;i++) {
    var s=c[i];
    if(s!='-')
      box.appendChild(word(s));
  }
  show_translations(saldo_ff.a);
}

function allowed(c) {
  switch(c) {
  case 'å':
  case 'ä':
  case 'ö':
  case 'é':
  case 'ü':
    return true;
  default:
    return 'a'<=c && c<='z';
  }
}

function ignore(msd) {
  switch(msd) {
  case "c":
  case "ci":
  case "cm":
  case "seg":
  case "sms":
    return true;
  default:
    return false;
  }
}

function count_wordforms(a) {
  var cnt=0;
  for(var i=0;i<a.length;i++)
    if(!ignore(a[i].msd)) cnt++;
  return cnt;
}

function pad(s) {
  return s.length>0 ? " "+s : "";
}

function show_translations(a) {
  var tr=element("translations");
  tr.innerHTML="";
  //if(!a) alert("a undefined in show_translations");
  if(count_wordforms(a)<1) {
    tr.appendChild(p(text(a.length<1 ? "Detta är inte en giltig ordform"
			             : "Denna form förekommer bara i sammansättningar")));
    element("surface").setAttribute("class","invalid");
  }
  else {
    element("surface").setAttribute("class","valid");
    for(var i=0;i<a.length;i++)
      if(!ignore(a[i].msd))
	tr.appendChild(p(text(a[i].gf+" ("+a[i].pos+pad(a[i].is)+", "+a[i].msd+")")));
  }
}

function show_ordlista() {
  var trans=element("translations");
  trans.innerHTML="Följande ord har slagits upp: ";
  var apnd=function(el) { trans.appendChild(el) };
  for(var i in ordlista) {
    apnd(empty("br"));
    apnd(span_class(ordlista[i].a.length<1 ? "invalid" : "valid",text(" "+i)));
    apnd(text(": "+(ordlista[i].ok!=null ? ordlista[i].ok.length : "?")
	      +"/"+(ordlista[i].allowed!=null ? ordlista[i].allowed.length : "?")));
  }
}

function extend_ordlista(s,cs,cont) {
  if(cs.length<1) cont();
  else {
    var c=cs[0];
    var cs2=cs.substring(1);
    with_completions(s+c,function(o){extend_ordlista(s,cs2,cont)});
  }
}

function known_possible_moves(s,cont) {
  var c=implode(sort(filter(allowed,ordlista[s].c)));
  ordlista[s].allowed=c;
  extend_ordlista(s,c,function() {
      var ok="";
      for(var i=0;i<c.length;i++) {
	var next=s+c[i];
	var ff=ordlista[next];
	//if(!ff.a) alert(show_props(ff,"ff"));
	if(next.length<2 || count_wordforms(ff.a)<1) ok+=c[i];
      }
      ordlista[s].ok=ok;
      cont(ok);
    }
    );
}

function unknown_possible_moves(s,cont) {
  with_completions(s,function(c){known_possible_moves(s,cont);});
}

function currently_possible_moves(cont) {
  known_possible_moves(current,cont);
}

function show_moves() {
  var trans=element("translations");
  trans.innerHTML="Letar efter möjliga drag";
  currently_possible_moves(function(ok) {
      trans.innerHTML="Tänkbara drag: "+ok;
      winning_moves(trans,ok);
    });
}

function winning_moves(trans,ok) {
  var ws=map(function(c){return current+c;},ok);
  mapc(unknown_possible_moves,ws,function(oks){
      var winning="";
      for(i=0;i<oks.length;i++)
	if(oks[i].length<1) winning+=ok[i];
      trans.innerHTML+="<br>Vinnande drag: "+winning;
    });
}

function make_a_move() {
  currently_possible_moves(function(ok) {
      if(ok.length<1) element("translations").innerHTML="Hittade inga möjliga drag!";
      else {
	var i=Math.floor(Math.random()*ok.length);
	extend_current(ok[i]);
      }
    }
    );
}

function show_prefixes_of(trans,s) {
  if(s.length>0) {
    var p=s.substr(0,s.length-1);
    with_completions(p,function(c) {
	if(count_wordforms(c.a)>0) trans.innerHTML+="<br>"+p;
	show_prefixes_of(trans,p);
      });
  }
}

function show_prefixes() {
  var trans=element("translations");
  trans.innerHTML="Prefix av "+current+":";
  show_prefixes_of(trans,current);
}
