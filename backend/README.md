# Terraform Backend Bootstrap

This directory bootstraps the Terraform remote backend infrastructure.

## Why local state is used here
Terraform requires backend infrastructure before it can use a remote backend.
This folder intentionally uses local state to create:
- An S3 bucket for Terraform state
- A DynamoDB table for state locking

This is a documented, one-time exception.

## Rules
- Run this Terraform only once
- Never use this folder for application or network resources
- Never add environment logic here
- Do not destroy backend resources after creation

## After bootstrap
All other Terraform code must use the remote backend with:
- S3 state storage
- DynamoDB locking

Local state usage outside this folder is forbidden.
