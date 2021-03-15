resource "tls_private_key" "es_keypair" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "aws_key_pair" "es_keypair" {
  key_name   = var.key_pair
  public_key = tls_private_key.es_keypair.public_key_openssh
}

resource "local_file" "local_ssh_private_key" {
  content         = tls_private_key.es_keypair.private_key_pem
  filename        = "ssh-key-private.pem"
  file_permission = "0777"
}

resource "local_file" "local_ssh_public_key" {
  content         = tls_private_key.es_keypair.public_key_openssh
  filename        = "ssh-key-public.pem"
  file_permission = "0777"
}

resource "aws_instance" "es-demo" {
  ami           = var.ami_id
  instance_type = var.instance_type

  key_name = aws_key_pair.es_keypair.key_name
  subnet_id = aws_subnet.subnet.id
  vpc_security_group_ids = ["${aws_security_group.es_security.id}"]
  tags = {
      Name = "es-demo"
  }

  connection {
    type = "ssh"
    user = var.user
    private_key = tls_private_key.es_keypair.private_key_pem
    host = "${self.public_ip}"
  } 

  provisioner "file" {
    source      = "script.sh"
    destination = "/home/${var.user}/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/script.sh",
      "bash /home/ubuntu/script.sh",
    ]
  }
}

output "public_ip" {
  value = aws_instance.es-demo.public_ip
}