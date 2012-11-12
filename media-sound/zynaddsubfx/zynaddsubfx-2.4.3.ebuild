# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: bar-overlay/media-sound/zynaddsubfx/zynaddsubfx-2.4.3.ebuild,v 1.1 2012/11/09 17:56:16 -tclover Exp $

EAPI=4

inherit eutils cmake-utils

MY_P=ZynAddSubFX-${PV}

DESCRIPTION="ZynAddSubFX is an opensource software synthesizer."
HOMEPAGE="http://zynaddsubfx.sourceforge.net/"
SRC_URI="mirror://sourceforge/zynaddsubfx/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="alsa +fltk jack lash"
REQUIRED_USE="lash? ( alsa ) !alsa? ( jack )"

RDEPEND=">=dev-libs/mini-xml-2.2.1
	sci-libs/fftw:3.0
	alsa? ( media-libs/alsa-lib )
	fltk? ( >=x11-libs/fltk-1.3:1 )
	jack? ( media-sound/jack-audio-connection-kit )
	lash? ( || ( media-sound/ladish media-sound/lash ) )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${MY_P}

PATCHES=(
	"${FILESDIR}"/${PN}-2.4.1-docs.patch
)

DOCS="ChangeLog FAQ.txt HISTORY.txt README.txt ZynAddSubFX.lsm bugs.txt"

src_configure() {
	use lash || sed -i -e 's/lash-1.0/lash_disabled/' "${S}"/src/CMakeLists.txt
	mycmakeargs=(
		`use fltk && echo "-DGuiModule=fltk" || echo "-DGuiModule=off"`
		`use alsa && echo "-DOutputModule=alsa" || echo "-DOutputModule=jack"`
		`use alsa && echo "-DAlsaMidiOutput=TRUE" || echo "-DAlsaMidiOutput=FALSE"`
		`use jack && echo "-DJackOutput=TRUE" || echo "-DJackOutput=FALSE"`
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	insinto /usr/share/${PN}
	doins -r "${S}"/instruments/*
}
