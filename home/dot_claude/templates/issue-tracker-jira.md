# Issue tracker: JIRA

Issues and specs for this repo live in JIRA, in project `PROJ`. Replace `PROJ`
with the real project key before you use this file.

Copy this file into a repo as `docs/agents/issue-tracker.md`. The engineering
skills (`/triage`, `/to-tickets`, `/to-spec`, `/wayfinder`) read it from there.

## Access

There is no JIRA CLI on this machine, so every operation below is a REST call
made with `curl`. Three environment variables carry the connection:

- `JIRA_BASE_URL`, for example `https://acme.atlassian.net`
- `JIRA_EMAIL`, the account email
- `JIRA_API_TOKEN`, an Atlassian API token

Never print these values, and never write them into a file. Pass them with
`-u "$JIRA_EMAIL:$JIRA_API_TOKEN"`.

The examples use REST API v2. Version 2 accepts a plain string for
`description` and for a comment `body`. Version 3 requires Atlassian Document
Format, which is a nested JSON structure. Use v2 unless you need a v3-only
field, because plain strings are far cheaper to produce and to read.

If this repo later gets a JIRA CLI or an MCP server, replace this section and
the commands below. Nothing else in the file changes.

## Conventions

**Create an issue.** `issuetype` must be a type that project `PROJ` defines.

```sh
curl -sS -u "$JIRA_EMAIL:$JIRA_API_TOKEN" -X POST \
  -H 'Content-Type: application/json' \
  "$JIRA_BASE_URL/rest/api/2/issue" \
  -d @- <<'JSON'
{"fields":{"project":{"key":"PROJ"},"summary":"...","description":"...","issuetype":{"name":"Task"}}}
JSON
```

**Read an issue**, with its comments and links in one call:

```sh
curl -sS -u "$JIRA_EMAIL:$JIRA_API_TOKEN" \
  "$JIRA_BASE_URL/rest/api/2/issue/PROJ-42?fields=summary,description,labels,status,issuelinks,parent&expand=renderedFields" 
curl -sS -u "$JIRA_EMAIL:$JIRA_API_TOKEN" \
  "$JIRA_BASE_URL/rest/api/2/issue/PROJ-42/comment"
```

**List issues.** Query with JQL and ask only for the fields you need, because
the default response is large:

```sh
curl -sS -u "$JIRA_EMAIL:$JIRA_API_TOKEN" -G \
  --data-urlencode 'jql=project = PROJ AND labels = "needs-triage" AND statusCategory != Done ORDER BY created ASC' \
  --data-urlencode 'fields=summary,description,labels,status,assignee,issuelinks' \
  "$JIRA_BASE_URL/rest/api/2/search"
```

**Comment on an issue:**

```sh
curl -sS -u "$JIRA_EMAIL:$JIRA_API_TOKEN" -X POST \
  -H 'Content-Type: application/json' \
  "$JIRA_BASE_URL/rest/api/2/issue/PROJ-42/comment" \
  -d '{"body":"..."}'
```

**Add or remove labels.** Use the `update` block, not `fields`. A write to
`fields.labels` replaces the whole list and drops labels set by other people.

```sh
curl -sS -u "$JIRA_EMAIL:$JIRA_API_TOKEN" -X PUT \
  -H 'Content-Type: application/json' \
  "$JIRA_BASE_URL/rest/api/2/issue/PROJ-42" \
  -d '{"update":{"labels":[{"add":"ready-for-agent"},{"remove":"needs-triage"}]}}'
```

**Close an issue.** JIRA has no direct close. You apply a workflow transition,
and the transition identifiers differ per project. Read the available
transitions first, then post the one you want.

```sh
curl -sS -u "$JIRA_EMAIL:$JIRA_API_TOKEN" \
  "$JIRA_BASE_URL/rest/api/2/issue/PROJ-42/transitions"
curl -sS -u "$JIRA_EMAIL:$JIRA_API_TOKEN" -X POST \
  -H 'Content-Type: application/json' \
  "$JIRA_BASE_URL/rest/api/2/issue/PROJ-42/transitions" \
  -d '{"transition":{"id":"31"}}'
```

Comment first, then transition. A transition alone leaves no reason on record.

## Triage labels

The skills speak in terms of five canonical triage roles. This table maps each
role to the JIRA label string used in this project. JIRA labels are free-form,
so any user can create them, and they sit alongside whatever workflow the board
already runs.

| Role in mattpocock/skills | Label in JIRA     | Meaning                                  |
| ------------------------- | ----------------- | ---------------------------------------- |
| `needs-triage`            | `needs-triage`    | Maintainer needs to evaluate this issue  |
| `needs-info`              | `needs-info`      | Waiting on reporter for more information |
| `ready-for-agent`         | `ready-for-agent` | Fully specified, ready for an AFK agent  |
| `ready-for-human`         | `ready-for-human` | Requires human implementation            |
| `wontfix`                 | `wontfix`         | Will not be actioned                     |

Edit the middle column to match the vocabulary this project already uses. When
a skill names a role, apply the label string from the middle column.

JIRA labels reject spaces. If a team vocabulary contains a space, pick a
hyphenated form here and keep it stable.

## Pull requests as a triage surface

**PRs as a request surface: no.** _(Set to `yes` if this repo treats incoming
pull requests as feature requests. `/triage` reads this flag.)_

JIRA holds no pull requests, so the code review platform is a separate system.
If you set this flag to `yes`, name that platform and its CLI here, and state
how a pull request maps to a JIRA issue. Without that mapping, leave the flag
at `no`.

A bare `#42` never refers to a JIRA issue. JIRA keys look like `PROJ-42`. Treat
a bare number as a reference to the code review platform, or ask.

## When a skill says "publish to the issue tracker"

Create a JIRA issue in project `PROJ`.

## When a skill says "fetch the relevant ticket"

Read the issue by key, together with its comments, as shown under Conventions.

## Wayfinding operations

Used by `/wayfinder`. The **map** is one issue, and the tickets are its
children.

**Map.** One issue with the label `wayfinder-map`, holding the Notes,
Decisions-so-far and Fog sections in its description. JIRA labels reject the
colon that the GitHub template uses, so the separator here is a hyphen.

**Child ticket.** One issue that names the map as its parent. The parent
mechanism differs by project type, and this is the one value to confirm per
JIRA instance:

- A team-managed project accepts `"parent":{"key":"PROJ-1"}` in `fields` on
  create, for any issue type.
- A company-managed project accepts `parent` for sub-tasks. For other types it
  uses the Epic Link custom field, whose identifier you read from
  `/rest/api/2/issue/createmeta`.

If neither path works in this project, fall back to an issue link of type
`Relates` to the map, and put `Part of PROJ-1` on the first line of the
description.

Label each child `wayfinder-research`, `wayfinder-prototype`,
`wayfinder-grilling` or `wayfinder-task`.

**Blocking.** Use JIRA's native `Blocks` link type. It is visible in the UI and
queryable, so it is the canonical edge. The blocker is the outward issue.

```sh
curl -sS -u "$JIRA_EMAIL:$JIRA_API_TOKEN" -X POST \
  -H 'Content-Type: application/json' \
  "$JIRA_BASE_URL/rest/api/2/issueLink" \
  -d '{"type":{"name":"Blocks"},"outwardIssue":{"key":"PROJ-7"},"inwardIssue":{"key":"PROJ-9"}}'
```

That call reads: `PROJ-7` blocks `PROJ-9`. A ticket is unblocked when every
issue that blocks it reaches a Done status category.

**Frontier query.** List the map's open children, drop any with an open
blocker, drop any that already has an assignee, and take the first in map
order.

```sh
curl -sS -u "$JIRA_EMAIL:$JIRA_API_TOKEN" -G \
  --data-urlencode 'jql=project = PROJ AND parent = PROJ-1 AND statusCategory != Done AND assignee IS EMPTY ORDER BY created ASC' \
  --data-urlencode 'fields=summary,labels,status,assignee,issuelinks' \
  "$JIRA_BASE_URL/rest/api/2/search"
```

`issuelinks` carries the blocking edges. For each candidate, keep it only when
every inward `Blocks` link points at an issue whose status category is Done.

**Claim.** Assign the ticket to yourself. This is the session's first write, so
it marks the ticket as taken before any other work starts.

```sh
curl -sS -u "$JIRA_EMAIL:$JIRA_API_TOKEN" -X PUT \
  -H 'Content-Type: application/json' \
  "$JIRA_BASE_URL/rest/api/2/issue/PROJ-9/assignee" \
  -d '{"accountId":"<your-account-id>"}'
```

Read your own account id once from `/rest/api/2/myself` and record it here.

**Resolve.** Post the answer as a comment, transition the ticket to Done, then
append a pointer to the map's Decisions-so-far section.
