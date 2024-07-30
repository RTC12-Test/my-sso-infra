variable "dlsecret" {
  description = "Delinea varaiables"
  type        = any
  default     = ""
}
variable "delinea_username" {
  description = "The username of the Secret Server User"
  type        = string
  default     = ""
}
variable "delinea_password" {
  description = "The password of the Secret Server User"
  type        = string
  default     = ""
}
variable "delinea_server_url" {
  description = "The Secret Server base URL e.g. https://localhost/SecretServer"
  type        = string
  default     = ""
}
variable "env" {
  description = "Environment"
  type        = string
  default     = ""
}
