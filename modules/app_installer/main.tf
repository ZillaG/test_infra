resource "null_resource" "app" {
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("/Users/cfouts/.ssh/test-user-rsa")
    host        = var.host_public_ip 
  }

  provisioner "file" {
    source      = "../modules/app_installer/setup-app.sh"
    destination = "/tmp/setup-app.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/setup-app.sh; sudo /tmp/setup-app.sh"
    ]
  }
}
