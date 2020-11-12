# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# taken and adapted from:
# https://github.com/PF4Public/gentoo-overlay/blob/master/app-misc/font-manager/font-manager-9999.ebuild

EAPI=6

inherit gnome2 meson vala

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/FontManager/font-manager.git"
	SRC_URI=""
else
	SRC_URI="https://github.com/FontManager/font-manager/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

KEYWORDS="amd64 x86"

DESCRIPTION="A simple font management application for Gtk+ Desktop Environments"
HOMEPAGE="https://fontmanager.github.io"

VALA_MIN_API_VERSION=0.44
VALA_USE_DEPEND="vapigen"

LICENSE="GPL-3"
SLOT="0"
IUSE="doc +manager nautilus nemo reproducible thunar +viewer +nls"

RDEPEND="gnome-base/gnome-common
	dev-libs/json-glib
	>=dev-libs/libxml2-2.9
	>=media-libs/freetype-2.5
	>=x11-libs/gtk+-3.22
	>=dev-db/sqlite-3.8
	nautilus? ( gnome-base/nautilus )
	nemo? ( gnome-extra/nemo )
	thunar? ( xfce-base/thunar )
"

DEPEND="${RDEPEND}
	$(vala_depend)
	dev-util/ninja
	dev-util/meson
	doc? ( app-text/yelp-tools )
"

src_prepare() {
	default
	vala_src_prepare
	gnome2_src_prepare
}

src_configure() {
	meson_src_configure \
		$(meson_use manager) \
		$(meson_use viewer) \
		$(meson_use reproducible) \
		$(meson_use nautilus) \
		$(meson_use nemo) \
		$(meson_use thunar) \
		-Denable-nls=$(usex nls true false) \
		-Dyelp-doc=$(usex doc true false) \
		--buildtype=release
}
