#!/bin/bash
#Copyright donnie(donnie4w@gmail.com)
#Description: start zkfire
export LC_ALL=C

function start(){
	
JAVA_HOME="$JAVA_HOME"  

cd ../
BASE_PATH="./"

if [ x"$JAVA_HOME" = "x" ];
  then echo "JAVA_HOME has not configured,please configure JAVA_HOME first"
 	return 0
fi

CLASSPATH="$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/dt.jar"

lib=$BASE_PATH"lib"
conf=$BASE_PATH"conf"

EXEC_JAVA="$JAVA_HOME/bin/java"

for jar in `ls $lib`; 
    do  
      CLASSPATH="$CLASSPATH":$lib"/$jar"  
    done

CLASSPATH="$CLASSPATH":$conf
mianclass="org.jivesoftware.openfire.main.StartZKfire"

java_opts="-server -Xms1280m -Xmx1280m -Xms512m -Xss256k -XX:PermSize=64M  -XX:+UseConcMarkSweepGC -XX:CMSMaxAbortablePrecleanTime=5000 -XX:+CMSClassUnloadingEnabled -XX:+UseCMSInitiatingOccupancyOnly -XX:+DisableExplicitGC -XX:CMSInitiatingOccupancyFraction=90 -XX:+UseCMSCompactAtFullCollection"


echo " zkfire will start ,please wait..."
echo ""
sleep 1

$EXEC_JAVA $java_opts  -classpath $CLASSPATH   $mianclass &

}



start