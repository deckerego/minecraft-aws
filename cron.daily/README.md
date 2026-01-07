# Installing crontab entries

1. sudo cp backup_server /etc/cron.daily
1. sudo chown minecraft /etc/cron.daily/backup_server
1. sudo chmod u+x /etc/cron.daily/backup_server
1. Modify backup_server to have the correct S3 bucket name
