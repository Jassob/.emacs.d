# Compiler variables
CC:=emacs
CCFLAGS:=--batch --eval "(require 'org)"
NOOUTPUT:=>/dev/null 2>&1
SKIPLOCAL:=-name .local -prune -o
FINDELFILES:=find . $(SKIPLOCAL) -type f -name \*.el
FINDELCFILES:=find . $(SKIPLOCAL) -type f -name \*.elc

# targets all and modules are PHONY targets
.PHONY: all modules

all: core.el init.el modules
	-echo "All done!"

# Install packages
.local/packages/elpa: core.el init.el
	-emacs -nw -e kill-emacs

# Tangle all the modules
modules:
	-$(MAKE) -C modules --silent all

# Tangle the init file
init.el: README.org
	-echo "Tangling $@"
	-$(CC) $(CCFLAGS) --eval '(org-babel-tangle-file "$<")' $(NOOUTPUT)

# Compile elisp files
byte-compile: .local/packages/elpa
	-echo "Byte compiling .el files.."
	-$(FINDELFILES) -exec $(CC) $(CCFLAGS) -l ~/.emacs.d/init.el -f batch-byte-compile '{}' +

# Implicit rule to create the elisp files from the org-sources
%.el: %.org
	-echo "Tangling $@"
	-$(CC) $(CCFLAGS) --eval '(org-babel-tangle-file "$<")' $(NOOUTPUT)

# Remove .el files
clean: clean-byte-compiled
	-$(MAKE) -C modules --silent clean
	-$(FINDELFILES) -exec rm '{}' +

# Remove .elc files
clean-byte-compiled:
	-$(FINDELCFILES) -exec rm '{}' +
