
output "helm_service_account_name" {
  value = kubernetes_service_account.helm_account.metadata.0.name
}