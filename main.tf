locals {
  user_grants = merge([
    for role, users in var.role_assertions : {
      for user in users :
      "${role}++${user}" => user
    }
  ]...)
}

resource "zitadel_project" "sso" {
  name                   = title(var.display_name)
  org_id                 = var.org_id
  has_project_check      = true
  project_role_check     = true
  project_role_assertion = true
}

resource "zitadel_project_role" "sso" {
  for_each     = var.role_assertions
  org_id       = var.org_id
  project_id   = zitadel_project.sso.id
  role_key     = each.key
  display_name = "${title(var.display_name)} ${title(each.key)}"
  group        = lower(var.display_name)
}

resource "zitadel_application_oidc" "sso" {
  name                        = lower(var.display_name)
  org_id                      = var.org_id
  project_id                  = zitadel_project.sso.id
  redirect_uris               = var.redirect_uris
  response_types              = var.response_types
  grant_types                 = var.grant_types
  id_token_userinfo_assertion = var.id_token_userinfo_assertion
  app_type                    = var.app_type
  auth_method_type            = var.app_type == "OIDC_APP_TYPE_USER_AGENT" ? "OIDC_AUTH_METHOD_TYPE_NONE" : "OIDC_AUTH_METHOD_TYPE_BASIC"

}

resource "zitadel_user_grant" "sso" {
  depends_on = [zitadel_project_role.sso]
  for_each   = local.user_grants
  org_id     = var.org_id
  project_id = zitadel_project.sso.id
  role_keys  = [split("++", each.key)[0]]
  user_id    = each.value
}
