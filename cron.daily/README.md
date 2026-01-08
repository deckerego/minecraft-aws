# Installing crontab entries

1. Create a new S3 bucket. If you enable versioning to keep a history of your backups, don't forget to create a Lifecycle event to delete old versions after _x_ days.
1. Create a policy that allows for List, Get, and appropriate PutObject permissions for your S3 bucket
1. Create a role for the EC2 instance that uses the new policy
1. Attach the role to the EC2 instance running your Minecraft server
1. sudo cp backup_server /etc/cron.daily
1. sudo chown minecraft /etc/cron.daily/backup_server
1. sudo chmod u+x /etc/cron.daily/backup_server
1. Modify backup_server to have the correct name of the S3 bucket you created
1. sudo cp check_server /etc/cron.daily
1. sudo chown minecraft /etc/cron.daily/check_server
1. sudo chmod u+x /etc/cron.daily/check_server
