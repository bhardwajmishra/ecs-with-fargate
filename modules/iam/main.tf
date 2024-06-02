# resource "aws_iam_role" "ecs_ec2_role" {
#   name = "ecs-ec2-tf1"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [{
#       Action = "sts:AssumeRole"
#       Effect = "Allow"
#       Principal = {
#         Service = "ec2.amazonaws.com"
#       }
#     }]
#   })
# }

# resource "aws_iam_policy_attachment" "ecs_instance_role_attachment" {
#   name       = "ecs_instance_role_attachment1"
#   roles      = [aws_iam_role.ecs_ec2_role.name]
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
# }

# resource "aws_iam_instance_profile" "ecs_instance_profile" {
#   name = "ecsInstanceProfile1"
#   role = aws_iam_role.ecs_ec2_role.name
# }
// IAM role

resource "aws_iam_role" "bhatdwaj-ecs-task-exec" {
  name = "test_role"
  assume_role_policy = data.aws_iam_policy_document.instance_assume_role_policy.json # (not shown)
}

// assume policy 

data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-task.amazonaws.com"]
    }
  }
}

// policy attechment

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.bhatdwaj-ecs-task-exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}