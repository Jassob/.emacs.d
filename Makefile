# Compiler variables
CC:=emacs
CCFLAGS:=--batch --eval "(require 'org)"
NOOUTPUT:=>/dev/null 2>&1
SKIPLOCAL:=-name .local -prune -o
FINDELFILES:=find . $(SKIPLOCAL) -type f -name \*.el
FINDELCFILES:=find . $(SKIPLOCAL) -type f -name \*.elc

.PHONY: all
all: core.el init.el modules.el .packages-installed modules
	-echo "All done!"

# Install packages
.PHONY: packages
packages:
	echo "Starting Emacs to download and install packages.."
	-emacs -nw -e kill-emacs
	-touch .packages-installed

.packages-installed: core.el init.el
	make packages

# Tangle all the modules
.PHONY: modules
modules: core.el modules.el
	-$(CC) $(CCFLAGS) -l core.el -l modules.el --eval '(enable-modules)' $(NOOUTPUT)
	-$(MAKE) -C modules --silent all

# Tangle the init file
modules.el init.el: README.org
	-echo "Tangling $@"
	-$(CC) $(CCFLAGS) --eval '(org-babel-tangle-file "$<")' $(NOOUTPUT)

# Compile elisp files
.PHONY: byte-compile
byte-compile: modules.el modules .packages-installed
	-echo "Byte compiling .el files.."
	-$(FINDELFILES) -exec $(CC) $(CCFLAGS) -l ~/.emacs.d/init.el -f batch-byte-compile '{}' +

# Implicit rule to create the elisp files from the org-sources
%.el: %.org
	-echo "Tangling $@"
	-$(CC) $(CCFLAGS) --eval '(org-babel-tangle-file "$<")' $(NOOUTPUT)

# Remove .el files
.PHONY: clean
clean: clean-byte-compiled clean-enabled
	-$(MAKE) -C modules --silent clean
	-$(FINDELFILES) -exec rm '{}' +

# Remove .elc files
.PHONY: clean-byte-compiled
clean-byte-compiled:
	-$(FINDELCFILES) -exec rm '{}' +


# Remove enable symlinks
.PHONY: clean-enabled
clean-enabled:
	-cd modules && ls -I Makefile | xargs -r rm

# Remove Emacs user packages
.PHONY: clean-packages
clean-packages:
	-rm -rf .local/packages/elpa
