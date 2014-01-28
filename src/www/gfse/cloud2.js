
function with_dir(cont) {
    function have_dir(dir) {
	var unique_id=local.get("unique_id")
	if(!unique_id) {
	    unique_id=dir.substr(10) // skip "/tmp/gfse."
	    local.put("unique_id",unique_id)
	}
	cont(dir,unique_id)
    }
    var dir=local.get("dir","");
    if(/^\/tmp\//.test(dir)) have_dir(dir);
    else ajax_http_get("/new",
		       function(dir) {
			   local.put("dir",dir);
			   have_dir(dir);
		       });
}

function remove_cloud_grammar(g) {
    var dir=local.get("dir")
    if(dir && g.unique_name) {
	var path=g.unique_name+".json"
	gfcloud("rm",{file:path},debug);
    }
}

// Upload the grammar to the server and check it for errors
function old_upload(g) {
    function upload2(dir) {
	var form=node("form",{method:"post",action:"/cloud"},
		      [hidden("dir",dir),hidden("command","make"),
		       hidden(g.basename+".gf",show_abstract(g))])
	//var files = [g.basename+".gf"]
	for(var i in g.concretes) {
	    var cname=g.basename+g.concretes[i].langcode+".gf";
	    //files.push(cname);
	    form.appendChild(hidden(cname,
				    show_concrete(g)(g.concretes[i])));
	}
	editor.appendChild(form);
	form.submit();
	form.parentNode.removeChild(form);
    }

    function upload3(message) {	if(message) alert(message); }

    with_dir(upload2)
}

// Upload the grammar to the server and check it for errors
function upload_grammars(gs,cont) {
    function upload2(dir) {
	var pre="dir="+encodeURIComponent(dir)
	var form= {command:"make"}
	for(var aix in gs) {
	    var g=gs[aix]
	    form[encodeURIComponent(g.basename+".gf")]=show_abstract(g)
	    var cnc=g.concretes
	    for(var i in cnc) {
		var cname=g.basename+cnc[i].langcode+".gf";
		form[encodeURIComponent(cname)]=show_concrete(g)(cnc[i]);
	    }
	}
	ajax_http_post("/cloud",pre+encodeArgs(form),upload3)
    }

    function upload3(json) {
	var res=JSON.parse(json)
	if(cont) cont(res)
	else alert(res.errorcode+"\n"+res.command+"\n\n"+res.output);
    }

    if(navigator.onLine) with_dir(upload2)
    else cont({errorcode:"Offline",command:"",output:""})
}

function assign_unique_name(g,unique_id) {
    if(!g.unique_name) {
	g.unique_name=unique_id+"-"+g.index;
	save_grammar(g)
    }
    return g
}

// Upload all grammars to the cloud
function upload_json(cont) {
    function upload2(dir,unique_id) {
	function upload3(resptext,status) {
	    local.put("json_uploaded",Date.now());
	    //debug("Upload complete")
	    if(cont) cont();
	    else {
		var sharing=element("sharing");
		if(sharing) {
		    if(status==204) {
			var a=empty("a");
			a.href="share.html#"+dir.substr(5) // skip "/tmp/"
			a.innerHTML=a.href;
			sharing.innerHTML="";
			sharing.appendChild(text("Use the following link for shared access to your grammars from multiple devices: "))
			sharing.appendChild(a)
		    }
		    else
			sharing.innerHTML=resptext;
		}
	    }
	}

	//debug("New form data");
	//var form=new FormData(); // !!! Doesn't work on Android 2.2!
	var form={dir:dir};
	//debug("Preparing form data");
	for(var i=0;i<local.count;i++) {
	    var g=local.get(i,null);
	    if(g) {
		g=assign_unique_name(g,unique_id)
		//form.append(g.unique_name+".json",JSON.stringify(g));
		form[encodeURIComponent(g.unique_name+".json")]=JSON.stringify(g)
	    }
	}
	ajax_http_post("/cloud","command=upload"+encodeArgs(form),upload3,cont)
    }

    with_dir(upload2);
}

function remove_public(name,cont,err) {
    gfcloud_public_post("rm",{file:name},cont,err)
}

// Publish a single grammar
function publish_json(g,cont) {
    function publish2(dir,unique_id) {
	var oldname=g.publishedAs

	function publish3(resptext,status) {
	    console.log("publish3")
	    if(oldname && oldname!=g.basename) {
		console.log("old name="+oldname)
		var name=oldname+"-"+g.unique_name+".json"
		remove_public(name,cont,cont)
	    }
	    else cont()
	}
	g.publishedAs=g.basename;
	save_grammar(g);
	g=assign_unique_name(g,unique_id)
	var name=g.basename+"-"+g.unique_name
	var ix=g.index;
	delete g.publishedAs
	delete g.unique_name
	delete g.index
	var form={}
	form[encodeURIComponent(name+".json")]=JSON.stringify(g)
	g=reget_grammar(ix)
	gfcloud_public_post("upload",form,publish3,cont)
    }
    with_dir(publish2);
}

function download_json() {
    var dir=local.get("dir");
    var downloading=0;

    function get_list(ok,err) {	gfcloud("ls",{},ok,err) }

    function get_file(file,ok,err) {
	downloading++;
	gfcloud("download",{file:file},ok,err);
    }

    function file_failed(errormsg,status) {
	debug(errormsg)
	downloading--;
    }
    function file_downloaded(grammar) {
	downloading--;
	var newg=JSON.parse(grammar);
	debug("Downloaded "+newg.unique_name)
	var i=my_grammar(newg.unique_name);
	if(i!=null) merge_grammar(i,newg)
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
	    var files=JSON.parse(ls);
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
    gfcloud("link_directories",{newdir:newdir},cont)
}

/* -------------------------------------------------------------------------- */

var public_dir="/tmp/public"

// Request GF cloud service in the public directory (using GET)
function gfcloud_public_json(cmd,args,cont,err) {
    var enc=encodeURIComponent;
    var url="/cloud?dir="+public_dir+"&command="+enc(cmd)+encodeArgs(args)
    http_get_json(url,cont,err)
}

// Request GF cloud service in the public directory (using POST)
function gfcloud_public_post(cmd,args,cont,err) {
    var enc=encodeURIComponent;
    var req="dir="+public_dir+"&command="+enc(cmd)+encodeArgs(args)
    ajax_http_post("/cloud",req,cont,err)
}

// Request GF cloud service (using GET, for idempotent requests)
function gfcloud(cmd,args,cont,err) {
    with_dir(function(dir) {
	var enc=encodeURIComponent;
	var url="/cloud?dir="+enc(dir)+"&command="+enc(cmd)+encodeArgs(args)
	ajax_http_get(url,cont,err)
    })
}

// Reqest GF cloud service (using POST, for state changing requests)
function gfcloud_post(cmd,args,cont,err) {
    with_dir(function(dir) {
	var enc=encodeURIComponent;
	var req="dir="+enc(dir)+"&command="+enc(cmd)+encodeArgs(args)
	ajax_http_post("/cloud",req,cont,err)
    })
}

// Send a command to the GF shell
function gfshell(cmd,cont) {
    with_dir(function(dir) {
	var enc=encodeURIComponent;
	ajax_http_get("/gfshell?dir="+enc(dir)+"&command="+enc(cmd),cont)
    })
}

// Check the syntax of a source module
function check_module(path,source,cont) {
    var enc=encodeURIComponent;
    //http_get_json("/parse?"+enc(path)+"="+enc(source),cont)
    ajax_http_post_json("/parse",enc(path)+"="+enc(source),cont)
}

// Check the syntax of an expression
function check_exp(s,cont) {
    function check(gf_message) {
	//debug("cc "+s+" = "+gf_message);
	cont(/(parse|syntax) error/.test(gf_message) ? "syntax error" : null);
    }
    gfshell("cc "+s,check);
}

// Lexing/unlexing text
function lextext(txt,cont) { gfshell('ps -lextext "'+txt+'"',cont) }
function unlextext(txt,cont) { gfshell('ps -bind -unlextext "'+txt+'"',cont) }
