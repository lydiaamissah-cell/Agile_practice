# Agile DevOps Prototype: Task Tracker API

This repository demonstrates Agile and DevOps practices across three sprints:
- Sprint 0 (Planning)
- Sprint 1 (Execution)
- Sprint 2 (Execution and Improvement)

The prototype is a small Flask-based API for tracking simple tasks.

## Run locally

```bash
python -m venv .venv
.venv\Scripts\activate
pip install -r requirements.txt
python -m app.main
```

API base URL: `http://127.0.0.1:5000`

## Run tests

```bash
pytest
```

## CI/CD

- Pipeline runs on push/PR to `main`.
- CI performs:
  - Lint checks with `ruff`
  - Unit tests with `pytest`
- CD performs:
  - On push to `main`, packages the app into `task-tracker-<sha>.zip`
  - Uploads the zip as a GitHub Actions artifact

## Key endpoints

- `GET /health` - health and basic metrics
- `POST /tasks` - create task
- `GET /tasks` - list tasks
- `PATCH /tasks/<id>/complete` - mark task complete
- `GET /tasks/summary` - summary of total/completed/pending

## Agile artifacts

- `docs/sprint0.md`
- `docs/sprint1_review.md`
- `docs/sprint1_retrospective.md`
- `docs/sprint2_review.md`
- `docs/final_retrospective.md`
