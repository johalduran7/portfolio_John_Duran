variable "vpc_id" {
  type    = string
  #default = "vpc-53cd6b2e"

}

variable "aws_region" {
  description = "The AWS region to create resources in"
  #default     = "us-east-1"
}

variable "app_tg_arn" {
  default = ""
}

variable "apache_tg_arn" {
  default = ""
}


variable "alb_dns_name" {
  default = ""

}

variable "public_subnets" {
  default = ""
}

variable "private_subnets" {
  default = ""
}

variable "asg_name" {
  type    = string
  default = "app_asg"
}

variable "env" {
  type    = string
  #default = "dev"
}

variable "ssh_public_key" {
  description = "Public SSH key for EC2 instances"
  type        = string
}

variable "desired_asg" {
  default = "0"
}

variable "min_asg" {
  default = "0"
}

variable "max_asg" {
  default = "1"
}
variable "path_user_data" {
  default = "./modules/asg/user_data.sh"
}