# Infrastructure Repository

---

## What this repository is for

Infrastructure code defines the cloud foundation of the organization.  
It includes provisioning scripts, automation workflows, and configuration files that shape the platform running applications.

### How environments are separated

Infrastructure is deployed in multiple stages such as development, staging, and production.  
Each environment uses different configuration values and is updated in order to catch issues early.  

---

## What type of changes are allowed

- Infrastructure configuration files 
- Networking, access rules, and scaling configurations
- Environment setup and platform documentation
- CI/CD infrastructure components

All changes must go through a Pull Request and clearly state **what changed and why**.

---

## What changes are NOT allowed

- Application source code, business logic, frontend or backend services
- Secrets, passwords, tokens, API keys, certificates
- Experimental changes that are not related to infrastructure

If a change does not affect infrastructure, it does not belong here.

### How secrets are handled

Secrets are never stored inside this repository.  
They are managed using secure secret storage systems and injected at deployment time.  
If a secret is committed accidentally, it must be revoked and replaced immediately to avoid exposure.

---

## What happens when things fail

If infrastructure components fail or become unreachable, workloads shift to backup resources where possible.  
Users may see slower responses or temporary outages while systems recover, depending on the severity of the failure.  
Product teams may pause releases until stability returns to prevent further impact.

---

## How rollback or recovery works

When failures occur, the last known stable infrastructure state is restored instead of fixing components individually.  
Automation rebuilds or replaces affected resources to match that stable version across environments.  
Rollback keeps production working while updated changes are retested safely.

---

## Who is impacted by failure

Service interruptions can affect customers and delay releases.  
Internal teams may need to coordinate fixes, but protecting production availability remains the top priority.

---
