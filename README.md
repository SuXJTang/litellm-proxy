# LiteLLM Proxy 使用说明

## 快速启动
1. 双击运行 `start.ps1` 脚本即可启动服务
2. 服务将在 http://localhost:8000 上运行

## 更新 GitHub Token
1. 用记事本打开 `start.ps1`
2. 修改 `$GITHUB_TOKEN` 的值为新的 token
3. 保存文件
4. 重新运行 `start.ps1`

## 检查服务状态
```bash
# 检查健康状态
curl http://localhost:8000/health

# 测试API
curl http://localhost:8000/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "gpt-3.5-turbo",
    "messages": [{"role": "user", "content": "Hello!"}]
  }'
```

## 常见问题
1. 如果服务无法启动，检查：
   - Docker Desktop 是否正在运行
   - 端口 8000 是否被占用
   - GitHub Token 是否有效

2. 如何查看日志：
   ```bash
   docker logs litellm-proxy
   ```

## 文件说明
- `start.ps1`: 启动脚本，包含 GitHub Token 配置
- `config.yaml`: LiteLLM 配置文件
- `Dockerfile`: Docker 镜像构建文件
