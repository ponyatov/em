GZ += static/jquery.js
static/jquery.js:
	$(CURL) $@ https://code.jquery.com/jquery-$(JQUERY_VER).slim.min.js
