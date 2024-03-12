#! /bin/sh
eval `dbus export owxbyz`
source /koolshare/scripts/base.sh

if [ "${owxbyz_enable}" == "1" ];then
    if pidof owxbyz >/dev/null; then
        yz_info=`curl -s -m 5 -o- http://127.0.0.1:9120/sys/sign`
        if [ -n "${yz_info}" ];then
            yz_msg="<a type=\\\"button\\\" id=\\\"owxbyz_website\\\" class=\\\"owxbyz_btn\\\" href=\\\"https://yz.iepose.com/istore/?${yz_info}\\\" target=\\\"_blank\\\">驿站运行中...点击打开</a>"
        else
            yz_msg="驿站运行中，但无节点信息，请重新提交!"
        fi
    else
        yz_msg="驿站已停止"
        if [ -n "${owxbyz_cachepath}" ];then
            yz_msg="${yz_msg}: 运行异常，请重新提交!"
        else
            yz_msg="${yz_msg}: 未配置磁盘"
        fi
    fi
else
    yz_msg="驿站未开启"
fi

http_response "${yz_msg}"
