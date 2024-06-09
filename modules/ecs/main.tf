resource "aws_ecs_cluster" "main" {
  name = "bhardwaj-cluster-tf1"
}

// task defination 

# resource "aws_ecs_task_definition" "service" {
#   family = "service"
#   container_definitions = jsonencode([
#     {
#       name      = "first"
#       image     = "service-first"
#       cpu       = 10
#       memory    = 512
#       essential = true
#       portMappings = [
#         {
#           containerPort = 80
#           hostPort      = 80
#         }
#       ]
#     },
#   ])

#   volume {
#     name      = "service-storage"
#     host_path = "/ecs/service-storage"
#   }

#   placement_constraints {
#     type       = "memberOf"
#     expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
#   }
# }


resource "aws_ecs_task_definition" "main" {
  family                   = "test"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  task_role_arn            = "${var.task_arn}"
  execution_role_arn       = "${var.iam_role}"

  container_definitions    = jsonencode([
  {
    "name": "bhardwaj-td",
    "image": "public.ecr.aws/l9t7b5s8/ecrtf:html",
    "cpu": 1024,
    "memory": 2048,
    "networkMode": "awsvpc",
    "essential": true
    "portMappings": [
                     {
		"containerPort": 80
		"hostPort": 80
	      }
    ]
  }
 ]
 )
}

// service 

resource "aws_ecs_service" "bhardwaj-html" {
  name            = "html"
  launch_type     = "FARGATE"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.main.arn
  desired_count   = 1

  network_configuration {
    subnets = ["${var.subnet_a}", "${var.subnet_b}"]
    security_groups = ["${var.sg_id}"]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = "bhardwaj-td"
    container_port   = 80
  }

  # placement_constraints {
  #   type       = "memberOf"
  #   expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  # }
}