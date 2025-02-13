# LiteLLM Proxy 启动脚本
# 作用：自动化部署和管理 LiteLLM 代理服务的 Docker 容器
# 使用方法：
# 1. 设置环境变量 GITHUB_TOKEN（在 PowerShell 中运行）：
#    $env:GITHUB_TOKEN = "你的GitHub Token"
# 2. 运行此脚本：
#    .\start.ps1

# 第一步：清理旧容器（如果存在）
# 2>$null 表示忽略错误输出，因为首次运行时容器可能不存在
docker stop litellm-proxy 2>$null
docker rm litellm-proxy 2>$null

# 第二步：获取 GitHub Token
# 从环境变量获取 Token，这样更安全，避免硬编码
$GITHUB_TOKEN = $env:GITHUB_TOKEN
if (-not $GITHUB_TOKEN) {
    Write-Error "错误：未设置 GITHUB_TOKEN 环境变量"
    Write-Error "请先运行: `$env:GITHUB_TOKEN = '你的GitHub Token'"
    exit 1
}

# 第三步：启动新容器
# -d: 后台运行容器
# -p 8000:8000: 将容器的 8000 端口映射到主机的 8000 端口
# --name: 指定容器名称
# -e: 设置环境变量
docker run -d `
    -p 8000:8000 `
    --name litellm-proxy `
    -e GITHUB_TOKEN=$GITHUB_TOKEN `
    litellm-proxy

Write-Host "LiteLLM 代理服务已启动！"
Write-Host "API 地址: http://localhost:8000"
Write-Host "测试命令: curl http://localhost:8000/health"
