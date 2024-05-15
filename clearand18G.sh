#!/bin/bash

# Stop and remove all containers
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

# Remove all images
docker rmi $(docker images -q)

# Clean logs
truncate -s 0 /var/lib/docker/containers/*/*-json.log

# Clean /root directory
find /root -type d -name '.titanedge*' -exec rm -rf {} +
find /root -type d -name 'titan*' -exec rm -rf {} +
rm -rf /root/titan
#mkdir -p /root/titan/storage

# Download and extract titan_v0.1.18_linux_amd64.tar.gz
wget https://github.com/Titannet-dao/titan-node/releases/download/v0.1.18/titan_v0.1.18_linux_amd64.tar.gz
tar -xvf titan_v0.1.18_linux_amd64.tar.gz
cd titan_v0.1.18_linux_amd64

# Set environment variable
export QUIC_GO_DISABLE_ECN=true

# Add any additional commands you want to execute here

# Background execution of commands
echo "执行程序"
./titan-edge daemon start --init --url https://test-locator.titannet.io:5000/rpc/v0 &
sleep 30
echo "绑定id"
./titan-edge bind --hash=4AA7139E-BAF2-4598-935C-512B6D54199D https://api-test1.container1.titannet.io/api/v2/device/binding 
echo "设置容量"
./titan-edge config set --storage-size 25GB 
#./titan-edge config set --storage-path /root/titan/storage
pkill -f "titan-edge daemon start"
./titan-edge daemon start --init --url https://test-locator.titannet.io:5000/rpc/v0 &
