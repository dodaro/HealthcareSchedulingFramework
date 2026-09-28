#!/bin/sh
# Converts an instance from the original format of a problem and runs the
# framework on it: convert_instance.sh followed by launch_instance.sh.
# The converted instance is written to a temporary file, removed at the end.
# Every argument after the instance is passed to clingo unchanged.
#
# Usage:   ./convert_and_launch.sh <problem> <original-instance> [clingo options...]
# Example: ./convert_and_launch.sh CTS instances/CTS/CTS_input.lp --time-limit=60 --outf=1 > CTS_solution.txt

if [ $# -lt 2 ]; then
    echo "Usage: $0 <problem> <original-instance> [clingo options...]" >&2
    exit 2
fi

repo_dir=$(cd "$(dirname "$0")" && pwd)
problem=$1
original=$2
shift 2

converted=$(mktemp "${TMPDIR:-/tmp}/converted_instance.XXXXXX") || exit 1
trap 'rm -f "$converted"' EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

"$repo_dir/convert_instance.sh" "$problem" "$original" > "$converted" || exit $?
"$repo_dir/launch_instance.sh" "$problem" "$converted" "$@"
