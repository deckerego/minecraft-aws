## Installing system startup script

1. cp minecraft.service /etc/systemd/system/
1. sudo systemctl daemon-reload
1. sudo systemctl enable minecraft.service
1. sudo systemctl start minecraft.service