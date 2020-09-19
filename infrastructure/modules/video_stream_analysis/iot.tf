resource "aws_iot_thing" "camera" {
  name = "${var.project}-${var.env}-camera"
}

resource "aws_iot_certificate" "camera_certificate" {
  active = true
}

resource "aws_iot_thing_principal_attachment" "camera_certificate_attachment" {
  principal = aws_iot_certificate.camera_certificate.arn
  thing     = aws_iot_thing.camera.name
}

resource "aws_iot_role_alias" "camera_role_alias" {
  alias    = "${var.project}-${var.env}-camera-role-alias"
  role_arn = aws_iam_role.camera_role.arn
}

resource "aws_iot_policy" "camera_iot_policy" {
  name = "${var.project}-${var.env}-camera-iot-policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "iot:Connect",
        "iot:AssumeRoleWithCertificate"
      ],          
      "Resource": "${aws_iot_role_alias.camera_role_alias.arn}"
    }
  ]
}
EOF
}

resource "aws_iot_policy_attachment" "camera_iot_policy_attachment" {
  policy = aws_iot_policy.camera_iot_policy.name
  target = aws_iot_certificate.camera_certificate.arn
}

data "aws_iot_endpoint" "camera_credentials_provider_endpoint" {
  endpoint_type = "iot:CredentialProvider"
}