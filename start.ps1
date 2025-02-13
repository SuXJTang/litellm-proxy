# 停止并删除旧容器（如果存在）
docker stop litellm-proxy 2>$null
docker rm litellm-proxy 2>$null

# 从环境变量获取 GitHub Token
$GITHUB_TOKEN = $env:GITHUB_TOKEN
if (-not $GITHUB_TOKEN) {
    Write-Error "请设置环境变量 GITHUB_TOKEN"
    exit 1
}

# 启动新容器
docker run -d `
    --name litellm-proxy `
    -p 8000:8000 `
    -e GITHUB_TOKEN=$GITHUB_TOKEN `
    litellm-proxy
