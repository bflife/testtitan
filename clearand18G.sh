#!/bin/bash

# Stop and remove all containers
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

# Remove all images
docker rmi $(docker images -q)

# Clean logs
truncate -s 0 /var/lib/docker/containers/*/*-json.log

# Clean /root directory
find /root -type d -name 'titan_storage*' -exec rm -rf {} +

# Download and extract titan_v0.1.18_linux_amd64.tar.gz
wget https://github.com/Titannet-dao/titan-node/releases/download/v0.1.18/titan_v0.1.18_linux_amd64.tar.gz
tar -xvf titan_v0.1.18_linux_amd64.tar.gz
cd titan_v0.1.18_linux_amd64

# Set environment variable
export QUIC_GO_DISABLE_ECN=true

# Add any additional commands you want to execute here

# Background execution of commands
./titan-edge daemon start --init --url https://us-locator.titannet.io:5000/rpc/v0 &
./titan-edge bind --hash=D0D12B17-A819-454D-8E34-99546CCC19F3 https://api-test1.container1.titannet.io/api/v2/device/binding 
./titan-edge config set --storage-size 18GB 
