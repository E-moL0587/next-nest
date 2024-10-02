#!/bin/sh

# サーバーをバックグラウンドで起動
cd /app/server && npm run start:prod &

# クライアントを起動
cd /app/client && npm run start
