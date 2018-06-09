yum install httpd -y
rpm -ql httpd #查看 httpd文件安装路径 一般是在/etc/httpd/下 文件目录是在/var/www/下
配置文件 /etc/httpd/conf/httpd.conf
关闭selinux # setentfoce 0
关闭IPtables # /bin/systemctl stop iptables.service
验证是否启动 ： echo “hello world ” > /var/www/html/index.html
启动httpd服务：# /bin/systemctl start httpd.service
在浏览器中输入 localhost:80验证
