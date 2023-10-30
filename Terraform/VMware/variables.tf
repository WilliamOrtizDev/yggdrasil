variable "vcenter_user" {
    description = "User for vcenter"
    type = string
    default = "administrator@ortizservers.com"
}

variable "vcenter_pass" {
  description = "Password for vcenter"
  type = string
  sensitive = true
  default = "#93Z1tr019"
}

variable "vcenter_host" {
  description = "Host or IP for vcenter"
  type = string
  default = "192.168.1.39"
}