variable "project_id" {
  type = string
}
variable "plan" {
  type    = string
  default = "c3.small.x86"
}
variable "metro" {
  type = string
}
variable "operating_system" {
  type = string
}
variable "billing_cycle" {
  type    = string
  default = "hourly"
}
variable "nums" {
  type = number
}
variable "core_count" {
  description = ""
}

variable "metro_code" {
  description = ""
}

variable "notifications" {
  description = ""
}

variable "package_code" {
  description = ""
}

variable "sec_metro_code" {
  description = ""
}

variable "type_code" {
  description = ""
}

variable "ver" {
  description = ""
}
variable "account_number" {
}
variable "sec_account_number" {
}