# EC2 Role: ec2-role with AmazonS3FullAccess policy
resource "aws_iam_role" "ec2_role" {
  name = "ec2-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "ec2_role_s3_full_access" {
  name       = "ec2-role-s3-full-access"
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  roles      = [aws_iam_role.ec2_role.name]
}

# CodeDeploy Role: code-deploy-role with AWSCodeDeployRole policy
resource "aws_iam_role" "code_deploy_role" {
  name = "code-deploy-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "codedeploy.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "code_deploy_role_code_deploy" {
  name       = "code-deploy-role-code-deploy"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
  roles      = [aws_iam_role.code_deploy_role.name]
}

