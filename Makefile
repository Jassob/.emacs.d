# Compiler variables
CC:=emacs
CCFLAGS:=--batch --eval "(require 'org)"
NOOUTPUT:=>/dev/null 2>&1

# targets all and modules are PHONY targets
.PHONY: all modules

all: core.el personal.el init.el modules
	-echo "All done!"

# Tangle all the modules
modules:
	-$(MAKE) -C modules --silent all

# Tangle the init file
init.el: README.org
	-echo "Tangling $@"
	-$(CC) $(CCFLAGS) --eval '(org-babel-tangle-file "$<")' $(NOOUTPUT)

# Implicit rule to create the elisp files from the org-sources
%.el: %.org
	-echo "Tangling $@"
	-$(CC) $(CCFLAGS) --eval '(org-babel-tangle-file "$<")' $(NOOUTPUT)

clean:
	-$(MAKE) -C modules --silent clean
	rm *.el
