terraform {
  backend "s3" {
    bucket  = "fooddocs-terraform-state"
    key     = "initial_setup/terraform.tfstate"
    region  = "eu-central-1"
    encrypt = true
  }
}


resource "aws_s3_bucket" "fooddocs-terraform-state" {
  bucket = "fooddocs-terraform-state"
  tags = {
    Name        = "fooddocs-terraform-state"
    Environment = "dev"
  }
}

resource "aws_s3_bucket_versioning" "fooddocs-terraform-state" {
  bucket = aws_s3_bucket.fooddocs-terraform-state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "fooddocs-terraform-state" {
  bucket = aws_s3_bucket.fooddocs-terraform-state.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "fooddocs-terraform-state" {
  bucket = aws_s3_bucket.fooddocs-terraform-state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "fooddocs-terraform-state" {
  bucket                  = aws_s3_bucket.fooddocs-terraform-state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "fooddocs-terraform-state" {
  bucket = aws_s3_bucket.fooddocs-terraform-state.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_policy" "fooddocs-terraform-state-bucket-policy" {
  bucket = "fooddocs-terraform-state"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "NotPrincipal": {
        "AWS": [
          ${trim(jsonencode(data.aws_iam_group.Admin.users.*.arn), "[]")}
        ]
      },
      "Action": "s3:*",
      "Resource": [
        "${aws_s3_bucket.fooddocs-terraform-state.arn}/*",
        "${aws_s3_bucket.fooddocs-terraform-state.arn}"
      ],
      "Effect": "Deny"
    }
  ]
}
POLICY
}
