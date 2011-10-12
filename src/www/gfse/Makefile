
save: save.hs
	ghc --make save.hs

install::
	@make save
	rsync -avz --exclude .DS_Store P *.html *.css *.js ../../runtime/javascript/minibar/support.js *.cgi *.manifest save www.grammaticalframework.org:/usr/local/www/GF/demos/gfse
