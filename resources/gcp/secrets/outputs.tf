output "application_secrets" {
  value = google_secret_manager_secret.secret-basic.*.id
}

output "secrets_map" {
  value = local.secretMap
}

output "secrets" {
  value = local.secrets
}