output "s3_bucket_name" {
  value = "${aws_s3_bucket.default_s3.name}"
}

output "s3_bucket_id" {
  value = "${aws_s3_bucket.default_s3.id}"
}
