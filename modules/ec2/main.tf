resource "aws_instance" "validation" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 (us-east-1)
  instance_type = "t2.micro"

  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]

  associate_public_ip_address = false

  tags = merge(
    var.tags,
    {
      Name = "validation-app-${var.tags["Environment"]}"
      Role = "validation"
    }
  )
}
