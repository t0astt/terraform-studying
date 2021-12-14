/*
Terraform loads all files in the current directory ending in .tf, so config file names can be whatever you want.
*/

variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ExampleAppServerInstance"
}
