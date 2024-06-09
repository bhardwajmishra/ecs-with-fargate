variable iam_role {}
variable alb_target_group_arn {}
variable "subnet_a" {
}
variable "subnet_b" {
}
variable "sg_id" {
}

variable "task_arn"{
  type = string
  default = null
  description = "S3 Role ARN"
}

