resource "aws_key_pair" "test_user" {
  key_name   = var.key_name
  public_key = var.public_key
}

output "key_pair_id" {
  value = aws_key_pair.test_user.id
  description = "Key pair id"
}
