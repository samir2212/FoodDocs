resource "aws_s3_bucket" "fooddocs-dev-env-bucket" {
  bucket = "${var.project}-${local.stage_name}-env-bucket"
  tags = {
    Name        = "${var.project}-${local.stage_name}-env-bucket"
    Environment = "dev"
  }
}

resource "aws_s3_bucket_versioning" "fooddocs-dev-env-bucket" {
  bucket = aws_s3_bucket.fooddocs-dev-env-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "fooddocs-dev-env-bucket" {
  bucket = aws_s3_bucket.fooddocs-dev-env-bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "fooddocs-dev-env-bucket" {
  bucket = aws_s3_bucket.fooddocs-dev-env-bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "fooddocs-dev-env-bucket" {
  bucket                  = aws_s3_bucket.fooddocs-dev-env-bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
