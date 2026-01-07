# Terraform Templates

This will ultimately be a Terraform-enabled version of an
[AWS for Games Blog post](https://aws.amazon.com/blogs/gametech/setting-up-a-minecraft-java-server-on-amazon-ec2/)
that details how to build a Minecraft server manually, leaning in to the free tier when possible. 

This setup skips the user data steps of the tutorial and does not provision an Elastic IP,
instead relying on the [setup scripts](../scripts/) and [systemd service](../systemd/)
to be installed by copying the files over.

**Note:** this does open TCP/25565 to the public internet. Make sure this instance is isolated from all your other workloads.

## Work in Progress

The templates are a work in progress - I have several created but they aren't ready to commit just yet.
Ultimately they will include:

1. Creating an EC2 instance that can run in the free tier
1. Creating an S3 bucket with versioning for backups
1. Necessary roles & policies for S3 sync operations from your EC2 instance
1. Security groups for your EC2 instance
1. Installation of the `scripts/` helpers
1. Backup jobs within crontab
1. Sever version upgrades within crontab
