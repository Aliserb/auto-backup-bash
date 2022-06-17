#!/bin/bash
date

#data from the sender's server
send_dir=/home/odmin/domains/sud.gov.kz/html
send_user=odmin
send_ip=212.154.160.153

# project name
project_name=sud.gov.kz

#destination backup folder
destination_dir=backup

#backup lifetime
lifetime_dir=7

# Check Backup Directory is exist and create it if not exist
if [ ! -d $destination_dir ]
then
    echo "Directory does not exist! Creating backup database directory ..."
    mkdir -p $destination_dir
    echo "Directory created successfully!" >> $destination_dir
    echo "+++++++++++++++++++++++++++++++++++++++++++++++"
    echo "Starting MySQL Backup" >> $destination_dir
else 
    echo "Starting MySQL Backup" >> $destination_dir
fi

rsync --archive --verbose --progress $send_user@$send_ip:$send_dir $destination_dir/$project_name

echo "search files by expired date ($lifetime_dir days)"
find $destination_dir/$project_name -maxdepth 1 -type d -mtime +$lifetime_dir -exec rm -rf {} \;
date

echo "Finish backup $project_name"