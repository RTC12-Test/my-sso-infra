# Resource to create ECS service
resource "aws_ecs_service" "ecs_service" {
  name                   = "${var.org_name}-${var.app_name}-${var.service_name}-${var.env}-ecs-service"
  cluster                = var.aws_ecs_cluster_id
  task_definition        = var.aws_ecs_service_task_arn
  desired_count          = var.aws_ecs_service_task_desired_count
  launch_type            = var.aws_ecs_service_launch_type
  platform_version       = var.aws_ecs_service_platform_version
  scheduling_strategy    = var.aws_ecs_service_scheduling_strategy
  enable_execute_command = var.enable_execute_command
  network_configuration {
    subnets          = var.aws_ecs_service_vpc_subnet
    assign_public_ip = var.aws_ecs_service_assign_public_ip
    security_groups  = var.aws_ecs_service_sg_id
  }
  load_balancer {
    target_group_arn = var.aws_lb_active_target_group_arn
    container_port   = var.aws_ecs_service_container_port
    container_name   = var.aws_ecs_service_container_name
  }
  deployment_controller {
    type = var.aws_ecs_service_deployment_controller_type
  }
  tags = merge(var.default_tags, {
    Name         = "${var.org_name}-${var.app_name}-${var.service_name}-${var.env}-ecs-service"
    map-migrated = var.map_migrated_tag
  })
  lifecycle {
    ignore_changes = [
      task_definition,
      load_balancer,
      deployment_controller,
      platform_version,
      desired_count
    ]
  }
}

# Resource to create codedeploy application 
resource "aws_codedeploy_app" "codedeploy_app" {
  name             = "${var.org_name}-${var.app_name}-${var.service_name}-${var.env}-codedeploy-app"
  compute_platform = var.aws_codedeploy_compute_plaform
  tags = merge(var.default_tags, {
    "name"       = "${var.org_name}-${var.app_name}-${var.service_name}-${var.env}-codedeploy-app"
    map-migrated = var.map_migrated_tag
  })
}

# Resource to create codedeploy group
resource "aws_codedeploy_deployment_group" "codedeploy_group" {
  app_name               = aws_codedeploy_app.codedeploy_app.name
  deployment_group_name  = "${var.org_name}-${var.app_name}-${var.service_name}-${var.env}-codedeploy-group"
  deployment_config_name = var.aws_codeploy_deployment_config_name
  service_role_arn       = var.sso_infra_deploy_arn
  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout    = var.aws_codedeploy_deployment_action_on_timeout
      wait_time_in_minutes = var.aws_codedeploy_deployment_wait_time
    }
    terminate_blue_instances_on_deployment_success {
      action                           = var.aws_instance_action
      termination_wait_time_in_minutes = var.aws_instance_action_wait_time
    }
  }
  # Ensure the deployment style is set to BLUE_GREEN
  deployment_style {
    deployment_option = var.aws_codedeploy_deployment_option
    deployment_type   = var.aws_codedeploy_deployment_type
  }
  # trigger_configuration {
  #   trigger_events     = var.aws_codedeploy_trigger_events
  #   trigger_name       = "${var.org_name}-${var.app_name}-${var.service_name}-${var.env}-trigger_name"
  #   trigger_target_arn = var.aws_sns_topic_arn
  # }
  ecs_service {
    cluster_name = var.aws_ecs_cluster_name
    service_name = aws_ecs_service.ecs_service.name
  }
  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [var.aws_nlb_listener]
      }
      target_group {
        name = var.aws_lb_blue_target_group_name
      }
      target_group {
        name = var.aws_lb_green_target_group_name
      }
    }
  }
  tags = merge(var.default_tags, {
    "name"       = "${var.org_name}-${var.app_name}-${var.service_name}-${var.env}-codedeploy-group"
    map-migrated = var.map_migrated_tag
  })
}

# Resource to create Autoscaling target for ECS service
resource "aws_appautoscaling_target" "ecs_target" {
  service_namespace  = var.aws_service_namespace
  resource_id        = "service/${var.aws_ecs_cluster_name}/${aws_ecs_service.ecs_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  min_capacity       = var.aws_autoscaling_min_capacity
  max_capacity       = var.aws_autoscaling_max_capacity
}

# Resource to automatically scale capacity up by one
resource "aws_appautoscaling_policy" "ecs_scale_up" {
  name               = "${var.org_name}-${var.app_name}-${var.service_name}-${var.env}-${var.aws_ecs_cloudwatch_metric_high_cpu_alarm}-ecs-scale-up"
  service_namespace  = var.aws_service_namespace
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  step_scaling_policy_configuration {
    adjustment_type         = var.aws_autoscaling_adjustment_type
    cooldown                = var.aws_autoscaling_cooldown_period
    metric_aggregation_type = var.aws_autoscaling_metric_aggregation_type
    step_adjustment {
      metric_interval_lower_bound = var.aws_autoscaling_metric_interval_lower_bound_high_cpu
      metric_interval_upper_bound = var.aws_autoscaling_metric_interval_upper_bound_high_cpu
      scaling_adjustment          = var.ecs_tasks_scale_up_high_cpu
    }
  }
  depends_on = [aws_appautoscaling_target.ecs_target]
}

# Resource to automatically scale capacity down by one
resource "aws_appautoscaling_policy" "ecs_scale_down" {
  name               = "${var.org_name}-${var.app_name}-${var.service_name}-${var.env}-${var.aws_ecs_cloudwatch_metric_low_cpu_alarm}-ecs-scale-down"
  service_namespace  = var.aws_service_namespace
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  step_scaling_policy_configuration {
    adjustment_type         = var.aws_autoscaling_adjustment_type
    cooldown                = var.aws_autoscaling_cooldown_period
    metric_aggregation_type = var.aws_autoscaling_metric_aggregation_type
    step_adjustment {
      metric_interval_upper_bound = var.aws_autoscaling_metric_interval_upper_bound_low_cpu
      scaling_adjustment          = var.ecs_tasks_scale_down_low_cpu
    }
  }
  depends_on = [aws_appautoscaling_target.ecs_target]
}

# Resource to create CloudWatch alarm that triggers the autoscaling up policy
resource "aws_cloudwatch_metric_alarm" "cloudwatch_metric_high_cpu" {
  alarm_name          = "${var.org_name}-${var.app_name}-${var.service_name}-${var.env}-${var.aws_ecs_cloudwatch_metric_high_cpu_alarm}"
  comparison_operator = var.aws_comparison_operator_high_cpu
  evaluation_periods  = var.aws_evaluation_period
  metric_name         = var.aws_cloudwatch_metric_name
  period              = var.aws_cloudwatch_period
  statistic           = var.aws_cloudwatch_statistic
  threshold           = var.aws_high_cpu_threshold
  namespace           = var.aws_cloudwatch_metric_namespace
  dimensions = {
    ClusterName = var.aws_ecs_cluster_name
    ServiceName = aws_ecs_service.ecs_service.name
  }
  alarm_actions = [aws_appautoscaling_policy.ecs_scale_up.arn]
  tags = merge(var.default_tags, {
    "name"       = "${var.org_name}-${var.app_name}-${var.service_name}-${var.env}-${var.aws_ecs_cloudwatch_metric_high_cpu_alarm}"
    map-migrated = var.map_migrated_tag
  })
}

# Resource to create CloudWatch alarm that triggers the autoscaling down policy
resource "aws_cloudwatch_metric_alarm" "cloudwatch_metric_low_cpu" {
  alarm_name          = "${var.org_name}-${var.app_name}-${var.service_name}-${var.env}-${var.aws_ecs_cloudwatch_metric_low_cpu_alarm}"
  comparison_operator = var.aws_comparison_operator_low_cpu
  evaluation_periods  = var.aws_evaluation_period
  metric_name         = var.aws_cloudwatch_metric_name
  period              = var.aws_cloudwatch_period
  statistic           = var.aws_cloudwatch_statistic
  threshold           = var.aws_low_cpu_threshold
  namespace           = var.aws_cloudwatch_metric_namespace
  dimensions = {
    ClusterName = var.aws_ecs_cluster_name
    ServiceName = aws_ecs_service.ecs_service.name
  }
  alarm_actions = [aws_appautoscaling_policy.ecs_scale_down.arn]
  tags = merge(var.default_tags, {
    "name"       = "${var.org_name}-${var.app_name}-${var.service_name}-${var.env}-${var.aws_ecs_cloudwatch_metric_low_cpu_alarm}"
    map-migrated = var.map_migrated_tag
  })
}

