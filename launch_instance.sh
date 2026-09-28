#!/bin/sh
# Runs clingo on the framework encoding of a problem and a framework instance.
# The encoding is examples/<problem>/encoding_framework.lp, which includes
# framework.lp and the problem-specific constraints.
# Every argument after the instance is passed to clingo unchanged.
#
# Usage:   ./launch_instance.sh <problem> <instance> [clingo options...]
# Example: ./launch_instance.sh CTS CTS_converted_instance.lp --time-limit=60 --outf=1 > CTS_solution.txt

if [ $# -lt 2 ]; then
    echo "Usage: $0 <problem> <instance> [clingo options...]" >&2
    exit 2
fi

repo_dir=$(cd "$(dirname "$0")" && pwd)
problem_dir="$repo_dir/examples/$1"

if [ ! -f "$problem_dir/encoding_framework.lp" ]; then
    echo "Unknown problem '$1'. Available problems: $(ls "$repo_dir/examples" | xargs)" >&2
    exit 2
fi

if [ ! -f "$2" ]; then
    echo "Instance not found: $2" >&2
    exit 2
fi

instance=$(cd "$(dirname "$2")" && pwd)/$(basename "$2")
shift 2

cd "$problem_dir" && exec clingo encoding_framework.lp "$instance" "$@"
