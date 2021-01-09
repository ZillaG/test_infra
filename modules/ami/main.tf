data "aws_ami" "ami" {
  most_recent      = true
  owners           = ["self"]

  filter {
    name   = "name"
    values = ["test_ami"]
  }
}

output "ami_id" {
  value =  data.aws_ami.ami.id
  description = "Amazon EC2 Linux v2 AMI"
}
