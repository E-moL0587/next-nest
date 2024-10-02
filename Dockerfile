# ベースイメージとしてNode.jsを使用
FROM node:18-alpine

# 作業ディレクトリを作成
WORKDIR /app

# ルートのpackage.jsonを作成（必要に応じて）
RUN echo '{}' > package.json

# クライアントの依存関係をインストール
COPY client/package*.json ./client/
RUN cd client && npm install

# サーバーの依存関係をインストール
COPY server/package*.json ./server/
RUN cd server && npm install

# 環境変数ファイルをコピー
COPY client/.env.local ./client/.env.local
COPY client/.env.production ./client/.env.production

# クライアントのビルド
COPY client ./client
RUN cd client && npm run build

# サーバーのビルド
COPY server ./server
RUN cd server && npm run build

# 必要なツールのインストール
RUN npm install -g concurrently

# 起動スクリプトを追加
COPY start.sh /start.sh
RUN chmod +x /start.sh

# 全体のポートを開放
EXPOSE 3000 3001

# コンテナ起動時にスクリプトを実行
CMD ["/start.sh"]
