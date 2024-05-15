#!/bin/bash

# 定义titan-edge程序所在目录和启动命令
titan_directory="/root/titan_v0.1.18_linux_amd64"
titan_start_command="./titan-edge daemon start --init --url https://us-locator.titannet.io:5000/rpc/v0 "

# 检查titan-edge程序是否在运行
if pgrep -x "titan-edge" > /dev/null
then
    # 若程序正在运行，执行export命令
    export QUIC_GO_DISABLE_ECN=true
    echo "titan-edge程序正在运行，已执行export命令"
else
    # 若程序未运行，切换到指定目录并启动titan-edge程序
    cd $titan_directory
    export QUIC_GO_DISABLE_ECN=true
    $titan_start_command &
    echo "titan-edge程序未运行，已启动新实例并保持后台执行"
fi
