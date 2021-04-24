output "adminuser_access_key_secret" {
  description = "The encrypted secret, base64 encoded"
  value       = module.adminuser.this_iam_access_key_encrypted_secret
}

output "adminuser_access_key_id" {
  description = "The access key ID"
  value       = module.adminuser.this_iam_access_key_id
}

output "adminuser_user_login_profile_password" {
  description = "The encrypted password, base64 encoded"
  value       = module.adminuser.this_iam_user_login_profile_encrypted_password
}

output "readonlyuser_access_key_secret" {
  description = "The encrypted secret, base64 encoded"
  value       = module.readonlyuser.this_iam_access_key_encrypted_secret
}

output "readonlyuser_access_key_id" {
  description = "The access key ID"
  value       = module.readonlyuser.this_iam_access_key_id
}