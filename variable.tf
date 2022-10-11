variable "private_subnet" {
  type = list
}

variable "public_subnet" {
  type = list
}

variable "app_port" {
  type = string
  default = "5000"
}

variable "image_tag" {
  type = string
  default = "latest"
}

variable "ecs_task_count" {
  type = string
  default = "2"
}

variable "ecs_task_cpu" {
  type = number
  default = 256
}

variable "ecs_task_memory" {
  type = number
  default = 512
}

variable "db_create" {
  type = bool
  default = false
}

variable "db_username" {
  type = string
  sensitive = true
  default = "app22"
}

variable "db_password" {
  type = string
  sensitive = true
  default = "app22"
}

variable "shared_config_files" {
  type = string
  sensitive = true
}

variable "shared_credentials_files" {
  type = string
  sensitive = true
}