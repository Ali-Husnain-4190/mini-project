terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}
data "aws_vpcs" "foo" {
  filter {
    name   = "tag:Name"
    values = ["vpc-1"]
  }
}

output "vpcs" {
  value = data.aws_vpcs.foo.ids[0]
}
data "aws_security_group" "sg" {
  vpc_id = data.aws_vpcs.foo.ids[0]
  filter {
    name   = "tag:Name"
    values = ["ssm"]
  }
}

output "sg_name" {
  value = data.aws_security_group.sg.id
}
resource "aws_vpc_endpoint" "ec2" {
  vpc_id            = data.aws_vpcs.foo.ids[0]
  service_name      = "com.amazonaws.us-east-1.ssm"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    data.aws_security_group.sg.id,
  ]
  subnet_ids = ["subnet-09dd3c9310267ba64"]

  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id            = data.aws_vpcs.foo.ids[0]
  service_name      = "com.amazonaws.us-east-1.ec2messages"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    data.aws_security_group.sg.id,
  ]
  subnet_ids = ["subnet-09dd3c9310267ba64"]

  private_dns_enabled = true
}
resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id            = data.aws_vpcs.foo.ids[0]
  service_name      = "com.amazonaws.us-east-1.ssmmessages"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    data.aws_security_group.sg.id,
  ]
  subnet_ids = ["subnet-09dd3c9310267ba64"]

  private_dns_enabled = true
}
