#!/bin/sh

# メール送信スクリプトの準備
SCRIPT_DIR=$(cd $(dirname ${0}); pwd)
source ${SCRIPT_DIR}/mail_send.sh

# 実行前に記述する箇所 ===========================================
# サービスの生存確認間隔
INTERVAL=10

# メールの件名
SUBJECT="[watch_process.sh] Alert Mail"
# ================================================================

# サービス名の入力確認
if [ -z "${1}" ]; then
  echo "[ERROR] サービス名が未指定です。"
  exit 1
fi

PROCESS_NAME=${1}
RESTART_CMD="/etc/init.d/${PROCESS_NAME} restart" #Cent OS6
#RESTART_CMD="systemctl restart ${PROCESS_NAME}.service" #Cent OS7

while true
do
    IS_ALIVE=`ps -ef | grep "${PROCESS_NAME}" | egrep -v "grep|${0}" | wc -l`
    if [ ${IS_ALIVE} -ge 1 ]; then
        :
    else
        mail_send "[`hostname`] サービス ${PROCESS_NAME} を再起動します。" 
        ${RESTART_CMD}
    fi
    sleep ${INTERVAL}
done
