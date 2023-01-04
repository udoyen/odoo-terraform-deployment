resource "helm_release" "odoo" {
  name       = "${var.project_id}-helm-release"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "odoo"
  namespace  = "default"
  # timeout    = 900

  values = [
    file("${path.module}/values-odoo.yaml")
  ]

  # Database parameters
  set_sensitive {
    name  = "postgresql.auth.password"
    value = var.odoo_postgresql_password
    

  }

  depends_on = [
    var.cluster_name,
  ]

}
