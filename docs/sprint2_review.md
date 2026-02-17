# Sprint 2 Review

## Sprint Goal
Apply Sprint 1 retrospective feedback, improve observability, and deliver the next functional increment of the Task Tracker API.

## Planned vs Actual
- Planned stories: US-3, US-5, US-6 (8 SP total).
- Completed stories: US-3, US-5, US-6 (8 SP completed).
- Sprint outcome: Goal achieved; planned process improvements were implemented alongside feature delivery.

## Sprint 1 Improvement Actions and Status
1. Standardize API conventions before coding.
   - Status: Completed.
   - Evidence: endpoints now return consistent JSON error payloads for validation/not-found scenarios.
2. Add baseline observability.
   - Status: Completed.
   - Evidence: `/health` endpoint exposes service status and lightweight metrics (`requests`, `errors`, `task_count`); logging added for key task state changes.
3. Improve review readiness.
   - Status: Completed.
   - Evidence: acceptance checks and artifact mapping explicitly documented in this review.

## Completed Stories
- US-3: Mark task complete (`PATCH /tasks/{id}/complete`)
- US-5: Health and basic metrics (`GET /health`)
- US-6: Task summary endpoint (`GET /tasks/summary`)

## Acceptance Criteria Check
- US-3: Met.
  - Existing task completion sets `completed=true` and writes `completed_at`.
  - Completing unknown task returns `404` JSON error.
- US-5: Met.
  - `/health` returns `status`, `timestamp`, and metrics (`requests`, `errors`, `task_count`).
- US-6: Met.
  - `/tasks/summary` returns accurate `total`, `completed`, `pending` aggregates based on current task state.

## Delivered Increment
- Task lifecycle now supports completion state transitions.
- Health and runtime counters are available for basic operational monitoring.
- Summary endpoint provides quick progress visibility without scanning full task lists.
- Logging captures key domain events (task creation/completion) for traceability.

## Evidence (Repository Artifacts)
- Feature implementation: `app/main.py`
- Tests validating flow and monitoring endpoint: `tests/test_app.py`
- CI validation on push/PR: `.github/workflows/ci.yml`

## DevOps Outcomes
- Continuous verification remained active through Sprint 2 using the existing CI pipeline.
- Observability baseline established (health endpoint + metrics + logs), improving operational confidence.
- Regression risk reduced by extending automated tests to cover Sprint 2 behavior.

## Demo Script
1. Create two tasks via `POST /tasks`.
2. Complete one task via `PATCH /tasks/1/complete`.
3. Validate aggregates via `GET /tasks/summary` (expect total=2, completed=1, pending=1).
4. Inspect `GET /health` response for status and runtime counters.

## Remaining Gaps / Deferred Work
- In-memory storage means data is reset when service restarts.
- No authentication/authorization for multi-user use.
- No deployment pipeline to staging/production yet.

These items are intentionally deferred to a future iteration and captured in the final retrospective.
