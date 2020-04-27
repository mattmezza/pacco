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
    I|ia|inatall-all
    U|ua|uninstall-all
    S|sa|source-all

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
    $ $0 I                   # installs all pkgs
    $ $0 U                   # uninstalls all pkgs
    $ $0 S                   # sources all the pkgs
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
            if [ -f "$DIR/$WHAT/pacco" ]; then
                source "$DIR/$WHAT/pacco"
            else
                return 0
            fi
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
        I|ia|install-all)
            source <(cat $MANIFEST | while read in; do echo "$0 i $in"; done)
            ;;
        U|ua|uninstall-all)
            source <(cat $MANIFEST | while read in; do echo "$0 u $in"; done)
            ;;
        S|sa|source-all)
            source <(cat $MANIFEST | while read in; do echo "$0 s $in"; done)
            ;;
        *)
            echo $($0 -h)
            return 1
            ;;
    esac
}
