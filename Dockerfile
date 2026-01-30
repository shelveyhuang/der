FROM node:alpine3.20

# 不要用 /tmp，改用 /app
WORKDIR /app

# 先复制 package.json 安装依赖 (这样可以利用缓存，加快部署)
COPY package*.json ./
RUN npm install

# 再复制其他所有文件
COPY . .

# 保持原有的端口和启动命令
EXPOSE 3000/tcp

# 如果需要安装这些工具，保留在这里
RUN apk update && apk upgrade && \
    apk add --no-cache openssl curl gcompat iproute2 coreutils bash && \
    chmod +x index.js

CMD ["node", "index.js"]
