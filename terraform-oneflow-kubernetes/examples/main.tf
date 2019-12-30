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
        "echo '=========== docker installation start ==========='",
        "sudo yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine",
        "sudo yum install -y yum-utils device-mapper-persistent-data lvm2",
        "sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo",
        "sudo yum install -y docker-ce docker-ce-cli containerd.io",
        "echo '=========== docker installation end ============='",
    ]
}

variable "k8s_config" {
    default = {
        "filename" = "kube_config.yml",
        "filepath" = "."
    }
}

module "docker-kubernetes-installation" {
    source = "../"
    nodes = var.nodes
    pre_install = var.pre_install
    k8s_config = var.k8s_config
}
