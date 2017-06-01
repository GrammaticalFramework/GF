
// Find an element with a certain tag containing a certain text.
function findElement(tagname,text) {
    var els=document.body.getElementsByTagName(tagname)
    for(var i=0;i<els.length;i++)
	if(els[i].innerText==text) return els[i]
    return null
}

function text(s) { return document.createTextNode(s); }

function appendChildren(n,ds) {
    if(Array.isArray(ds)) for(var i in ds) n.appendChild(ds[i]);
    else if(typeof ds=="string")
        n.appendChild(text(ds))
    else
	n.appendChild(ds)
}

function node(tag,cls,ds) {
    var n=document.createElement(tag)
    if(cls) n.className=cls
    if(ds) appendChildren(n,ds)
    return n
}

function a(href,txt) {
    var a=node("a","",txt)
    a.href=href
    return a
}

function tr(ds) { return node("tr","",ds) }
function th(d) { return node("th","",d) }
function td(d) { return node("td","",d) }

function forAllLinks(list,f) {
    for(var i=0;i<list.length;i++) {
	var c=list[i].firstElementChild
	if(c && c.tagName=="A" && c.href) f(c)
    }
}

/* -------------------------------------------------------------------------- */

// Extract links to the syntax rules
function listrules(ul) {
    var rules=[]
    if(ul.tagName!="UL") return []
    forAllLinks(ul.children,function(c) {
	rules.push({href:c.href,text:c.innerText.split(" -")[0],
		    full:c.innerText})
    })
    return rules
}

// Extract the links to the paradigm sections for all the languages
function listlangs(ul) {
    var langs=[]
    if(ul.tagName!="UL") return []
    forAllLinks(ul.children,function(c) {
	if(/^Paradigms for /.test(c.innerText))
	    langs.push({href:c.href,text:c.innerText.substr(14),
			full:c.innerText})
    })
    return langs
}

function linklist(links) {
    var d=node("td","quicklinks")
    for(var i=0;i<links.length;i++) {
	var l=a(links[i].href,links[i].text)
	l.title=links[i].full
	d.appendChild(l)
    }
    return d
}

function quicklinks() {
    // Find the detailed table of contents
    var h1toc=findElement("h1","Table of Contents")
    var ultoc=h1toc.nextElementSibling
    while(ultoc && ultoc.tagName!="UL") ultoc=ultoc.nextElementSibling

    var lis=ultoc.children
    
    var syntaxrules=[],langs=[]

    // Find the Syntax Rules and Lexical Paradigms sections in the toc
    for(var i=0;i<lis.length;i++) {
	var li=lis[i],c=li.firstElementChild
	if(c.tagName=="A") {
	    if(/^Syntax Rules /.test(c.innerText))
		syntaxrules=listrules(c.nextElementSibling)
	    else if(c.innerText=="Lexical Paradigms")
		langs=listlangs(c.nextElementSibling)
	}
    }

    var table=node("table","quicklinks",
	       [tr([th("Syntax"),th("Morphology")]),
		tr([linklist(syntaxrules),linklist(langs)])])

    return node("div","quicklinks",
		[text("Quick links"),
		 node("div","expand",table)])
}

document.body.appendChild(quicklinks())
