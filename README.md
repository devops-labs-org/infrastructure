# Infrastructure Repository

---

## What this repository is for

This repository is used to store **infrastructure-related files only**.
It contains configurations, scripts, and documents that define how systems are created, connected, and managed.

---

## What type of changes are allowed

- Infrastructure configuration files
- Environment setup documentation
- CI/CD infrastructure definitions
- Access, networking, or resource-related configs

All changes must be made through a Pull Request and should explain **what changed and why**.

---

## What changes are NOT allowed
- Application source code
- Business logic or feature changes
- Frontend or backend service code
- Secrets, passwords, API keys, or tokens
- Temporary experiments or personal files

If something is not related to infrastructure, it does not belong in this repository.---

## What happens when things fail

When parts of the infrastructure break, the system automatically shifts work to backup machines or routes to keep things running.  
Data issues may slow down writes or cause short delays, but the platform tries to protect data and stay usable.  
If failures stack up or backups can't keep up, customers may see slow responses or temporary service outages until recovery completes.

---

## How rollback or recovery works

When something goes wrong, we restore the last known stable infrastructure setup instead of fixing pieces one-by-one.  
The system then rebuilds or replaces broken parts automatically to match that stable state.  
If the restored state is outdated or missing recent changes, some services may briefly behave differently until updates are re-applied safely.

---

## Who is impacted by failure

If the infrastructure breaks and backups can’t fully cover the load, customers may face slow responses or short outages.  
Product teams might need to pause new releases until the platform becomes stable again.  

---

## Risk if misused

If someone adds application code or secrets in this repo, sensitive data could be exposed or the platform could behave unpredictably.  
Wrong changes here might break core infrastructure and make recovery harder during an outage.  
Keeping this repo focused only on infrastructure is important to avoid security leaks and prevent failures that affect everyone.

---
