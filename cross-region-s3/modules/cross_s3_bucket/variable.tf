variable "first_bucket" {
  type        = string
  description = "bucket name"
}
variable "second_bucket" {

  type = string

  description = "second bucket"
}
variable "tags" {
  type = object({
    Owner             = string
    Envioronment      = string
    Deployment_method = string
  })
}

