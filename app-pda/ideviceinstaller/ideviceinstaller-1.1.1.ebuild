# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="A tool to interact with the installation_proxy of an Apple’s iDevice"
HOMEPAGE="https://libimobiledevice.org/"
SRC_URI="https://github.com/libimobiledevice/${PN}/releases/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=app-pda/libimobiledevice-1.3.0:=
	>=app-pda/libplist-2.2.0:=
	>=dev-libs/libzip-0.10"
DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.64
	virtual/pkgconfig"

DOCS=( AUTHORS NEWS README )

src_prepare() {
	sed -i -e 's:-Werror -g::' configure || die
}
