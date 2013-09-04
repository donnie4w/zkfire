   zkfire之所以从1.0直接升级到2.0 是因为2.0版本是一个完整的工程，并提供了启动脚本,支持linux与windows启动;而zkfire1.0只是openfire工程打包的的一个jar包，启动时需依赖openfire启动。2.0版本去掉了openfire部分程序(插件部分去掉了)，并修正了zkfire1.0集群的一些bug。2.0集群的实现方式与1.0基本一致。详细说明可见：http://www.oschina.net/p/zkfire。
   sbin文件中有linux与windows的启动脚本。
   zkfire的集群依赖zookeeper。如果您已经有zookeeper服务。可以直接将zkfire指向现有的zookeeper服务器并去掉zkfire自身zk服务:注释掉cluster.xml的zoo节点；<zClient>127.0.0.1:3181</zClient> 指定zk的ip与端口。如若没有，则可以按默认的配置指向自身zk服务。

   如何启动zkfire：
   1,建立数据库。相应的sql文件在database中，选择相应数据库脚本运行即可。
   2,修改ofproperty 变量。zkfire2.0也增加了几个变量。以下是部分变量的说明：

     xmpp.domain                 域名 默认 127.0.0.1
     xmpp.socket.plain.port      访问端口 默认5222
     xmpp.proxy.port             代理端口 默认7777  用于传输文件等。
     xmpp.monitor.port(新增)     数据端口 默认5915  
     xmpp.receipt.active(新增)   开启服务器与客户端之间的消息回执(自定义消息保障机制协议) 默认false不开启。开启时需客户端配合,否则消息都会记录在离线信息表。

   3,配置conf/openfire.xml。连接数据库。该配置与openfire的openfire.xml是一致的，无另做处理。具体可以参考工程里openfire.xml配置。
   4,配置conf/cluster.xml 集群文件。配置方式与zkfire1.0一致。可参考http://www.oschina.net/p/zkfire.
   5,启动脚本sbin文件：zkfireStart.bat(windows) ,zkfireStart.sh (linux)

   
   http://127.0.0.1:5915/i 查询服务器环境数据。(utf8编码)
   http://127.0.0.1:5915/u 查询在线用户的数据。(utf8编码)
      在线用户总数： 集群环境中所有在线用户
      本地在线用户： 本zkfire服务器在线用户


有任何问题或建议欢迎随时email给我donnie4w@gmail.com，谢谢!
  