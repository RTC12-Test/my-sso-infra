locals {
  task_definition_vars = merge(
    var.task_definition_variables,
    {
      aws_region = var.aws_region
    }
  )
}
