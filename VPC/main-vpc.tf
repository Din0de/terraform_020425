# Create VPC example 100.64.0.0/16

resource "aws_vpc" "vpc-example" {
  cidr_block           = var.vpc-cidr #this looks at the tfvars.tf because we made a variable there
  enable_dns_support   = true         # I put this in quotations before
  enable_dns_hostnames = true         # this gives it a public DNS name
  tags                 = { Name = "vpc-example" }
}


# Create internet gateway

resource "aws_internet_gateway" "igw-example" {
  vpc_id = aws_vpc.vpc-example.id
  tags   = { Name = "igw-example" }
}

# Create the public subnet

resource "aws_subnet" "public-tf-sn" {
  cidr_block              = var.pub-cidr
  map_public_ip_on_launch = "true"
  vpc_id                  = aws_vpc.vpc-example.id
  availability_zone       = "us-east-1a"
  tags                    = { Name = "public-tf-sn" }
}

# Create the private subnet

resource "aws_subnet" "private-tf-sn" {
  cidr_block        = var.priv-cidr
  vpc_id            = aws_vpc.vpc-example.id
  availability_zone = "us-east-1b"
  tags              = { Name = "private-tf-sn" }
}

# Create the route table

resource "aws_route_table" "public-tf-rt" {
  vpc_id = aws_vpc.vpc-example.id
  tags   = { Name = "public-tf-RT" }
}

# Create the public route for the route table
# This adds a default route to the internet for the route table

resource "aws_route" "public-tf-route" {
  route_table_id         = aws_route_table.public-tf-rt.id # related to the tag above
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw-example.id
}

# Associate public subnet with the public route table

resource "aws_route_table_association" "public-sn-to-public-rt" {
  route_table_id = aws_route_table.public-tf-rt.id
  subnet_id      = aws_subnet.public-tf-sn.id
}

# The module below is the producer

output "vpc-id" {
    value = aws_vpc.vpc-example.id
}

output "public-subnet" {
    value = aws_subnet.public-tf-sn.id
}



