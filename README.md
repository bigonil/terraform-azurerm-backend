### 📄 `terraform-backend-azurerm/README.md`

````markdown
# Terraform Backend Module for AzureRM 💠

This module provisions Azure infrastructure to support **remote Terraform state storage** and **locking**, using:

- 🔐 Azure Blob Storage for storing `.tfstate`
- 🔒 Native Azure Blob Lease for state locking (no extra DB required)

---

## 📦 Features

- Creates a dedicated **Azure Resource Group**
- Deploys a **globally unique Azure Storage Account**
- Creates a **private Blob Storage Container** for storing Terraform state
- Adds a **random suffix** to ensure uniqueness of the storage account
- Includes **input validation** to prevent misconfigured names
- Modular, taggable, reusable across environments (`dev`, `stage`, `prod`)

---

## 🚀 Usage

```hcl
module "backend" {
  source                 = "./terraform-backend-azurerm"
  location               = "eastus"
  resource_group_name    = "terraform-backend-dev"
  storage_account_prefix = "tfstateprod"
  container_name         = "tfstate"

  tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
````

### 💡 After Applying

Manually configure your backend in the root Terraform project:

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-backend-dev"
    storage_account_name = "tfstateprod3a7c5b"  # <- use module output
    container_name       = "tfstate"
    key                  = "envs/dev/terraform.tfstate"
  }
}
```

> Run `terraform init` after setting the backend block.

---

## 🔧 Input Variables

| Name                     | Type          | Description                                                                        | Default     |
| ------------------------ | ------------- | ---------------------------------------------------------------------------------- | ----------- |
| `location`               | `string`      | Azure region to deploy resources into                                              | `"eastus"`  |
| `resource_group_name`    | `string`      | Name of the Azure Resource Group                                                   | *required*  |
| `storage_account_prefix` | `string`      | Prefix for the storage account — must be ≤18 chars, lowercase letters/numbers only | *required*  |
| `container_name`         | `string`      | Name of the blob container used for Terraform state                                | `"tfstate"` |
| `tags`                   | `map(string)` | Tags to apply to resources                                                         | `{}`        |

### 🛡 Validation

This module enforces:

* Max length for `storage_account_prefix` (≤18 characters)
* Only lowercase letters and numbers for `storage_account_prefix`

---

## 📤 Outputs

| Name                   | Description                        |
| ---------------------- | ---------------------------------- |
| `resource_group_name`  | Name of the created resource group |
| `storage_account_name` | Final storage account name         |
| `container_name`       | Name of the blob container         |

---

## ✅ Requirements

* Terraform v1.0+
* AzureRM Provider v3.x+
* Azure CLI or Service Principal for authentication

---

## 🔐 State Locking

This module uses [Azure Blob Lease Locking](https://learn.microsoft.com/en-us/azure/storage/blobs/lease-container) — no need for a DynamoDB or external locking system 🎉

---

## 🧪 Testing Example Prefix

Valid:

```hcl
storage_account_prefix = "tfstatedev"
```

Invalid:

```hcl
storage_account_prefix = "terraform-backend-storage"  # ❌ too long + contains dashes
```

---

## 📘 License

Apache 2.0 — feel free to fork, improve, and contribute.

---

## ✨ Authors

Maintained by \[Your Name or Organization] with ❤️ from the cloud ☁️