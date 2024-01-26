resource "aws_instance" "instance_a" { //Instance A
  ami           = var.ami
  instance_type = "t2.micro"

  subnet_id = var.subnet_a

  key_name = "tfserverkey"

  tags = {
    Name = "Instance A"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
              echo '<!doctype html>
              <html lang="en"><h1>Home page!</h1></br>
              <h3>(Instance A)</h3>
              </html>' | sudo tee /var/www/html/index.html
              EOF
}

resource "aws_instance" "instance_b" { //Instance B
  ami           = var.ami
  instance_type = "t2.micro"

  subnet_id = var.subnet_b

  key_name = "tfserverkey"

  tags = {
    Name = "Instance B"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
              echo '<!doctype html>
              <html lang="en"><h1>Images!</h1></br>
              <h3>(Instance B)</h3>
              </html>' | sudo tee /var/www/html/index.html
              echo 'server {
                        listen 80 default_server;
                        listen [::]:80 default_server;
                        root /var/www/html;
                        index index.html index.htm index.nginx-debian.html;
                        server_name _;
                        location /images/ {
                            alias /var/www/html/;
                            index index.html;
                        }
                        location / {
                            try_files $uri $uri/ =404;
                        }
                    }' | sudo tee /etc/nginx/sites-available/default
              sudo systemctl reload nginx
              EOF
}

resource "aws_instance" "instance_c" { //Instance C
  ami           = var.ami
  instance_type = "t2.micro"

  subnet_id = var.subnet_c

  key_name = "tfserverkey"

  tags = {
    Name = "Instance C"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
              echo '<!doctype html>
              <html lang="en"><h1>Register!</h1></br>
              <h3>(Instance C)</h3>
              </html>' | sudo tee /var/www/html/index.html
              echo 'server {
                        listen 80 default_server;
                        listen [::]:80 default_server;
                        root /var/www/html;
                        index index.html index.htm index.nginx-debian.html;
                        server_name _;
                        location /register/ {
                            alias /var/www/html/;
                            index index.html;
                        }
                        location / {
                            try_files $uri $uri/ =404;
                        }
                    }' | sudo tee /etc/nginx/sites-available/default
              sudo systemctl reload nginx
              EOF
}