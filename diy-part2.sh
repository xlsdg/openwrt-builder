#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.88.7/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate

mkdir -p files/etc/openclash/core

CLASH_DEV_URL=$(curl -fsSL 'https://api.github.com/repos/vernesong/OpenClash/contents/master/dev?ref=core' | grep download_url | grep /clash-linux-amd64.tar.gz | awk -F '"' '{print $4}')
CLASH_DEV_V3_URL=$(curl -fsSL 'https://api.github.com/repos/vernesong/OpenClash/contents/master/dev?ref=core' | grep download_url | grep /clash-linux-amd64-v3.tar.gz | awk -F '"' '{print $4}')

wget -qO- $CLASH_DEV_URL | gunzip -c > files/etc/openclash/core/clash
wget -qO- $CLASH_DEV_V3_URL | gunzip -c > files/etc/openclash/core/clash_v3

CLASH_TUN_URL=$(curl -fsSL 'https://api.github.com/repos/vernesong/OpenClash/contents/master/premium?ref=core' | grep download_url | grep /clash-linux-amd64-2 | awk -F '"' '{print $4}')
CLASH_TUN_V3_URL=$(curl -fsSL 'https://api.github.com/repos/vernesong/OpenClash/contents/master/premium?ref=core' | grep download_url | grep /clash-linux-amd64-v3-2 | awk -F '"' '{print $4}')

wget -qO- $CLASH_TUN_URL | gunzip -c > files/etc/openclash/core/clash_tun
wget -qO- $CLASH_TUN_V3_URL | gunzip -c > files/etc/openclash/core/clash_tun_v3

CLASH_META_URL=$(curl -fsSL 'https://api.github.com/repos/vernesong/OpenClash/contents/master/meta?ref=core' | grep download_url | grep /clash-linux-amd64.tar.gz | awk -F '"' '{print $4}')
CLASH_META_V3_URL=$(curl -fsSL 'https://api.github.com/repos/vernesong/OpenClash/contents/master/meta?ref=core' | grep download_url | grep /clash-linux-amd64-v3.tar.gz | awk -F '"' '{print $4}')

wget -qO- $CLASH_META_URL | gunzip -c > files/etc/openclash/core/clash_meta
wget -qO- $CLASH_META_V3_URL | gunzip -c > files/etc/openclash/core/clash_meta_v3

chmod +x files/etc/openclash/core/clash*

COUNTRY_URL=https://raw.githubusercontent.com/Loyalsoldier/geoip/release/Country.mmdb
wget -qO- $COUNTRY_URL > files/etc/openclash/Country.mmdb
