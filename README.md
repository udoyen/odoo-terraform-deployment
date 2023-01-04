# odoo-terraform-config

repository for the odoo terraform deployment

## Helper Documentation

1. [Best practice](https://cloudkul.com/blog/terraform-and-its-best-practices)
2. Terrform:
   - [GKE](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster)
   - [Helm](https://registry.terraform.io/providers/hashicorp/helm/latest/docs)
3. [Getting Started with Terrform on GCP](https://cloud.google.com/docs/terraform/get-started-with-terraform)
4. [Google Terrform Samples](https://github.com/terraform-google-modules/terraform-docs-samples)
5. [GCP Terraform How to Guide](https://learn.hashicorp.com/tutorials/terraform/gke?in=terraform/kubernetes&utm_source=WEBSITE&utm_medium=WEB_IO&utm_offer=ARTICLE_PAGE&utm_content=DOCS&_ga=2.227700189.1501271430.1661543890-1254865410.1660034828)
6. [Terraform: Get Started](https://learn.hashicorp.com/collections/terraform/aws-get-started)
7. [Odoo Helm Bitnami ArtifactHub](https://artifacthub.io/packages/helm/bitnami/odoo)
8. [Creating a private cluster](https://cloud.google.com/kubernetes-engine/docs/how-to/private-clusters#cloud_shell)
9. [A Complete GCP Environment with Terraform](https://medium.com/slalom-technology/a-complete-gcp-environment-with-terraform-c087190366f0)
10. [How to create a Static Outbound IP for Google Cloud Functions using Terraform](https://shashwotrisal.medium.com/how-to-create-a-static-outbound-ip-for-google-cloud-functions-using-terraform-a8e9b30074b6)
11. [Creating Dependencies between your Terraform Modules](https://gcloud.devoteam.com/blog/creating-dependencies-between-your-terraform-modules/#:~:text=Even%20without%20a%20built-in,module%20dependencies%20for%20specific%20resources.)
12. [Bitnami odoo chart](https://artifacthub.io/packages/helm/bitnami/odoo)
13. [Helm How-To](https://binx.io/2021/05/02/how-to-deploy-elasticsearch-on-gke-using-terraform-and-helm/)

## Developer's Help

1. ***DON'T WORK OR PUSH TO MAIN BRANCH***.
2. Create a new branch for your work then push and create a pull request.
3. Before working do a ```terrafrom init``` on your local system.

## Setup your system

1. ADC:
   - ```gcloud auth application-default login``` and login with your techequity gmail account
   - Use a service account:

      ```HCL
          provider "google" {
            credentials = "${file("service-account.json")}"
            project     = "my-project-id"
            region      = "us-central1"
            zone        = "us-central1-c"
         }
      ```

2. [google auth application-default](https://cloud.google.com/sdk/gcloud/reference/auth/application-default)
