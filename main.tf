locals {
  user_grants = flatten([
    for role, users in var.role_assertions : [
      for user in users : {
        role = role
        user = user
      }
    ]
  ])
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
  count      = length(local.user_grants)
  depends_on = [zitadel_project_role.sso]
  org_id     = var.org_id
  project_id = zitadel_project.sso.id
  role_keys  = [local.user_grants[count.index].role]
  user_id    = local.user_grants[count.index].user
}

resource "zitadel_project_grant" "sso" {
  for_each       = { for g in var.additional_org_grants : g.org_id => g }
  org_id         = var.org_id
  project_id     = zitadel_project.sso.id
  granted_org_id = each.key
  role_keys      = each.value.roles
}
