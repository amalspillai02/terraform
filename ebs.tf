provider "aws" {
  region = "ap-south-1"  # change to your desired region
}

resource "aws_ebs_volume" "example" {
  availability_zone = "ap-south-1b"  # must match your EC2 instance AZ if attaching
  size              = 10            # size in GiB
  type              = "gp3"         # or gp2, io1, sc1, st1
  tags = {
    Name = "MyEBSVolume"
  }
}
resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdf"                       # Linux-style name
  volume_id   = aws_ebs_volume.example.id
  instance_id = "i-09ae2ee1443050726"            # replace with your EC2 instance ID
  force_detach = true
}

