# Zitadel App Module

This module enables you to create a SSO app in Zitadel by abstracting some parts that can be error prone.
If you need more flexibility you can write the configuration from scratch.

## Example

```hcl
module "zitadel_app" {
  source        = "app.terraform.io/irbech/app/zitadel"
  version       = "~>1.0"
  display_name  = "Dozzle"
  org_id        = zitadel_org.myorg.id
  redirect_uris = ["https://app.example.com/oauth2/callback"]
  role_assertions = {
    "user" = [zitadel_human_user.user1.id]
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >=1.12 |
| zitadel | ~>3.3 |

## Providers

| Name | Version |
|------|---------|
| zitadel | ~>3.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [zitadel_application_v2.sso](https://registry.terraform.io/providers/zitadel/zitadel/latest/docs/resources/application_v2) | resource |
| [zitadel_project_grant.sso](https://registry.terraform.io/providers/zitadel/zitadel/latest/docs/resources/project_grant) | resource |
| [zitadel_project_role.sso](https://registry.terraform.io/providers/zitadel/zitadel/latest/docs/resources/project_role) | resource |
| [zitadel_project_v2.sso](https://registry.terraform.io/providers/zitadel/zitadel/latest/docs/resources/project_v2) | resource |
| [zitadel_user_grant.sso](https://registry.terraform.io/providers/zitadel/zitadel/latest/docs/resources/user_grant) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_org\_grants | Object that contains additional organizations and roles (must match role\_assertions) that should be granted. Although a user assignment must be still made | <pre>list(object({<br/>    org_id = number<br/>    roles  = list(string)<br/>  }))</pre> | `[]` | no |
| app\_type | Type of the application | `string` | `"OIDC_APP_TYPE_WEB"` | no |
| display\_name | Displayname of the app | `string` | n/a | yes |
| grant\_types | List of grant types | `list(string)` | <pre>[<br/>  "OIDC_GRANT_TYPE_AUTHORIZATION_CODE"<br/>]</pre> | no |
| id\_token\_userinfo\_assertion | Put userinfo into id\_token | `bool` | `true` | no |
| org\_id | ID of the organization that hosts the app | `string` | n/a | yes |
| redirect\_uris | List of redirect URIs | `list(string)` | n/a | yes |
| response\_types | List of response types | `list(string)` | <pre>[<br/>  "OIDC_RESPONSE_TYPE_CODE"<br/>]</pre> | no |
| role\_assertions | Map of roles and associated user ids | `map(list(string))` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| client\_id | Client ID of the app |
| client\_secret | Client secret of the app |
<!-- END_TF_DOCS -->