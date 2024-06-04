// IAM role

resource "aws_iam_role" "bhatdwaj-ecs-task-exec" {
  name = "test_role"
  assume_role_policy =  "${data.aws_iam_policy_document.ecs_assume_role_policy.json}" # (not shown)
}

// assume policy 

data "aws_iam_policy_document" "ecs_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

// policy attechment

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.bhatdwaj-ecs-task-exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}