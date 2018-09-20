# Compiler variables
CC:=emacs
CCFLAGS:=--batch --eval "(require 'org)"
NOOUTPUT:=>/dev/null 2>&1
SKIPLOCAL:=-name .local -prune -o
FINDELFILES:=find . $(SKIPLOCAL) -type f -name \*.el
FINDELCFILES:=find . $(SKIPLOCAL) -type f -name \*.elc

# targets all and modules are PHONY targets
.PHONY: all modules

all: core.el init.el .packages-installed modules.el modules
	-echo "All done!"

# Install packages
.packages-installed: core.el init.el
	echo "Starting Emacs to download and install packages.."
	-emacs -nw -e kill-emacs
	-touch .packages-installed

# Tangle all the modules
modules: core.el modules.el
	-$(CC) $(CCFLAGS) -l core.el -l modules.el --eval '(enable-modules)'
	-$(MAKE) -C modules --silent all

# Tangle the init file
modules.el init.el: README.org
	-echo "Tangling $@"
	-$(CC) $(CCFLAGS) --eval '(org-babel-tangle-file "$<")' $(NOOUTPUT)

# Compile elisp files
byte-compile: modules.el modules .packages-installed
	-echo "Byte compiling .el files.."
	-$(FINDELFILES) -exec $(CC) $(CCFLAGS) -l ~/.emacs.d/init.el -f batch-byte-compile '{}' +

# Implicit rule to create the elisp files from the org-sources
%.el: %.org
	-echo "Tangling $@"
	-$(CC) $(CCFLAGS) --eval '(org-babel-tangle-file "$<")' $(NOOUTPUT)

# Remove .el files
clean: clean-byte-compiled clean-enabled
	-$(MAKE) -C modules --silent clean
	-$(FINDELFILES) -exec rm '{}' +

# Remove .elc files
clean-byte-compiled:
	-$(FINDELCFILES) -exec rm '{}' +


# Remove enable symlinks
clean-enabled:
	-cd modules && ls -I Makefile | xargs -r rm
