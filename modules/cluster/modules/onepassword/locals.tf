locals {
  values = {
    connect = {
      credentials = jsonencode(var.credentials)
    }
    operator = {
      create = true
      token = {
        value = var.token
      }
    }
  }
}
