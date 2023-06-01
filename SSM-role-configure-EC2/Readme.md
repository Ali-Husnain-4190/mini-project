Script to install apache on amazon linux
---
#!/bin/bash
yum update -y
yum install -y httpd.x86_64
systemctl start httpd.service
systemctl enable httpd.service
echo “Hello World from $(hostname -f)” > /var/www/html/index.html
---

If you want to see user-data
---
# Get instance ID
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

# Print user data 
sudo cat /var/lib/cloud/instances/$INSTANCE_ID/user-data.txt
---