resource "aws_instance" "ec2-terraformed" {
  ami               = data.aws_ami.latest_ami.id
  instance_type     = var.chassis
  subnet_id         = var.public-subnet
  security_groups   = [var.sg]
  key_name          = "key"
  tags              = { Name = "ec2-terraformed" }
  user_data         = file("userdata.sh")
}