resource "aws_instance" "my_instance" {
  ami                         = "ami-01e444924a2233b07"
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  security_groups             = [aws_security_group.ssh_sg.id]
  key_name                    = var.key_name
  associate_public_ip_address = true

  tags = {
    Name = "MyInstance"
  }
}

resource "aws_dynamodb_table" "example" {
  name           = var.dynamodb_table_name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name = var.dynamodb_table_name
  }
}
