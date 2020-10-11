#!/usr/bin/env sh

inside_git_repo="$(git rev-parse --is-inside-work-tree 2>/dev/null)"

is_git() {
  if [ "$inside_git_repo" ]; then
    date

    COMMIT_COUNT="$(git rev-list --all --count)"
    printf "\nAll commits: %s\n" "$COMMIT_COUNT"

    LAST_WEEK_COMMITS="$(git log --oneline --since=1.weeks | wc -l)"
    printf "\nCommits last week: %s\n" "$LAST_WEEK_COMMITS"

    ID_LAST_WEEK="$(git log --since=1.weeks --numstat --pretty="%H" \
    | awk 'NF==3 {plus+=$1; minus+=$2} END {printf("+%d, -%d\n", plus, minus)}')"
    printf "\nInsertions and deletions last week: %s\n" "$ID_LAST_WEEK"

    LAST_WEEK_AUTHORS="$(git log --oneline --since=1.weeks --format="%aN" | sort -u)"
    printf "\nAuthors commited last week:\n%s\n\n" "$LAST_WEEK_AUTHORS"

    return 0
  else
  	echo 'Not a git repo'
  	return 1
  fi
}

is_git
echo "exited with status code: $?"