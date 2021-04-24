#########################################
# IAM user, login profile and access key
#########################################
module "adminuser" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "~> 3.0"

  name                          = "adminuser"
  create_iam_user_login_profile = true
  create_iam_access_key         = true
  force_destroy                 = true # When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices

  # Install keybase.io in our local
  # Create Keybase key by using "keybase pgp gen"
  # Then give the reference of this Keybase key in your terraform code keybase:username_of_keybase
  # Then "terraform apply"
  # Dcrypted password "terraform output -raw adminuser_user_login_profile_password | base64 --decode | keybase pgp decrypt"
  # Dcrypted access key "terraform output -raw adminuser_access_key_secret | base64 --decode | keybase pgp decrypt"
  pgp_key = "keybase:thenaim"

  password_reset_required = false

  # SSH public key
  upload_iam_user_ssh_key = true
  ssh_public_key          = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDkWco4WiGFw9/q9I6EWLyX58o0g9h4GaIA0unAqktMgybU4bWmZ/59LynImJtbxK46kprLE/lcew7jpX2p9iS+WKro13NmlfxzRXCXufMu8zuuR8od+dcBCagHypVo7r00/4seakdc6i/DCPDAl8RcBMsR15ZWa+pwQiHFIHUnBXOaBGH8v/UuLhcw7IzdXi2juhIQ8vrn3XFYGtmACnE+/lweE5bys/ynqp+ezINUmaqtpAGaJqNT5Skwy9DelbUkxOuvliIC2vBMj7Hjb8XGUSbgFKznCEsMwKkdEDgg5pAHFwJRAN7EQ6IPg7pMloNs4GzqtWGfV3Wa9ZXgCl+RCZ7AN7Ng0mVdOhtwkxh5oa3T+U7JNhWEMmvKt4iK2t1sk+upl3lS12CXcQd8YIPuwjZ9kpYdrDQtPkKgZLWKP5gbRwwMc8Qh5TP4jePo8s0M8qff0E/vC2fNaWNAEis5Bk43skG72T4jpveqLRONNV5l3URb92XJNJaTItrVW6xFzcG2XPVSqyHFeNKT0wBmalfbDQ0llZoTbL9VOua4aXd3KJc23XsPN12e1iK8n5tBB2IiZAF4aNzhyGo3jngB9nsjHL/HrlZ9RuBA96YOFWUtnemaIDGphJuTJ3tclfD9uL9h5r8nQiwrSssumV/p/5ZtWvoxJvFN9OTOs9K0Jw== mail@thenaim.com"
}

#########################################
# IAM user, access key
#########################################
module "readonlyuser" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "~> 3.0"

  name                          = "readonlyuser"
  create_iam_user_login_profile = false
  create_iam_access_key         = true
  force_destroy                 = true # When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices

  # Install keybase.io in our local
  # Create Keybase key by using "keybase pgp gen"
  # Then give the reference of this Keybase key in your terraform code keybase:username_of_keybase
  # Then "terraform apply"
  # Dcrypted password "terraform output -raw readonlyuser_access_key_secret | base64 --decode | keybase pgp decrypt"
  # Dcrypted access key "terraform output -raw readonlyuser_access_key_id | base64 --decode | keybase pgp decrypt"
  pgp_key = "keybase:thenaim"
}

#####################################################################################
# IAM group with full Administrator access
#####################################################################################
module "admin_group" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  version = "~> 3.0"

  name = "administrator"

  group_users = [
    module.adminuser.this_iam_user_name,
  ]

  custom_group_policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess",
  ]
}

#####################################################################################
# IAM group with Read Only access
#####################################################################################
module "readonly_group" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  version = "~> 3.0"

  name = "readonly"

  group_users = [
    module.readonlyuser.this_iam_user_name,
  ]

  custom_group_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess",
  ]
}