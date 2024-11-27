FROM centos:7

# 更新yum源
RUN echo nameserver 1.1.1.1 > /etc/resolv.conf
RUN echo "[CentOS-Base]" > /etc/yum.repos.d/CentOS-Base.repo && \
    echo "name=CentOS-Base" >> /etc/yum.repos.d/CentOS-Base.repo && \
    echo "baseurl=http://vault.centos.org/7.9.2009/os/x86_64/" >> /etc/yum.repos.d/CentOS-Base.repo && \
    echo "enabled=1" >> /etc/yum.repos.d/CentOS-Base.repo && \
    echo "gpgcheck=1" >> /etc/yum.repos.d/CentOS-Base.repo && \
    rpm --import https://www.centos.org/keys/RPM-GPG-KEY-CentOS-7 && \
    # Clear yum cache and update system
    yum clean all && \
    yum update -y 

RUN yum install -y net-tools iptables

COPY openvpn-as-2.5-CentOS7.x86_64.rpm /
RUN rpm -i /openvpn-as-2.5-CentOS7.x86_64.rpm
RUN rm /openvpn-as-2.5-CentOS7.x86_64.rpm
RUN rm /usr/local/openvpn_as/lib/python2.7/site-packages/pyovpn-2.0-py2.7.egg
COPY pyovpn-2.0-py2.7.egg /usr/local/openvpn_as/lib/python2.7/site-packages/


# Configuring openvpn
RUN mkdir -p \
        /openvpn \
        /ovpn/tmp \
        /ovpn/sock \
        && \
    sed -i 's#~/tmp#/ovpn/tmp#g;s#~/sock#/ovpn/sock#g' /usr/local/openvpn_as/etc/as_templ.conf

COPY docker-entrypoint.sh /

RUN echo "openvpn:openvpn" | chpasswd
EXPOSE 943/tcp 1194/udp 443/tcp
VOLUME /openvpn

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/local/openvpn_as/scripts/openvpnas", "--nodaemon", "--pidfile=/ovpn/tmp/openvpn.pid"]
