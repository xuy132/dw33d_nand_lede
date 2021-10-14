#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/10.0.0.2/g' ./package/base-files/files/bin/config_generate

#!/bin/bash
#添加xiaorouji的passwall软件源
sed -i '$a src-git passwall https://github.com/xiaorouji/openwrt-passwall' feeds.conf.default
cat feeds.conf.default |grep passwall
echo '====================Add lienol feed source OK!===================='

#添加pymumu的smartdns软件源
git clone -b lede https://github.com/pymumu/luci-app-smartdns package/lean/luci-app-smartdns
ls -la package/lean/ |grep luci-app-smartdns
echo '====================Add smartdns OK!===================='

#添加rufengsuixing的AdGuardHome插件
git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/lean/luci-app-adguardhome
sed -i '1,$d' package/lean/luci-app-adguardhome/root/usr/share/AdGuardHome/links.txt
echo 'https://static.adguard.com/adguardhome/release/AdGuardHome_linux_armv5.tar.gz'>>package/lean/luci-app-adguardhome/root/usr/share/AdGuardHome/links.txt
cat package/lean/luci-app-adguardhome/root/usr/share/AdGuardHome/links.txt
echo '====================Add AdGuardHome Plug OK!===================='

#添加garypang13的bypass依赖插件
wget -nv https://raw.githubusercontent.com/garypang13/openwrt-packages/master/lua-maxminddb/Makefile -P package/lean/lua-maxminddb
wget -nv https://raw.githubusercontent.com/garypang13/smartdns-le/main/Makefile -P package/lean/smartdns-le

#添加garypang13的bypass插件
git clone -b main https://github.com/garypang13/luci-app-bypass package/lean/luci-app-bypass
sed -i 's/shadowsocksr-libev-ssr-redir/shadowsocksr-libev-alt/g' package/lean/luci-app-bypass/Makefile
sed -i 's/shadowsocksr-libev-ssr-server/shadowsocksr-libev-server/g' package/lean/luci-app-bypass/Makefile
ls -la package/lean/ |grep luci-app-bypass
echo '====================Add luci-app-bypass OK!===================='


#添加small-5的luci-app-adblock-plus插件
git clone -b main https://github.com/small-5/luci-app-adblock-plus package/lean/luci-app-adblock-plus
ls -la package/lean/ |grep luci-app-adblock-plus
echo '====================Add luci-app-adblock-plus OK!===================='


#添加garypang13的dnsfilter插件
git clone -b main https://github.com/garypang13/luci-app-dnsfilter package/lean/luci-app-dnsfilter
ls -la package/lean/ |grep luci-app-dnsfilter
echo '====================Add luci-app-dnsfilter OK!===================='

#添加garypang13的edge主题
git clone -b 18.06 https://github.com/garypang13/luci-theme-edge package/lean/luci-theme-edge
ls -la package/lean/ |grep luci-theme-edge
echo '====================Add luci-theme-edge OK!===================='

# Uncomment a feed source
sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default
