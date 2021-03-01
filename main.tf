resource "tls_private_key" "demo_key_1" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "aws_key_pair" "demo_key_1" {
  key_name   = "demo-key-1"
  public_key = tls_private_key.demo_key_1.public_key_openssh
}

resource "local_file" "local_ssh_private_key" {
  content         = tls_private_key.demo_key_1.private_key_pem
  filename        = "ssh-key-private.pem"
  file_permission = "0777"
}

resource "local_file" "local_ssh_public_key" {
  content         = tls_private_key.demo_key_1.public_key_openssh
  filename        = "ssh-key-public.pem"
  file_permission = "0777"
}

resource "aws_instance" "es-demo" {
  ami           = "ami-0e8710d48cc4ea8dd"
  instance_type = "t2.micro"

  key_name = aws_key_pair.demo_key_1.key_name
  subnet_id = aws_subnet.sub-1.id
  vpc_security_group_ids = ["${aws_security_group.secgroup.id}"]
  tags = {
      Name = "es-demo"
  }

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = tls_private_key.demo_key_1.private_key_pem
    host = "${self.public_ip}"
  } 

  provisioner "file" {
    source      = "script.sh"
    destination = "/home/ubuntu/script.sh"
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