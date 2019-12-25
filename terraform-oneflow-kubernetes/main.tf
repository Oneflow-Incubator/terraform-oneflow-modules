# docker installation
resource "null_resource" "nodes" {
    for_each = var.nodes

    // mapper for connections
    connection {
        type = each.value.type
        host = each.value.host
        port = each.value.port
        user = each.value.user
        private_key = file(each.value.private_key)
    }

    // install docker 
    provisioner "remote-exec" {
        inline = var.pre-install
    }
}

# kubernetes cluster installation
resource "rke_cluster" "kubernetes-cluster" {
    dynamic nodes {
        for_each = var.nodes
        content {
            address = nodes.value.host
            user = nodes.value.user
            role = split(",", nodes.value.role)
            ssh_key = file(nodes.value.private_key)
        }
    }
}

# kubernetes cluster config output
resource "local_file" "k8s_config" {
    filename = format("%s/%s", var.k8s_config.filepath, var.k8s_config.filename)
    content = rke_cluster.kubernetes-cluster.kube_config_yaml
}

# load kubernetes cluster config from rke
provider "kubernetes" {
  host     = kubernetes-cluster.cluster.api_server_url
  username = kubernetes-cluster.cluster.kube_admin_user

  client_certificate     = kubernetes-cluster.cluster.client_cert
  client_key             = kubernetes-cluster.cluster.client_key
  cluster_ca_certificate = kubernetes-cluster.cluster.ca_crt
}
