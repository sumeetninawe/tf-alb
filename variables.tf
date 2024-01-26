variable "ami" {
  type        = string
  description = "Ubuntu AMI ID in Frankfurt Region"
  default     = "ami-065deacbcaac64cf2"
}
variable "vpc_id" {
  type        = string
  description = "Default VPC ID"
}
variable "subnet_a" {
  type        = string
  description = "Subnet ID in AZ A"
}
variable "subnet_b" {
  type        = string
  description = "Subnet ID in AZ B"
}
variable "subnet_c" {
  type        = string
  description = "Subnet ID in AZ C"
}
variable "vpc_sg" {
  type        = string
  description = "Default Security Group"
}