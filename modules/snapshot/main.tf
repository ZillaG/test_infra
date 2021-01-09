// Find the green EBS volume based on the Name tag
data "aws_ebs_volume" "ebs" {
  most_recent = true
  filter {
    name   = "tag:Name"
    values = [var.ebs_id]
  }
}

// Take a snapshot of the green EBS resource
resource "aws_ebs_snapshot" "snapshot" {
  volume_id = data.aws_ebs_volume.ebs.id
  timeouts {
    create = var.create_timeout
    delete = var.delete_timeout
  }
}

output "snapshot_id" {
  value       = aws_ebs_snapshot.snapshot.id
  description = "Jenkins green snapshot id"
}

output "snapshot_size" {
  value       = aws_ebs_snapshot.snapshot.volume_size
  description = "Jenkins green snapshot size"
}
