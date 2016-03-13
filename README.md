# My emacs configuration

The title says it all. This is my emacs config.

It uses `use-package` to load packages lazily and fetch the packages with `packages.el` if they do not exist on the current machine.

## Getting started

To use my configuration you need three things:

1. Emacs (doh!).
2. `use-package.el`, a package that loads and configures other packages.
3. My current theme `twilight-anti-bright`.

Then one only have to either restart emacs or evaluate all the `load` lines in `init.el`.

## TODO

* Add more language packages so they exist on my machines on a fresh install.
* Add some conditional package loads, for instance load `fancy-battery-mode` on laptops but not on stationary computers.
