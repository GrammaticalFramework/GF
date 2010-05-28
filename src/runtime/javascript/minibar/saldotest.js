
var Saldo_ws_url = "http://spraakbanken.gu.se/ws/saldo-ws/";
//var Saldo_ff_url = Saldo_ws_url+"ff/json+remember_completions/";
var Saldo_lid_url = Saldo_ws_url+"lid/json";

function saldo_ws(fn,fmt,arg,cont_name) {
    jsonp(Saldo_ws_url+fn+"/"+fmt+(cont_name ? "+"+cont_name : "")+"/"+arg,"");
}

function saldo_json(fn,arg,cont_name) { saldo_ws(fn,"json",arg,cont_name); }
function saldo_lid(arg,cont_name) { saldo_json("lid",arg,cont_name); }
function saldo_lid_rnd(cont_name) { saldo_lid("rnd?"+Math.random(),cont_name); }

var ordlista=[];
var current="";

function start_saldotest() {
  appendChildren(element("saldotest"),
		 [button("Slumpa","random_word()"),
		  button("Rensa","clear_all()"),
		  button("⌫","delete_last()"),
		//button("Ordlista","show_ordlista()"),
		  button("Visa tänkbara drag","show_moves()"),
		  button("Gör ett drag","make_a_move()"),
		//button("Visa prefix","show_prefixes()"),
		  div_id("surface"),
		  div_id("words"),
		  div_id("translations")])
  var style0="min-height: 3ex; margin: 5px; padding: 5px;";
  element("surface").setAttribute("style",style0+"border: 3px dashed #e0e0e0;");
  element("words").setAttribute("style",style0+"border: 3px solid #e0e0e0;");
  clear_all();
}

function random_word() {
  saldo_lid_rnd("show_random");
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
    //var w=span_class("word",text(s));
    //if(s==" ") w.innerHTML="&nbsp;";
    //w.setAttribute("onclick",'extend_current("'+s+'")');
    //return w;
    return button(s,'extend_current("'+s+'")');
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

// ordklasser: mxc sxc (förekommer bara som prefix),
//             *h (förekommer bara som suffix)
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

/* -------------------------------------------------------------------------- */

var spel={ antal_ord: 4, // antal närbesläktade ord att visa
	   antal_korrekta_svar: 0,
	   antal_felaktiga_svar: 0 
	 };

function start_saldospel() {
    spel.hylla=div_id("hylla");
    spel.status=div_id("status");
    //element("saldospel").innerHTML="<span id=score></span>";
    appendChildren(element("saldospel"),
		   [spel.hylla,spel.status,
		    p(text("")),
		    button("Nya ord","spel0()"),
		    text(" "),
		    wrap("b",span_id("score"))]);
    spel.score=element("score");
    show_score();
    spel0();
}

function spel0() { // Välj ord 1
  saldo_lid_rnd("spel1");
}

function spel1(lid) { // Slå upp md1 för ord 1
    spel.lid=lid;
    saldo_json("md1",lid.lex,"spel2");
}

function spel2(md1) { // Kontrollera att det finns minst 4 ord i md1 för ord1
    if(md1.length<spel.antal_ord) spel0();
    else {
	spel.md1=md1;
	spel3();
    }
}

function spel3() { // Välj ord 2
    saldo_lid_rnd("spel4");
}

function spel4(lid) { // Slå upp md1 för ord 2
    spel.lid2=lid;
    saldo_json("md1",lid.lex,"spel5");
}

function spel5(md1) { // Kontrollera att ord 1 och ord 2 inte har något gemensamt
    var ordlista1=map(wf,spel.md1);
    var ord2=wf(spel.lid2.lex);
    var ordlista2=map(wf,md1).concat(ord2);
    if(overlaps(ordlista1,ordlista2)) spel3();
    else spel6(ordlista1,ord2);
}

function spel6(ordlista1,ord2) {
    spel.ord2=ord2;
    var pos=Math.floor(Math.random()*spel.antal_ord);
    var ordlista=shuffle(shuffle(ordlista1).slice(0,spel.antal_ord).concat(ord2));
    spel.hylla.innerHTML="";
    var lista=empty_class("div","space");
    for(var i=0;i<ordlista.length;i++)
	lista.appendChild((button(ordlista[i],"spel7(this)")));
    spel.hylla.appendChild(lista);
}

function spel7(btn) {
    btn.disabled=true;
    var ok=btn.value==spel.ord2;
    //btn.setAttribute("class",ok ? "correct" : "incorrect");
    btn.setAttribute("style",ok ? "color: green" : "color: red");
    if(ok) spel.antal_korrekta_svar++; else spel.antal_felaktiga_svar++;
    show_score();
    if(ok) spel0();
}

function show_score() {
    spel.score.innerHTML=""+spel.antal_korrekta_svar+" rätt, "
	+spel.antal_felaktiga_svar+" fel";
}

function wf(ord) { // word form, wf("band..1") == "band"
    return ord.split(".",1)[0].split("_").join(" ");
}
