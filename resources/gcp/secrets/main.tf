resource "google_secret_manager_secret" "secret-basic" {
  count     = length(var.secrets)
  secret_id = "${var.project_id}-${element(keys(var.secrets), count.index)}"

  #   labels = {
  #     label = "my-label"
  #   }

  replication {
    automatic = true
  }
}


resource "google_secret_manager_secret_version" "secret-version-basic" {
  count       = length(var.secrets)
  secret      = element(google_secret_manager_secret.secret-basic.*.id, count.index)
  secret_data = element(values(var.secrets), count.index)
}

locals {
  secrets = zipmap(keys(var.secrets), google_secret_manager_secret_version.*.id)

  secretMap = [for secretKey in keys(var.secrets) : {
    name      = secretKey
    valueFrom = lookup(local.secrets, secretKey)
  }]
}