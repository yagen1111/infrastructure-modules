variable "env" {
  description = "The environment for the deployment"
  type        = string
}

variable "cluster_autoscaler_helm_version" {
  description = "The Helm chart version for the cluster autoscaler"
  type        = string
}
 
variable "eks_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "enable_cluster_autoscaler" {
  description = "to deploy the cluster autoscaler ?"
  type        = bool
  default     = true
}
variable "openid_provider_arn" {
  description = "The ARN of the OpenID provider"
  type        = string
}
variable "enable_ebs_csi_driver" {
  description = "Enable EBS CSI driver"
  type        = bool
  default     = true
}

variable "ebs_csi_driver_helm_version" {
  description = "EBS CSI driver Helm chart version"
  type        = string
  default     = "2.35.1"
}


variable "enable_aws_load_balancer_controller" {
  description = "Enable AWS Load Balancer Controller"
  type        = bool
  default     = true
}

variable "enable_ingress_nginx" {
  description = "Enable Ingress Nginx"
  type        = bool  
  default     = true
}


variable "ssl_certificate_arn" {
  description = "ACM SSL certificate ARN"
  type        = string
  default     = ""
}
variable "vpc_id" {
  description = "VPC ID where the EKS cluster is deployed"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}
# ... existing code ...

variable "enable_external_secrets" {
  description = "Enable External Secrets Operator"
  type        = bool
  default     = true
}

variable "external_secrets_role_arn" {
  description = "IAM role ARN for External Secrets to access AWS Secrets Manager"
  type        = string
  default     = ""
}