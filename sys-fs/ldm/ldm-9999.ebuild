# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit git-r3 toolchain-funcs

DESCRIPTION="LDM – Lightweight Device Mounter"
HOMEPAGE="https://github.com/LemonBoy/ldm"

EGIT_REPO_URI="https://github.com/LemonBoy/ldm.git"
EGIT_BRANCH="master"
EGIT_CLONE_TYPE="shallow"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE="systemd"

RDEPEND="virtual/libudev"
BDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}"

#src_prepare() {
#}

src_compile() {
	default

	if use systemd; then
		emake service || die "emake failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install-main

	if use systemd; then
		emake DESTDIR="${D}" install-systemd
	fi
}
