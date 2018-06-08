# DNS简介
<br> DNS（domain name system ）是域名解析系统的简称，BIND: Berkeley Internet Name Domain。dns的主要功能是进行域名与ip地址之间的解析。域名是等级的
一般分为：主机名.三级域名.二级域名.顶级域名. 。最后一点是根域，是所有域名的起点。</br><br>域名查询分为递归查询与迭代查询。递归查询：客户端首先检查本地缓存中是否有之前的查询记录，有就直接读取，没有就向本地DNS服务器发送查询请求。迭代查询：从分布式DNS系统顶端开始查询,一般DNS服务器之间属迭代查询，如：若DNS2不能响应DNS1的请求，则它会将DNS3的IP给DNS2，以便其再向DNS3发出请求</br>

#  DNS数据库的记录：正解，反解，Zone得意义
* 从主机名查询到 IP 的流程称为：正解
* 从 IP 反解析到主机名的流程称为：反解
* 不管是正解还是反解，每个领域的记录就是一个区域 (zone)
<br>正解的设定权以及DNS正解zone记录的标志符合上层NDS所给予的领域范围，即可申请正解DNS服务器；
正解zone通常标志：
    SOA：就是开始验证 (Start of Authority) 的缩写，相关资料本章后续小节说明；
    NS：就是名称服务器 (NameServer) 的缩写，后面记录的数据是 DNS 服务器的意思；
    A：就是地址 (Address) 的缩写，后面记录的是 IP 的对应 (最重要)；
</br>
<br>反解的设定权以及 DNS 反解 zone 记录的标志:能够设定反解的就只有 IP 的拥有人，亦即你的 ISP 才有权力设定反解的。
那你向 ISP 取得的 IP 能不能自己设定反解呢？答案是不行！
除非你取得的是整个 class C 以上等级的 IP 网段，那你的 ISP 才有可能给你 IP 反解授权。
否则，若有反解的需求，就得要向你的直属上层 ISP 申请才行。
 
反解zone通常标志：

    SOA：就是开始验证 (Start of Authority) 的缩写，相关资料本章后续小节说明；
    NS：就是名称服务器 (NameServer) 的缩写，后面记录的数据是 DNS 服务器的意思；
    PTR：就是指向 (PoinTeR) 的缩写，后面记录的数据就是反解到主机名啰

 
每部DNS都需要的正解zone：hint
 
hint:
根目录在哪里的记录；
 
所以说，一部简单的正解 DNS 服务器，基本上就要有两个 zone 才行，一个是hint ，一个是关于自己领域的正解 zone。
 
 
DNS数据库的类型：hint，master/slave架构
 
hint：.(root)基本数据库类型；
master，slave 是两种基本类型，用来解决DNS服务器主从结构，数据同步问题的。
 
master

    要管理员自己手动去修改与设定;并且重启后才生效；
    一般来说，我们说的DNS设定，就是指设定这种数据库的类型
    给slave的DNS提供数据库内容

 
slave

    必须与master相互搭配
    只支持一主多从
    更改master之后，slave自动更新

 
master/slave的查询优先权？
在 DNS 系统当中，领域名的查询是『先抢先赢』的状态；
 
 
Master / Slave 数据的同步化过程
 
基本上，不论 Master 还是 Slave 的数据库，都会有一个代表该数据库新旧的『序号』，这个序号数值的大小，是会影响是否要更新的动作。
 
更新的两种方式：

    master主动告知
         Master 在修改了数据库内容，并且加大数据库序号后， 重新启动 DNS 服务，那 master 会主动告知 slave 来更新数据库，
    slave主动提出
        Slave 会定时的向 Master 察看数据库的序号， 当发现 Master 数据库的序号比 Slave 自己的序号还要大 (代表比较新)，那么 Slave 就会开始更新

 </br>
 # DNS 区域配置文件
 <br>  (1)资源记录：ResourceRecord, 简称rr；

     区域数据库文件中的每一个记录条目

    (2)记录有类型：A， AAAA， PTR，SOA， NS， CNAME， MX

                      SOA：StartOf Authority, 起始授权记录； 一个区域解析库有且只能有一个SOA记录，而且必须放在第一条；

                      NS：NameService, 域名服务记录；一个区域解析库可以有多个NS记录；其中一个为主的；

                      A： Address, 地址记录，FQDN --> IPv4转换；

                      AAAA：地址记录, FQDN --> IPv6转换；

                      CNAME：CanonicalName, 别名记录；

                      PTR：Pointer，指针, 从IP --> FQDN实现反向解析地址

                      MX：Mail eXchanger, 邮件交换器；有优先级的概念，用数字0-99表示，数字越小优先级越高；

        (3)资源记录的定义格式：

                   语法：name   [TTL]              IN            RR_TYPE              value

                          name：名称，可以为主机名、FQDN、IP，正向解析主机名是name，反向解析IP是name

                           TTL：缓存周期。DNS的缓存机制，可以统一定义，每条定义记录中省略从全局继承

                           IN：关键字，不能省略，指明其类型和值

                           RR_TYPE ：资源区域数据库的资源记录的类型

                           value：值，可以包含多段组成</br>
# bind的安装配置
<br>yum install bind*


        DNS主配置文件，fyoungr.com域名，zone.fyoungr.com域的配置文件
        vi /etc/named.conf
        zone "fyoungr.com" IN {
             type master;
             file "zone.fyoungr.com";
              allow-update { none; };
        };
        测试主配置文件
        named-checkconf
        新建域的配置文件zone.fyoungr.com
        vi /var/named/chroot/var/named/zone.fyoungr.com
        $TTL 86400
        @         IN   SOA xs.  fyoungr.com. (
                                                         20180414
                                                         3H
                                                         15M
                                                         1W
                                                         1D
                                                        )
                  IN  NS  xs.
                  IN  MX 5 mail.
        www       IN  A   192.168.1.20
        ftp       IN  A   192.168.1.20
        mail      IN  A   192.168.1.20
        测试fyoungr.com域配置文件
        named-checkzone fyoungr.com  /var/named/chroot/var/named/zone.fyoungr.com
        建立域配置文件的软连接
        ln -s /var/named/chroot/var/named/zone.fyoungr.com  /var/named/zone.fyoungr.com
        重启named服务
        service named  restart
        设置DNS
        vi /etc/resolv.conf
        测试解析是否成功
        host www.fyoungr.com
        nslookup www.fyoungr.com </br>
 
 
