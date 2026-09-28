#!/bin/sh
# Converts an instance from the original format of a problem into a framework
# instance, using examples/<problem>/input_converter.lp.
# The converted instance is written to standard output.
#
# Usage:   ./convert_instance.sh <problem> <original-instance>
# Example: ./convert_instance.sh CTS instances/CTS/CTS_input.lp > CTS_converted_instance.lp

if [ $# -ne 2 ]; then
    echo "Usage: $0 <problem> <original-instance>" >&2
    exit 2
fi

repo_dir=$(cd "$(dirname "$0")" && pwd)
converter="$repo_dir/examples/$1/input_converter.lp"

if [ ! -f "$converter" ]; then
    echo "Unknown problem '$1'. Available problems: $(ls "$repo_dir/examples" | xargs)" >&2
    exit 2
fi

if [ ! -f "$2" ]; then
    echo "Instance not found: $2" >&2
    exit 2
fi

# The converter is deterministic: print the facts of its unique answer set.
clingo --warn=none --outf=1 "$converter" "$2" |
    awk '/^ANSWER$/ { getline; print; found = 1 }
         END { if (!found) { print "Conversion failed: no answer set." > "/dev/stderr"; exit 1 } }'
