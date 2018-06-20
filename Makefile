SCRIPTS = scripts/*
HELPERS = helpers/*

all: x-scripts x-helpers

x-scripts:
	@for script in $(SCRIPTS); do chmod +x $$script; done

x-helpers:
	@for script in $(SCRIPTS); do chmod +x $$script; done

install-helpers:
	./install-helpers.sh

install:
	./install.sh
