module "logs" {
  source = "github.com/global-devops-terraform/s3?ref=v0.17.2"

  bucket_name = local.log_bucket_name
  bucket_acl  = "log-delivery-write"
  versioning  = false
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:PutObject"]
    resources = ["${module.logs.bucket_arn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::156460612806:root"]
    }
  }

  statement {
    actions   = ["s3:PutObject"]
    resources = ["${module.logs.bucket_arn}/*"]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"

      values = [
        "bucket-owner-full-control"
      ]
    }

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
  }

  statement {
    actions   = ["s3:GetBucketAcl"]
    resources = [module.logs.bucket_arn]

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
  }
}

resource "aws_s3_bucket_policy" "logs" {
  bucket = module.logs.bucket_name
  policy = data.aws_iam_policy_document.s3_policy.json
}
