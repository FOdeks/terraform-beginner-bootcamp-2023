variable "terratowns_endpoint" {
  type = string
}

variable "teacherseat_user_uuid" {
  type = string
}

variable "terratowns_access_token" {
  type = string
}

variable "smoothjazz" {
  type = object({
    public_path     = string
    content_version = number
  })
}

variable "crabdish" {
  type = object({
    public_path     = string
    content_version = number
  })
}