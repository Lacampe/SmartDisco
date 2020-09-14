resource "aws_iam_role" "camera_role" {
  name = "${var.project}-${var.env}-camera-role"

  assume_role_policy = data.aws_iam_policy_document.camera_assume_role_policy_document.json
}

data "aws_iam_policy_document" "camera_assume_role_policy_document" {
  statement {
    actions = [ "sts:AssumeRole" ]

    principals {
      type        = "Service"
      identifiers = [ "credentials.iot.amazonaws.com" ]
    }
  }
}

resource "aws_iam_role_policy" "camera_role_inline_policy" {
  name = "${var.project}-${var.env}-camera-role-policy"
  role = aws_iam_role.camera_role.id

  policy = data.aws_iam_policy_document.camera_role_inline_polic_document.json
}

data "aws_iam_policy_document" "camera_role_inline_polic_document" {
  statement {
    actions = [
      "kinesisvideo:ConnectAsMaster",
      "kinesisvideo:GetSignalingChannelEndpoint",
      "kinesisvideo:GetIceServerConfig"
    ]

    resources = "arn:aws:kinesisvideo:${var.region}:${var.account_id}:channel/${credentials-iot:ThingName}/*"
  }
}