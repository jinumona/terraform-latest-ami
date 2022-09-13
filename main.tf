#vim main.tf

data "aws_ami" "amazon" {
  
  owners        = ["amazon"]
  most_recent  = true
    

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


output "amazon-linux-latest" {
    
   value = data.aws_ami.amazon.image_id
}


resource "aws_instance"  "webserver" {
    
    ami                    =  data.aws_ami.amazon.image_id
    instance_type          =  "t2.micro"
    key_name               =  "devops-class"
    vpc_security_group_ids =  [ "sg-04182bdfbfa17d831"]
    
    tags = {
    Name = "webserver-prod"
  }

}

