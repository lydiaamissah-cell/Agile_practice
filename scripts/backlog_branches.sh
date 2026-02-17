#!/usr/bin/env bash
set -euo pipefail

# Branch-based workflow aligned to backlog stories.
# It creates sprint branches and story branches, then prints next actions.
#
# Usage:
#   bash scripts/backlog_branches.sh
#
# Optional env overrides:
#   MAIN_BRANCH=develop SPRINT1=sprint/one SPRINT2=sprint/two bash scripts/backlog_branches.sh

MAIN_BRANCH="${MAIN_BRANCH:-main}"
SPRINT1="${SPRINT1:-sprint/1}"
SPRINT2="${SPRINT2:-sprint/2}"

S1_STORIES=(
  "feature/us-1-create-task"
  "feature/us-2-list-tasks"
  "chore/us-4-ci-tests"
)

S2_STORIES=(
  "feature/us-3-complete-task"
  "feature/us-5-health-metrics"
  "feature/us-6-summary"
)

create_or_checkout_branch() {
  local base="$1"
  local branch="$2"

  git checkout "$base"
  if git show-ref --verify --quiet "refs/heads/$branch"; then
    git checkout "$branch"
  else
    git checkout -b "$branch"
  fi
}

print_story_guidance() {
  local story_branch="$1"
  local sprint_branch="$2"

  echo "Now on branch: $story_branch"
  echo "  1) implement only this story scope"
  echo "  2) stage focused changes: git add -p"
  echo "  3) commit with backlog-aligned messages, e.g.:"
  case "$story_branch" in
    "feature/us-1-create-task")
      echo "     - feat(us-1): add create task endpoint with title validation"
      echo "     - test(us-1): add creation success and validation tests"
      ;;
    "feature/us-2-list-tasks")
      echo "     - feat(us-2): add list tasks endpoint"
      echo "     - test(us-2): add list tasks response tests"
      ;;
    "chore/us-4-ci-tests")
      echo "     - ci(us-4): add lint and unit-test workflow"
      echo "     - docs(us-4): document ci checks in readme"
      ;;
    "feature/us-3-complete-task")
      echo "     - feat(us-3): add complete task endpoint and 404 handling"
      echo "     - test(us-3): add completion flow tests"
      ;;
    "feature/us-5-health-metrics")
      echo "     - feat(us-5): add health endpoint with basic metrics"
      echo "     - test(us-5): add health endpoint coverage"
      ;;
    "feature/us-6-summary")
      echo "     - feat(us-6): add task summary endpoint"
      echo "     - test(us-6): add summary totals tests"
      ;;
  esac
  echo "  4) push branch: git push -u origin $story_branch"
  echo "  5) merge back to sprint branch:"
  echo "     git checkout $sprint_branch"
  echo "     git merge --no-ff $story_branch -m \"merge: $story_branch into $sprint_branch\""
  echo
}

echo "== Fetch latest =="
git fetch origin
git checkout "$MAIN_BRANCH"
git pull origin "$MAIN_BRANCH"
echo

echo "== Prepare sprint branches =="
create_or_checkout_branch "$MAIN_BRANCH" "$SPRINT1"
create_or_checkout_branch "$MAIN_BRANCH" "$SPRINT2"
git checkout "$MAIN_BRANCH"
echo "Ready: $SPRINT1, $SPRINT2"
echo

echo "== Sprint 1 story branches =="
for story in "${S1_STORIES[@]}"; do
  create_or_checkout_branch "$SPRINT1" "$story"
  print_story_guidance "$story" "$SPRINT1"
done

echo "== Sprint 2 story branches =="
for story in "${S2_STORIES[@]}"; do
  create_or_checkout_branch "$SPRINT2" "$story"
  print_story_guidance "$story" "$SPRINT2"
done

echo "== Final integration =="
echo "When sprint branches are complete:"
echo "  git checkout $MAIN_BRANCH"
echo "  git merge --no-ff $SPRINT1 -m \"merge: sprint 1\""
echo "  git merge --no-ff $SPRINT2 -m \"merge: sprint 2\""
echo "  git push origin $MAIN_BRANCH"

