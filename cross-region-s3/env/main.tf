module "cross-se-bucket" {
  source        = "../modules/cross_s3_bucket"
  tags          = var.tags
  first_bucket  = var.first_bucket
  second_bucket = var.second_bucket
}
