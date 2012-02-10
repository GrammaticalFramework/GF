
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
function upload(g) {
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

// Upload the grammar to store it in the cloud
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
		if(!g.unique_name) {
		    g.unique_name=unique_id+"-"+i;
		    save_grammar(g)
		}
		//form.append(g.unique_name+".json",JSON.stringify(g));
		form[encodeURIComponent(g.unique_name+".json")]=JSON.stringify(g)
	    }
	}
	ajax_http_post("/cloud","command=upload"+encodeArgs(form),upload3,cont)
    }

    with_dir(upload2);
}

function download_json() {
    var dir=local.get("dir");
    var index=grammar_index();
    var downloading=0;

    function get_list(ok,err) {	gfcloud("ls",{},ok,err) }

    function get_file(file,ok,err) {
	downloading++;
	gfcloud("download",{file:encodeURIComponent(file)},ok,err);
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
    gfcloud("link_directories",{newdir:newdir},cont)
}

/* -------------------------------------------------------------------------- */

// Request GF cloud service
function gfcloud(cmd,args,cont,err) {
    with_dir(function(dir) {
	var enc=encodeURIComponent;
	var url="/cloud?dir="+enc(dir)+"&command="+enc(cmd)+encodeArgs(args)
	ajax_http_get(url,cont,err)
    })
}

// Send a command to the GF shell
function gfshell(cmd,cont) {
    with_dir(function(dir) {
	var enc=encodeURIComponent;
	ajax_http_get("/gfshell?dir="+enc(dir)+"&command="+enc(cmd),cont)
    })
}

// Check the syntax of an expression
function check_exp(s,cont) {
    function check(gf_message) {
	//debug("cc "+s+" = "+gf_message);
	cont(/(parse|syntax) error/.test(gf_message) ? "syntax error" : null);
    }
    gfshell("cc "+s,check);
}
