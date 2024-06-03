module "vpc" {
  source = "./modules/vpc"
}

module "iam" {
  source = "./modules/iam"
}

module "ecs" {
  source = "./modules/ecs"
  iam_role = module.iam.ecs_task_execution_role_arn
}

module "taskdefination" {
  source = "./modules/taskdefination"
}

module "service" {
  source = "./modules/service"
  cluster_id           = module.aws_ecs.cluster_id
  task_definition_arn  = module.taskdefination.task_definition_arn
}

module "alb"{
  source = "./modules/alb"
  vpc_id = module.vpc.vpc_id
  # subnet_id = module.vpc.aws_subnet_main_a
  # # security_group_id = module.vpc.security_group_id
  # # target_group_arn = module.service.target_group_arn
}