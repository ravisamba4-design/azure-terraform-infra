# Azure Infrastructure with Terraform

Reusable Terraform deployment of a secure Azure environment, built at zero cost.

## What it builds
- Virtual network with public and private subnets
- NSGs: public subnet allows HTTPS only; private subnet denies all Internet inbound
- Linux VM in the private subnet with no public IP, SSH keys only
- Storage account locked to the private subnet (default deny, service endpoint)
- Log Analytics workspace (0.1 GB/day cap), NSG diagnostic logs, CPU alert by email
- Remote state in an Azure Storage account (blob versioning on)

## Architecture

    Internet --443--> snet-public  (NSG: HTTPS only)
                      snet-private (NSG: deny Internet inbound)
                         |-- Linux VM (no public IP)
                         |-- service endpoint --> Storage (default deny)
    Log Analytics <-- NSG logs;  CPU alert --> email

## How exposure is limited
- No public IP on the VM
- Explicit deny-Internet rule on the private NSG
- Storage account denies all traffic except the private subnet
- Password login disabled, SSH keys only
- Log ingestion capped to avoid cost

## Usage

    cp terraform.tfvars.example terraform.tfvars   # fill in your values
    terraform init -backend-config=backend.hcl
    terraform fmt && terraform validate
    terraform plan -out=tfplan
    terraform apply tfplan

## Teardown

    terraform destroy

## Lessons learned
The network, NSGs, storage and monitoring deployed successfully. VM creation hit
SkuNotAvailable (Azure capacity shortage) in several UK regions and sizes on a
free subscription. Because vm_size, location and zone are variables, the fix is
to retry with another size or region.
