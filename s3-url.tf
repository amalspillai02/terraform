resource "aws_s3_bucket" "my_bucket" {
  bucket = "amalspillai-tf-bucket"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "allow_public" {
  bucket                  = aws_s3_bucket.my_bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Upload the object (without ACL)
resource "aws_s3_object" "uploaded_file" {
  bucket = aws_s3_bucket.my_bucket.id
  key    = "uploads/hello.txt"
  source = "hello.txt"
}

# Add a public bucket policy
resource "aws_s3_bucket_policy" "public_policy" {
  bucket = aws_s3_bucket.my_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*"
        Action = "s3:GetObject"
        Resource = "${aws_s3_bucket.my_bucket.arn}/*"
      }
    ]
  })
}

