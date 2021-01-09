// Use the snapshot obtained in above data resource
// to create an EBS volume
resource "aws_ebs_volume" "ebs" {
  availability_zone = var.availability_zone
  snapshot_id       = var.snapshot_id
  size              = var.size
  type              = "gp2"
  tags = {
    Name        = var.tag_name
    Environment = "sandbox"
    Product     = "Jenkins"
    Role        = "master"
  }
}

output "ebs_id" {
  value       = aws_ebs_volume.ebs.id
  description = "Volume id of the green EBS volume"
}
