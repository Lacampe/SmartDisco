resource "aws_s3_bucket" "_" {
  bucket = "${var.project}-${var.env}-faces"
}