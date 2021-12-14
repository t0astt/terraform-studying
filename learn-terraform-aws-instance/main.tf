
/*
Terraform block contains terraform settings, inc. required providers terraform will use to provision the infra.
*/
terraform {
  required_providers {
    aws = {
      # Source defines optional hostname, namespace, and provider type
      # Providers are installed from terraform registry (https://registry.terraform.io/) by default
      # Source below is shorthand for registry.terraform.io/hashicorp/aws
      source = "hashicorp/aws"

      # Recommended to constrain version to ensure terraform doesn't install a provider version that doesn't work
      # with your config.
      # If version attribute is omitted, terraform will use the latest version.
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

/*
Configures the specified provider.
A provider is a plugin that Terraform uses to create & manage resources
Multiple provider blocks can be configured
*/
provider "aws" {
  profile = "default" # Refers to the AWS creds stores in the AWS config file
  region  = "us-west-2"
}

/*
Resource block defines components of your infrastructure.
Can be physical or virtual components, such as EC2 instance or logical resource like an Heroku app.

Resource blocks have two strings before the block - the resource type and the resource name.
In this example, the type is "aws_instance" and the name is "app_server".
The prefix of the type maps to the name of the provider - in this example, terraform manages the "aws_instance" with
the "aws" provider.
Here, the ID for the EC2 instance will be aws_instance.app_server

Resource blocks contain args to configure a resource.
*/
resource "aws_instance" "app_server" {
  /*
  AMI ID of an Ubuntu image.
  AWS provider knows it can't change the AMI of an instance after creation, so Terraform will destroy the old instance
  and create a new one if this is changed.
  */
  ami           = "ami-08d70e59c07c61a3a"
  instance_type = "t2.micro"              # instance type that qualifies for AWS free tier

  tags = {
    Name = "ExampleAppServerInstance" # Tags the instance
  }
}

