resource "aws_kinesis_stream" "_" {
  name = "${var.project}-${var.env}-video-analysis-stream"
  shard_count = 1
}