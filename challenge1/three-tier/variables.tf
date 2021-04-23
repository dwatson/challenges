variable "project" {
    type        = string
    description = "GCP Project name"
}

variable "region" {
    type        = string
    description = "GCP Region for deploy"
}

variable "zone" {
    type = string
    description = "GCP Zone for deploy"
}

variable "prefix" {
    type        = string
    description = "Uniquie identifier for deploy"
}

variable "app_tier_count" {
    type = number
    description = "Number of app tier instances"
}

variable "app_tier_machinetype" {
    type = string
    description = "Machine typefor app tier instances"
    default = "f1-micro"
}

variable "data_tier_machinetype" {
    type = string
    description = "Machine typefor data tier instances"
    default = "db-f1-micro"
}