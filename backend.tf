terraform {
  backend "s3" {
    bucket         = "strike1" # Same bucket name as created above
    key            = "3-tier-app-infra/state/terraform.tfstate" # Path in the bucket for the state file
    region         = "us-west-2" # Same region as the bucket
    # dynamodb_table = "terraform-state-locks" # DynamoDB table for state locking
    encrypt        = true
  }
}