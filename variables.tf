variable "terraform_bucket_name" {
  description = "The name of the s3 bucket where terraform.tfstate will be stored"
  default     = "gonecrazy-test-terraform-remote-state-storage-s3"
}

variable "tags" {
  default = {
    client     = "ExampleClient"
    costcenter = "ExampleClient"
  }
}
