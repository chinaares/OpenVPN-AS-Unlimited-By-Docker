# OpenVPN Access Server With Unlimited Licence
##### Server Requirement: **Centos 7 x86_64**

### 安装

```sh
$ cd /tmp/ && yum install git -y && git clone https://github.com/hk59775634/OpenVPN-AS-Unlimited-By-Docker && cd OpenVPN-AS-Unlimited-By-Docker/ && sed -i -e 's/\r$//' centos7.sh && chmod 755 centos7.sh && ./centos7.sh
```

### Docker-compose 部署

```sh
$ cd /opt/ && git clone https://github.com/hk59775634/OpenVPN-AS-Unlimited-By-Docker && cd OpenVPN-AS-Unlimited-By-Docker/ && docker-compose up -d
```

安装完成后访问
```sh
https://ip:943/admin
```

username:openvpn
password:openvpn
