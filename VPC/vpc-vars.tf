variable "vpc-cidr" {
  type        = string               # optional
  description = "the VPC CIDR block" # optional
  default     = "100.64.0.0/16"
}

variable "pub-cidr" {
  type        = string
  description = "the public subnet address"
  default     = "100.64.1.0/24"
}


variable "priv-cidr" {
  type        = string
  description = "the private subnet address"
  default     = "100.64.2.0/24"
}