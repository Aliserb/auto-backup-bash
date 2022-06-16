#!/bin/bash
date

destination_dir=backup/test-sud.backup

srv_name=sud.gov.kz

destination_ip=85.29.133.222

destination_user=oem

#srv_dir=domains/sud.gov.kz/html
send_dir=/home/odmin/test-backup

echo "Start backup ${srv_name}"

#mkdir -p ${destination_dir}${srv_name}/increment/
db_user=eleven
db_password=ST2017whiller#
db_name=sot

destination_db=db/

dump_db=${destination_db}${db_name}-$(date '+%d-%m-%Y_%H-%M-%S').sql

mysqldump -u${db_user} -p${db_password} ${db_name} > ${dump_db}

rsync --archive --verbose --progress --rsh='ssh -p2222' ${dump_db} ${destination_user}@${destination_ip}:${destination_dir}/db

rsync --archive --verbose --progress --rsh='ssh -p2222' ${send_dir} ${destination_user}@${destination_ip}:${destination_dir}${srv_name}

find ${destination_dir}${srv_name} -maxdepth 1 -type d -mtime +7 -exec rm -rf {} \;
date

echo "Finish backup ${srv_name}"
