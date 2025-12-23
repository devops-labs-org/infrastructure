# Infrastructure Repository

# What this repository is for
This repository is used to store **infrastructure-related files only**.
It contains configurations, scripts, and documents that define how systems are created, connected, and managed.

The main goal is to **keep infrastructure separate from application code**.
This repository helps new and existing engineers understand how the environment is set up without digging into application logic.

---

# What type of changes are allowed
- Infrastructure configuration files
- Environment setup documentation
- CI/CD infrastructure definitions
- Access, networking, or resource-related configs

All changes must be made through a Pull Request and should explain **what changed and why**.

---

# What changes are NOT allowed
- Application source code
- Business logic or feature changes
- Frontend or backend service code
- Secrets, passwords, API keys, or tokens
- Temporary experiments or personal files

If something is not related to infrastructure, it does not belong in this repository.

---

# Who owns this repository
This repository is owned by the **Infrastructure / Platform team**.
Only approved maintainers can merge changes to the main branch.

All contributors are expected to follow the defined branching rules and review process.

---

# Risk if this repository is misused
If application code or secret data is added here by mistake,
it may be exposed to more people than intended.

This can lead to security leaks, accidental production outages,
or broken infrastructure that is hard to roll back during incidents.

Following repository boundaries is critical
to keep systems stable, secure, and recoverable.

---

# Final note
This repository is a shared responsibility.
Make changes carefully, document clearly, and always think about production impact.
