provider "aws" {
    region = var.aws_region
  }

resource "aws_security_group" "terraform_sg" {
  count=1
  name = var.sec_grp_name
  description = var.sec_grp_name
  vpc_id = var.aws_vpc_id

  // To Allow SSH Transport
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  // To Allow Port 80 Transport
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port = 443
    protocol = "tcp"
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
  }  

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_key_pair" "keypair_test" {
  key_name   = "jen-tf-keypair"
  public_key = "${file("${path.root}/id_rsa.pub")}"
}

resource "aws_instance" "project-iac" {
  count = 1
  ami = var.aws_ami 
  instance_type = var.inst_type
  subnet_id = var.subnet_id  #FFXsubnet2
  associate_public_ip_address = var.publicip
  key_name = var.keyname


  vpc_security_group_ids = [
    aws_security_group.terraform_sg.id
  ]
  root_block_device {
    delete_on_termination = true
    volume_size = 50
    volume_type = "gp2"
  }
  tags = {
    Name ="testserver"
    OS = "UBUNTU"
    Managed = "IAC"
  }

  depends_on = [ aws_security_group.terraform_sg ]
}


output "ec2_id" {
  value = "${aws_instance.project-iac.id}"
}

output "ec2_public_ip" {
  value = "${aws_instance.project-iac.public_ip}"
}