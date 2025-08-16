output "external_secrets_role_arn" {
  description = "ARN of the External Secrets IAM role"
  value       = var.enable_external_secrets ? aws_iam_role.external_secrets[0].arn : ""
}
