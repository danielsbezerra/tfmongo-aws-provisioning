// VPC
resource "aws_vpc" "mongodb-vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
        App = var.app
        Env = var.env
    }
}

resource "aws_internet_gateway" "mongodb-gw" {
    vpc_id = aws_vpc.mongodb-vpc.id
}


// PUBLIC SUBNETS

// Public Subnet AZ 1a
resource "aws_subnet" "mongodb-az1a-pub-snet" {
    vpc_id = aws_vpc.mongodb-vpc.id

    cidr_block = var.public_subnet_cidr_1a
    availability_zone = "us-east-1a"

    tags = {
        App = var.app
        Env = var.env
    }
}

resource "aws_route_table" "mongodb-az1a-pub-rt" {
    vpc_id = aws_vpc.mongodb-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.mongodb-gw.id
    }

    tags = {
        App = var.app
        Env = var.env
    }
}

resource "aws_route_table_association" "mongodb-az1a-pub-rt-assoc" {
    subnet_id = aws_subnet.mongodb-az1a-pub-snet.id
    route_table_id = aws_route_table.mongodb-az1a-pub-rt.id
}


// Public Subnet AZ 1b
resource "aws_subnet" "mongodb-az1b-pub-snet" {
    vpc_id = aws_vpc.mongodb-vpc.id

    cidr_block = var.public_subnet_cidr_1b
    availability_zone = "us-east-1b"

    tags = {
        App = var.app
        Env = var.env
    }
}

resource "aws_route_table" "mongodb-az1b-pub-rt" {
    vpc_id = aws_vpc.mongodb-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.mongodb-gw.id
    }

    tags = {
        App = var.app
        Env = var.env
    }
}

resource "aws_route_table_association" "mongodb-az1b-pub-rt-assoc" {
    subnet_id = aws_subnet.mongodb-az1b-pub-snet.id
    route_table_id = aws_route_table.mongodb-az1b-pub-rt.id
}


// Public Subnet AZ 1c
resource "aws_subnet" "mongodb-az1c-pub-snet" {
    vpc_id = aws_vpc.mongodb-vpc.id

    cidr_block = var.public_subnet_cidr_1c
    availability_zone = "us-east-1c"

    tags = {
        App = var.app
        Env = var.env
    }
}

resource "aws_route_table" "mongodb-az1c-pub-rt" {
    vpc_id = aws_vpc.mongodb-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.mongodb-gw.id
    }

    tags = {
        App = var.app
        Env = var.env
    }
}

resource "aws_route_table_association" "mongodb-az1c-pub-rt-assoc" {
    subnet_id = aws_subnet.mongodb-az1c-pub-snet.id
    route_table_id = aws_route_table.mongodb-az1c-pub-rt.id
}




// PRIVATE SUBNET

// Private Subnet AZ 1a
resource "aws_subnet" "mongodb-az1a-priv-snet" {
    vpc_id = aws_vpc.mongodb-vpc.id

    cidr_block = var.private_subnet_cidr_1a
    availability_zone = "us-east-1a"

    tags = {
        App = var.app
        Env = var.env
    }
}

resource "aws_route_table" "mongodb-az1a-priv-rt" {
    vpc_id = aws_vpc.mongodb-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.mongodb-az1a-natgw.id
    }

    tags = {
        App = var.app
        Env = var.env
    }
}

resource "aws_route_table_association" "mongodb-az1a-priv-rt-assoc" {
    subnet_id = aws_subnet.mongodb-az1a-priv-snet.id
    route_table_id = aws_route_table.mongodb-az1a-priv-rt.id
}


// Private Subnet AZ 1b
resource "aws_subnet" "mongodb-az1b-priv-snet" {
    vpc_id = aws_vpc.mongodb-vpc.id

    cidr_block = var.private_subnet_cidr_1b
    availability_zone = "us-east-1b"

    tags = {
        App = var.app
        Env = var.env
    }
}

resource "aws_route_table" "mongodb-az1b-priv-rt" {
    vpc_id = aws_vpc.mongodb-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.mongodb-az1b-natgw.id
    }

    tags = {
        App = var.app
        Env = var.env
    }
}

resource "aws_route_table_association" "mongodb-az1b-priv-rt-assoc" {
    subnet_id = aws_subnet.mongodb-az1b-priv-snet.id
    route_table_id = aws_route_table.mongodb-az1b-priv-rt.id
}


// Private Subnet AZ 1c
resource "aws_subnet" "mongodb-az1c-priv-snet" {
    vpc_id = aws_vpc.mongodb-vpc.id

    cidr_block = var.private_subnet_cidr_1c
    availability_zone = "us-east-1c"

    tags = {
        App = var.app
        Env = var.env
    }
}

resource "aws_route_table" "mongodb-az1c-priv-rt" {
    vpc_id = aws_vpc.mongodb-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.mongodb-az1c-natgw.id
    }

    tags = {
        App = var.app
        Env = var.env
    }
}

resource "aws_route_table_association" "mongodb-az1c-priv-rt-assoc" {
    subnet_id = aws_subnet.mongodb-az1c-priv-snet.id
    route_table_id = aws_route_table.mongodb-az1c-priv-rt.id
}



// NAT Gateway

// Creates elastic IPs and NAT gateways
resource "aws_eip" "mongodb-az1a-eip" {
    vpc = true
    tags = {
        App = var.app
        Env = var.env
    }
}

resource "aws_eip" "mongodb-az1b-eip" {
    vpc = true
    tags = {
        App = var.app
        Env = var.env
    }
}

resource "aws_eip" "mongodb-az1c-eip" {
    vpc = true
    tags = {
        App = var.app
        Env = var.env
    }
}

resource "aws_nat_gateway" "mongodb-az1a-natgw" {
  allocation_id = aws_eip.mongodb-az1a-eip.id
  subnet_id     = aws_subnet.mongodb-az1a-pub-snet.id
}

resource "aws_nat_gateway" "mongodb-az1b-natgw" {
  allocation_id = aws_eip.mongodb-az1b-eip.id
  subnet_id     = aws_subnet.mongodb-az1b-pub-snet.id
}

resource "aws_nat_gateway" "mongodb-az1c-natgw" {
  allocation_id = aws_eip.mongodb-az1c-eip.id
  subnet_id     = aws_subnet.mongodb-az1c-pub-snet.id
}

// BASTION
resource "aws_instance" "mongodb-bastion" {
  # ami                         = "ami-0c37ee902a7924ed2"   // Ubuntu 16.04 hvm:ebs-ssd	20191204
  ami                         = "ami-03736048a69f59e6d"     // Amz Linux us-east1 amzn-ami-hvm
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.mongodb-vpc-sg.id}"]
  key_name                    = "terraform_ec2_key"
  subnet_id                   = aws_subnet.mongodb-az1a-pub-snet.id
}

resource "aws_key_pair" "terraform_ec2_key" {
  key_name = "terraform_ec2_key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "mongodb-vpc-sg" {
  name   = "mongodb-vpc-sg"
  vpc_id = aws_vpc.mongodb-vpc.id

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "roads_mongo_config" {
  count                       = 3
  ami                         = "ami-00e782930f1c3dbc7"
  instance_type               = "t2.micro"
  associate_public_ip_address = false
  vpc_security_group_ids      = ["<security_group_id>"]
  key_name                    = "<my_private_key>"
  subnet_id                   = <subnet_to_be_used>

  provisioner "chef" {
    environment     = "_default"
    run_list        = ["role[roads_config]"]
    node_name       = "${aws_instance.roads_mongo_config[count.index].id}"
    server_url      = "https://chef-server-url/organizations/orgName"
    recreate_client = true
    user_name       = "<your_user_name>"
    user_key        = "${file("/Path/to/your_private_key")}"
    ssl_verify_mode = ":verify_none"
    client_options  = ["chef_license 'accept'"]
    version         = "12.21.3"

    connection {
      type         = "ssh"
      host         = "${aws_instance.roads_mongo_config[count.index].private_ip}"
      user         = "ec2-user"
      private_key  = "${file("/Path/to/my_private_key")}"
      bastion_host = "bastion-server-url"
      bastion_host_key = "<copy-bastion-host-key from ~/.ssh/known_hosts file>"
  }
  }




# # mongodb-router
# resource "aws_instance" "mongodb-router" {
#   ami                         = "ami-0c37ee902a7924ed2"   // Ubuntu 16.04 hvm:ebs-ssd	20191204
#   #ami                         = "ami-03736048a69f59e6d"     // Amz Linux us-east1 amzn-ami-hvm
#   instance_type               = "t2.micro"
#   associate_public_ip_address = true
#   vpc_security_group_ids      = ["${aws_security_group.mongodb-vpc-sg.id}"]
#   key_name                    = "terraform_ec2_key"
#   subnet_id                   = aws_subnet.mongodb-az1a-priv-snet.id
# }

# # mongodb-shard
# resource "aws_instance" "mongodb-shard" {
#   ami                         = "ami-0c37ee902a7924ed2"   // Ubuntu 16.04 hvm:ebs-ssd	20191204
#   #ami                         = "ami-03736048a69f59e6d"     // Amz Linux us-east1 amzn-ami-hvm
#   instance_type               = "t2.micro"
#   associate_public_ip_address = true
#   vpc_security_group_ids      = ["${aws_security_group.mongodb-vpc-sg.id}"]
#   key_name                    = "terraform_ec2_key"
#   subnet_id                   = aws_subnet.mongodb-az1a-priv-snet.id
# }

# # mongodb-config
# resource "aws_instance" "mongodb-config" {
#   ami                         = "ami-0c37ee902a7924ed2"   // Ubuntu 16.04 hvm:ebs-ssd	20191204
#   #ami                         = "ami-03736048a69f59e6d"     // Amz Linux us-east1 amzn-ami-hvm
#   instance_type               = "t2.micro"
#   associate_public_ip_address = true
#   vpc_security_group_ids      = ["${aws_security_group.mongodb-vpc-sg.id}"]
#   key_name                    = "terraform_ec2_key"
#   subnet_id                   = aws_subnet.mongodb-az1a-priv-snet.id
# }