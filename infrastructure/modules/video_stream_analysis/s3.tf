resource "aws_s3_bucket" "_" {
  bucket = "${lower(var.project)}-${var.env}-faces"
}