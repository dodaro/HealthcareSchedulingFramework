#!/bin/sh
# Runs the LBBD approach (LBBD/run_lbbd.py) on a framework instance, with the
# LBBD encoding and the domain-specific cuts of the problem.
# Every argument after the instance is passed to run_lbbd.py and overrides the
# defaults below (e.g., --cuts=all).
#
# Usage:   ./launch_lbbd.sh <problem> <instance> [run_lbbd.py options...]
# Example: ./launch_lbbd.sh CTS CTS_converted_instance.lp > CTS_lbbd_solution.txt

if [ $# -lt 2 ]; then
    echo "Usage: $0 <problem> <instance> [run_lbbd.py options...]" >&2
    exit 2
fi

repo_dir=$(cd "$(dirname "$0")" && pwd)
lbbd_problem=$(echo "$1" | tr '[:upper:]' '[:lower:]')
encoding="$repo_dir/LBBD/encoding_lbbd_$lbbd_problem.lp"

if [ ! -f "$encoding" ]; then
    available=$(ls "$repo_dir"/LBBD/encoding_lbbd_*.lp | sed 's/.*encoding_lbbd_\(.*\)\.lp$/\1/' | tr '[:lower:]' '[:upper:]' | xargs)
    echo "LBBD is not available for problem '$1'. Available problems: $available" >&2
    exit 2
fi

if [ ! -f "$2" ]; then
    echo "Instance not found: $2" >&2
    exit 2
fi

instance=$2
shift 2

exec python3 "$repo_dir/LBBD/run_lbbd.py" \
    --input-file="$instance" \
    --encoding-file="$encoding" \
    --timeout-master=0 \
    --cuts=domain_specific \
    --specific-cut-module="specific_cut_$lbbd_problem" \
    "$@"
