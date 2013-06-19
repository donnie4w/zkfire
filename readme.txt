  zkfire = zookeeper+openfire(3.8.1)
  openfire http://www.igniterealtime.org/
  Openfire 采用Java开发，开源的实时协作（RTC）服务器基于XMPP（Jabber）协议,您可以使用它轻易的构建高效率的即时通信服务器. 
  根据对xmpp与openfire的理解，我在openfire中相应的地方植入少量的代码，并把zookeeper包也一并打包到zkfire中。使用zookeeper(http://zookeeper.apache.org/)管理集群中的节点。
  客户登陆集群中的不同服务器进行通信就如登陆同一台服务器一样。
  openfire自身也有一套集群的实现，使用了oracle 的coherence的中间件，使用时要自己加入相应的jar包与集群插件。
  之所以又自己开发了一套集群实现，一个是给集群提供多一些选择，一个是兴趣^_^。
  
  zkfire使用的场景：
  zkfire中有zookeeper的服务器监听与客户端连接程序，但可以不依赖自身的zookeeper服务，可以在openfire之外另外开启其他zookeeper服务，此时只需指定
  cluster.xml配置文件中zClient节点的连接地址即可。
  如果只是zookeeper单机服务，那么所有openfire服务器只需要连到同一个zookeeper服务器就可以完成openfire的集群
  如果是zookeeper集群，根据zookeeper的集群特点，集群中节点不应该少于3台。如果超过一半的zk节点宕机，那么整个集群境将不能正常的工作。
  
  使用方法：
  将zkfire.jar包替换lib下的openfire.jar,之所以命名zkfire.jar只是为了易于区分，名字可以随意取。并将cluster.xml放到bin目录下。
  zkfire基于单openfire的实现，所以如果使用的话建议不要开启openfire自身的集群功能。
  在安装的openfire目前bin下，放入cluster.xml文件。
  示例内容如下：
  <?xml version="1.0" encoding="UTF-8"?>
   <jive>
        <!-- 该节点用于openfire服务器之间通讯。IP为本机IP地址，需其他服务器能访问到 -->
	<notice>10.10.152.180:3004</notice>
         <!-- zoo节点用于配置zkfire的zookeeper服务。如果用其他zk服务器，那么这个节点可以去掉。-->
	<zoo> 
		<tickTime>2000</tickTime>
		<initLimit>10</initLimit>
		<syncLimit>5</syncLimit>
		<dataDir>E:/zoo/data</dataDir>
		<clientPort>3181</clientPort>
		<server name="server.1">10.10.152.180:2888:3888</server>
              <server name="server.2">10.10.152.185:2888:3888</server>
              <server name="server.3">10.10.152.189:2888:3888</server>
		<myid>1</myid>
		<!-- ########## -->
		<globalOutstandingLimit>1000</globalOutstandingLimit>
	</zoo>
        
      <!-- 该节点用于连接zk服务器，如果连接zkfire自身的zk服务器，那么该节点可以去掉 -->
	<zClient>127.0.0.1:3181</zClient>
   </jive>

   zoo中的节点server用于配置zookeeper的集群，myid指定本身zookeeper服务器的myid值，server.X 这个数字就是对应myid中的数字，集群中不同zk服务器的myid值不同。
   zoo中其他节点的内容皆对应zk配制文件的键值内容。这里不再详述，可以参考 http://rdc.taobao.com/team/jm/archives/665，但dataDir与clientPort是必须配置，用于指定zookeeper数据文件地址与监听端口。 
  