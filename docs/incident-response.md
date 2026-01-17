# Incident Response Guide
_Last Updated: 2025-12-27_

## What qualifies as an incident
An incident is an unexpected event that impacts users or critical systems.
Examples: service outage, major errors, data issues, security alerts, bad deploy.
If users are blocked or data is at risk, treat it as an incident immediately.

## Who responds first
The on-call engineer responds first; if none, the last deployer does.
First responder tasks:
1. Confirm the incident and pause ongoing changes
2. Inform the team and open an incident channel
3. Start initial investigation or delegate

## Communication steps
All updates happen in a shared channel (e.g., `#incidents`) for visibility.
Declare using: `INCIDENT DECLARED — <summary> — <time> — <first responder>`
Assign roles: Incident Lead coordinates, Comms Lead posts updates every 15–30 min.
Share new information quickly and avoid private messages.
Close using: `INCIDENT RESOLVED — <summary> — <time>`

## Rollback authority
The Incident Lead can trigger rollback if the latest change caused the issue.
If the lead is unavailable, the on-call engineer may roll back without delay.
Fast rollback is better than long debugging when users are impacted.

## Blameless culture
We fix the issue first, then learn from it without blaming individuals.
Blame slows learning; transparency and honesty speed recovery.
A short review explains what happened and how to prevent repeats.

## Incident flow summary
Detect → Acknowledge → Declare → Communicate → Fix or Rollback → Close → Review

## Expectations
Respond quickly, communicate clearly, prioritize users, and avoid blame.
