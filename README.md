sendgridjp-docker-example
=========================

This project includes the Dockerfile for creating the environment to run SendGrid official library for some programming languages.

このプロジェクトは、[SendGridブログ](https://sendgrid.kke.co.jp/blog/?cat=6)でご紹介しているサンプルを実行するための環境をDockerを利用して構築するためのDockerfileを含んでいます。  
これを利用することで簡単に各種プログラミング言語のライブラリ実行環境を構築することができます。  

# Programming languages
* go
* node.js
* php
* python
* ruby
* java

# Usage

## Building image
```bash
git clone https://github.com/SendGridJP/sendgridjp-docker-example.git
cd sendgridjp-docker-example
cp .env.example .env
# .envファイルを編集してください
./build.sh
```

## Sending Email
```bash
./send.sh
```

## ssh
```bash
./run.sh
./ssh.sh
```
