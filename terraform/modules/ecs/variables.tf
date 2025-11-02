
variable "vpc_id" { type = string }
variable "public_subnets" { type = list(string) }
variable "ecs_task_execution_arn" { type = string }
variable "cloudwatch_log_group_name" { 
  type = string
  default = "/ecs/aws-cloud-app" 
}
variable "region" { 
  type = string 
  default = "us-east-1" 
}
