[![github-actions](https://github.com/mathisve/terraform-aws-autoscaling-group/workflows/terraform.yaml/badge.svg)](https://github.com/mathisve/terraform-aws-autoscaling-group/actions)

# terraform-aws-autoscaling-group
Example of Terraform AWS EC2 autoscaling group


Read `main.tf` for a full example.
```
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
```