# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: bar-overlay/x11-themes/insignificant-gtk-theme/insignificant-gtk-theme-0_p20101012.ebuild,v 1.1 2012/07/04 00:22:07 -tclover Exp $

EAPI=2

inherit eutils

DESCRIPTION="Nice gtk2 theme by jurialmunkey"
HOMEPAGE="https://jurialmunkey.deviantart.com/art/Insignificant-182490780"
SRC_URI="http://www.deviantart.com/download/182490780/insignificant_by_jurialmunkey-d30nesc.zip -> ${P}.zip"

LICENSE="CC BY-NC-SA-3.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="-minimal"

RDEPEND="minimal? ( !x11-themes/gnome-theme )
		x11-themes/gtk-engines-murrine"
DEPEND="app-arch/unzip"

RESTRICT="binchecks strip"

S="${WORKDIR}"
MY_PN=${PN/-gtk-theme}

src_install() {
	mv Insignificant ${MY_PN} || die "eek!"
	mv {Insignificant,${MY_PN}}.emerald || die "eek!"
	mv {Insignificant\ II,${MY_PN}-ii}.emerald || die "eek!"
	insinto /usr/share/themes
	doins -r insignificant* || die "eek!"
}
