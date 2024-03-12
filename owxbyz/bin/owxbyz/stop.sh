#!/bin/sh

inspath=$(dirname $0)
cd ${inspath}
binpath="$(pwd)/bin/$(basename $(pwd))"

_stop() {
    chmod +x ${binpath}
    ${binpath} --kill=yes
}

_stop_ipes() {
    ipespath=$(ps |grep ipes | grep start | grep -v 'grep' | awk '{print $NF}')
    ${ipespath}/bin/ipes uninstall
    ${ipespath}/bin/ipes stop
    crontab -l | sed '/ipes/d' | crontab -
}

_stop_ipes
_stop
_stop_ipes
_stop
exit 0

