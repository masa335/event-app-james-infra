resource "aws_s3_bucket" "james_alb_logs" {
  bucket = "${var.r_prefix}-20210827-alb-logs"
}

resource "aws_s3_bucket" "james_images" {
  bucket = "${var.r_prefix}-20211001-images"
}