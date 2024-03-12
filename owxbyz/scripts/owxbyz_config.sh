#!/bin/sh
eval `dbus export owxbyz`
source /koolshare/scripts/base.sh
alias echo_date='echo $(date +%Y年%m月%d日\ %X):'

BIN=/koolshare/bin/owxbyz
PID_FILE=/var/run/owxbyz.pid

owlogdir="/tmp/.owxbyz"
owlogfile="${owlogdir}/startup.log"
[ -d ${owlogdir} ] || mkdir ${owlogdir}
echo "==== $(date) ${0} ${@}..." >${owlogfile}
echo "$(date) owxbyz ${ACTION}...enable=${owxbyz_enable}, cachepath=${owxbyz_cachepath}" >>${owlogfile}

start_ee(){
    params="-d -s"
    if [ -z "${owxbyz_cachepath}" ];then
        echo "$(date) owxbyz start_ee but owxbyz_cachepath=${owxbyz_cachepath}" >>${owlogfile}
        return 0
    fi

    chmod +x /koolshare/bin/owxbyz/start.sh
    /koolshare/bin/owxbyz/start.sh ${owxbyz_cachepath}
    echo "$(date) owxbyz start_ee ps=$(ps |grep owxb)" >>${owlogfile}

    [ ! -L "/koolshare/init.d/S99owxbyz.sh" ] && ln -sf /koolshare/scripts/owxbyz_config.sh /koolshare/init.d/S99owxbyz.sh
    [ ! -L "/koolshare/init.d/N99owxbyz.sh" ] && ln -sf /koolshare/scripts/owxbyz_config.sh /koolshare/init.d/N99owxbyz.sh
}

kill_ee(){
    killall -2 owxbyz > /dev/null 2>&1
    sleep 1
    chmod +x /koolshare/bin/owxbyz/stop.sh
    /koolshare/bin/owxbyz/stop.sh
}

#=========================================================

case $ACTION in
start)
    if [ "$owxbyz_enable" == "1" ];then
        logger "[软件中心]: 启动owxbyz插件"
        if [ -n "${owxbyz_cachepath}" ];then
            logger "[软件中心]: 未配置共享磁盘，暂停启动"
        else
            kill_ee
            start_ee
        fi
    else
        logger "[软件中心]: owxbyz插件未开启"
    fi
    ;;
*)
    if [ "$owxbyz_enable" == "1" ];then
        kill_ee
        start_ee
        http_response "$1"
    else
        kill_ee
        http_response "$1"
    fi
    ;;
esac

