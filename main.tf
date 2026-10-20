
























# 1. Cloud Provider Block: Tell Terraform to look at AWS
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# The AWS region is inherited from your "aws configure" terminal settings
provider "aws" {
  region = "us-west-1"
}

# 2. Virtual Server Block: Provision a free-tier virtual machine (EC2)
resource "aws_instance" "chattter_cloud_server" {
  # The Amazon Machine Image ID for a basic Ubuntu 22.04 server in us-west-1
  ami           = "ami-0cbd40f694b804622" 
  
  # t2.micro is the golden standard size for the 100% Free Tier allotment
  instance_type = "t2.micro"

  tags = {
    Name = "Chattter-Cloud-Prod-Server"
  }
}
