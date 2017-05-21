# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: sys-kernel/git-sources/git-sources-4.9.13.ebuild,v 2.2 2015/06/30 $

EAPI="5"
ETYPE="sources"
K_DEBLOB_AVAILABLE="1"
PATCHSET=(aufs bfq ck fbcondecor gentoo hardened muqss reiser4 rt)

OKV="${PV}"
MKV="${PV%.*}"
KV_PATCH="${PV##*.}"

CK_VER="${MKV}-ck1"
CK_SRC=${CK_VER}-broken-out.tar.xz
GENTOO_VER="${MKV}-14"
FBCONDECORONDECOR_VER="${GENTOOTOO_VER}"
HARDENED_VER="${OKV}-2"
REISER4_VER="${MKV}.3"
RT_VER="${OKV}-rt12"
RT_URI="https://www.kernel.org/pub/linux/kernel/projects/rt/${MKV}/older"

inherit kernel-git