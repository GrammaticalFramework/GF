
// We use localStorage to store the grammars,
// see http://diveintohtml5.org/storage.html

var local={
    prefix:"gf.editor.simple.grammar",
    get: function (name,def) {
	var id=this.prefix+name
	return localStorage[id] ? JSON.parse(localStorage[id]) : def;
    },
    put: function (name,value) {
	var id=this.prefix+name;
	localStorage[id]=JSON.stringify(value);
    },
    remove: function(name) {
	var id=this.prefix+name;
	localStorage.removeItem(id);
    },
    get count() { return this.get("count",0); },
    set count(v) { this.put("count",v); }
}
