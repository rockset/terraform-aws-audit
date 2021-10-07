output "rockset-role-arn" {
  value = aws_iam_role.rockset.arn
  description = "AWS ARN of Rockset integration role"
}
