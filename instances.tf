# public ec2 for bation host
resource "aws_instance" "bation--host" {
    ami = var.ami
    key_name = var.key-name
    instance_type = var.instance-type
    vpc_security_group_ids = [aws_security_group.bastion-host.id]
    subnet_id = aws_subnet.pub1.id
     tags = {
      Name= "bastion-server"
    }   
}

# front end servers
resource "aws_instance" "front1" {
    ami = var.ami
    instance_type = var.instance-type
    key_name = var.key-name
    availability_zone = "us-west-2a"
    subnet_id = aws_subnet.prvt3.id
    vpc_security_group_ids = [aws_security_group.frontend-server-sg.id]
    tags = {
      Name = "frontend-server-1"
    }
}

resource "aws_instance" "front2" {
    ami = var.ami
    instance_type = var.instance-type
    key_name = var.key-name
    availability_zone = "us-west-2b"
    subnet_id = aws_subnet.prvt4.id
    vpc_security_group_ids = [aws_security_group.frontend-server-sg.id]
    tags = {
      Name = "frontend-server-2"
    }
}

# backend server
resource "aws_instance" "back1" {
    ami = var.ami
    instance_type = var.instance-type
    key_name = var.key-name
    availability_zone = "us-west-2a"
    subnet_id = aws_subnet.prvt5.id
    vpc_security_group_ids = [aws_security_group.backend-server-sg.id]
    tags = {
      Name = "backend-server-1"
    }
}

resource "aws_instance" "back2" {
    ami = var.ami
    instance_type = var.instance-type
    key_name = var.key-name
    availability_zone = "us-west-2b"
    subnet_id = aws_subnet.prvt6.id
    vpc_security_group_ids = [aws_security_group.backend-server-sg.id]
    tags = {
      Name = "backend-server-2"
    }
}