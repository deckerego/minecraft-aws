# Terraform Templates

This is intended to be a Terraform-enabled version of an
[AWS for Games Blog post](https://aws.amazon.com/blogs/gametech/setting-up-a-minecraft-java-server-on-amazon-ec2/)
that details how to build a Minecraft server manually, leaning in to the free tier when possible. 

This setup skips the user data steps of the tutorial and does not provision an Elastic IP,
instead relying on the [setup scripts](../scripts/) and [systemd service](../systemd/)
to be installed by copying the files over.

**Note:** this does open TCP/25565 to the public internet. Make sure this instance is isolated from all your other workloads.


## Setup

1. Configure variables by editing `terraform.tfvars` or passing `-var` on the CLI.
2. Initialize and apply:

```bash
cd resources/terraform
terraform init
terraform apply
```

Customize `variables.tf` defaults to match your needs (region, key name, SSH CIDR).

Example variables file
- A sample `terraform.tfvars` is provided at `terraform.tfvars.example`. Copy it to `terraform.tfvars` and edit values before running `terraform apply`.

Example `terraform.tfvars` keys:

- `aws_region` — AWS region (e.g. `us-east-1`)
- `instance_type` — EC2 instance type (default `t4g.small`)
- `instance_name` — Tag name for the EC2 instance
- `key_name` — EC2 Key Pair name (leave blank to not assign a key)
- `ssh_cidr` — CIDR allowed for SSH (recommend EC2 Instance Connect CIDR or your admin IP)
- `ebs_size` — Root volume size in GB (default `8`)

The provided example is at: `terraform.tfvars.example` in this directory.
