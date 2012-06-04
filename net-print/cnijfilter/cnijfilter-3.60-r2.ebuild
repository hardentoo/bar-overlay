# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: bar-overlay/net-print/cnijfilter/cnijfilter-3.60-r1.ebuild,v 1.8 2012/06/01 00:11:34 -tclover Exp $

EAPI=4

inherit ecnij

DESCRIPTION="Canon InkJet Printer Driver for Linux (Pixus/Pixma-Series)."
HOMEPAGE="http://support-sg.canon-asia.com/contents/SG/EN/0100392802.html"
RESTRICT="nomirror confcache"

SRC_URI="http://gdlp01.c-wss.com/gds/8/0100003928/01/${PN}-source-${PV}-1.tar.gz
	scanner? ( http://gdlp01.c-wss.com/gds/1/0100003931/01/scangearmp-source-1.80-1.tar.gz )
"
LICENSE="UNKNOWN" # GPL-2 source and proprietary binaries

ECNIJ_PRUSE=("mg2100" "mg3100" "mg4100" "mg5300" "mg6200" "mg8200" "ip4900" "e500")
ECNIJ_PRID=("386" "387" "388" "389" "390" "391" "392" "393")
IUSE="net scanner symlink ${ECNIJ_PRUSE[@]}"
SLOT=${PV}

if has scanner ${IUSE}; then
	if use scanner; then
		SCANSRC=../scangearmp-source-1.40-1
		ECNIJ_SRC=${SCANSRC}
	fi
	has net ${IUSE} && REQUIRED_USE="scanner? ( net )"
	DEPEND="scanner? ( >=media-gfx/gimp-2.0.0 
		media-gfx/sane-backends
		dev-libs/libusb:0 )"
fi
S="${WORKDIR}"/${PN}-source-${PV}-1

pkg_setup() {
	if [[ "${SLOT:0:1}" -eq "3" ]] && [[ "${SLOT:2:2}" -ge "40" ]]; then
		[[ -n "$(uname -m | grep 64)" ]] && ARC=64 || ARC=32
	fi
	ecnij_pkg_setup
}

src_prepare() {
	sed -e 's/-lcnnet/-lcnnet -ldl/g' -i cngpijmon/cnijnpr/cnijnpr/Makefile.am || die
	epatch "${FILESDIR}"/${PN}-${PV/60/20}-4-cups_ppd.patch || die
	epatch "${FILESDIR}"/${PN}-${PV/60/20}-4-libpng15.patch || die
	if use scanner; then
		sed -i ${_scansrc}/scangearmp/backend/Makefile.am \
			-e "s:BACKEND_V_REV):BACKEND_V_REV) -L../../com/libs_bin${ARC}:" || die
		pushd ${_scansrc} && epatch "${FILESDIR}"/scangearmp-1.70-libpng15.patch && popd
	fi
	ecnij_src_prepare
}

src_install() {
	ecnij_src_install
	local bindir=/usr/bin ldir=/usr/$(get_libdir) gdir p pr prid slot
	use multislot && slot=${SLOT} || slot=${SLOT:0:1}

	if use scanner; then gdir=${ldir}/gimp/2.0/plug-ins
		for p in ${ECNIJ_PRN}; do
			pr=${ECNIJ_PRUSE[$p]} prid=${ECNIJ_PRID[$p]}
			if use ${pr}; then
				install -m644 ${SCANSRC}/${prid}/*.tbl "${D}${ldir}"/cnijlib || die
				dolib.so ${SCANSRC}/${prid}/libs_bin${ARC}/* || die
			fi
		done
		dolib.so ${SCANSRC}/com/libs_bin${ARC}/* || die
		install -m644 -glp -olp ${SCANSRC}/com/ini/canon_mfp_net.ini "${D}${ldir}"/bjlib || die
		mv "${D}${bindir}"/scangearmp{,${slot}} || die
		if use symlink; then
			dosym ${bindir}/scangearmp${slot} ${gdir}/scangearmp${slot} || die
		fi
		if use usb; then 
			install -Dm644 ${SCANSRC}/scangearmp/etc/80-canon_mfp.rules \
				"${D}"/etc/udev/rules.d/80-${PN}-${slot}.rules || die
		fi
	fi
}
