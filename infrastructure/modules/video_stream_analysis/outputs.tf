resource "aws_cloudformation_stack" "_" {
  name = "${var.project}-${var.env}-video-stream-analysis-terraform-outputs-stack"

  template_body = <<STACK
    {
      "Resources": {
        "KinesisStreamArn": {
          "Type": "AWS::SSM::Parameter",
          "Properties": {
            "Name": "kinesis-stream-arn",
            "Type": "String",
            "Value": "${aws_kinesis_stream._.arn}"
          }
        },
        "IoTCredentialsProviderEndpoint": {
          "Type": "AWS::SSM::Parameter",
          "Properties": {
            "Name": "iot-credentials-provider-endpoint",
            "Type": "String",
            "Value": "${data.aws_iot_endpoint.camera_credentials_provider_endpoint.endpoint_address}"
          }
        },
        "IoTCertificatePrivateKey": {
          "Type": "AWS::SSM::Parameter",
          "Properties": {
            "Name": "iot-certificate-private-key",
            "Type": "String",
            "Value": "${aws_iot_certificate.camera_certificate.private_key}"
          }
        }        
      },
      "Outputs": {
        "KinesisStreamArn": {
          "Value": "${aws_kinesis_stream._.arn}"
        },
        "IoTCredentialsProviderEndpoint": {
          "Value": "${data.aws_iot_endpoint.camera_credentials_provider_endpoint.endpoint_address}"
        },
        "IoTCertificatePrivateKey": {
          "Value": "${aws_iot_certificate.camera_certificate.private_key}"
        }        
      }
    }
  STACK
}