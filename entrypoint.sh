#!/bin/sh -l
set -eu

# validate subscription status
UPSTREAM="Azure/static-web-apps-deploy"
ACTION_REPO="${GITHUB_ACTION_REPOSITORY:-}"
DOCS_URL="https://docs.stepsecurity.io/actions/stepsecurity-maintained-actions"

REPO_PRIVATE=""
if [ -n "${GITHUB_EVENT_PATH:-}" ] && [ -f "$GITHUB_EVENT_PATH" ]; then
  REPO_PRIVATE=$(grep -o '"private"[[:space:]]*:[[:space:]]*\(true\|false\)' "$GITHUB_EVENT_PATH" 2>/dev/null | head -1 | grep -o 'true\|false' || true)
fi

printf '\n'
printf '\033[1;36mStepSecurity Maintained Action\033[0m\n'
printf 'Secure drop-in replacement for %s\n' "$UPSTREAM"
if [ "$REPO_PRIVATE" = "false" ]; then
  printf '\033[32m\342\234\223 Free for public repositories\033[0m\n'
fi
printf '\033[36mLearn more:\033[0m %s\n' "$DOCS_URL"
printf '\n'

if [ "$REPO_PRIVATE" != "false" ]; then
  SERVER_URL="${GITHUB_SERVER_URL:-https://github.com}"

  if [ "$SERVER_URL" != "https://github.com" ]; then
    BODY=$(printf '{"action":"%s","ghes_server":"%s"}' "$ACTION_REPO" "$SERVER_URL")
  else
    BODY=$(printf '{"action":"%s"}' "$ACTION_REPO")
  fi

  API_URL="https://agent.api.stepsecurity.io/v1/github/$GITHUB_REPOSITORY/actions/maintained-actions-subscription"

  RESPONSE=$(curl --max-time 3 -s -w "%{http_code}" \
    -X POST \
    -H "Content-Type: application/json" \
    -d "$BODY" \
    "$API_URL" -o /dev/null) && CURL_EXIT_CODE=0 || CURL_EXIT_CODE=$?

  if [ "$CURL_EXIT_CODE" -ne 0 ]; then
    echo "Timeout or API not reachable. Continuing to next step."
  elif [ "$RESPONSE" = "403" ]; then
    printf '::error::\033[1;31mThis action requires a StepSecurity subscription for private repositories.\033[0m\n' >&2
    printf '::error::\033[31mLearn how to enable a subscription: %s\033[0m\n' "$DOCS_URL" >&2
    exit 1
  fi
fi

case "${INPUT_ACTION:-}" in
  '') echo "::error::'action' input is required" >&2; exit 1 ;;
  *[!A-Za-z0-9_-]*) echo "::error::'action' input contains invalid characters" >&2; exit 1 ;;
esac

cd /bin/staticsites/
./StaticSitesClient "$INPUT_ACTION"
