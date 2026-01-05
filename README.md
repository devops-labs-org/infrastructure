# Infrastructure Repository

---

## 1. What this repository is for

This repository defines **AWS network infrastructure using Terraform**.  
It is responsible for creating and managing the **VPC, subnets, routing, security groups, and validation compute**.

This repo is treated as **shared platform code** used by multiple engineers and environments.  
Changes here affect the foundation of all workloads.

---

## 2. What changes are allowed

- Terraform infrastructure code
- Network, security, and routing configuration
- Environment definitions (dev / stage / prod)
- Documentation related to infrastructure behavior

All changes must be:
- Made via Pull Request
- Reviewed before merge
- Clearly explained (what + why)

---

## 3. What changes are NOT allowed

- Application or service code
- Secrets, passwords, API keys
- Temporary experiments
- Manual AWS Console changes

This repository is **Terraform-only** and infrastructure-focused.

---

## 4. Architecture Decisions

The network follows a **layered design** to reduce risk and improve clarity.

Three layers are used:
- **Public** – entry points only (ALB, NAT, IGW)
- **App** – private compute workloads
- **Data** – databases and stateful services

Each layer has its own:
- Subnets
- Route tables
- Security groups

This prevents accidental access and limits blast radius.

---

## 5. CIDR Strategy

The VPC uses: 10.0.0.0/16


This CIDR was chosen to:
- Avoid future rework
- Support multiple environments
- Allow long-term scaling

Subnets are split by purpose:
- Smaller CIDRs for public access
- Larger CIDRs for application workloads
- Isolated CIDRs for data

Extra CIDR space is reserved for future growth.

---

## 6. How Routing Works

Routing is explicit and minimal:

- **Public subnets**
  - Route to Internet Gateway
  - Used only for ingress and NAT

- **App subnets**
  - Route to NAT Gateway
  - No inbound internet access

- **Data subnets**
  - No internet routes
  - Internal access only

There is no accidental cross-layer routing.

---

## 7. NAT Gateway Strategy

A single NAT Gateway is used in the dev environment to balance
cost and functionality.

Why one NAT:
- Dev workloads are non-critical
- Reduces cost while still allowing outbound access
- Simpler to operate and troubleshoot

AZ failure impact:
- If the AZ hosting the NAT fails, outbound internet access
  from private subnets is temporarily unavailable
- Inbound traffic is NOT affected

Production consideration:
- Production environments should use one NAT per AZ
  to avoid single-AZ dependency

Cost note:
- NAT Gateways incur hourly and data processing charges
- Using one NAT in dev keeps costs controlled

---

## 8. How Security Is Enforced

Security is enforced using **least privilege**:

- No default security groups
- Separate security groups per layer
- Ingress allowed only from required sources

Rules follow this flow:
- Internet → ALB
- ALB → App
- App → Data

Direct internet access to private layers is blocked.

---

## 9. How to Add or Scale Safely

### Add a new subnet
- Add CIDR to the subnet module
- Associate it with the correct route table
- Apply Terraform

### Add a new Availability Zone
- Add AZ to environment config
- Terraform creates matching subnets automatically

### Add a new environment
- Copy `environments/dev`
- Change backend state key
- Keep the same CIDR structure
- No module changes needed

---

## 10. How to Safely Run Terraform

Always run Terraform from an environment directory.

Recommended flow:

```bash
terraform init
terraform plan
terraform apply


