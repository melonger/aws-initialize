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
  name  = "service_account_policy"
  group = "${aws_iam_group.my_developers.id}"

  policy = "${data.aws_iam_policy_document.policy.json}"
}
