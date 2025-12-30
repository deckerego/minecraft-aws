variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t4g.small"
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = "Minecraft Server"
}

variable "key_name" {
  description = "EC2 key pair name to use for SSH (leave empty to not set)"
  type        = string
  default     = ""
}

variable "ssh_cidr" {
  description = "CIDR allowed for SSH access (recommended: EC2 Instance Connect ranges for your region). Leave empty to allow SSH from anywhere (not recommended)."
  type        = string
  default     = "0.0.0.0/0"
}

variable "ebs_size" {
  description = "Root EBS volume size in GB"
  type        = number
  default     = 8
}
