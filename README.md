# Simple IBM Cloud VPC deployment using Terraform 

This repository will deploy the following resources:
 - 1 VPC 
 - 2 Public Gateways and 2 subnets (1 of each in every zone)
 - 1 SSH Key
 - 1 Compute Instance 
 - 1 Transit Gateway with a single connection defined for our VPC

## Pre-Reqs

- An [IBM Cloud API Key][api-key].
- [Terraform installed][tf-install]. 
- (Optional) The name of an existing VPC SSH Key in the region. If none provided, one will be created.
- (Optional) The name of an existing Resource Group for the deployed resources. If none provided, one will be created.

> If you cannot install Terraform locally, you can use [IBM Cloud Shell][cloud-shell] to deploy this example code. 

## Deploy all resources

Clone the repository to get started:

   ```sh
   git clone https://github.com/cloud-design-dev/simple-ibmcloud-vpc-example.git
   cd simple-ibmcloud-vpc-example
   ```

### Step 1: Provide variables for the deployment

The provided `terraform.tfvars.example` file contains all the variables that can be used to customize the deployment. Copy the file to `terraform.tfvars` and update the values as needed. See [inputs](#inputs) for available options

   ```sh
   cp terraform.tfvars.example terraform.tfvars
   ```

### Step 2: Generate Terraform Plan:

Initialize the deployment and generate a plan for the deployment by running the following commands:

   ```sh
   terraform init
   terraform plan -out default.tfplan
   ```

> The `init` subcommand will download the needed Terraform providers from the official registry. This code is currently tested against version `1.45.1` of the IBM Cloud provider and Terraform version `1.2.9`.

### Step 3: Apply generated Terraform plan:

If our plan generated successfully, we can now apply it and deploy the resources by running the following command:

   ```sh
   terraform apply default.tfplan
   ```

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ibmcloud\_api\_key | IBM Cloud API key used to deploy resources. | `string` | n/a | yes |
| prefix | Name that will be prepended to all deployed resources. | `string` | n/a | yes |
| region | IBM Cloud VPC region for deployed resources. | `string` | n/a | yes |
| classic\_access | Specify if you want to create a VPC that can connect to classic infrastructure resources. | `bool` | `false` | yes |
| default\_address\_prefix | Indicates whether a default address prefix should be created automatically `auto` or manually `manual` for each zone in this VPC. | `string` | `auto` | yes |
| existing\_resource\_group | Name of an existing resource group to associate with all deployed resources. If none provided, one will be created for you. | `string` | n/a | no |
| existing\_ssh\_key | Name of an existing VPC ssh key for the region. If not provided a new key will be generated and attached to the VPC. | `string` | n/a | no |
| compute\_image | Name of the image to use for the compute instance. | `string` | `ibm-ubuntu-20-04-minimal-amd64-2` | no |
| tags | Default tags to add to all resources. | `list(string)` | `provider:ibm` | no |

[api-key]: https://cloud.ibm.com/docs/account?topic=account-userapikey&interface=ui#create_user_key
[tf-install]: https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started
[cloud-shell]: https://cloud.ibm.com/shell
