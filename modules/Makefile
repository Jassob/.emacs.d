CC:=emacs --batch -l ./setup.el

# Get all module.el files
readmes := $(wildcard */README.org)
modules := $(patsubst %/README.org,%/module.el,$(readmes))

.PHONY: all
all: $(modules)

# Implicit rule to create the module.el from the README.org
%/module.el: %/README.org
	-echo "Tangling $<"
	-$(CC) --eval '(org-babel-tangle-file "$<")'

# Remove
clean:
	-rm $(modules) > /dev/null 2>&1
