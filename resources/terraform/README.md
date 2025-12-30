This Terraform configuration provisions a single EC2 instance for a Minecraft Java server.

Important notes:
- This configuration does NOT include any User Data (per request).
- This configuration does NOT provision an Elastic IP.
- The security group opens TCP/25565 (Minecraft) to the public internet and allows SSH from the CIDR provided via `var.ssh_cidr`.

Usage:

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
