

// See http://diveintohtml5.info/storage.html

function supports_html5_storage() {
  try {
    return 'localStorage' in window && window['localStorage'] !== null;
  } catch (e) {
    return false;
  }
}

var fakedLocalStorage = [] // a shared substitute for persistent localStorage

// An interface to localStorage, to store JSON data under a unique prefix
function appLocalStorage(appPrefix,privateStorage) {

    function parse(s,def) {
	try { return JSON.parse(s) } catch(e) { return def }
    }

    function methods(storage) {
	return {
	    get: function (name,def) {
		var id=appPrefix+name
		return parse(storage[id]||"",def);
	    },
	    put: function (name,value) {
		var id=appPrefix+name;
		storage[id]=JSON.stringify(value);
	    },
	    remove: function(name) {
		var id=appPrefix+name;
		delete storage[id]
	    },
	    ls: function(prefix) {
		var pre=appPrefix+(prefix||"")
		var files=[]
		for(var i in storage)
		    if(hasPrefix(i,pre)) files.push(i.substr(pre.length))
		files.sort()
		return files
	    },
	    get count() { return this.get("count",0); },
	    set count(v) { this.put("count",v); }
	}
    }

    function get_html5_storage() {
	try {
	    return 'localStorage' in window
		   && window['localStorage']
		   || fakedLocalStorage
	} catch (e) {
	    return fakedLocalStorage; // fake it
	}
    }

    return methods(privateStorage || get_html5_storage())
}
