### 📄 `terraform-backend-azurerm/README.md`

````
# Terraform Backend Module for AzureRM 💠

This module provisions the required Azure infrastructure to support **remote Terraform state storage** and **state locking** using:

- 🔐 Azure Blob Storage (as backend)
- 🔒 Native Azure Blob Lease (for locking – no external DB required)

---

## 📦 Features

- Creates an **Azure Resource Group**
- Creates a globally unique **Azure Storage Account**
- Creates a **Blob Storage Container** for state files
- Automatically enables secure settings (no public access)
- Supports tagging, region config, and modular reuse

---

## 🚀 Usage

```hcl
module "backend" {
  source                 = "./terraform-backend-azurerm"
  location               = "eastus"
  resource_group_name    = "terraform-backend-dev"
  storage_account_prefix = "tfstate"
  container_name         = "tfstate"

  tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
````

After applying the module, configure your backend in the root project:

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-backend-dev"
    storage_account_name = "tfstatea1b2c3"    # <- output from module
    container_name       = "tfstate"
    key                  = "envs/dev/terraform.tfstate"
  }
}
```

> 💡 Remember: Backend config must be manually added and initialized using `terraform init`.

---

## 🔧 Input Variables

| Name                     | Type          | Description                                          | Default      |
| ------------------------ | ------------- | ---------------------------------------------------- | ------------ |
| `location`               | `string`      | Azure region                                         | `"eastus"`   |
| `resource_group_name`    | `string`      | Name of the resource group                           | **required** |
| `storage_account_prefix` | `string`      | Prefix for storage account (must be globally unique) | **required** |
| `container_name`         | `string`      | Blob container name                                  | `"tfstate"`  |
| `tags`                   | `map(string)` | Tags to apply to all resources                       | `{}`         |

---

## 📤 Outputs

| Name                   | Description                        |
| ---------------------- | ---------------------------------- |
| `resource_group_name`  | Name of the created resource group |
| `storage_account_name` | Final storage account name         |
| `container_name`       | Name of the blob container         |

---

## ✅ Requirements

* Terraform 1.0+
* AzureRM Provider 3.x+
* Azure Subscription with sufficient privileges

---

## 🔐 Locking

This module relies on [Azure Blob Lease locking](https://learn.microsoft.com/en-us/azure/storage/blobs/lease-container) — **no need for a separate lock table or DB** 🎉

---

## 📘 License

Apache 2.0 — feel free to fork, modify, and contribute!

---

## ✨ Authors

Module maintained by \[Your Name or Org] with ❤️ from the cloud ☁️

```

---

Let me know if you want:

- A **versioned release example** (`v1.0.0`)
- A **GitHub Actions workflow** to validate PRs and changes
- Conversion to a **Terraform Registry**-compatible module (`terraform-azurerm-backend`)

🔨🤖 Ready to ship when you are!
```
