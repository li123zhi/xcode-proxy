#!/bin/bash

# Xcode Proxy 停止脚本

echo "🛑 停止 Xcode Proxy 服务器..."

# 查找并停止 uvicorn 进程
if pkill -f "uvicorn app.main:app" ; then
    echo "✅ 服务已停止"
else
    echo "⚠️  没有找到运行中的服务"
fi
