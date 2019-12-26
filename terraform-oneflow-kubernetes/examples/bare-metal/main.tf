variable "nodes" {
    default = [{
        type = "ssh",
        host = "192.168.33.101",
        port = "22",
        user = "vagrant",
        role = "controlplane,worker,etcd",
        private_key = "~/.vagrant.d/boxes/xxmyjk-VAGRANTSLASH-oneflow-devbox/1.0.0/virtualbox/vagrant_private_key",
    }, {
        type = "ssh",
        host = "192.168.33.102",
        port = "22",
        user = "vagrant",
        role = "controlplane,worker,etcd",
        private_key = "~/.vagrant.d/boxes/xxmyjk-VAGRANTSLASH-oneflow-devbox/1.0.0/virtualbox/vagrant_private_key",
    }, {
        type = "ssh",
        host = "192.168.33.103",
        port = "22",
        user = "vagrant",
        role = "controlplane,worker,etcd",
        private_key = "~/.vagrant.d/boxes/xxmyjk-VAGRANTSLASH-oneflow-devbox/1.0.0/virtualbox/vagrant_private_key",
    },]
}

variable "pre_install" {
    default = [
        "hostname",
        "uname -r",
    ]
}

variable "k8s_config" {
    default = {
        "filename" = "kube_config.yml",
        "filepath" = "."
    }
}

module "aaaaa" {
    source = "../../"
    nodes = var.nodes
    pre_install = var.pre_install
    k8s_config = var.k8s_config
}
