provider "aws" {
    region = "eu-central-1"
}

variable "tags" {
    type = map(string)
    default = {
      Environment = "Dev"
    }   
}

resource "aws_launch_template" "test" {
    name = "test-lt"
    image_id = "ami-0453cb7b5f2b7fca2" # Amazon Linux 2 in eu-central-1
    instance_type = "t3.micro"

    tags = var.tags

    block_device_mappings {
        device_name = "/dev/sda1"

        ebs {
            volume_size = 20
        }
    }
}

resource "aws_vpc" "test" {
    cidr_block = "10.0.0.0/16"

    tags = var.tags
}

resource "aws_subnet" "test" {
    vpc_id = aws_vpc.test.id
    cidr_block = "10.0.1.0/24"

    tags = var.tags
}

resource "aws_autoscaling_group" "test" {
    name = "test-ag"
    min_size = 1
    max_size = 2
    vpc_zone_identifier = [aws_subnet.test.id]

    launch_template {
      id = aws_launch_template.test.id
      version = "$Latest"
    }

    tags = [var.tags]
}