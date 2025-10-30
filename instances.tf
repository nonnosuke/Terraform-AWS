resource "aws_instance" "web1" {
  ami             = "ami-0440d3b780d96b29d"
  instance_type   = "t3.medium"
  subnet_id     = aws_subnet.main_a.id
  security_groups = [aws_security_group.web_sg.id]
  key_name        = var.key_name
  tags = {
    Name = "Production_Env1"
  }
}

resource "aws_instance" "web2" {
  ami             = "ami-0440d3b780d96b29d"
  instance_type   = "t3.medium"
  subnet_id     = aws_subnet.main_b.id
  security_groups = [aws_security_group.web_sg.id]
  key_name        = var.key_name
  tags = {
    Name = "Production_Env2"
  }
}

resource "aws_instance" "jenkins" {
  ami             = "ami-0440d3b780d96b29d"
  instance_type   = "t3.medium"
  subnet_id     = aws_subnet.main_a.id
  security_groups = [aws_security_group.web_sg.id]
  key_name        = var.key_name
  user_data       = file("scripts/jenkins_install.sh")
  tags = {
    Name = "JenkinsController"
  }
}

resource "aws_instance" "testing" {
  ami             = "ami-0440d3b780d96b29d"
  instance_type   = "t3.medium"
  subnet_id     = aws_subnet.main_b.id
  security_groups = [aws_security_group.web_sg.id]
  key_name        = var.key_name
  tags = {
    Name = "Testing_Env"
  }
}

resource "aws_instance" "staging" {
  ami             = "ami-0440d3b780d96b29d"
  instance_type   = "t3.medium"
  subnet_id     = aws_subnet.main_a.id
  security_groups = [aws_security_group.web_sg.id]
  key_name        = var.key_name
  tags = {
    Name = "Staging_Env"
  }
}

resource "aws_instance" "permanent_agent" {
  ami             = "ami-0440d3b780d96b29d"
  instance_type   = "t3.medium"
  subnet_id     = aws_subnet.main_b.id
  security_groups = [aws_security_group.web_sg.id]
  key_name        = var.key_name
  user_data       = <<-EOF
                #!/bin/bash
                # Update system
                sudo dnf update -y

                # Install required tools
                sudo dnf install -y git java-21-amazon-corretto git

                # Add 1 GB Swap
                sudo fallocate -l 1G /swapfile_extend_1GB
                sudo chmod 600 /swapfile_extend_1GB
                sudo mkswap /swapfile_extend_1GB
                sudo swapon /swapfile_extend_1GB

                # Extend /tmp directory
                sudo mount -o remount,size=5G /tmp/
                EOF
  tags = {
    Name = "Permanent_Agent"
  }
}
