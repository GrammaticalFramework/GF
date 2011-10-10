
function with_dir(cont) {
    var dir=local.get("dir","");
    if(/^\/tmp\//.test(dir)) cont(dir);
    else ajax_http_get("/new",
		       function(dir) {
			   local.put("dir",dir);
			   cont(dir);
		       });
}

function remove_cloud_grammar(g) {
    alert("remove_cloud_grammar(g) not implemented yet!!!")
}

// Upload the grammar to the server and check it for errors
function upload(g) {
    function upload2(dir) {
	var form=node("form",{method:"post",action:"/upload"},
		      [hidden("dir",dir),hidden(g.basename,show_abstract(g))])
	var files = [g.basename+".gf"]
	for(var i in g.concretes) {
	    var cname=g.basename+g.concretes[i].langcode;
	    files.push(cname+".gf");
	    form.appendChild(hidden(cname,
				    show_concrete(g.basename)(g.concretes[i])));
	}
	editor.appendChild(form);
	form.submit();
	form.parentNode.removeChild(form);
	/* wait until upload is done */
	gfshell("i -retain "+files.join(" "),upload3)
    }
    
    function upload3(message) {	if(message) alert(message); }

    with_dir(upload2)
}

// Upload the grammar to store it in the cloud
function upload_json(cont) {
    alert("upload_json() not implemented yet!!!")
}

function download_json() {
    alert("download_json() not implemented yet!!!")
}

function link_directories(olddir,newdir,cont) {
    alert("link_directories(...) not implemented yet!!!")
}

/* -------------------------------------------------------------------------- */

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
	cont(/parse error/.test(gf_message) ? "parse error" : null);
    }
    gfshell("cc "+s,check);
}
