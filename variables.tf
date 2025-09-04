variable "display_name" {
  type        = string
  description = "Displayname of the app"
}

variable "app_type" {
  type        = string
  description = "Type of the application"
  validation {
    condition     = contains(["OIDC_APP_TYPE_WEB", "OIDC_APP_TYPE_USER_AGENT", "OIDC_APP_TYPE_NATIVE"], var.app_type)
    error_message = "App type must be one of OIDC_APP_TYPE_WEB, OIDC_APP_TYPE_USER_AGENT or OIDC_APP_TYPE_NATIVE"
  }
  default = "OIDC_APP_TYPE_WEB"
}

variable "org_id" {
  type        = string
  description = "ID of the organization that hosts the app"
}

variable "additional_org_grants" {
  type = list(object({
    org_id = number
    roles  = list(string)
  }))
  description = "Object that contains additional organizations and roles (must match role_assertions) that should be granted. Although a user assignment must be still made"
  default     = []
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

variable "id_token_userinfo_assertion" {
  type        = bool
  description = "Put userinfo into id_token"
  default     = true
}
