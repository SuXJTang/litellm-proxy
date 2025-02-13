# 使用轻量级的 Python 3.9 基础镜像
# slim 版本比完整版小，但包含了运行 Python 所需的所有组件
FROM hub.staronearth.win/library/python:3.9-slim

# 设置工作目录
# 所有后续的命令都将在这个目录中执行
WORKDIR /app

# 配置 pip 使用阿里云镜像源加速包的下载
RUN pip config set global.index-url https://mirrors.aliyun.com/pypi/simple/

# 复制依赖文件并安装依赖
# 这一步放在前面是为了利用 Docker 的缓存机制
# 只有当 requirements.txt 发生变化时才会重新安装依赖
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 复制配置文件和说明文档到容器中
# 这些文件放在后面是因为它们可能经常变化
COPY config.yaml .
COPY .env .
COPY README.md .

# 设置环境变量
# PORT: LiteLLM 代理服务监听的端口
# HOST: 监听的地址，0.0.0.0 表示监听所有网络接口
ENV PORT=8000
ENV HOST=0.0.0.0

# 暴露容器端口
EXPOSE 8000

# 启动命令
# litellm 命令来自 litellm[proxy] 包
# --config 指定配置文件路径
CMD ["litellm", "--config", "config.yaml"]
