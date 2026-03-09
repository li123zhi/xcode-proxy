#!/bin/bash

# Xcode Proxy 快速启动脚本

echo "🚀 启动 Xcode Proxy 服务器..."

# 激活虚拟环境并启动服务
source venv/bin/activate
export PYTHONPATH=/Users/ruite_ios/Desktop/aiShortVideo/xcode-proxy

# 检查是否已有服务在运行
if lsof -Pi :3000 -sTCP:LISTEN -t >/dev/null ; then
    echo "⚠️  端口 3000 已被占用，正在停止旧服务..."
    pkill -f "uvicorn app.main:app"
    sleep 2
fi

# 启动新服务
echo "📡 启动服务在 http://0.0.0.0:3000"
nohup uvicorn app.main:app --host 0.0.0.0 --port 3000 > server.log 2>&1 &

# 等待服务启动
sleep 3

# 检查服务状态
if curl -s http://localhost:3000/health > /dev/null ; then
    echo "✅ 服务启动成功！"
    echo "📡 服务地址: http://localhost:3000"
    echo "🤖 可用模型: GLM-4.7, GLM-4.6"
    echo ""
    echo "查看日志: tail -f server.log"
    echo "停止服务: ./stop.sh"
else
    echo "❌ 服务启动失败，请查看日志: cat server.log"
fi
