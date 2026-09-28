#!/bin/sh
# Checks a framework solution with examples/<problem>/checker.lp.
# The original instance is required: the checker constraints are expressed on
# the original predicates and constants (e.g., the #const of ORS).
# The solution must be the output of launch_instance.sh or convert_and_launch.sh
# run with --outf=1; only its last answer set is checked.
# Prints check_ok. (exit status 0) or check_failed. (exit status 1).
#
# Usage:   ./launch_checker.sh <problem> <original-instance> <solution>
# Example: ./launch_checker.sh CTS instances/CTS/CTS_input.lp CTS_solution.txt

if [ $# -ne 3 ]; then
    echo "Usage: $0 <problem> <original-instance> <solution>" >&2
    exit 2
fi

repo_dir=$(cd "$(dirname "$0")" && pwd)
checker="$repo_dir/examples/$1/checker.lp"

if [ ! -f "$checker" ]; then
    echo "Unknown problem '$1'. Available problems: $(ls "$repo_dir/examples" | xargs)" >&2
    exit 2
fi

for file in "$2" "$3"; do
    if [ ! -f "$file" ]; then
        echo "File not found: $file" >&2
        exit 2
    fi
done

if ! grep -q '^ANSWER$' "$3"; then
    echo "No answer set found in $3 (the solution must be produced with --outf=1)." >&2
    exit 2
fi

result=$(awk '/^ANSWER$/ { getline; model = $0 } END { print model }' "$3" |
    clingo --warn=none --outf=1 "$checker" "$2" -)

case "$result" in
    *check_ok*) echo "check_ok."; exit 0 ;;
    *INCONSISTENT*) echo "check_failed."; exit 1 ;;
    *) echo "The checker did not complete." >&2; exit 2 ;;
esac
