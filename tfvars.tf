variable az {
    default = "ap-south-1a"
}

variable vpc_cidr {
    default = "10.0.0.0/16"
}
variable subnet_cidr {
    default = "10.0.0.0/20"
}
variable open_cidr {
    default = "0.0.0.0/0"
}
variable key_pair {
    default = "es-keypair"
}
variable ami_id {
    default = "ami-0e8710d48cc4ea8dd"
}
variable instance_type {
    default = "t2.micro"
}

variable user {
    default = "ubuntu"
}