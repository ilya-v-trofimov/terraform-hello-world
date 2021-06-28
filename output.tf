output "bucket_name" {
  value = aws_s3_bucket.bucket.id
}

output "role_arn" {
  value = aws_iam_role.terraform-lab-role.arn
}

output "instance_profile" {
  value = aws_iam_instance_profile.terraform-lab-instance-profile.name
}
