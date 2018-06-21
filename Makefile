SCRIPTS = scripts/*
HELPERS = helpers/*

all: x-scripts x-helpers

x-scripts:
	@for script in $(SCRIPTS); do chmod +x $$script; done

x-helpers:
	@for script in $(SCRIPTS); do chmod +x $$script; done

install-helpers:
	-mkdir -p tmp
	./install-helpers.sh
	-rm -rf tmp

install-scripts:
	-mkdir -p tmp
	./install-scripts.sh
	-rm -rf tmp

install: install-helpers install-scripts
