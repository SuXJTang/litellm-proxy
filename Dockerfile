FROM hub.staronearth.win/library/python:3.9-slim

WORKDIR /app

# 设置pip镜像源
RUN pip config set global.index-url https://mirrors.aliyun.com/pypi/simple/

# 安装依赖
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 复制配置文件和说明文档
COPY config.yaml .
COPY .env .
COPY README.md .

# 设置环境变量
ENV PORT=8000
ENV HOST=0.0.0.0

# 暴露端口
EXPOSE 8000

# 启动命令
CMD ["litellm", "--config", "config.yaml"]
