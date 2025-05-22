variable "vpc_cidr_block" {
        type = string
        default = "10.0.0.0/16"
        description = "vpc_cidr_block"
}

variable "publicsubnet_cidr_block" {
        type = string
        default = "10.0.10.0/24"
        description = "publicsubnet"
}
                                                                                                                                     variable "privatesubnet_cidr_block" {
        type = string
        default = "10.0.20.0/24"
        description = "privatesubnet"
}                                                                                                                                    
variable "publicRT_cidr_block" {
        type = string
        default = "0.0.0.0/0"
        description = "publicRT_cidr_block"

}

variable "region" {
        type = string
        default = "us-east-1"
        description = "aws vpc region"
}

variable "ami_id" {
        default = "ami-084568db4383264d4"
        type = string
}

variable "key_name" {
        type = string
        default = "EC2-Multi-Env-TF"
}

variable "type" {
        type = string
        default = "t2.micro"
}
