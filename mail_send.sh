#!/bin/bash
# nkf が入っていなければインストールしておく
# sudo rpm -ivh nkf-2.0.8b-6.2.el6.x86_64.rpm  
export PATH=$PATH:/usr/sbin

# 実行前に入力する箇所 ----------------------------------
MAIL_TO="user01とか"
MAIL_FROM="サーバごとの適当なメールアドレス"
# SUBJECT は mail_send.sh の読み込み元で記述すること
# -------------------------------------------------------

mail_send () {
  local body=${1}

cat << EOD | nkf -j -m0 | sendmail -t
From: ${MAIL_FROM}
To: ${MAIL_TO}
Subject: ${SUBJECT:-"メールテスト"}
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
${body:-"テスト"}
EOD

  return 0
}
