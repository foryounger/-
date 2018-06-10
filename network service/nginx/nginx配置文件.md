#nginx配置文件解析
、、、shell
    #设置用户与组
    #user  nobody;
    #启动子进程数，可以通过ps aux|grep nginx查看
    worker_processes  1;
    #错误日志文件，以及日志级别
    #error_log  logs/error.log;
    #error_log  logs/error.log  notice;
    #error_log  logs/error.log  info;
    
    #进程号保存文件
    #pid        logs/nginx.pid;


    events {
    #每个进程可以处理的连续数，受系统文件句柄的权限
        worker_connections  1024;
    }


    http {
    #mime.types为文件类型定义文件
        include       mime.types;
    #默认文件类型
        default_type  application/octet-stream;
    #使用log_format可以自定义日志格式，名称为main
        #log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
        #                  '$status $body_bytes_sent "$http_referer" '
        #                  '"$http_user_agent" "$http_x_forwarded_for"';
    #创建访问日志，格式采用main定义的格式
        #access_log  logs/access.log  main;
    #是否调用sendfile（）进行数据复制，sendfile（）复制数据是在内核级别完成的，所以会比一般的read、write更高效
        sendfile        on;
    #开启后服务器的响应头部信息产生独立的数据包发送，即一个响应头部信息一个包
        #tcp_nopush     on;
    #保持连接的超时时间
        #keepalive_timeout  0;
        keepalive_timeout  65;
    #是否采用压缩功能，将页面压缩后传输更节省流量
        #gzip  on;
    #使用server定义虚拟主机
        server {
    #服务器监听的端口
            listen       80;
            #访问域名
            server_name  localhost;
            #编码格式，如果网页编码与此设置不同，则将被自动转码
            #charset koi8-r;
            #设置虚拟主机的访问日志
            #access_log  logs/host.access.log  main;
            #对URL进行匹配
            location / {
            #设置网页根路径，使用的是相对路径，html指的是处于nginx安装路径下
                root   html;
             #首页文件，先找index.html，若没有，再找index.htm
                index  index.html index.htm;
            }
            #设置错误代码对应的错误页面

            #error_page  404              /404.html;

            # redirect server error pages to the static page /50x.html
            #
            error_page   500 502 503 504  /50x.html;
            location = /50x.html {
                root   html;
            

            # proxy the PHP scripts to Apache listening on 127.0.0.1:80
            #
            #下面三行注射表明，若用户访问URL以.php结尾，则自动将该请求转交给127.0.0.1服务器，通过proxy_pass可以实现代理
            #location ~ \.php$ {
            #    proxy_pass   http://127.0.0.1;
            #}

            # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
            #
            #location ~ \.php$ {
            #    root           html;
            #    fastcgi_pass   127.0.0.1:9000;
            #    fastcgi_index  index.php;
            #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
            #    include        fastcgi_params;
            #}

            # deny access to .htaccess files, if Apache's document root
            # concurs with nginx's one
            #
            #拒绝所有人的访问.ht页面
            #location ~ /\.ht {
            #    deny  all;
            #}
        }


        # another virtual host using mix of IP-, name-, and port-based configuration
        #
        #定义虚拟主机
        #server {
        #    listen       8000;
        #    listen       somename:8080;
        #    server_name  somename  alias  another.alias;
        #
        #     location / {
        #        root   html;
        #       index  index.html index.htm;
        #        }
        #}


        

        # HTTPS server
        #
        #server {
        #监听TLS使用的443端口
        #    listen       443 ssl;
        #    server_name  localhost;
        #开启ssl功能
        #     ssl        on;
        #指定证书文件，使用相对路径证书需要存放在与nginx.conf同目录下
        #    ssl_certificate      cert.pem;
        #指定私钥文件，使用相对路径私钥需要存放在与nginx.conf同目录下
        #    ssl_certificate_key  cert.key;

        #    ssl_session_cache    shared:SSL:1m;
        #    ssl_session_timeout  5m;

        #    ssl_ciphers  HIGH:!aNULL:!MD5;
        #    ssl_prefer_server_ciphers  on;

        #    location / {
        #        root   html;
        #        index  index.html index.htm;
        #    }
        #}

    }

、、、
