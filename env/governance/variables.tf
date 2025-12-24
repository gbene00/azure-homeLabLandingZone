## Azure Environment Variable
variable "environment" {
  description = "Deployment environment (dev, tst, acc, prd)"
  type        = string
  default     = "dev"
}
