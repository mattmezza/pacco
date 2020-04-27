pacco() {
    local MANIFEST=${PACCO_FILE:-"pacco.txt"}
    local DIR=${PACCO_DIR:-"pacchi"}
    local VERSION="1.0.0"
    case $1 in
        -h|--help)
            cat <<- EOF
Usage:
    $0 [OPT] CMD ARGS

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
    $ $0 list                # lists all pkgs
    $ $0 i name git-url tag  # installs pkg 'name' @tag via 'url'
    $ $0 u name              # uninstalls pkg 'name'
    $ $0 s name              # sources pkg 'name'
    $ $0 ia                  # installs all pkgs
    $ $0 ua                  # uninstalls all pkgs
    $ $0 sa                  # sources all the pkgs
    $ $0 -v                  # prints the pacco version
    $ $0 -h                  # prints this message
    $ $0 -d                  # prints the pacco dir
    $ $0 -f                  # prints the pacco file
EOF
            ;;
        -v|--version)
            echo $VERSION
            ;;
        -d|--dir)
            echo $DIR
            ;;
        -f|--file)
            echo $MANIFEST
            ;;
        l|list)
            cat $MANIFEST | sort
            ;;
        u|uninstall)
            local WHAT=$2
            [ -d "$DIR/$WHAT" ] && rm -rf "$DIR/$WHAT" && echo "Uninstalled '$WHAT'"
            ;;
        s|source)
            local WHAT=$2
            source "$DIR/$WHAT/pacco"
            ;;
        i|install)
            local WHAT=$2
            local WHERE=$3
            local WHICH=$4
            echo "Installing '$WHAT:$WHICH'..."
            mkdir -p "$DIR/$WHAT"
            git clone -q --branch $WHICH $WHERE "$DIR/$WHAT" > /dev/null 2> /dev/null
            echo "Installed '$WHAT:$WHICH'"
            ;;
        ia|install-all)
            source <(cat $MANIFEST | while read in; do echo "$0 i $in"; done)
            ;;
        ua|uninstall-all)
            source <(cat $MANIFEST | while read in; do echo "$0 u $in"; done)
            ;;
        sa|source-all)
            source <(cat $MANIFEST | while read in; do echo "$0 s $in"; done)
            ;;
        *)
            echo $($0 -h)
            return 1
            ;;
    esac
}
