# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: bar-overlay/games-board/fuego/fuego-1.1.ebuild,v 1.1 2012/07/31 23:23:04 -tclover Exp $

EAPI=3

inherit autotools flag-o-matic games

DESCRIPTION="C++ libraries for developing software for the game of Go"
HOMEPAGE="http://fuego.sourceforge.net/"
SRC_URI="http://garr.dl.sourceforge.net/project/${PN}/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cache-sync optimization"

DEPEND=">=sys-devel/autoconf-2.59
		>=dev-libs/boost-1.33.1
"
RDEPEND="${DEPEND}"

WANT_AUTOCONF=2.5

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		--prefix="${GAMES_PREFIX}" \
		--libdir="$(games_get_libdir)" \
		--datadir="${GAMES_DATADIR}" \
		--sysconfdir="${GAMES_SYSCONFDIR}" \
		--localstatedir="${GAMES_STATEDIR}" \
		--enable-max-size=19 \
		--enable-uct-value-type=float \
		$(use_enable cache-sync)
	if use optimization; then
		append-cxxflags "-O3 -ffast-math -g -pipe"
	fi
}