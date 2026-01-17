# ADR — Branching Strategy Decision
Date: 2025-12-27  
Status: Accepted

## Problem
We need a clear way for developers to collaborate without creating confusion or breaking the main code.  
If branches are created randomly or merged without structure, reviews become messy and the main branch can become unstable.  
Since multiple people may work at the same time, we need a branching strategy that keeps the main branch reliable but still supports quick progress.

## Options Considered
**1. GitFlow**
- Separate branches for features, releases, and hotfixes  
- Good for large release cycles  
- But feels heavy for smaller teams and slows down frequent changes

**2. Trunk-Based Development**
- Developers branch from `main` and merge back often  
- Encourages small, frequent contributions and keeps `main` always deployable  
- Needs discipline for regular merges and code reviews

**3. GitHub Flow**
- Simple model using only `main` and feature branches  
- Easy for beginners, but lacks structure around releases

## Final Decision
We will use **Trunk-Based Development** with `main` as the single long-lived branch.  
All work is done in short-lived feature branches and merged back after review and checks.  
This supports steady progress, keeps `main` clean, and works well with CI/CD automation.  
Branch naming will follow: `feature/<name>`, `fix/<name>`, or `chore/<name>`.

## Risks
- If developers do not merge frequently, branches may drift away from `main`  
- Requires consistent communication to make sure small commits flow smoothly
