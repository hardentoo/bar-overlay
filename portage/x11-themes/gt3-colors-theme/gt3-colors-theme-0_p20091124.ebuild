# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $BAR-overlay/portage/x11-themesgt3-colors-theme/gt3-colors-theme-0_p20091124.ebuild, v1.1 2011/08/18 Exp $

inherit gnome2-utils

DESCRIPTION="GT3 cursor themes ported to *nix."
HOMEPAGE="http://kde-look.org/content/show.php/GT3?content=106536"
SRC_URI="http://kde-look.org/CONTENT/content-files/106536-GT3-colors-pack.rar -> ${P}.rar"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="minimal"
EAPI=2

RDEPEND="!minimal? ( x11-themes/xcursor-themes )"
DEPEND="app-arch/unrar"

RESTRICT="binchecks strip"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
}

src_install() {
	for i in GT3{,-azure,-bronze,-light,-red}; do unpack ./${i}.tar.gz; done
	insinto /usr/share/icons
	doins -r GT3{,-azure,-bronze,-light,-red} || die "eek!"
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
