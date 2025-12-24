# Infrastructure Security Guidelines

This repository manages infrastructure settings used by shared and production environments.
If security issues here are handled wrongly, they can affect many systems at once.

---

## How to raise a security concern
If you notice a security weakness related to infrastructure,
do not fix it directly in the main branch.

Contact the infrastructure owners privately
and explain the issue with enough context to understand the risk.
Avoid sharing details in public issues or pull requests.

---

## Information to provide
- Which environment or resource is affected
- What misconfiguration or access issue you observed
- When and where the issue was noticed
- Whether production systems could be impacted

---

## Important restrictions
- Never commit secrets, keys, or access tokens
- Do not test security issues on production systems
- Do not apply emergency fixes without approval

---

## Handling and resolution
Infrastructure maintainers will assess the risk,
plan a safe fix, and apply changes through a reviewed process.
