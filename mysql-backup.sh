#!/bin/bash
date

#accesses from mysql database
db_user=eleven
db_password=ST2017whiller#
db_name=sot

#database backup directory
destination_db=db

# Check Backup Directory is exist and create it if not exist
if [ ! -d $destination_db ]
then
    echo "Directory does not exist! Creating backup database directory ..."
    mkdir -p $destination_db
    echo "Directory created successfully!" >> $destination_db
    echo "+++++++++++++++++++++++++++++++++++++++++++++++"
    echo "Starting MySQL Backup" >> $destination_db
else 
    echo "Starting MySQL Backup" >> $destination_db
fi

dump_db=$destination_db/$db_name-$(date '+%d-%m-%Y_%H-%M-%S').sql

mysqldump --user=$db_user --password=$db_password $db_name > $dump_db | gzip > $dump_db.gz

#recipient's ssh access
destination_user=oem
destination_ip=85.29.133.222
destination_dir=/home/odmin/auto-backup/db

#sending
rsync --archive --verbose --progress --rsh='ssh -p2222' $dump_db $destination_user@$destination_ip:$destination_dir