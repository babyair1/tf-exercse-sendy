resource "aws_autoscaling_group" "terraform-asg" {
  name                      = "terraform-asg"
  max_size                  = 3
  min_size                  = 1
  desired_capacity          = 1
  health_check_grace_period = 60
  launch_configuration      = aws_launch_configuration.terraform-config.name

  tag {
    key                 = "Name"
    value               = "web"
    propagate_at_launch = true
  }
}

resource "aws_launch_configuration" "terraform-config" {
  name = "terraform-config"
  instance_type = var.AWS_INSTANCE_TYPE
  ami           = var.AWS_AMIS[var.AWS_REGION[0]]
}

resource "aws_autoscaling_policy" "terraform-policy" {
  name                   = "terraform-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.terraform-asg.name
}

resource "aws_autoscaling_schedule" "terraform-schedule" {
  scheduled_action_name  = "foobar"
  min_size               = 1
  max_size               = 3
  desired_capacity       = 0
  autoscaling_group_name = aws_autoscaling_group.terraform-asg.name
}

resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.terraform-asg.id
  alb_target_group_arn   = aws_lb_target_group.tg-terraform-alb.arn
}

resource "aws_cloudwatch_metric_alarm" "terraform-alarm" {
  alarm_name          = "terraform-alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "40"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.terraform-asg.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.terraform-policy.arn]
}