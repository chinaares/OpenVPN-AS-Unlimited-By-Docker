你使用的是基于 hk59775634/openvpn-as 镜像部署的 OpenVPN Access Server，它默认使用了 OpenVPN 官方的 Access Server 版本，支持通过命令行修改管理员账号密码。

🔐 修改 OpenVPN 管理员账号密码的方法如下：
1.	进入容器终端：

docker exec -it openvpn-as /bin/bash

	2.	修改管理员账户密码：

OpenVPN Access Server 默认的管理员账户通常是 openvpn。你可以使用 passwd 命令修改该账号的密码：

passwd openvpn

系统会提示你输入新密码并确认。

⸻

✅ 可选：添加新管理员账户

如果你希望创建新的管理员账号，也可以使用以下命令：

adduser myadmin     # 创建用户
passwd myadmin      # 设置密码
/usr/local/openvpn_as/scripts/sacli --user myadmin --key "prop_superuser" --value "true" ConfigPut
/usr/local/openvpn_as/scripts/sacli --user myadmin --key "type" --value "user_connect" ConfigPut
/usr/local/openvpn_as/scripts/sacli start

这样你就创建了一个新的具有管理员权限的账户 myadmin。

⸻

🌐 Web 登录方式（默认端口）：
•	管理后台地址: https://<你的服务器IP>:943/admin
•	用户登录地址: https://<你的服务器IP>:943/

默认用户是 openvpn，密码你刚刚用 passwd 修改过。

⸻

如有其他 OpenVPN 配置需求（如客户端导出、用户权限管理等），也可以通过这个管理后台完成。需要我帮你生成客户端配置文件（.ovpn）或设置 NAT 转发规则也可以告诉我。