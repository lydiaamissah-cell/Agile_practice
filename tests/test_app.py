import importlib


def get_test_client():
    module = importlib.import_module("app.main")
    module.TASKS.clear()
    module.NEXT_ID = 1
    module.REQUEST_COUNT = 0
    module.ERROR_COUNT = 0
    module.app.config["TESTING"] = True
    return module.app.test_client()


def test_create_task_success():
    client = get_test_client()
    response = client.post("/tasks", json={"title": "Write user story"})
    assert response.status_code == 201
    data = response.get_json()
    assert data["id"] == 1
    assert data["title"] == "Write user story"
    assert data["completed"] is False


def test_create_task_validation():
    client = get_test_client()
    response = client.post("/tasks", json={"title": "   "})
    assert response.status_code == 400
    assert response.get_json()["error"] == "title is required"


def test_complete_task_and_summary():
    client = get_test_client()
    client.post("/tasks", json={"title": "Task A"})
    client.post("/tasks", json={"title": "Task B"})

    complete_response = client.patch("/tasks/1/complete")
    assert complete_response.status_code == 200
    assert complete_response.get_json()["completed"] is True

    summary_response = client.get("/tasks/summary")
    assert summary_response.status_code == 200
    summary = summary_response.get_json()
    assert summary["total"] == 2
    assert summary["completed"] == 1
    assert summary["pending"] == 1


def test_health_endpoint():
    client = get_test_client()
    response = client.get("/health")
    assert response.status_code == 200
    body = response.get_json()
    assert body["status"] == "ok"
    assert "metrics" in body
    assert "requests" in body["metrics"]

