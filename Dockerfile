# ベースイメージとしてNode.jsを使用
FROM node:18-alpine

# 作業ディレクトリを作成
WORKDIR /app

# 必要なファイルをコピー
COPY package*.json ./

# ルートのpackage.jsonを作成
RUN echo '{}' > package.json

# クライアントの依存関係をインストール
COPY client/package*.json ./client/
RUN cd client && npm install

# サーバーの依存関係をインストール
COPY server/package*.json ./server/
RUN cd server && npm install

# クライアントのビルド
COPY client ./client
RUN cd client && npm run build

# サーバーのビルド
COPY server ./server
RUN cd server && npm run build

# 全体のポートを開放
EXPOSE 3000 3001

# サーバーとクライアントを同時に起動するために、`concurrently`を使用
RUN npm install -g concurrently

# 起動スクリプトを追加
COPY start.sh /start.sh
RUN chmod +x /start.sh

# コンテナ起動時にスクリプトを実行
CMD ["/start.sh"]
