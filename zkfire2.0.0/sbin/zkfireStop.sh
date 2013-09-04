#!/bin/bash
#Copyright donnie(donnie4w@gmail.com)
#Description: stop zkfire
export LC_ALL=C

echo "kill the zkfire process..."
kill -9 `ps aux|grep java|grep StartZKfire|awk '{print $2}'`
echo "ok,dbware stop!"