#!/bin/sh

# Install Frpc As deamon 
# RUN AS ROOT!

mkdir /opt/frp -p \
   && cd /opt/frp \
   && wget https://github.com/fatedier/frp/releases/download/v0.27.0/frp_0.27.0_linux_amd64.tar.gz \
   && tar zxvf frp_0.27.0_linux_amd64.tar.gz \
   && cd frp_0.27.0_linux_amd64
   
mkdir /usr/lib/systemd/system -p
mkdir /etc/frp -p

# link exe
ln -s /opt/frp/frp_0.27.0_linux_amd64/frpc /usr/bin/frpc

# copy ini to /etc/frp/
cp ./etc/* /etc/frp/

cp ./systemd/* /usr/lib/systemd/system/ 

# systemctl
systemctl enable frpc
systemctl enable frpc_skygufei

systemctl start frpc_skygufei
 



