variable "aws_ecs_service_task_desired_count" {
  description = "Number of instances of the task definition"
  type        = string
  default     = "2"
}
variable "aws_ecs_service_launch_type" {
  description = "Launch type on which to run your service. The valid values are EC2, FARGATE, and EXTERNAL. Defaults to EC2"
  type        = string
  default     = "FARGATE"
}
variable "aws_ecs_service_container_name" {
  description = "Name of the container to associate with the load balancer"
  type        = string
  default     = ""
}
variable "aws_ecs_service_container_port" {
  description = "Port value, already specified in the task definition, to be used for your service discovery service"
  type        = string
  default     = ""
}
variable "aws_ecs_service_vpc_subnet" {
  description = "Subnets associated with the task or service"
  type        = list(string)
  default     = [""]
}
variable "aws_ecs_service_task_arn" {
  description = "Family and revision (family:revision) or full ARN of the task definition that you want to run in your service. Required unless using the EXTERNAL deployment controller. If a revision is not specified, the latest ACTIVE revision is used"
  type        = string
  default     = ""
}
variable "aws_ecs_cluster_id" {
  description = "ID of an ECS cluster"
  type        = string
  default     = ""
}
variable "aws_ecs_service_sg_id" {
  description = "Security Groups associated with the task or service. If you do not specify a Security Group, the default Security Group for the VPC is used"
  type        = list(string)
  default     = [""]
}
variable "aws_ecs_cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
  default     = ""
}
variable "aws_lb_green_target_group_name" {
  description = "Name of the green target group"
  type        = string
  default     = ""
}
# variable "aws_nlb_listener" {
#   description = "lb listener arn"
#   type        = string
# }
# variable "aws_lb_blue_target_group_name" {
#   description = "Name of  the blue target group"
#   type        = string
# }
# variable "aws_lb_active_target_group_arn" {
#   description = "ARN of the Load Balancer target group to associate with the service"
#   type        = string
# }
variable "org_name" {
  description = "Organization name"
  type        = string
  default     = ""
}
variable "app_name" {
  description = "Application name"
  type        = string
  default     = ""
}
variable "env" {
  description = "Environment"
  type        = string
  default     = ""
}
variable "default_tags" {
  description = "Default tags for all resources"
  type        = map(string)
  default     = {}
}
variable "sso_infra_deploy_arn" {
  description = "The service role ARN that allows deployments"
  type        = string
  default     = ""
}
variable "aws_ecs_service_deployment_circuit_breaker_enable" {
  description = "Whether to enable the deployment circuit breaker logic for the service"
  type        = bool
  default     = true
}
variable "aws_ecs_service_deployment_rollback_enable" {
  description = "Whether to enable Amazon ECS to roll back the service if a service deployment fails. If rollback is enabled, when a service deployment fails, the service is rolled back to the last deployment that completed successfully"
  type        = bool
  default     = true
}
variable "aws_ecs_service_assign_public_ip" {
  description = "Assign a public IP address to the ENI (Fargate launch type only). Valid values are true or false. Default false"
  type        = bool
  default     = true
}
variable "aws_ecs_service_deployment_controller_type" {
  description = "Type of deployment controller. Valid values: CODE_DEPLOY, ECS, EXTERNAL. Default: ECS"
  type        = string
  default     = "CODE_DEPLOY"
}
variable "aws_ecs_service_platform_version" {
  description = "Platform version on which to run your service. Only applicable for launch_type set to FARGATE. Defaults to LATEST"
  type        = string
  default     = "LATEST"
}
variable "aws_ecs_service_scheduling_strategy" {
  description = "Scheduling strategy to use for the service. The valid values are REPLICA and DAEMON. Defaults to REPLICA"
  type        = string
  default     = "REPLICA"
}
variable "aws_codedeploy_compute_plaform" {
  description = "The compute platform can either be ECS, Lambda, or Server. Default is Server"
  type        = string
  default     = "ECS"
}
variable "aws_codeploy_deployment_config_name" {
  description = "The name of the deployment config"
  type        = string
  default     = "CodeDeployDefault.ECSAllAtOnce"
}
variable "aws_codedeploy_deployment_action_on_timeout" {
  description = "When to reroute traffic from an original environment to a replacement environment in a blue/green deployment"
  type        = string
  default     = "CONTINUE_DEPLOYMENT"
}
variable "aws_codedeploy_deployment_wait_time" {
  description = "The number of minutes to wait before the status of a blue/green deployment changed to Stopped if rerouting is not started manually. Applies only to the STOP_DEPLOYMENT option for action_on_timeout"
  type        = number
  default     = 0
}
variable "aws_instance_action" {
  description = "The action to take on instances in the original environment after a successful blue/green deployment"
  type        = string
  default     = "TERMINATE"
}
variable "aws_instance_action_wait_time" {
  description = "The number of minutes to wait after a successful blue/green deployment before terminating instances from the original environment"
  type        = number
  default     = 5
}
variable "aws_codedeploy_deployment_option" {
  description = "Indicates whether to route deployment traffic behind a load balancer. Valid Values are WITH_TRAFFIC_CONTROL"
  type        = string
  default     = "WITH_TRAFFIC_CONTROL"
}
variable "aws_codedeploy_deployment_type" {
  description = "Indicates whether to run an in-place deployment or a blue/green deployment. Valid Values are IN_PLACE or BLUE_GREEN"
  type        = string
  default     = "BLUE_GREEN"
}
variable "aws_codedeploy_trigger_events" {
  description = "The event type or types for which notifications are triggered. Some values that are supported: DeploymentStart, DeploymentSuccess, DeploymentFailure, DeploymentStop, DeploymentRollback, InstanceStart, InstanceSuccess, InstanceFailure."
  type        = list(string)
  default     = ["DeploymentFailure", "DeploymentStart", "DeploymentStop", "DeploymentSuccess", "DeploymentRollback"]
}
variable "aws_sns_topic_arn" {
  description = "Friendly name of the topic to match"
  type        = string
  default     = ""
}
variable "service_name" {
  description = "Service name"
  type        = string
  default     = ""
}
variable "aws_ecs_cloudwatch_metric_low_cpu_alarm" {
  description = "Name for cloudwatch alarm for low cpu utilization"
  type        = string
  default     = "ecs-cpu-utilization-low"
}
variable "aws_ecs_cloudwatch_metric_high_cpu_alarm" {
  description = "Name for cloudwatch alarm for high cpu utilization"
  type        = string
  default     = "ecs-cpu-utilization-high"
}
variable "aws_comparison_operator_high_cpu" {
  description = "The arithmetic operation to use when comparing the specified Statistic and Threshold"
  type        = string
  default     = "GreaterThanOrEqualToThreshold"
}
variable "aws_comparison_operator_low_cpu" {
  description = "The arithmetic operation to use when comparing the specified Statistic and Threshold"
  type        = string
  default     = "LessThanOrEqualToThreshold"
}
variable "aws_evaluation_period" {
  description = "The number of periods over which data is compared to the specified threshold"
  type        = string
  default     = "2"
}
variable "aws_cloudwatch_metric_name" {
  description = "The name for the alarm's associated metric"
  type        = string
  default     = "CPUUtilization"
}
variable "aws_cloudwatch_period" {
  description = "The period in seconds over which the specified statistic is applied. Valid values are 10, 30, or any multiple of 60"
  type        = string
  default     = "60"
}
variable "aws_cloudwatch_statistic" {
  description = " The statistic to apply to the alarm's associated metric. Either of the following is supported: SampleCount, Average, Sum, Minimum, Maximum"
  type        = string
  default     = "Average"
}
variable "aws_high_cpu_threshold" {
  description = "The value against which the specified statistic is compared. This parameter is required for alarms based on static thresholds, but should not be used for alarms based on anomaly detection models"
  type        = string
  default     = "60"
}
variable "aws_low_cpu_threshold" {
  description = "The value against which the specified statistic is compared. This parameter is required for alarms based on static thresholds, but should not be used for alarms based on anomaly detection models"
  type        = string
  default     = "10"
}
variable "aws_service_namespace" {
  description = "AWS service namespace of the scalable target"
  type        = string
  default     = "ecs"
}
variable "aws_autoscaling_min_capacity" {
  description = "Min capacity of the scalable target"
  type        = string
  default     = "2"
}
variable "aws_autoscaling_max_capacity" {
  description = "Max capacity of the scalable target"
  type        = string
  default     = "5"
}
variable "aws_autoscaling_adjustment_type" {
  description = "Whether the adjustment is an absolute number or a percentage of the current capacity. Valid values are ChangeInCapacity, ExactCapacity, and PercentChangeInCapacity"
  type        = string
  default     = "ChangeInCapacity"
}
variable "aws_autoscaling_cooldown_period" {
  description = "Amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start"
  type        = number
  default     = 60
}
variable "aws_autoscaling_metric_aggregation_type" {
  description = "Aggregation type for the policy's metrics. Valid values are Minimum, Maximum, and Average. Without a value, AWS will treat the aggregation type as Average"
  type        = string
  default     = "Maximum"
}
variable "aws_autoscaling_metric_interval_lower_bound_high_cpu" {
  description = "Lower bound for the difference between the alarm threshold and the CloudWatch metric. Without a value, AWS will treat this bound as negative infinity"
  type        = number
  default     = 0
}
variable "aws_autoscaling_metric_interval_upper_bound_high_cpu" {
  description = "Upper bound for the difference between the alarm threshold and the CloudWatch metric. Without a value, AWS will treat this bound as infinity. The upper bound must be greater than the lower bound"
  type        = number
  default     = null
}
variable "aws_autoscaling_metric_interval_upper_bound_low_cpu" {
  description = "Upper bound for the difference between the alarm threshold and the CloudWatch metric. Without a value, AWS will treat this bound as infinity. The upper bound must be greater than the lower bound"
  type        = number
  default     = 0
}
variable "ecs_tasks_scale_down_low_cpu" {
  description = "Number of members by which to scale, when the adjustment bounds are breached. A positive value scales up. A negative value scales down"
  type        = number
  default     = 0
}
variable "ecs_tasks_scale_up_high_cpu" {
  description = "Number of members by which to scale, when the adjustment bounds are breached. A positive value scales up. A negative value scales down"
  type        = number
  default     = 0
}
variable "aws_cloudwatch_metric_namespace" {
  description = "The namespace for the alarm's associated metric"
  type        = string
  default     = "AWS/ECS"
}
variable "map_migrated_tag" {
  description = "Workloads moving to AWS should have this tag"
  type        = string
  default     = ""
}
variable "enable_execute_command" {
  description = "Can be used to exec into containers"
  type        = bool
  default     = false
}
