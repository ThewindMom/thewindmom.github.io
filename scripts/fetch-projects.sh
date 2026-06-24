#!/usr/bin/env bash
# Fetch ThewindMom's non-fork GitHub repos, sorted by most recent push.
# Writes data/projects.yml for Hugo to consume at build time.
# Requires: curl, jq. Uses GITHUB_TOKEN if available (higher rate limit).

set -euo pipefail

OWNER="ThewindMom"
OUT="data/projects.yml"

AUTH_HEADER=()
if [[ -n "${GITHUB_TOKEN:-}" ]]; then
    AUTH_HEADER=(-H "Authorization: Bearer $GITHUB_TOKEN")
fi

# Fetch non-fork repos (excluding this site repo), skip null descriptions.
REPOS_JSON=$(curl -sf "${AUTH_HEADER[@]}" \
    -H "Accept: application/vnd.github+json" \
    "https://api.github.com/users/$OWNER/repos?per_page=100&type=owner" \
    | jq '[.[] | select(.fork == false) | select(.name != "thewindmom.github.io") | select(.description != null) | {
        name: .name,
        description: .description,
        url: .html_url,
        language: (.language // "—"),
        stars: .stargazers_count,
        date: (.pushed_at | .[0:7]),
        pushed_at: .pushed_at
    }] | sort_by(.pushed_at) | reverse'
)

# Write YAML
{
    echo "$REPOS_JSON" | jq -r '.[] | "  - name: \"" + .name + "\"\n    description: \"" + (.description | gsub("\""; "\\\"")) + "\"\n    url: " + .url + "\n    language: " + .language + "\n    stars: " + (.stars | tostring) + "\n    date: " + .date'
} > "$OUT"

echo "Wrote $(jq '. | length' <<< "$REPOS_JSON") repos to $OUT"
