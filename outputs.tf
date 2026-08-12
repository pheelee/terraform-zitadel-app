output "client_id" {
  description = "Client ID of the app"
  value       = zitadel_application_v2.sso.oidc[0].client_id
}
output "client_secret" {
  description = "Client secret of the app"
  value       = zitadel_application_v2.sso.oidc[0].client_secret
  sensitive   = true
}
