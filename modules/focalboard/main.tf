resource "aws_instance" "focalboard" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.security_group_ids
  subnet_id              = var.public_subnet_ids[0]

  #user_data = templatefile("${path.module}/user_data.sh", {})

  user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt-get install -y docker.io
                sudo systemctl start docker
                sudo systemctl enable docker
                usermod -aG docker ubuntu
                docker run -d -p 8000:8000 mattermost/focalboard
                EOF

  tags = {
    Name = "focalboard-instance"
  }

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }
}