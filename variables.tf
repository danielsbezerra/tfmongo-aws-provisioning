variable "env" {
    default = "dev"
}

variable "tag" {
    default = "mongodbcluster"
}

variable "region" {
    default = "us-east-1" //US East (N. Virginia)
}

variable "az" {
    default = ["us-east-1a","us-east-1b"]
}