#!/bin/bash
DIR=$(pwd)

LOCAL_PORT=22

REMOTE_PORT=5556

HOSTNAME=$(cat /etc/hostname)

echo "hostname:$HOSTNAME"
echo "localport:$LOCAL_PORT"
echo "remoteport:$REMOTE_PORT"

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

cd $DIR

# copy ini to /etc/frp/
cp -rf ./etc/* /etc/frp/

cp -rf ./systemd/* /usr/lib/systemd/system/ 


# add to ini

echo \
    "[ssh_$HOSTNAME@$REMOTE_PORT@$LOCAL_PORT]" \
    "\ntype = tcp" \
    "\nlocal_ip = 127.0.0.1" \
    "\nlocal_port = $LOCAL_PORT" \
    "\nremote_port = $REMOTE_PORT" \
>> /etc/frp/frpc_gufei.ini

# systemctl
systemctl enable frpc
systemctl enable frpc_skygufei

systemctl restart frpc_skygufei
systemctl status frpc_skygufei
 



