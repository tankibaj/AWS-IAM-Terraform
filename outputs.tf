output "this_iam_user_name" {
  description = "The user's name"
  value       = module.iam_user.this_iam_user_name
}

output "this_iam_user_login_profile_encrypted_password" {
  description = "The encrypted password, base64 encoded"
  value       = module.iam_user.this_iam_user_login_profile_encrypted_password
}

output "this_iam_access_key_id" {
  description = "The access key ID"
  value       = module.iam_user.this_iam_access_key_id
}

output "this_iam_access_key_encrypted_secret" {
  description = "The encrypted secret, base64 encoded"
  value       = module.iam_user.this_iam_access_key_encrypted_secret
}