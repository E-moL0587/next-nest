#!/bin/sh

# サーバーをバックグラウンドで起動
cd server && npm run start:prod &

# クライアントを起動
cd ../client && npm run start
