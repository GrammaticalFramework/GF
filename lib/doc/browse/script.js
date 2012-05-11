/*
  GF RGL Browser
  John J. Camiller, 2012
*/
$(document).ready(function() {

//    var urlPrefix = "/GF"; // local
    var urlPrefix = ""; // live

    var scrollToTop = function(){
        $("html, body").animate({ scrollTop: 0 }, "slow");
    }

    var current_language = undefined;
    var index;
    $.getJSON("index.json", function(data){
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
        $("#loading").hide();
    });

    var setLanguage = function(lang){
        current_language = lang;
        $("#languages select").val(lang);
        initModules(lang);
    }

    // Initialize the module list
    var initModules = function(lang){
        index['languages'][lang] = index['languages'][lang].sort();
        $("#modules").html("");
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
        $("<span>")
            .addClass('tab').addClass($(b).attr('id'))
            .html($(b).attr('id'))
            .click(function(){
                showPanel(b);
            })
            .insertBefore("#loading");
    });
    showPanel(".panel:first");

    var setTitle =  function(s){
        $('#tabbar h2').html(s);
   }

    var loadFile = function(lang, module){
        setTitle(lang+"/"+module);
        loadTagsFile(module);
        loadSourceFile(lang, module)
    }

    // Load a tags file
    var loadTagsFile = function(module) {
        $('#search').val("");
        $('#scope dl').html("");
        $("#loading").show();
        $.ajax({
            url: "tags/"+module+".gf-tags",
            type: "GET",
            dataType: "text",
            success: function(data){
                var data = data.replace(/^(\S+)\s+(.+)$/gm, '<dt name="$1">$1</dt><dd name="$1">$2</dd>');
                data = data.replace(/\s(\/lib\/\S+?\.gf(-tags)?)/gm, '<a href="$1">$1</a>');
                $('#scope dl').html(data);
                $('#scope dl a').click(function(){
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
                                $('#code').html("");
                                loadTagsFile(m[2]);
                            }
                        });
                    }
                    scrollToTop();
                    return false;
                });
                $("#loading").hide();
            },
            error: function(data){
                $('#scope dl').html("<em>No scope available</em>");
                $("#loading").hide();
            },
        });
    }

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
        $('#code').html("");
        $("#loading").show();
        $.ajax({
            url: urlPrefix + "/lib/src/"+lang+"/"+module+".gf",
            type: "GET",
            dataType: "text",
            success: function(data){
                $('#code').html(data);
                $("#loading").hide();
            },
            error: function(data){
                $('#code').html("<em>No code available</em>");
                $("#loading").hide();
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
        $("#scope dl *").show();
        if (s)
            $("#scope dl *:not(:match(\""+s+"\"))").hide();
    }

    $("#search").keyup(runfilter);
    $("#case_sensitive").change(runfilter);
});  
