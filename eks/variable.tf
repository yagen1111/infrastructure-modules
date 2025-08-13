variable "env" {
    description = "env name"
    type        = string
}
variable "eks_version"{
    description = "EKS version"
    type        = string
}

variable "eks_name" {
    description = "EKS cluster name"
    type        = string
}
variable "subnet_ids" {
    description = "EKS cluster subnet IDs"
    type        = list(string)
}

variable "node_iam_policies" {
    description = "EKS node IAM policies"
    type        = map(any)
    default     = {
        1 = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
        2 = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
        3 = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
        4 = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
        5 = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
        # not recomed but for test
        6 = "arn:aws:iam::aws:policy/AdministratorAccess"
    }
}
variable "node_group" {
    description = "EKS node group configuration"
    type        = map(any)
}
variable "enable_irsa" {
    description = "Enable IAM Roles for Service Accounts (IRSA)"
    type        = bool
    default     = true
}
variable "enable_ebs_csi_driver" {
    description = "Enable EBS CSI driver with IRSA"
    type        = bool
    default     = true
}