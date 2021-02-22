resource "aws_s3_bucket" "itea-s3-bucket-sturyk" {
  bucket = "itea-s3-bucket-sturyk"
  acl    = "public-read"
  tags = {
    Name        = "itea-S3-bucket-sturyk"
  }
}