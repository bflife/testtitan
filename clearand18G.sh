#!/bin/bash

# Stop and remove all containers
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

# Remove all images
docker rmi $(docker images -q)

# Clean logs
truncate -s 0 /var/lib/docker/containers/*/*-json.log

# Clean /root directory
find /root -type d -name 'titanedge*' -exec rm -rf {} +

# Download and extract titan_v0.1.18_linux_amd64.tar.gz
wget https://github.com/Titannet-dao/titan-node/releases/download/v0.1.18/titan_v0.1.18_linux_amd64.tar.gz
tar -xvf titan_v0.1.18_linux_amd64.tar.gz
cd titan_v0.1.18_linux_amd64

# Set environment variable
export QUIC_GO_DISABLE_ECN=true

# Add any additional commands you want to execute here

# Background execution of commands
echo "执行程序"
nohup ./titan-edge daemon start --init --url https://us-locator.titannet.io:5000/rpc/v0 &
sleep 30
echo "绑定id"
./titan-edge bind --hash=5B48F06A-52D3-4544-8640-48B0DCB99876 https://api-test1.container1.titannet.io/api/v2/device/binding 
echo "设置容量"
./titan-edge config set --storage-size 72GB 
pkill -f "titan-edge daemon start"
nohup ./titan-edge daemon start --init --url https://us-locator.titannet.io:5000/rpc/v0 &
