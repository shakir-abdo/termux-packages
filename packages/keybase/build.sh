TERMUX_PKG_HOMEPAGE=https://keybase.io
TERMUX_PKG_DESCRIPTION="Key directory that maps social media identities to encryption keys"
TERMUX_PKG_LICENSE="BSD 3-Clause"
TERMUX_PKG_VERSION=5.5.2
TERMUX_PKG_SRCURL=https://github.com/keybase/client/archive/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=2610dbc44d84b93822f9e4ec510aac473116c953f1073a45aef983898a2289fd
TERMUX_PKG_REPLACES="kbfs"
TERMUX_PKG_CONFLICTS="kbfs"

termux_step_make_install() {
	cd $TERMUX_PKG_SRCDIR

	termux_setup_golang

	mkdir -p .gopath/src/github.com/keybase
	ln -sf "$PWD" .gopath/src/github.com/keybase/client
	export GOPATH="$PWD/.gopath"

	go build -v -tags 'production' -o keybase github.com/keybase/client/go/keybase
	go build -v -tags 'production' -o git-remote-keybase github.com/keybase/client/go/kbfs/kbfsgit/git-remote-keybase
	go build -v -tags 'production' -o kbfsfusebin github.com/keybase/client/go/kbfs/kbfsfuse

	cp keybase $TERMUX_PREFIX/bin/keybase
	cp git-remote-keybase $TERMUX_PREFIX/bin/git-remote-keybase
	cp kbfsfusebin $TERMUX_PREFIX/bin/kbfsfuse
}
