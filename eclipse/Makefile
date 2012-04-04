html:
	php ~/markdown-convert.php https://raw.github.com/GrammaticalFramework/gf-eclipse-plugin/master/README.md index.html 

local:
	echo "<html>\n<head>\n" > index.html
	echo "<title>GF Eclipse Plugin</title>\n" >> index.html
	echo "<link rel=\"stylesheet\" type=\"text/css\" href=\"http://www.grammaticalframework.org/css/style.css\">\n" >> index.html
	echo "</head>\n<body>\n" >> index.html
	php ~/markdown-convert.php ~/repositories/gf-eclipse-plugin/README.md index.html --append
	echo "</body>\n</html>" >> index.html
