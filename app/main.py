from flask import Flask, jsonify, request
from datetime import datetime, UTC


app = Flask(__name__)

TASKS = []
NEXT_ID = 1
REQUEST_COUNT = 0
ERROR_COUNT = 0


def _utc_now_iso() -> str:
    return datetime.now(UTC).isoformat()


def _find_task(task_id: int):
    for task in TASKS:
        if task["id"] == task_id:
            return task
    return None


@app.before_request
def count_requests():
    global REQUEST_COUNT
    REQUEST_COUNT += 1


@app.errorhandler(Exception)
def handle_unexpected_error(err):
    global ERROR_COUNT
    ERROR_COUNT += 1
    return jsonify({"error": "internal server error"}), 500


@app.get("/health")
def health():
    return jsonify(
        {
            "status": "ok",
            "timestamp": _utc_now_iso(),
            "metrics": {
                "requests": REQUEST_COUNT,
                "errors": ERROR_COUNT,
                "task_count": len(TASKS),
            },
        }
    )


@app.post("/tasks")
def create_task():
    global NEXT_ID
    payload = request.get_json(silent=True) or {}
    title = str(payload.get("title", "")).strip()
    if not title:
        return jsonify({"error": "title is required"}), 400

    task = {
        "id": NEXT_ID,
        "title": title,
        "completed": False,
        "created_at": _utc_now_iso(),
        "completed_at": None,
    }
    NEXT_ID += 1
    TASKS.append(task)
    app.logger.info("task_created id=%s title=%s", task["id"], task["title"])
    return jsonify(task), 201


@app.get("/tasks")
def list_tasks():
    return jsonify(TASKS)


@app.patch("/tasks/<int:task_id>/complete")
def complete_task(task_id: int):
    task = _find_task(task_id)
    if task is None:
        return jsonify({"error": "task not found"}), 404
    if task["completed"]:
        return jsonify(task), 200

    task["completed"] = True
    task["completed_at"] = _utc_now_iso()
    app.logger.info("task_completed id=%s", task["id"])
    return jsonify(task), 200


@app.get("/tasks/summary")
def summary():
    total = len(TASKS)
    completed = len([t for t in TASKS if t["completed"]])
    pending = total - completed
    return jsonify({"total": total, "completed": completed, "pending": pending})


if __name__ == "__main__":
    app.run(debug=True)

