resource "aws_s3_bucket" "IaS-s3-bucket-sturyk" {
  bucket = "iac-s3-bucket-sturyk"
  acl    = "public-read"
  tags = {
    Name        = "IaS-S3-bucket-sturyk"
  }
}