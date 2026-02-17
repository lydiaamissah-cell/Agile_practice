# Sprint 0 - Planning

## Product Vision
Build a lightweight Task Tracker API that helps users capture, view, and complete personal work items with minimal friction.
The service should be reliable, testable, and continuously validated through an automated CI pipeline so each change can be delivered safely and incrementally.

## Problem Statement
Many small personal or team tasks are tracked informally (notes, chat messages), which leads to poor visibility and missed follow-ups.
This prototype provides a minimal API layer to centralize task state and demonstrate Agile + DevOps delivery practices.

## Target Users
- Primary user: individual learner/developer who needs a simple task log.
- Secondary user: reviewer/assessor evaluating iterative delivery quality.

## Scope
- In scope:
  - Basic task lifecycle (create, list, complete).
  - Operational visibility (health + simple metrics).
  - CI automation for tests.
- Out of scope (for this iteration):
  - Persistent database storage.
  - Authentication/authorization.
  - Frontend UI.

## Assumptions
- API is used in a local/dev context with in-memory storage.
- JSON is the only supported payload/response format.
- A lightweight CI pipeline is sufficient for this assignment (build + tests).

## Product Backlog (Prioritized)

| Priority | Story ID | User Story | Acceptance Criteria | Estimate (SP) | Rationale |
|---|---|---|---|---|
| 1 | US-1 | As a user, I want to create a task so that I can capture work items. | `POST /tasks` accepts non-empty `title` and returns `201` with `id`, `title`, `completed`, `created_at`; empty or missing title returns `400` with JSON error. | 3 | Core business value and prerequisite for other stories. |
| 2 | US-2 | As a user, I want to view all tasks so that I can track what is pending. | `GET /tasks` returns `200` and JSON array; each task includes `id`, `title`, `completed`, timestamps. | 2 | Low complexity; immediate visibility after create. |
| 3 | US-4 | As a developer, I want automated tests in CI so that changes are validated on each push/PR. | Pipeline triggers on push/PR to `main`; installs dependencies; runs `pytest`; build is marked failed when tests fail. | 5 | Higher setup effort but reduces integration risk. |
| 4 | US-3 | As a user, I want to mark a task complete so that I can track finished work. | `PATCH /tasks/{id}/complete` sets `completed=true`; sets `completed_at`; unknown id returns `404`. | 3 | Depends on create/list flow being stable first. |
| 5 | US-5 | As an operator, I want a health endpoint with basic metrics so that I can monitor service status. | `GET /health` returns `status`, `timestamp`, and metrics (`requests`, `errors`, `task_count`). | 3 | Operational visibility after core flows exist. |
| 6 | US-6 | As a user, I want a summary endpoint so that I can quickly see total/completed/pending tasks. | `GET /tasks/summary` returns accurate aggregates for `total`, `completed`, `pending`. | 2 | Quick analytical value with low implementation cost. |

## Estimation Method
- Technique: relative sizing using story points (Fibonacci-lite: 2, 3, 5).
- Criteria:
  - `2`: straightforward endpoint or aggregation.
  - `3`: endpoint with validation and state transitions.
  - `5`: cross-cutting setup affecting workflow (CI + tests).

## Definition of Done (DoD)
- Feature behavior satisfies all listed acceptance criteria.
- Code is committed incrementally (small, traceable changes).
- New or updated tests cover main path and at least one failure path.
- CI pipeline passes for the branch/PR.
- API responses use JSON consistently, including errors.
- Logging is present for important state changes where relevant.
- Documentation is updated (`README` + sprint artifacts).
- Manual smoke checks for endpoint behavior are completed with no critical defects.

## Risks and Mitigations
- Risk: late CI setup could block merges near sprint end.
  - Mitigation: prioritize CI story in Sprint 1.
- Risk: inconsistent API error shapes may cause rework.
  - Mitigation: define error-response convention and validate in tests.
- Risk: no persistence may reset data during testing.
  - Mitigation: keep demo scripts short and deterministic.

## Sprint 1 Plan
### Sprint 1 Goal
Deliver the first usable API increment with automated quality checks.

### Selected Stories
- US-1: Create task endpoint.
- US-2: List tasks endpoint.
- US-4: CI pipeline and tests.

### Sprint 1 Forecast
- Planned story points: 10 SP (US-1: 3, US-2: 2, US-4: 5).
- Planned deliverables:
  - Running API service.
  - Initial automated tests.
  - CI workflow file integrated with repository.

### Sprint 1 Task Breakdown
- Create project scaffold and dependency setup.
- Implement `POST /tasks` with input validation.
- Implement `GET /tasks`.
- Write tests for create/list behavior and validation.
- Configure CI workflow to run tests on push/PR.
- Update documentation for review and retrospective.
