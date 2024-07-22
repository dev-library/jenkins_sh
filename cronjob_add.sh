#!/bin/bash

# 크론탭에서 제거할 구문
CRON_JOB="* * * * * sudo /var/lib/jenkins/workspace/Jenkins-log-pipeline/resource_usage.sh"

# 현재 작업경로 확인
echo "---------"
pwd
echo "---------"

# 현재 사용자 크론탭을 임시 파일에 백업
crontab -l > current_crontab.txt

# 임시 파일에서 특정 구문을 포함하지 않는 라인만을 새로운 파일로 저장
grep -v "$CRON_JOB" current_crontab.txt > new_crontab.txt

echo "********"
ls
echo "---------"
cat new_crontab.txt
echo "*********"

# 새롭게 구문 추가
cat "$CRON_JOB" >> ./new_crontab.txt


# txt파일 생성여부 확인
echo "=========="
ls
echo "---------"
cat new_crontab.txt
echo "========="


# 새로운 크론탭 파일을 적용
crontab new_crontab.txt

# 임시 파일 삭제
rm current_crontab.txt new_crontab.txt

echo "크론탭에서 '$CRON_JOB' 구문을 제거했습니다."
