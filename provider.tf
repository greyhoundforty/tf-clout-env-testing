terraform {
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "1.47.0-beta2"
    }
  }
}

provider "ibm" {
  region           = var.region
}
