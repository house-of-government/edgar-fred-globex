#!/bin/sh
set -eu

repo=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
tool="$repo/bin/nsf-awards"

expect_url() {
    expected=$1
    shift
    actual=$(python3 "$tool" "$@")
    if [ "$actual" != "$expected" ]; then
        printf 'expected: %s\nactual:   %s\n' "$expected" "$actual" >&2
        exit 1
    fi
}

expect_url \
    'https://api.nsf.gov/services/v1/awards.json?keyword=%22non-von+Neumann%22&awardeeName=Indiana+University&awardeeStateCode=IN&rpp=25&offset=25' \
    search --print-url '"non-von Neumann"' --awardee 'Indiana University' --state IN --rpp 25 --offset 25

expect_url \
    'https://api.nsf.gov/services/v1/awards.xml?keyword=water&ActiveAwards=True&sortKey=startDate' \
    search --format xml --print-url water --active --sort startDate

expect_url \
    'https://api.nsf.gov/services/v1/awards.json?keyword=quantum&progRefCode=7556' \
    search --print-url quantum --param 'progRefCode=7556'

expect_url \
    'https://api.nsf.gov/services/v1/awards/1052893.json' \
    award --print-url 1052893

expect_url \
    'https://api.nsf.gov/services/v1/awards/1052893/projectoutcomes.xml' \
    outcomes --format xml --print-url 1052893

actual=$(NSF_API_BASE='https://example.invalid/v9/' python3 "$tool" award --print-url 1052893)
expected='https://example.invalid/v9/awards/1052893.json'
if [ "$actual" != "$expected" ]; then
    printf 'expected: %s\nactual:   %s\n' "$expected" "$actual" >&2
    exit 1
fi

printf 'nsf-awards CLI URL tests passed\n'
