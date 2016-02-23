# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: dev-util/eflete/eflete-9999.ebuild,v 1.2 2015/06/30 12:02:10 Exp $

EAPI=5

case "${PV}" in
	(*9999*)
		KEYWORDS=""
		VCS_ECLASS=git-2
		EGIT_REPO_URI="git://git.enlightenment.org/apps/${PN}.git"
		EGIT_PROJECT="${PN}.git"
		AUTOTOOLS_AUTORECONF=1
		;;
	(*)
		KEYWORDS="~amd64 ~arm ~x86"
		SRC_URI="https://download.enlightenment.org/rel/apps/${PN}/${PN}-${PV/_/-}.tar.gz"
		;;
esac
inherit autotools-utils ${VCS_ECLASS}

DESCRIPTION="EFL Edje Theme Editor - a theme graphical editor"
HOMEPAGE="https://enlightenment.org"

IUSE="debug doc enventor"
LICENSE="BSD-2"
SLOT="0"

EFL_VERSION=1.12.2
RDEPEND=">=dev-libs/efl-${EFL_VERSION}
	>=media-libs/elementary-${EFL_VERSION}
	enventor? ( >=dev-util/enventor-0.4.0 )
	>=media-libs/ewe-0.2.2"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	virtual/libintl"

DOCS=( AUTHORS ChangeLog NEWS NOTES README )

src_configure()
{
	local -a myeconfargs=(
		${EXTRA_EFLETE_CONF}
		$(use_enable debug)
		$(use_enable enventor)
	)
	autotools-utils_src_configure
}
