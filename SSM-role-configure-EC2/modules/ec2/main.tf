resource "aws_security_group" "my_ec2_instance_sg" {
  name        = var.sg_name
  description = "my_ec2_instnace_sg"
  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
resource "aws_security_group" "my_ec2_instance_sg_apache" {
  name        = "httpd"
  description = "my_ec2_instnace_sg"
  ingress {
    description = "Allow Inbound HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_iam_instance_profile" "my_instance_profile" {
  name = "my_instance_profile"
  role = aws_iam_role.test_role.name
}

resource "aws_instance" "my_ec2_instance" {
  # name                   = var.ec2_name
  ami                    = var.ami
  instance_type          = var.instnace_type
  vpc_security_group_ids = [aws_security_group.my_ec2_instance_sg.id, aws_security_group.my_ec2_instance_sg_apache.id]
  iam_instance_profile   = aws_iam_instance_profile.my_instance_profile.name
  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo yum -y install httpd && sudo systemctl start httpd",
  #     "echo '<h1><center>My Test Website With Help From Terraform Provisioner</center></h1>' > index.html",
  #     "sudo mv index.html /var/www/html/"
  #   ]
  # }
  user_data = <<EOF
#!/bin/bash
yum update -y
yum install -y httpd.x86_64
systemctl start httpd.service
systemctl enable httpd.service
echo “Hello World from $(hostname -f)” > /var/www/html/index.html
    
  EOF
}
