# ADR — Repository Separation Decision
Date: 2025-12-27  
Status: Accepted

## Problem
Initially, the plan was to keep the application code, infrastructure setup, and CI/CD workflows in one single repository.  
While this feels simple at the start, it becomes harder to manage as the work grows.  
Changes made for the app can accidentally affect infrastructure or CI/CD files, and reviewers get distracted by unrelated updates.  
Team members who only want to work on the application code don’t always need to touch infra or pipelines, yet everything stays mixed together.  
To make work easier and more organized, we need to decide whether each area should have its own repository.

## Options Considered
**1. Keep everything in one repository**  
- Very straightforward setup, one place to look  
- But high chance of accidental edits and noisy history  
- Reviews become heavier and pipelines run even when not needed

**2. Create separate repositories for app, infra, and CI/CD**  
- Responsibilities are clearly separated  
- Reviews are simpler because the context is specific  
- Pipelines run only when relevant files change  
- Slightly more initial effort to maintain multiple repos

## Final Decision
We will **separate the work into three repositories**:
- `app` → application code  
- `infra` → infrastructure configuration and governance 
- `cicd` → reusable automation, workflows, and pipeline logic  
This structure gives each area its own space and makes collaboration cleaner and less confusing.

## Risks
- Extra effort is required at the start to create and manage multiple repositories  
- Developers must follow boundaries to avoid duplication  
- Documentation and communication need to stay consistent so everyone knows where things belong
