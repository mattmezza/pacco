pacco
===

`pacco` is a utility to allow you to quickly install or uninstall plugins with custom alias or functions.

![](pacco.gif)
It works with a simple plain text file `pacco.txt` that lists the wanted packages in this format:
```
jump  git@github.com:mattmezza/jump.git   1.0.0
sp    git@github.com:mattmezza/sp.git     0.1.0
spot  https://github.com/rauchg/spot.git  0.2.0

```
You can override the name of the used file by setting an env variable `PACCO_FILE="your-pacco.txt"`.

When run, `pacco` will install the packages in a default directory `pacchi` (you can override this location via the env var `PACCO_DIR`).


Installation
===

`source <(curl -s https://raw.githubusercontent.com/mattmezza/pacco/1.0.0/pacco.sh) && pacco i pacco https://github.com/mattmezza/pacco.git 1.0.0`

Installing `pacco` is very easy: just source the `pacco.sh` in this repo. Here's how I do it in my [dotfiles](https://github.com/mattmezza/dotfiles).

Usage
===

What follows is the output of `pacco -h`, accessible at any time.

```
Usage:
    pacco [OPT] CMD ARGS

CMD:
     l|list
     i|install
     u|uninstall
     s|source
    ia|inatall-all
    ua|uninstall-all
    sa|source-all

OPT:
    -f|--file
    -d|--dir
    -h|--help
    -v|--version

Examples:
    $ pacco list                # lists all pkgs
    $ pacco i name git-url tag  # installs pkg 'name' @tag via 'url'
    $ pacco u name              # uninstalls pkg 'name'
    $ pacco s name              # sources pkg 'name'
    $ pacco ia                  # installs all pkgs
    $ pacco ua                  # uninstalls all pkgs
    $ pacco sa                  # sources all the pkgs
    $ pacco -v                  # prints the pacco version
    $ pacco -h                  # prints this message
    $ pacco -d                  # prints the pacco dir
    $ pacco -f                  # prints the pacco file

```

Development
===

Developing `pacco` is quite easy. Clone the repo and start editing the `pacco.sh` file. You can always source your verions and test it in your shell.

