# This is the main or root file

module "vpc" {
    source = "./VPC"
}

module "sg" {
    source = "./SG"
    vpc-id = module.vpc.vpc-id
}

module "ec2" {
    source = "./EC2"
    public-subnet = module.vpc.public-subnet
    sg = module.sg.sg
}