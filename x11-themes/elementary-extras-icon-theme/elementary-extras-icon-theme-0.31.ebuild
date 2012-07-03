# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: bar-overlay/x11-themes/elementary-extras-icon-theme/elementary-extras-icon-theme-0.31.ebuild,v 1.1 2012/07/04 00:21:58 -tclover Exp $

EAPI=2

inherit eutils

DESCRIPTION="elementary extras icon theme by spg76"
HOMEPAGE="http://spg76.deviantart.com/"
SRC_URI="http://www.deviantart.com/download/215459969/elementary_extras_icons_by_spg76-d3ka1z5.zip -> ${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="-minimal"

RDEPEND="minimal? ( !x11-themes/gnome-icon-theme )
		x11-themes/elementary-icon-theme"

RESTRICT="binchecks strip"

S="${WORKDIR}"

src_install() {
	insinto /usr/share/icons
	doins -r elementary-extras || die "eek!"
}
