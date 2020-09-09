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
      }
    },
    "Outputs": {
      "KinesisStreamArn": {
        "Value": "${aws_kinesis_stream._.arn}"
      }
    }
  }
  STACK
}