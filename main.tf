module "vpc" {
  source = "./modules/vpc"
}

module "iam" {
  source = "./modules/iam"
}

module "ecs" {
  source = "./modules/ecs"
  iam_role = module.iam.ecs_task_execution_role_arn
  alb_target_group_arn = module.alb.alb_target_group_arn
}

module "sg" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}

module "alb"{
  source = "./modules/alb"
  vpc_id = module.vpc.vpc_id
  subnet_a = module.vpc.aws_subnet_main_a
  subnet_b = module.vpc.aws_subnet_main_b
  sg_id = module.sg.security_group_id
}