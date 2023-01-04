resource "google_service_account" "sa" {
  account_id   = "${var.cluster_name}-gke-sa"
  display_name = "${var.cluster_name}-gke-sa"
}

# Assign role(s) to the service account
resource "google_project_iam_member" "k8s-member" {
  count   = length(var.iam_roles)
  project = var.project_id
  role    = element(var.iam_roles, count.index)
  member  = "serviceAccount:${google_service_account.sa.email}"

}