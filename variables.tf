variable "display_name" {
  type        = string
  description = "Displayname of the app"
}

variable "org_id" {
  type        = string
  description = "ID of the organization that hosts the app"
}

variable "redirect_uris" {
  type        = list(string)
  description = "List of redirect URIs"
}

variable "role_assertions" {
  type        = map(list(string))
  description = "Map of roles and associated user ids"
}

variable "response_types" {
  type        = list(string)
  description = "List of response types"
  default     = ["OIDC_RESPONSE_TYPE_CODE"]
}

variable "grant_types" {
  type        = list(string)
  description = "List of grant types"
  default     = ["OIDC_GRANT_TYPE_AUTHORIZATION_CODE"]
}
