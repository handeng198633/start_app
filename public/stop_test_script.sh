#!/usr/bin/sh
ps -ef | grep /usr/bin/sleep | awk '{print $2}' | xargs kill -9
