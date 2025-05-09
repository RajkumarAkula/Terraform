provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "nifi" {
  metadata {
    name = "nifi"
  }
}

resource "helm_release" "nifi" {
  name       = "nifi"
  namespace  = kubernetes_namespace.nifi.metadata[0].name
  repository = "https://cetic.github.io/helm-charts"
  chart      = "nifi"
  version    = "1.2.0" # Optional: can be updated based on latest

  

  values = [
    file("values.yaml")
  ]
}
