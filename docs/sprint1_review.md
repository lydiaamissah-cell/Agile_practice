# Sprint 1 Review

## Sprint Goal
Deliver the first working increment of the Task Tracker API and establish CI quality checks.

## Planned vs Actual
- Planned stories: US-1, US-2, US-4 (10 SP total).
- Completed stories: US-1, US-2, US-4 (10 SP completed).
- Sprint outcome: Goal achieved; first increment is operational and test-validated.

## Completed Stories
- US-1: Create task endpoint (`POST /tasks`)
- US-2: List tasks endpoint (`GET /tasks`)
- US-4: CI pipeline + automated tests

## Delivered Increment
- Flask API project scaffolded with clear module structure.
- Task creation endpoint implemented with title validation and JSON error response on invalid input.
- Task listing endpoint implemented for immediate visibility of all tasks in memory.
- Automated test suite created to cover:
  - successful task creation,
  - validation failure path for empty title,
  - basic endpoint behavior verification.
- GitHub Actions CI workflow configured to run `pytest` on push and pull request to `main`.

## Acceptance Criteria Check
- US-1: Met.
  - Valid title returns `201` and task payload.
  - Invalid/empty title returns `400`.
- US-2: Met.
  - Endpoint returns `200` and JSON array of tasks.
- US-4: Met.
  - CI workflow installs dependencies and executes tests automatically.

## Evidence (Repository Artifacts)
- API implementation: `app/main.py`
- Tests: `tests/test_app.py`
- Pipeline: `.github/workflows/ci.yml`

## DevOps Outcomes
- Quality gate introduced: test execution is automated in CI, reducing manual verification load.
- Feedback loop improved: failing tests block unhealthy changes before merge.

## Known Gaps After Sprint 1
- Task completion flow not yet implemented.
- No explicit health/monitoring endpoint yet.
- Aggregate progress view (summary counts) not yet available.

These gaps were intentionally deferred to Sprint 2 per backlog priority.

## Demo Notes
1. Send `POST /tasks` with `{ "title": "Write test" }` and confirm `201`.
2. Send `GET /tasks` and confirm created task appears in returned list.
3. Trigger CI via push/PR and confirm `pytest` step runs and passes.
