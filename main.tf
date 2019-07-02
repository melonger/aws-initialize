data "aws_iam_policy_document" "policy" {
  statement {
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
  }
}

resource "aws_iam_group" "service_account" {
  name = "service_accounts"
  path = "/users/"
}

resource "aws_iam_group_policy" "service_account_policy" {
  name  = "${lower(var.tags["client"])}_sp_policy"
  group = "${aws_iam_group.service_account.id}"

  policy = "${data.aws_iam_policy_document.policy.json}"
}

# create an S3 bucket to store the state file in
resource "aws_s3_bucket" "default_s3" {
  bucket = "${var.terraform_bucket_name}"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = "${var.terraform_bucket_lifecycle}"
  }

  tags = {
    Name       = "${var.tags["client"]} S3 Remote Terraform State Store"
    costcenter = "${var.tags["costcenter"]}"
  }
}

# create a dynamodb table for locking the state file as this is important when sharing the same state file across users
resource "aws_dynamodb_table" "dynamodb_tf_state_lock" {
  name           = "${var.tags["client"]}-terraform-state-lock-dynamo"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name       = "${var.tags["client"]} DynamoDB Terraform State Lock Table"
    costcenter = "${var.tags["costcenter"]}"
  }
}
