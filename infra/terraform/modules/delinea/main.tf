# Mapping delinea secrets name with name and delinea fields
locals {
  flat_field_details = flatten([for secret in var.dlsecret : [
    for field in secret.fields : {
      name  = secret.name
      id    = secret.id
      field = field
    }
  ]])
}

# Assuming each element in local.flat_field_details is a map with 'id' and 'field' keys
data "tss_secret" "secret_field" {
  for_each = { for idx, val in local.flat_field_details : "${val.name}_${val.field}" => val }
  id       = each.value.id
  field    = each.value.field
}
