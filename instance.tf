module "monolith" {
  source = "terraform-aws-modules/autoscaling/aws"

  name = "monolith"

  # Launch configuration
  lc_name = "monolith-lc"

  image_id        = "${var.ami}"
  instance_type   = "m5.large"
  security_groups = ["${aws_security_group.allow_ssh_and_httpd.name}"]

  ebs_block_device = [
    {
      device_name           = "/dev/xvdz"
      volume_type           = "gp2"
      volume_size           = "1024"
      delete_on_termination = true
    },
  ]

  root_block_device = [
    {
      volume_size = "50"
      volume_type = "gp2"
    },
  ]

  # Auto scaling group
  asg_name                  = "monolith-asg"
  vpc_zone_identifier       = ["${var.subnet1}", "${var.subnet2}"]
  health_check_type         = "EC2"
  min_size                  = "${var.min_size}"
  max_size                  = "${var.max_size}"
  desired_capacity          = "${var.desired_capacity}"
  wait_for_capacity_timeout = 0
  key_name                  =   "${var.key_name}"
}