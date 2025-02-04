# Create the security group

resource "aws_security_group" "sg-tf" {
  name        = "allow SSH and HTTP"
  description = "allow SSH and HTTP"
  vpc_id      = var.vpc-id
  tags        = { Name = "sg-tf" }
}

# Ingress SSH rule for security group

resource "aws_vpc_security_group_ingress_rule" "allow-ssh" {
  security_group_id = aws_security_group.sg-tf.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

# Ingress HTTP rule for security group 

resource "aws_vpc_security_group_ingress_rule" "allow-hhtp" {
  security_group_id = aws_security_group.sg-tf.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

# Egress all outbound rule for security group 

resource "aws_vpc_security_group_egress_rule" "all-outbound" {
  security_group_id = aws_security_group.sg-tf.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

output "sg" {
    value = aws_security_group.sg-tf.id
}