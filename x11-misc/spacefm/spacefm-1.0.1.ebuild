# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: x11-misc/spacefm/spacefm-1.0.1.ebuild,v 1.4 2015/05/18 19:40:05 -tclover Exp $

EAPI=5

inherit fdo-mime gnome2-utils linux-info

DESCRIPTION="A multi-panel tabbed file manager"
HOMEPAGE="http://ignorantguru.github.com/spacefm/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.xz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="-gtk3 +startup-notification video-thumbnails"

RDEPEND="dev-libs/glib:2
	dev-util/desktop-file-utils
	>=virtual/udev-143
	virtual/freedesktop-icon-theme
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	!gtk3? ( x11-libs/gtk+:2 ) gtk3? ( x11-libs/gtk+:3 )
	x11-libs/pango
	x11-libs/libX11
	x11-misc/shared-mime-info
	video-thumbnails? ( media-video/ffmpegthumbnailer )
	startup-notification? ( x11-libs/startup-notification )"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig
	virtual/libintl"

src_configure()
{
	local -a myeconfargs=(
		--htmldir=/usr/share/doc/${PF}/html
		$(use_enable startup-notification)
		$(use_enable video-thumbnails)
		--disable-hal
		--enable-inotify
		--disable-pixmaps
		$(usex gtk3 '--with-gtk3=yes' '--with-gtk3=no')
	)
	econf "${myeconfargs[@]}"
}

pkg_preinst()
{
	gnome2_icon_savelist
}

pkg_postinst()
{
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update

	einfo
	elog "To mount as non-root user you need one of the following:"
	elog "  sys-apps/udevil (recommended, see below)"
	elog "  sys-apps/pmount"
	elog "  sys-fs/udisks:0"
	elog "  sys-fs/udisks:2"
	elog "To support ftp/nfs/smb/ssh URLs in the path bar you need:"
	elog "  sys-apps/udevil"
	elog "To perform as root functionality you need one of the following:"
	elog "  x11-misc/ktsuss"
	elog "  x11-libs/gksu"
	elog "  kde-base/kdesu"
	elog "Other optional dependencies:"
	elog "  sys-apps/dbus"
	elog "  sys-process/lsof (device processes)"
	elog "  virtual/eject (eject media)"
	einfo
	if ! has_version 'sys-fs/udisks' ; then
		elog "When using SpaceFM without udisks, and without the udisks-daemon running,"
		elog "you may need to enable kernel polling for device media changes to be detected."
		elog "See /usr/share/doc/${PF}/html/spacefm-manual-en.html#devices-kernpoll"
		has_version '<virtual/udev-173' && ewarn "You need at least udev-173"
		kernel_is lt 2 6 38 && ewarn "You need at least kernel 2.6.38"
		einfo
	fi
}

pkg_postrm()
{
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}