# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: media-sound/rosegarden/rosegarden-14.06.ebuild,v 1.1 2014/07/14 22:31:21 -tclover Exp $

EAPI="5"

inherit autotools eutils fdo-mime gnome2-utils multilib

DESCRIPTION="MIDI and audio sequencer and notation editor."
HOMEPAGE="http://www.rosegardenmusic.com/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug dssi export gnome kde lilypond lirc"

RDEPEND="dev-qt/qtcore
	dev-qt/qtgui
	>=media-libs/alsa-lib-1.0
	>=media-libs/ladspa-cmt-1.14
	>=media-libs/ladspa-sdk-1.1
	>=media-libs/liblo-0.23[threads(+)]
	>=media-libs/liblrdf-0.2
	>=media-libs/libsamplerate-0.1.4
	>=media-sound/jack-audio-connection-kit-0.109
	sci-libs/fftw:3.0
	x11-misc/makedepend
	x11-libs/libXtst
	|| ( x11-libs/libX11 virtual/x11 )
	dssi? ( >=media-libs/dssi-0.9 )
	export? (
		|| ( kde-base/kdialog kde-base/kdebase )
		dev-perl/XML-Twig
		>=media-libs/libsndfile-1.0.16 )
	lilypond? (
		>=media-sound/lilypond-2.6.0
		|| (
		    app-text/mupdf
			kde? ( kde-base/okular )
			gnome? ( app-text/evince )
			app-text/acroread ) )
	lirc? ( >=app-misc/lirc-0.8 )"

DEPEND="${RDEPEND}
    dev-lang/perl
	virtual/pkgconfig"

PATCHES=( "${FILESDIR}/${PN}-12.12.25-debug.patch" )

pkg_setup(){
	if ! use export && \
		! ( has_all-pkg "media-libs/libsndfile dev-perl/XML-Twig" &&
		has_any-pkg "kde-base/kdialog kde-base/kdebase" ); then
		ewarn "you won't be able to use the rosegarden-project-package-manager"
		ewarn "please emerge with USE=\"export\""
	fi

	if ! use lilypond && ! ( has_version "media-sound/lilypond" &&
	    has_any-pkg "app-text/acroread kde-base/okular app-text/evince" ); then
		ewarn "lilypond preview won't work."
		ewarn "If you want this feature please remerge USE=\"lilypond\""
	fi
}

src_configure() {
	local myeconfargs=(
		--with-qtdir="${EPREFIX}"/usr/
		--with-qtlibdir="${EPREFIX}"/usr/$(get_libdir)/qt4
		$(use_enable debug)
	)
	autotools-utils_src_configure
}
