env = "dev"
bastion_nodes = ["172.31.16.174/32"]

vpc = {
  cidr = "10.10.0.0/16"
  public_subnets = ["10.10.0.0/24", "10.10.1.0/24"]
  web_subnets        = ["10.10.2.0/24", "10.10.3.0/24"]
  app_subnets        = ["10.10.4.0/24", "10.10.5.0/24"]
  db_subnets         = ["10.10.6.0/24", "10.10.7.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b"]
  default_vpc_id     = "vpc-038fd31d7a91e101d"
  default_vpc_rt     = "rtb-0a7c5b544c8a0179b"
  default_vpc_cidr   = "172.31.0.0/16"
}

apps= {

  frontend = {
    subnet_ref = "web"
    instance_type = "t2.micro"
    allow_port = 80
    allow_sg_cidr = ["10.10.0.0/24", "10.10.1.0/24"]
    capacity ={
      desired = 1
      max = 1
      min = 1
    }
  }

  catalogue = {
    subnet_ref = "app"
    instance_type = "t2.micro"
    allow_port = 8080
    allow_sg_cidr = ["10.10.2.0/24", "10.10.3.0/24"]
    capacity ={
      desired = 1
      max = 1
      min = 1
    }
  }
}




db ={
  mongo ={
    subnet_ref = "db"
    instance_type = "t2.micro"
    allow_port = 27017
    allow_sg_cidr = ["10.10.4.0/24", "10.10.5.0/24"]
  }
  mysql ={
    subnet_ref = "db"
    instance_type = "t2.micro"
    allow_port = 3306
    allow_sg_cidr = ["10.10.4.0/24", "10.10.5.0/24"]
  }
  rabbitmq ={
    subnet_ref = "db"
    instance_type = "t2.micro"
    allow_port = 5672
    allow_sg_cidr = ["10.10.4.0/24", "10.10.5.0/24"]
  }
  redis ={
    subnet_ref = "db"
    instance_type = "t2.micro"
    allow_port = 6379
    allow_sg_cidr = ["10.10.4.0/24", "10.10.5.0/24"]
  }
}

