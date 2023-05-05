# Packer command:
    For validatation
        `packer validate packer.json`
    For Build
        `packer build file_name`
# Builder :
    Define platform and platform configration , include API key information and desire source image.
`
    "builder": [
        {
            "type": "amazon-ebs",
            "access_key": "{{user `aws_access_key`}}",
            "secret_key": "{{user `aws_secret_key`}}",
            "region": "{{user `region`}}",
            "instance_type": "{{user `instance_type`}}",
            "ami-name": "Ali AMI",
            "source_ami_filter": {
                "filters": {
                    "virtualization": "hvm",
                    "name": "ubuntu/images",
                    "root-device-type": "ebs"
                },
                "owners": [
                    "099720109477"
                ],
                "most_recent": true
            },
            
        }
    ]`

# Communicator:
    how packer work on the machine image during creation . By default is SSH does not need to define.
    ssh_username: "ubuntu"


# Provisioner
    which we use to instlal other packages like updatem, install software etc



# Packer image
 