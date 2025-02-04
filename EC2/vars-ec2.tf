variable "chassis" {
  type        = string
  description = "the chassis of the AMI image"
  default     = "t2.micro"
}

data "aws_ami" "latest_ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

variable "public-subnet" {}
variable "sg" {}