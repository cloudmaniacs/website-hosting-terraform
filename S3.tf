resource "aws_s3_bucket" "cloudmaniacs-website" {
  bucket = "${var.project_name}-website"
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  website {
          index_document = "index.html"
          error_document = "index.html"
  }
  tags = {
    Name = "S3 Bucket for Cloud Maniacs Website"
  }

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "PublicAccess",
    "Statement": [
        {
            "Sid": "1",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${var.project_name}-website/*"
        }
    ]
}
POLICY

  force_destroy = true
}

resource "aws_s3_bucket" "cloudmaniacs-redirect" {
  bucket = "${var.project_name}-redirect"
  website {
          redirect_all_requests_to = "https://cloudmaniacs.de"
  }
  tags = {
    Name = "S3 Bucket for Cloud Maniacs Redirect"
  }
}

resource "null_resource" "upload_website_to_s3" {
  provisioner "local-exec" {
    command = "aws s3 cp ./website s3://${aws_s3_bucket.cloudmaniacs-website.id} --recursive"
  }
}