#!/bin/sh
source /koolshare/scripts/base.sh

/koolshare/scripts/owxbyz_config.sh stop
rm -rf /koolshare/init.d/*owxbyz.sh
rm -rf /koolshare/bin/owxbyz
rm -rf /koolshare/res/icon-owxbyz.png
rm -rf /koolshare/scripts/owxbyz*.sh
rm -rf /koolshare/webs/Module_owxbyz.asp
rm -rf /koolshare/scripts/uninstall_owxbyz.sh
rm -rf /tmp/owxbyz*
