resource "aws_key_pair" "terraformkey" {
  key_name = "terraform_key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "web" {
  ami             = var.AWS_AMIS[var.AWS_REGION[0]]
  instance_type   = var.AWS_INSTANCE_TYPE
  subnet_id       = aws_subnet.tv-public-1.id
  key_name = aws_key_pair.terraformkey.key_name
  user_data = <<-EOF
                #! /bin/bash
                sudo apt update
                sudo apt install apache2 -y
                sudo systemctl start apache2
                sudo systemctl enable apache2
                sudo git clone https://github.com/hisbu/template2.git /var/www/html/
                echo "<center><h1>'$(hostname -f)'</h1></center>" | sudo tee /var/www/html/index.html
              EOF

  # # script untuk copy file dari local mesin ke vm
  # provisioner "file" {
  #   source      = "script.sh"
  #   destination = "/tmp/script.sh"
  # }

  # # script untuk eksekusi command secara remote di vm
  # provisioner "remote-exec" {
  #   inline = [
  #     "chmod +x /tmp/script.sh", #ini command ubah permission
  #     "sudo /tmp/script.sh"
  #     # "sudo systemctl status apache2"
  #   ]
  # }
  
  # script untuk terraform connect ssh ke vm
  connection {
    host    = coalesce(self.public_ip, self.private_ip)
    type    = "ssh"
    user    = var.AWS_INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  } 

  vpc_security_group_ids = [aws_security_group.tf-allow-ssh.id, aws_security_group.tf-allow-http.id]
  associate_public_ip_address = true
  tags = {
    Name = "HelloTerraform"
  }
}

resource "aws_instance" "web2" {
  ami             = var.AWS_AMIS[var.AWS_REGION[0]]
  instance_type   = var.AWS_INSTANCE_TYPE
  subnet_id       = aws_subnet.tv-public-1.id
  key_name = aws_key_pair.terraformkey.key_name
  user_data = <<-EOF
                #! /bin/bash
                sudo apt update
                sudo apt install apache2 -y
                sudo systemctl start apache2
                sudo systemctl enable apache2
                sudo git clone https://github.com/hisbu/template2.git /var/www/html/
                echo "<center><h1>'$(hostname -f)'</h1></center>" | sudo tee /var/www/html/index.html
              EOF

  # # script untuk copy file dari local mesin ke vm
  # provisioner "file" {
  #   source      = "script.sh"
  #   destination = "/tmp/script.sh"
  # }

  # # script untuk eksekusi command secara remote di vm
  # provisioner "remote-exec" {
  #   inline = [
  #     "chmod +x /tmp/script.sh", #ini command ubah permission
  #     "sudo /tmp/script.sh"
  #     # "sudo systemctl status apache2"
  #   ]
  # }
  
  # script untuk terraform connect ssh ke vm
  connection {
    host    = coalesce(self.public_ip, self.private_ip)
    type    = "ssh"
    user    = var.AWS_INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  } 

  vpc_security_group_ids = [aws_security_group.tf-allow-ssh.id, aws_security_group.tf-allow-http.id]
  associate_public_ip_address = true
  tags = {
    Name = "HelloTerraform"
  }
}

resource "aws_instance" "web3" {
  ami             = var.AWS_AMIS[var.AWS_REGION[0]]
  instance_type   = var.AWS_INSTANCE_TYPE
  subnet_id       = aws_subnet.tv-public-1.id
  key_name = aws_key_pair.terraformkey.key_name
  user_data = <<-EOF
                #! /bin/bash
                sudo apt update
                sudo apt install apache2 -y
                sudo systemctl start apache2
                sudo systemctl enable apache2
                sudo git clone https://github.com/hisbu/template2.git /var/www/html/
                echo "<center><h1>'$(hostname -f)'</h1></center>" | sudo tee /var/www/html/index.html
              EOF

  # # script untuk copy file dari local mesin ke vm
  # provisioner "file" {
  #   source      = "script.sh"
  #   destination = "/tmp/script.sh"
  # }

  # # script untuk eksekusi command secara remote di vm
  # provisioner "remote-exec" {
  #   inline = [
  #     "chmod +x /tmp/script.sh", #ini command ubah permission
  #     "sudo /tmp/script.sh"
  #     # "sudo systemctl status apache2"
  #   ]
  # }
  
  # script untuk terraform connect ssh ke vm
  connection {
    host    = coalesce(self.public_ip, self.private_ip)
    type    = "ssh"
    user    = var.AWS_INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  } 

  vpc_security_group_ids = [aws_security_group.tf-allow-ssh.id, aws_security_group.tf-allow-http.id]
  associate_public_ip_address = true
  tags = {
    Name = "HelloTerraform"
  }
}