output "client_id" {
  description = "Client ID of the app"
  value       = zitadel_application_oidc.sso.client_id
}
output "client_secret" {
  description = "Client secret of the app"
  value       = zitadel_application_oidc.sso.client_secret
  sensitive   = true
}
