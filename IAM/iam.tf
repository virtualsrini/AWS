
resource "aws_iam_user" "raman" {
  name = "raman"

  tags = {
    creator = "raman"
  }
}

#create access key ID and secret key 
resource "aws_iam_access_key" "raman_access_key" {
  user = aws_iam_user.raman.name
}

output "access_key_id" {
  value = aws_iam_access_key.raman_access_key.id
  sensitive = true
}

output "secret_access_key" {
  value = aws_iam_access_key.raman_access_key.secret
  sensitive = true
}

locals {
  raman_keys_csv = "access_key,secret_key\n${aws_iam_access_key.raman_access_key.id},${aws_iam_access_key.raman_access_key.secret}"
}

resource "local_file" "raman_keys" {
  content  = local.raman_keys_csv
  filename = "raman-keys.csv"
}

resource "aws_iam_group" "terraform-developers" {
  name = "terraform-developers"
}

resource "aws_iam_group_membership" "raman_membership" {
  name = aws_iam_user.raman.name
  users = [aws_iam_user.raman.name]
  group = aws_iam_group.terraform-developers.name
}

#rds full
data "aws_iam_policy" "rds_full_access" {
  arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}

#ec2 custome

data "aws_iam_policy_document" "ec2_instance_actions" {
  statement {
    actions = [
      "ec2:StartInstances",
      "ec2:StopInstances",
    ]

    resources = [
      "arn:aws:ec2:*:*:instance/*",
    ]
  }
}

resource "aws_iam_policy" "ec2_instance_actions" {
  name        = "ec2_instance_actions"
  policy      = data.aws_iam_policy_document.ec2_instance_actions.json
}

resource "aws_iam_group_policy_attachment" "terraform-developers_rds_full_access" {
  policy_arn = data.aws_iam_policy.rds_full_access.arn
  group      = aws_iam_group.terraform-developers.name
}

resource "aws_iam_group_policy_attachment" "developers_ec2_instance_actions" {
  policy_arn = aws_iam_policy.ec2_instance_actions.arn
  group      = aws_iam_group.terraform-developers.name
}

resource "aws_iam_role" "terraform-cloudwatchagent-role" {
  name = "terraform-cloudwatchagent-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action    = "sts:AssumeRole"
      }
    ]
  })
}

#attache role policies
resource "aws_iam_role_policy_attachment" "my_role_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy" # Update with your desired policy
  role       = aws_iam_role.terraform-cloudwatchagent-role.name
}
