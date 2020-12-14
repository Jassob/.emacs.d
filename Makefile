# Compiler variables
SKIPLOCAL:=-name var -prune -o -name etc -prune -o
FINDELFILES:=find . $(SKIPLOCAL) -type f -name \*.el
FINDELCFILES:=find . $(SKIPLOCAL) -type f -name \*.elc

.PHONY: all
all: init.el packages
	@echo "All done!"

# Tangle the init file
init.el: README.org
	$(info Tangling $@)
	emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "$<")' > /dev/null

# Install packages
.PHONY: packages
packages:
	$(info Starting Emacs to download and install packages..)
	emacs -nw -e kill-emacs
	touch .packages-installed

# Compile elisp files
.PHONY: byte-compile
byte-compile: modules .packages-installed
	@echo "Byte compiling .el files.."
	emacs --batch --eval "(byte-recompile-directory user-emacs-directory)"

# Implicit rule to create the elisp files from the org-sources
%.el: %.org
	@echo "Tangling $@"
	emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "$<")' > /dev/null

# Remove .el files
.PHONY: clean
clean:
	-$(MAKE) -C modules --silent clean
	rm -rf init.el init.elc

# Remove Emacs user packages
.PHONY: clean-packages
clean-packages:
	rm -rf .local/packages/elpa
