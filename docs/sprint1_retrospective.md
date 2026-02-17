# Sprint 1 Retrospective

## Sprint Context
Sprint 1 focused on establishing the first functional increment and CI baseline.
Primary delivery pressure came from balancing feature implementation (US-1, US-2) with DevOps setup (US-4).

## What Went Well
- Backlog clarity and acceptance criteria reduced uncertainty during implementation.
- Prioritizing CI in Sprint 1 created an early quality gate for later sprints.
- Core API flow (create + list) was delivered without scope creep.

## What Did Not Go Well
- Error response consistency was decided during coding rather than defined upfront.
- Operational concerns (health/metrics/logging) were identified late, creating avoidable rework risk.
- Manual verification evidence (what was tested and why) was not captured in a structured way.

## Root Causes
- Definition of API standards was missing from the sprint start checklist.
- Sprint tasks were story-focused but not explicit about non-functional requirements.
- Review preparation happened too close to sprint close, reducing documentation quality.

## Improvement Actions for Sprint 2
1. Standardize API conventions before coding.
   - Action: enforce consistent JSON error payloads across endpoints.
   - Success signal: all failure paths return predictable JSON shape.
2. Add baseline observability.
   - Action: implement `/health` endpoint with request/error/task counters and add key event logging.
   - Success signal: service status and basic runtime metrics are visible in one call.
3. Improve review readiness.
   - Action: update review notes during implementation, not only at sprint end.
   - Success signal: Sprint 2 review includes explicit acceptance checks and evidence links.

## Carry-Forward Plan into Sprint 2
- Deliver US-3 (complete task) and US-6 (summary) as next user-facing value.
- Deliver US-5 (health endpoint) to address observability gap.
- Validate improvements through updated tests and CI pass before sprint closure.
