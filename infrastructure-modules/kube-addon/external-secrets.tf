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
      name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
      value = var.external_secrets_role_arn
    }
  ]
}
