resource "aws_s3_bucket" "flow_logs" {
  bucket        = "rm-${var.domain}-flow-log"
  force_destroy = true
  tags = var.tags
}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.flow_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "owner" {
  bucket = aws_s3_bucket.flow_logs.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_policy" "flow_logs_policy" {
  bucket = aws_s3_bucket.flow_logs.id

  policy = jsonencode({
    Version = "2012-10-17",
    Id      = "EnforceHTTPS",
    Statement = [
      {
        Sid       = "DenyHTTP",
        Effect    = "Deny",
        Principal = "*",
        Action    = "s3:*",
        Resource = [
          "arn:aws:s3:::rm-${var.domain}-flow-log",
          "arn:aws:s3:::rm-${var.domain}-flow-log/*"
        ],
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      },
      {
        Sid    = "AWSLogDeliveryWrite",
        Effect = "Allow",
        Principal = {
          Service = "delivery.logs.amazonaws.com"
        },
        Action = "s3:PutObject",
        Resource = "arn:aws:s3:::rm-${var.domain}-flow-log/AWSLogs/${var.account_id}/*",
        Condition = {
          StringEquals = {
            "aws:SourceAccount" = var.account_id,
            "s3:x-amz-acl"      = "bucket-owner-full-control"
          },
          ArnLike = {
            "aws:SourceArn" = "arn:aws:logs:${var.region}:${var.account_id}:*"
          }
        }
      },
      {
        Sid    = "AWSLogDeliveryAclCheck",
        Effect = "Allow",
        Principal = {
          Service = "delivery.logs.amazonaws.com"
        },
        Action = "s3:GetBucketAcl",
        Resource = "arn:aws:s3:::rm-${var.domain}-flow-log",
        Condition = {
          StringEquals = {
            "aws:SourceAccount" = var.account_id
          },
          ArnLike = {
            "aws:SourceArn" = "arn:aws:logs:${var.region}:${var.account_id}:*"
          }
        }
      }
    ]
  })
}
