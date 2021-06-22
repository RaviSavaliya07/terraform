# terraform {
#   backend "remote" {
#     organization = "terraform-prac"

#     workspaces {
#       name = "dev"
#     }
#   }
# }
terraform {
  backend "s3" {
    bucket = "terraform07"
    key    = "mykey"
    region = "ap-south-1"
    dynamodb_table = "test"
  }
}
