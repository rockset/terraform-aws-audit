resource "rockset_s3_integration" "integration" {
  name         = "${var.bucket_name}-integration"
  aws_role_arn = var.rockset_role_arn
}

resource "rockset_s3_collection" "collection" {
  name           = var.collection
  workspace      = var.workspace
  retention_secs = var.retention_secs
  source {
    format           = "json"
    integration_name = rockset_s3_integration.integration.name
    bucket           = var.bucket_name
    pattern = "*.json"
  }
}
