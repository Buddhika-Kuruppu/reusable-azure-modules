resource "azurerm_private_dns_zone" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  for_each = var.virtual_network_links

  name                  = each.value.name
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.this.name
  virtual_network_id    = each.value.virtual_network_id
  registration_enabled  = each.value.registration_enabled
  tags                  = var.tags
}

resource "azurerm_private_dns_a_record" "this" {
  for_each = var.a_records

  name                = each.value.name
  resource_group_name = var.resource_group_name
  zone_name           = azurerm_private_dns_zone.this.name
  ttl                 = each.value.ttl
  records             = each.value.records
  tags                = var.tags
}

resource "azurerm_private_dns_aaaa_record" "this" {
  for_each = var.aaaa_records

  name                = each.value.name
  resource_group_name = var.resource_group_name
  zone_name           = azurerm_private_dns_zone.this.name
  ttl                 = each.value.ttl
  records             = each.value.records
  tags                = var.tags
}

resource "azurerm_private_dns_cname_record" "this" {
  for_each = var.cname_records

  name                = each.value.name
  resource_group_name = var.resource_group_name
  zone_name           = azurerm_private_dns_zone.this.name
  ttl                 = each.value.ttl
  record              = each.value.record
  tags                = var.tags
}

resource "azurerm_private_dns_mx_record" "this" {
  for_each = var.mx_records

  name                = each.value.name
  resource_group_name = var.resource_group_name
  zone_name           = azurerm_private_dns_zone.this.name
  ttl                 = each.value.ttl
  tags                = var.tags

  dynamic "record" {
    for_each = each.value.records
    content {
      preference = record.value.preference
      exchange   = record.value.exchange
    }
  }
}

resource "azurerm_private_dns_ptr_record" "this" {
  for_each = var.ptr_records

  name                = each.value.name
  resource_group_name = var.resource_group_name
  zone_name           = azurerm_private_dns_zone.this.name
  ttl                 = each.value.ttl
  records             = each.value.records
  tags                = var.tags
}

resource "azurerm_private_dns_srv_record" "this" {
  for_each = var.srv_records

  name                = each.value.name
  resource_group_name = var.resource_group_name
  zone_name           = azurerm_private_dns_zone.this.name
  ttl                 = each.value.ttl
  tags                = var.tags

  dynamic "record" {
    for_each = each.value.records
    content {
      priority = record.value.priority
      weight   = record.value.weight
      port     = record.value.port
      target   = record.value.target
    }
  }
}

resource "azurerm_private_dns_txt_record" "this" {
  for_each = var.txt_records

  name                = each.value.name
  resource_group_name = var.resource_group_name
  zone_name           = azurerm_private_dns_zone.this.name
  ttl                 = each.value.ttl
  tags                = var.tags

  dynamic "record" {
    for_each = each.value.records
    content {
      value = record.value
    }
  }
}
