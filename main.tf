terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.29.0"
    }
  }
}

provider "aws" {
  region     = "ap-south-1"
}

data "aws_vpc" "default_vpc" {
  id = "vpc-0f624e4ecc843f288"
}

data "aws_security_group" "default_NSG" {
  id = "sg-0d3f74d66dbeccb82"
}

data "aws_subnet" "default_subnet" {
  id = "subnet-02da473617bab84e0"
}

resource "aws_instance" "TestVM" {
  ami           = "ami-0287a05f0ef0e9d9a" # us-west-2
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnet.default_subnet.id
  count         = 1
  key_name      = aws_key_pair.ssh_key.key_name
  tags = {
    Name = var.servername
  }
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "tf-key-pair"
  public_key = tls_private_key.vmkey.public_key_openssh
}

