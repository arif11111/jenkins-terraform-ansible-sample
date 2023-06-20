variable "publicip" {
  default = true
}

variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "aws_vpc_id" {
  type = string
  default = "vpc-0d71a5851aad3ea32"
}

variable "aws_ami" {
  type = string
  default = "ami-0889a44b331db0194"  #Linunx AMI ID  
}

variable "subnet_id" {
  type = string
  default = "subnet-062002c0d8ac5a355"
}

variable "inst_type" {
  type = string
  default = "t2.micro"
}

variable "keyname" {
  type = string
  default = "cloud_training_1"
} 

variable "sec_grp_name" {
  type = string
  default = "IAC-Sec-Group"
}