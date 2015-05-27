# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: sys-apps/hprofile/hprofile-5.0.ebuild,v 1.2 2014/05/26 08:41:42 -tclover Exp $

EAPI=5

case "${PV}" in
	(9999*)
	KEYWORDS=""
	VCS_ECLASS=git-2
	EGIT_REPO_URI="git://github.com/tokiclover/${PN}.git"
	EGIT_PROJECT="${PN}.git"
	;;
	(*)
	KEYWORDS="~amd64 ~arm ~x86"
	SRC_URI="https://github.com/tokiclover/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
esac
inherit eutils ${VCS_ECLASS}

DESCRIPTION="Utility to manage hardware, network, power or other profiles"
HOMEPAGE="https://github.com/tokiclover/hprofile"

LICENSE="GPL-2"
SLOT="0"

DEPEND="sys-apps/findutils"
RDEPEND="${DEPEND}
	sys-apps/diffutils
	sys-apps/sed"

src_install()
{
	sed -e '/.*COPYING.*$/d' -i Makefile
	emake DESTDIR="${ED}" prefix=/usr exec_prefix=/ install{,-doc}
}
