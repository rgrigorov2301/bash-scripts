#!/bin/bash
dnf install git wget make gcc rpm-build zlib-devel pcre-devel gd-devel which perl-devel perl-ExtUtils-Embed libxslt-devel nano openssl-devel -y

cd /tmp/
curl http://nginx.org/packages/rhel/8/SRPMS/nginx-1.20.2-1.el8.ngx.src.rpm > /tmp/nginx-1.20.2-1.el8.ngx.src.rpm
git clone https://github.com/gabihodoroaga/nginx-ntlm-module.git /tmp/nginx-ntlm-module
rpm -ivh nginx-1.20.2-1.el8.ngx.src.rpm
rpm2cpio nginx-1.20.2-1.el8.ngx.src.rpm | cpio -idmv
curl http://gate.sbi-bg.com/nginx-with-ntlm.spec > /tmp/nginx-with-ntlm.spec
rpmbuild -bb nginx-with-ntlm.spec
