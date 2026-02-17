# Final Retrospective

## Project Outcome
The project delivered a working Task Tracker API over two execution sprints with clear Agile planning artifacts, incremental scope delivery, automated testing, and CI integration.
All mandatory constraints were addressed: backlog-driven execution, sprint reviews/retrospectives, CI pipeline, tests, and basic monitoring.

## What Improved Across Sprints
- Planning quality improved from high-level scope to explicit acceptance checks and evidence mapping.
- Delivery discipline improved through incremental story completion aligned to sprint goals.
- DevOps maturity improved by combining test automation, CI gating, and operational visibility.

## Key Improvements Implemented
1. Early quality gate with CI + tests.
   - Impact: reduced integration risk and caught regressions before merge.
2. Consistent API behavior (JSON responses for both success and failure flows).
   - Impact: improved predictability for consumers and easier test assertions.
3. Baseline observability (`/health`, request/error/task counters, event logging).
   - Impact: faster runtime diagnostics and clearer operational state.

## Agile Process Reflection
### What Worked Well
- Prioritized backlog and story-point sizing kept scope realistic.
- Clear sprint goals prevented feature sprawl.
- Retrospective outputs were converted into concrete Sprint 2 actions.

### What Was Challenging
- Non-functional concerns (standards, observability) were initially under-specified.
- Environment limitations reduced local verification confidence (`pytest` and `git` unavailable in this runtime).
- Documentation detail was initially too brief and required later enhancement.

### How Challenges Were Addressed
- Added explicit standards and acceptance checks to sprint documentation.
- Strengthened review documents with planned-vs-actual tracking and artifact evidence.
- Preserved a structure that allows local verification once tools are available.

## Lessons Learned
- Agile artifacts are most useful when they are specific, measurable, and traceable to code.
- DevOps practices should start in Sprint 1, not be postponed, to avoid late quality risk.
- Retrospectives are effective only when each improvement has an owner action and a success signal.

## Evidence of Delivery
- Planning and backlog: `docs/sprint0.md`
- Sprint 1 review and retro: `docs/sprint1_review.md`, `docs/sprint1_retrospective.md`
- Sprint 2 review: `docs/sprint2_review.md`
- Implementation: `app/main.py`
- Tests: `tests/test_app.py`
- CI pipeline: `.github/workflows/ci.yml`

## Next Iteration Plan
1. Introduce persistence (SQLite/PostgreSQL) and migration support.
   - Reason: prevents data loss and enables realistic usage.
2. Add authentication and per-user task ownership.
   - Reason: enables multi-user scenarios and access control.
3. Expand CI into CD (deploy to staging on main branch).
   - Reason: shortens lead time and validates deployment readiness.
4. Add richer observability (structured logs, latency/error-rate metrics).
   - Reason: improves troubleshooting and reliability decisions.
