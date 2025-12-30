data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["*amzn-2023*"]
  }

  filter {
    name   = "architecture"
    values = ["arm64"]
  }
}

resource "aws_security_group" "minecraft" {
  name        = "minecraft-security-group"
  description = "Security group for Minecraft server"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "Minecraft TCP"
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "minecraft-sg"
  }
}

resource "aws_security_group_rule" "ssh_from_var" {
  count             = var.ssh_cidr != "" ? 1 : 0
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.ssh_cidr]
  security_group_id = aws_security_group.minecraft.id
  description       = "SSH from provided CIDR"
}

resource "aws_instance" "minecraft" {
  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = var.instance_type
  subnet_id     = data.aws_subnet_ids.default.ids[0]
  key_name      = var.key_name != "" ? var.key_name : null

  root_block_device {
    volume_size           = var.ebs_size
    volume_type           = "gp3"
    delete_on_termination = true
  }

  vpc_security_group_ids = [aws_security_group.minecraft.id]

  tags = {
    Name = var.instance_name
  }
}
