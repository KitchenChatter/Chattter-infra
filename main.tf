# =================================================================
# SECTION 1: PLATFORM PROVIDER CONFIGURATIONS
# =================================================================
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-west-1"
}

# =================================================================
# SECTION 2: FIREWALL & NETWORK SECURITY ENFORCEMENT
# =================================================================
resource "aws_security_group" "chattter_firewall" {
  name        = "chattter-production-firewall"
  description = "SRE Zero-Trust Firewall Rule Matrix for Chattter platform"

  # Inbound Rules (Ingress): Allow connection ONLY from your home network
  ingress {
    description     = "Secure access channel from engineer laptop location"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    ipv6_cidr_blocks = ["2607:fb92:2506:7e64:755b:e084:43a8:ffad/128"] 
  }

  # Outbound Rules (Egress): Allow your server to download patches and packages
  egress {
    description = "Allow complete outbound communication channels to the web"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Specifies ALL network protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Chattter-Prod-Firewall"
  }
}

# =================================================================
# SECTION 3: COMPUTE COMPONENT RESOURCE ALLOCATIONS
# =================================================================
resource "aws_instance" "chattter_cloud_server" {
  ami                    = "ami-0cbd40f694b804622" 
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.chattter_firewall.id]

  tags = {
    Name = "Chattter-Cloud-Prod-Server"
  }
}

# =================================================================
# SECTION 4: REMOTELY DEPLOYED PERSISTENT STORAGE VAULTS
# =================================================================
resource "aws_s3_bucket" "chattter_log_vault" {
  bucket        = "chattter-log-vault-mrowens"
  force_destroy = true

  tags = {
    Name        = "Chattter-Log-Vault"
    Environment = "Production"
  }
}
