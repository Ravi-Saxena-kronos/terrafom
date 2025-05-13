variable "bucket_names" {
  default = [
    "my-unique-bucket-12345-a",
    "my-unique-bucket-12345-b",
    "my-unique-bucket-12345-c",
    "my-unique-bucket-12345-d"
  ]
}

resource "aws_s3_bucket" "buckets" {
  for_each = toset(var.bucket_names)

  bucket = each.value

  tags = {
    Name = each.value
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  for_each = toset(var.bucket_names)

  bucket = aws_s3_bucket.buckets[each.value].id

  versioning_configuration {
    status = "Enabled"
  }
}