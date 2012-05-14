/*
  GF RGL Browser
  John J. Camilleri, 2012
*/
$(document).ready(function() {

//    var urlPrefix = "/GF"; // local
    var urlPrefix = ""; // live

    var loading = function(b){
        if (b)
            $("#loading").show();
        else
            $("#loading").hide();
    }

    var scrollToTop = function(){
        $("html, body").animate({ scrollTop: 0 }, "slow");
    }

    var current_language = undefined;
    var index;
    $.ajax({
        url: "index.json",
        dataType: "json",
        type: "GET",
        success: function(data){
            index = data;

            // Initialize the language list
            var lang_select = $("<select>")
                .attr('id', 'language_select')
                .change(function(){
                    setLanguage($(this).val());
                })
                .appendTo("#languages")
            var language_list = data['languages'];
            for (i in language_list) {
                if (!i) continue;
                var lang = i;
                $('<option>')
                    .html(lang)
                    .appendTo(lang_select);
            }
            setLanguage("english");
            loading(false);
        },
        error: function(){
            alert("Error getting index. Try reloading page, or just give up.");
            loading(false);
        }
    });

    var setLanguage = function(lang){
        current_language = lang;
        $("#languages select").val(lang);
        initModules(lang);
    }

    // Initialize the module list
    var initModules = function(lang){
        index['languages'][lang] = index['languages'][lang].sort();
        $("#modules").empty();
        for (i in index['languages'][lang]) {
            var module = index['languages'][lang][i];
            if (!module) continue;
            $('<span>')
                .html(module)
                .addClass('button')
                .click((function(lang, module){
                    return function() {
                        loadFile(lang, module);
                    }
                })(lang, module))
                .appendTo("#modules");
        }
    };

    // Initialize the panels & tabs
    var showPanel = function(obj){
        $(".panel").hide();
        $(obj).show(); // obj can be just a plain selector or a jQuery object
    }
    $(".panel").each(function(a,b){
        $("<a>")
            .addClass('tab')
            .addClass($(b).attr('id'))
            .attr('href', '#'+$(b).attr('id'))
            .html($(b).attr('id'))
            .click(function(){
                showPanel(b);
                return false;
            })
            .insertBefore("#loading");
    });
    showPanel(".panel:first");

    var setTitle = function(s){
        $('#tabbar h2').html(s);
    }

    var updateScopeCount = function(){
        $('#scope_count').text( $("#scope_list dt:visible").length );
    }

    // Load both scope & source for a file
    var loadFile = function(lang, module){
        setTitle(lang+"/"+module);
        loadTagsFile(module);
        loadSourceFile(lang, module)
    }

    // Load a tags file
    var loadTagsFile = function(module) {
        $('#search').val("");
        $('#scope dl').empty();
        updateScopeCount();
        loading(true);
        $.ajax({
            url: "tags/"+module+".gf-tags",
            type: "GET",
            dataType: "text",
            success: function(data){
                data = data.replace(/^(\S+)\s+(.+)$/gm, '<dt name="$1">$1</dt><dd name="$1">$2</dd>');
                // data = data.replace(/^(\S+)\s(\S+)\s(\S+)(.+)?$/gm, function(a,b,c,d,e){
                //     return '<tr name="'+b+'"><th>'+b+'</th><td>'+c+'</td><td>'+d+'</td><td>'+e+'</td></tr>'
                // });
                data = data.replace(/\s(\/lib\/\S+?\.gf(-tags)?)/gm, '<a href="$1">$1</a>');
                $('#scope_list').html(data);
                $('#scope_list a').click(function(){
                    var href = $(this).attr('href');
                    var m = href.match(/([^\/]+)\/([^\/]+)\.(gf(-tags)?)$/);
                    if (m[3]=="gf") {
                        // Load both tags and source
                        loadFile(m[1], m[2]);
                    } else if (m[3]=="gf-tags") {
                        // Try and determine the language from the contents
                        checkSourceFile({
                            lang: current_language,
                            module: m[2],
                            onsuccess: function(){
                                loadFile(current_language, m[2]);
                            },
                            onerror: function(){
                                // Load just tags (we don't know source)
                                setTitle(m[2]+" (scope only)");
                                $('#code').empty();
                                loadTagsFile(m[2]);
                            }
                        });
                    }
                    scrollToTop();
                    return false;
                });
                updateScopeCount();
                loading(false);
            },
            error: function(data){
                $('#scope_list').html("<em>No scope available</em>");
                loading(false);
            },
        });
    }

    // Just get the HTTP headers to see if a file exists
    var checkSourceFile = function(args) {
        $.ajax({
            url: urlPrefix + "/lib/src/"+args.lang+"/"+args.module+".gf",
            type: "HEAD",
            success: args.onsuccess,
            error: args.onerror
        });    
    }

    // Load a source module
    var loadSourceFile = function(lang, module) {
        $('#code').empty();
        loading(true);
        $.ajax({
            url: urlPrefix + "/lib/src/"+lang+"/"+module+".gf",
            type: "GET",
            dataType: "text",
            success: function(data){
                $('#code').html(data);
                loading(false);
            },
            error: function(data){
                $('#code').html("<em>No code available</em>");
                loading(false);
            }
        });
    }

    // Custom selector
    $.expr[':'].match = function(a,b,c) {
        var needle = c[3];
        var haystack = $(a).attr('name');
        if (haystack == undefined)
            return false;
        if ($("#case_sensitive").is(":checked"))
            return haystack.indexOf(needle)>=0;
        else
            return haystack.toLowerCase().indexOf(needle.toLowerCase())>=0;
    };
    var runfilter = function() {
        // Hide anything which doesn't match
        var s = $("#search").val();
        loading(true);
        try {
            if (s) {
                $("#scope_list").children(     ":match(\""+s+"\")").show();
                $("#scope_list").children(":not(:match(\""+s+"\"))").hide();
                //$("#scope_list tr:not(:match(\""+s+"\"))").hide();
            } else {
                $("#scope_list").children().show();
            }
        } catch (error) {
            alert(error.message);
        }
        updateScopeCount();
        loading(false);
    }

//    $("#search").keyup(runfilter);
    $("#search").keypress(function(e){
        var code = (e.keyCode ? e.keyCode : e.which);
        if(code == 13) { // Enter
            runfilter();
        }        
    });
    $("#submit").click(runfilter);
    $("#clear").click(function(){
        $("#search").val('');
        runfilter();
    });
    $("#case_sensitive").change(runfilter);
});  
