data "aws_ami" "ami"{
  most_recent = true
  name_regex = "RHEL-9-DevOps-Practice"
  owners = ["973714476881"]
}

data "aws_security_groups" "sg" {
  filter {
    name   = "group-name"
    values = ["allow-all"]
  }
}

resource "aws_instance" "test"{
  ami = data.aws_ami.ami.id
  vpc_security_group_ids = data.aws_security_groups.sg.ids
  instance_type=var.instance_type
  tags={
    Name = "test"
  }
}

output "private_ip" {
  value = aws_instance.test.private_ip
}