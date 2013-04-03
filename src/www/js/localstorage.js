

// See http://diveintohtml5.info/storage.html

function supports_html5_storage() {
  try {
    return 'localStorage' in window && window['localStorage'] !== null;
  } catch (e) {
    return false;
  }
}

// An interface to localStorage to store JSON data under a unique prefix
function appLocalStorage(appPrefix,fakeIt) {

    function methods(storage) {
	return {
	    get: function (name,def) {
		var id=appPrefix+name
		return storage[id] ? JSON.parse(storage[id]) : def;
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
		var pre=appPrefix+prefix
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
	    return 'localStorage' in window && window['localStorage'] || []
	} catch (e) {
	    return []; // fake it
	}
    }

    return methods(fakeIt || get_html5_storage())
}
