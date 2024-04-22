# variable "hostname" {
#     type = string  
# }
variable "plan" {
    type = string
    default = "c3.small.x86"
}
variable "metro" {
    type = string
}
variable "operating_system" {
    type = string
}
variable "billing_cycle" {
    type = string
    default = "hourly"
}
variable "nums" {
    type = number
}