variable "nodes" {
    description = "cluser nodes the kubernetes to deploy to"
    type = list(map({
        ssh = string
        host = string
        port = string
        user = string
        role = string
        private_key = string
    }))
}

variable "pre_install" {
    description = "cluster nodes package installation"
    type = list(string)
}

variable "k8s_config" {
    description = "kubernetes basic config"
    type = map({
        filename = string
        filepath = string
    })    
}

