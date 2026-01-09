static_site = {
  enabled = true

  storage_account = {
    name = "azlzonlineweb001"
    # optional fields can be omitted safely
    # account_tier             = "Standard"
    # account_replication_type = "LRS"
    # index_document           = "index.html"
    # error_404_document       = "404.html"
  }

  cdn = {
    enabled = false
    profile_name  = null
    endpoint_name = null
  }
}
