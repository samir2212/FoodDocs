resource "aws_iam_user" "fooddocs-terraform-dev" {
  name = "fooddocs-terraform-dev"
}

resource "aws_iam_user" "alex-cloudvisor" {
  name = "alex-cloudvisor"
}

# Creating Groups
resource "aws_iam_group" "Admin" {
  name = "Admin"
}
resource "aws_iam_group" "Developers" {
  name = "Developers"
}
resource "aws_iam_group" "Prod-admins" {
  name = "Prod-admins"
}
resource "aws_iam_group" "Prod-developers" {
  name = "Prod-developers"
}

#Assign users to groups

resource "aws_iam_group_membership" "Admin" {
  name = "Admin"
  users = [
    aws_iam_user.fooddocs-terraform-dev.name,
    aws_iam_user.alex-cloudvisor.name,
  ]
  group = aws_iam_group.Admin.name
}

#Assign dev users if needed

#resource "aws_iam_group_membership" "Developer" {
#  name = "Developer"
#  users = [
#    aws_iam_user.developer-1.name,
#  ]
#  group = aws_iam_group.Developers.name
#}

# Attach Policy
resource "aws_iam_policy_attachment" "Admin-access-policy" {
  name       = "Admin-access"
  groups     = [aws_iam_group.Admin.name]
  roles      = ["foodocs-dev-admin-role"]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Attach Policy
resource "aws_iam_policy_attachment" "Developer-access-policy" {
  name       = "Developer-access"
  groups     = [aws_iam_group.Developers.name]
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

data "aws_iam_group" "Admin" {
  group_name = "Admin"
  depends_on = [aws_iam_group_membership.Admin]
}

# Force MFA on user groups
/*
resource "aws_iam_policy" "force-mfa-on-user-policy" {
  name        = "force-mfa-on-user-policy"
  description = "A policy that enforces users to enable MFA"
  policy      = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowViewAccountInfo",
            "Effect": "Allow",
            "Action": [
                "iam:GetAccountPasswordPolicy",
                "iam:GetAccountSummary",
                "iam:ListVirtualMFADevices"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AllowManageOwnPasswords",
            "Effect": "Allow",
            "Action": [
                "iam:ChangePassword",
                "iam:GetUser"
            ],
            "Resource": "arn:aws:iam::*:user/$${aws:username}"
        },
        {
            "Sid": "AllowListActions",
            "Effect": "Allow",
            "Action": [
                "iam:ListUsers",
                "iam:ListVirtualMFADevices",
                "iam:ListUserPolicies"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AllowManageOwnAccessKeys",
            "Effect": "Allow",
            "Action": [
                "iam:CreateAccessKey",
                "iam:DeleteAccessKey",
                "iam:ListAccessKeys",
                "iam:UpdateAccessKey"
            ],
            "Resource": "arn:aws:iam::*:user/$${aws:username}"
        },
        {
            "Sid": "AllowManageOwnSigningCertificates",
            "Effect": "Allow",
            "Action": [
                "iam:DeleteSigningCertificate",
                "iam:ListSigningCertificates",
                "iam:UpdateSigningCertificate",
                "iam:UploadSigningCertificate"
            ],
            "Resource": "arn:aws:iam::*:user/$${aws:username}"
        },
        {
            "Sid": "AllowManageOwnSSHPublicKeys",
            "Effect": "Allow",
            "Action": [
                "iam:DeleteSSHPublicKey",
                "iam:GetSSHPublicKey",
                "iam:ListSSHPublicKeys",
                "iam:UpdateSSHPublicKey",
                "iam:UploadSSHPublicKey"
            ],
            "Resource": "arn:aws:iam::*:user/$${aws:username}"
        },
        {
            "Sid": "AllowManageOwnGitCredentials",
            "Effect": "Allow",
            "Action": [
                "iam:CreateServiceSpecificCredential",
                "iam:DeleteServiceSpecificCredential",
                "iam:ListServiceSpecificCredentials",
                "iam:ResetServiceSpecificCredential",
                "iam:UpdateServiceSpecificCredential"
            ],
            "Resource": "arn:aws:iam::*:user/$${aws:username}"
        },
        {
            "Sid": "AllowManageOwnVirtualMFADevice",
            "Effect": "Allow",
            "Action": [
                "iam:CreateVirtualMFADevice",
                "iam:DeleteVirtualMFADevice"
            ],
            "Resource": "arn:aws:iam::*:mfa/$${aws:username}"
        },
        {
            "Sid": "AllowManageOwnUserMFA",
            "Effect": "Allow",
            "Action": [
                "iam:DeactivateMFADevice",
                "iam:EnableMFADevice",
                "iam:ListMFADevices",
                "iam:ResyncMFADevice"
            ],
            "Resource": "arn:aws:iam::*:user/$${aws:username}"
        },
        {
            "Sid": "BlockMostAccessUnlessSignedInWithMFA",
            "Effect": "Deny",
            "NotAction": [
                "iam:CreateVirtualMFADevice",
                "iam:DeleteVirtualMFADevice",
                "iam:EnableMFADevice",
                "iam:ListMFADevices",
                "iam:ListUsers",
                "iam:ListVirtualMFADevices",
                "iam:ResyncMFADevice"
            ],
            "Resource": "*",
            "Condition": {
                "BoolIfExists": {
                    "aws:MultiFactorAuthPresent": "false"
                }
            }
        }
    ]
 }
POLICY
}
resource "aws_iam_group_policy_attachment" "MFA-policy-attach-developers" {
  group      = aws_iam_group.Developers.name
  policy_arn = aws_iam_policy.force-mfa-on-user-policy.arn
}
resource "aws_iam_group_policy_attachment" "MFA-policy-attach-admins" {
  group      = aws_iam_group.Admin.name
  policy_arn = aws_iam_policy.force-mfa-on-user-policy.arn
}
*/
