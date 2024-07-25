# Dies ist ein Kommentar

# Provider-Definition (Mindestanforderung für "terraform init")
provider "aws" {
  region = "eu-central-1"
}

# Sicherheitsgruppe für die EC2 Instanz
resource "aws_security_group" "my_security_group" {
  name        = "my_security_group"
  description = "Sicherheitsgruppe SSH, HTTP & HTTPS Zugriff von UEBERALL"

  ingress {
    description = "SSH von ueberall"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP von ueberall"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS von ueberall"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Alle ausgehenden Verbindungen erlaubt"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Eine Amazon Linux 2023 EC2 Instanz im t2.micro-Format
resource "aws_instance" "erste_instanz" {
  instance_type          = "t2.micro"
  ami                    = "ami-071878317c449ae48" # Amazon Linux 2023 AMI
  vpc_security_group_ids = [aws_security_group.my_security_group.id]

  tags = {
    Name = "<Brownies>"
  }
}

# Ausgaben
output "public_ip" {
  description = "Oeffentliche IP-Adresse der Instanz"
  value       = aws_instance.erste_instanz.public_ip
}

output "security_group_name" {
  description = "Name der Security Group"
  value       = aws_security_group.my_security_group.name
}

output "security_group_rule_arns" {
  description = "ARN aller Security-Group-Rules"
  value       = [
    aws_security_group.my_security_group.id
  ]
}