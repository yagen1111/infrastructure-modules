# External Secrets IAM Role
resource "aws_iam_role" "external_secrets" {
  count = var.enable_external_secrets ? 1 : 0
  
  name = "${var.eks_name}-external-secrets-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Federated = var.openid_provider_arn }
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringEquals = {
          "${regexreplace(var.openid_provider_arn, "^arn:aws:iam::[0-9]+:oidc-provider/", "")}:sub" = "system:serviceaccount:external-secrets:external-secrets"
          "${regexreplace(var.openid_provider_arn, "^arn:aws:iam::[0-9]+:oidc-provider/", "")}:aud" = "sts.amazonaws.com"
        }
      }
    }]
  })
}

# External Secrets IAM Policy
resource "aws_iam_role_policy" "external_secrets" {
  count = var.enable_external_secrets ? 1 : 0
  
  name = "${var.eks_name}-external-secrets-policy"
  role = aws_iam_role.external_secrets[0].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "helm_release" "external_secrets" {
  count = var.enable_external_secrets ? 1 : 0

  name = "external-secrets"

  repository = "https://charts.external-secrets.io"
  chart      = "external-secrets"
  namespace  = "external-secrets"
  version    = "0.9.5"

  create_namespace = true

  set = [
    {
    name  = "serviceAccount.create"
    value = "true"
    },
    {
    name  = "serviceAccount.name"
    value = "external-secrets"
    },
    {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.external_secrets[0].arn
    }
  ]
}
