@echo off
rem zkfire 2.0.0 
rem @Copyright donnie(donnie4w@gmail.com)
title zkfire
setlocal enabledelayedexpansion

if "%JAVA_HOME%" == "" goto javaerror
goto run

:javaerror
echo.
echo Error: JAVA_HOME environment variable not set, zkfire not started.
echo.
goto end

:run
set JAVA=%JAVA_HOME%\bin\java
set OPTS=-server -Xms1024m -Xmx1024m -Xms384m -Xss128k -XX:PermSize=64M -XX:+UseConcMarkSweepGC -XX:CMSMaxAbortablePrecleanTime=5000 -XX:+CMSClassUnloadingEnabled -XX:+UseCMSInitiatingOccupancyOnly -XX:+DisableExplicitGC -XX:CMSInitiatingOccupancyFraction=85 -XX:+UseCMSCompactAtFullCollection
cd ..
set LIBPATH=.\lib
set CONFIG=.\conf
set RESOURCE=.\resources
set CP=%CONFIG%;%RESOURCE%;
set MAIN=org.jivesoftware.openfire.main.StartZKfire
for /f %%i in ('dir /b %LIBPATH%\*.jar^|sort') do (
rem   set CP=%CP%%LIBPATH%\%%i;
   echo %LIBPATH%\%%i;
)
set CP=%CP%;.\lib\activation.jar;.\lib\ant-contrib.jar;.\lib\ant-jive-edition.jar;.\lib\ant-subdirtask.jar;.\lib\ant.jar;.\lib\bcprov-jdk16-145-1.jar;.\lib\bouncycastle.jar;.\lib\cglib-nodep.jar;.\lib\commons-codec.jar;.\lib\commons-el.jar;.\lib\commons-httpclient.jar;.\lib\commons-io-2.0.1.jar;.\lib\commons-lang-2.5.jar;.\lib\commons-lang.jar;.\lib\commons-logging.jar;.\lib\concurrentlinkedhashmap-lru-1.0_jdk5.jar;.\lib\concurrentlinkedhashmap-lru-1.3.2.jar;.\lib\dbutil.jar;.\lib\dom4j-1.6.1.jar;.\lib\hamcrest-api.jar;.\lib\hamcrest-library.jar;.\lib\hsqldb.jar;.\lib\i4jruntime.jar;.\lib\jasper-compiler.jar;.\lib\jasper-runtime.jar;.\lib\javapns-jdk16-163.jar;.\lib\jaxen.jar;.\lib\jdao1.0.6.jar;.\lib\jdic.jar;.\lib\jdom.jar;.\lib\jetty-continuation.jar;.\lib\jetty-http.jar;.\lib\jetty-io.jar;.\lib\jetty-security.jar;.\lib\jetty-server.jar;.\lib\jetty-servlet.jar;.\lib\jetty-util.jar;.\lib\jetty-webapp.jar;.\lib\jetty-websocket.jar;.\lib\jetty-xml.jar;.\lib\jmdns.jar;.\lib\jmock-junit4.jar;.\lib\jmock-legacy.jar;.\lib\jmock.jar;.\lib\jsp-api.jar;.\lib\jstl.jar;.\lib\jtds.jar;.\lib\junit.jar;.\lib\jzlib.jar;.\lib\libidn.jar;.\lib\log4j-1.2.16.jar;.\lib\log4j.jar;.\lib\mail.jar;.\lib\mchange-commons-java-0.2.3.jar;.\lib\mina-core.jar;.\lib\mina-filter-compression.jar;.\lib\mina-filter-ssl.jar;.\lib\myc3p0.jar;.\lib\mysql-connector-java-5.1.6-bin.jar;.\lib\mysql.jar;.\lib\objenesis.jar;.\lib\pack200task.jar;.\lib\postgres.jar;.\lib\proxool-0.9.0RC3.jar;.\lib\proxool.jar;.\lib\qdox.jar;.\lib\rome-fetcher.jar;.\lib\rome.jar;.\lib\servlet.jar;.\lib\shaj.jar;.\lib\sitemesh.jar;.\lib\slf4j-api.jar;.\lib\slf4j-log4j12.jar;.\lib\spring.jar;.\lib\standard.jar;.\lib\stringprep.jar;.\lib\tinder.jar;.\lib\xmltask.jar;.\lib\xpp3.jar;.\lib\zkc.jar;.\lib\zkfire.jar;.\lib\zookeeper-3.4.5.jar;
echo =============================================================================================
echo.
echo   zkfire 2.0.0 Environment
echo.
echo   JAVA: %JAVA%
echo.
echo   JAVA_OPTS: %OPTS%
echo.
echo   CP: %CP%
echo.
echo =============================================================================================
echo.
sleep 2
%JAVA% %OPTS% -cp %CP% %MAIN% 

:end
pause
