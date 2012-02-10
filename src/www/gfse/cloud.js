
function with_dir(cont) {
    var dir=local.get("dir","");
    if(dir) cont(dir);
    else ajax_http_get("upload.cgi?dir",
		       function(dir) {
			   local.put("dir",dir);
			   cont(dir);
		       });
}

function remove_cloud_grammar(g) {
    var dir=local.get("dir")
    if(dir && g.unique_name) {
	var path=dir+"/"+g.unique_name+".json"
	ajax_http_get("upload.cgi?rm="+encodeURIComponent(path),debug);
    }
}

// Upload the grammar to the server and check it for errors
function upload(g) {
    function upload2(dir) {
	var form=node("form",{method:"post",action:"upload.cgi"+dir},
		      [hidden(g.basename+".gf",show_abstract(g))])
	for(var i in g.concretes)
	    form.appendChild(hidden(g.basename+g.concretes[i].langcode+".gf",
				    show_concrete(g)(g.concretes[i])));
	editor.appendChild(form);
	form.submit();
	form.parentNode.removeChild(form);
    }

    with_dir(upload2);
}

// Upload the grammar to store it in the cloud
function upload_json(cont) {
    function upload3(resptext,status) {
	local.put("json_uploaded",Date.now());
	//debug("Upload complete")
	if(cont) cont();
	else {
	    var sharing=element("sharing");
	    if(sharing) sharing.innerHTML=resptext;
	}
    }
    function upload2(dir) {
	var prefix=dir.substr(10)+"-" // skip "/tmp/gfse."
	//debug("New form data");
	//var form=new FormData(); // !!! Doesn't work on Android 2.2!
	var form="",sep="";
	//debug("Preparing form data");
	for(var i=0;i<local.count;i++) {
	    var g=local.get(i,null);
	    if(g) {
		if(!g.unique_name) {
		    g.unique_name=prefix+i;
		    save_grammar(g)
		}
		//form.append(g.unique_name+".json",JSON.stringify(g));
		form+=sep+encodeURIComponent(g.unique_name+".json")+"="+
		    encodeURIComponent(JSON.stringify(g))
		sep="&"
	    }
	}
	//debug("Upload to "+prefix);
	ajax_http_post("upload.cgi"+dir,form,upload3,cont)
    }

    with_dir(upload2);
}

function download_json() {
    var dir=local.get("dir");
    var index=grammar_index();
    var downloading=0;

    function get_list(ok,err) {
	ajax_http_get("upload.cgi?ls="+dir,ok,err);
    }

    function get_file(file,ok,err) {
	downloading++;
	ajax_http_get("upload.cgi?download="+encodeURIComponent(dir+"/"+file),ok,err);
    }

    function file_failed(errormsg,status) {
	debug(errormsg)
	downloading--;
    }
    function file_downloaded(grammar) {
	downloading--;
	var newg=JSON.parse(grammar);
	debug("Downloaded "+newg.unique_name)
	var i=index[newg.unique_name];
	if(i!=undefined) merge_grammar(i,newg)
	else {
	    debug("New")
	    newg.index=null;
	    save_grammar(newg);
	}
	if(downloading==0) done()
    }

    function done() {
	setTimeout(function(){location.href="."},2000);
    }

    function download_files(ls) {
	local.put("current",0);
	if(ls) {
	    //debug("Downloading "+ls);
	    var files=ls.split(" ");
	    cleanup_deleted(files);
	    for(var i in files) get_file(files[i],file_downloaded,file_failed);
	}
	else {
	    debug("No grammars in the cloud")
	    done()
	}
    }

    get_list(download_files);
}

function link_directories(newdir,cont) {
    with_dir(function(olddir) {
	ajax_http_get("upload.cgi?rmdir="+olddir+"&newdir="+newdir,cont)
    })
}

/* -------------------------------------------------------------------------- */

// Send a command to the GF shell
function gfshell(cmd,cont) {
    alert("gfshell(...) not implmemented!!!")
}

// Check the syntax of an expression
function check_exp(s,cont) {
    function check(gf_message) {
	//debug("cc "+s+" = "+gf_message);
	cont(/(parse|syntax) error/.test(gf_message) ? "syntax error" : null);
    }
    if(navigator.onLine)
	ajax_http_get("upload.cgi?cc="+encodeURIComponent(s),check)
    else cont(null)
}
