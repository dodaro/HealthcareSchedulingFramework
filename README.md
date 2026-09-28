# Health Scheduling Framework

A framework, based on Answer Set Programming (ASP), for solving scheduling problems in health care. It includes a general encoding (`framework.lp`) plus problem-specific encodings for several case studies (**CTS**, **CTSWeekly**, **NMS**, **ORS**), and a Logic-Based Benders Decomposition (LBBD) approach implemented in Python on top of `clingo`.

## Requirements
The framework encoding is written mostly in ASP-Core-2, the standard input language of ASP systems, and is developed and tested with [clingo](https://potassco.org/clingo/). It uses a few clingo-specific constructs that are not supported by every ASP system, but these can be easily adapted to run the encodings with other systems. The LBBD approach, instead, relies on clingo, since it is built on the clingo Python API.

- **[clingo](https://potassco.org/clingo/)**, used by the shell scripts and by LBBD.
  - Install via conda (recommended): `conda install -c potassco clingo`
  - Or via pip: `pip install clingo`
  - See the [Potassco installation guide](https://potassco.org/clingo/) for other options (Linux/macOS/Windows binaries).
- **Python 3.9 or later**, to run LBBD (`launch_lbbd.sh` uses `python3`). The `clingo` Python API must be installed for this interpreter.

## Folder structure

- `framework.lp` - the general ASP encoding shared by all problems.
- `examples/<Problem>/` - per-problem encodings: `encoding_framework.lp`, `encoding_original.lp`, `input_converter.lp`, `checker.lp`, and the problem-specific constraints (`specific_constraints_*.lp`, for CTS, CTSWeekly, and NMS).
- `instances/<Problem>/` - toy instances, created to show how the framework works, in the original format of each problem (convert them with `convert_instance.sh`).
- `LBBD/` - Python implementation of the LBBD approach (`run_lbbd.py`), its ASP encodings (`encoding_lbbd_*.lp`), and problem-specific cut modules (`specific_cut_*.py`).

## Shell scripts

All scripts work on a single instance. They locate the repository from their own path, so they can be run from any directory, and they print their usage when called without arguments.

- **`convert_instance.sh`** - converts an instance from the original format of a problem into the framework's input format, using `examples/<Problem>/input_converter.lp`. The converted instance is written to standard output.
  ```
  ./convert_instance.sh <problem-name> <original-instance> > <framework-instance>
  ```
- **`launch_instance.sh`** - runs `clingo` on the framework encoding of a problem, `examples/<Problem>/encoding_framework.lp` (which includes `framework.lp` and the problem-specific constraints), and a framework instance. All further arguments are passed to `clingo` unchanged.
  ```
  ./launch_instance.sh <problem-name> <framework-instance> [clingo-options...]
  ```
- **`convert_and_launch.sh`** - runs `convert_instance.sh` and then `launch_instance.sh` on an instance in the original format. The converted instance is written to a temporary file, removed at the end. All further arguments are passed to `clingo` unchanged.
  ```
  ./convert_and_launch.sh <problem-name> <original-instance> [clingo-options...]
  ```
- **`launch_checker.sh`** - checks a framework solution with `examples/<Problem>/checker.lp` and prints `check_ok.` (exit status 0) or `check_failed.` (exit status 1). The original instance is required, because the checker constraints are expressed on the original predicates and constants. The solution must be produced by `launch_instance.sh` or `convert_and_launch.sh` with `--outf=1`; only its last (best) answer set is checked.
  ```
  ./launch_checker.sh <problem-name> <original-instance> <solution>
  ```
- **`launch_lbbd.sh`** - runs the LBBD approach (`LBBD/run_lbbd.py`) on a framework instance, with the LBBD encoding (`LBBD/encoding_lbbd_*.lp`) and the domain-specific cuts (`LBBD/specific_cut_*.py`) of the problem; LBBD is available for CTS and NMS. All further arguments are passed to `run_lbbd.py` and can override the defaults of the script (`--cuts=domain_specific`, `--timeout-master=0`).
  ```
  ./launch_lbbd.sh <problem-name> <framework-instance> [run_lbbd.py-options...]
  ```
- **`convert_and_launch_lbbd.sh`** - runs `convert_instance.sh` and then `launch_lbbd.sh` on an instance in the original format. The converted instance is written to a temporary file, removed at the end. All further arguments are passed to `run_lbbd.py`.
  ```
  ./convert_and_launch_lbbd.sh <problem-name> <original-instance> [run_lbbd.py-options...]
  ```

### Example

Convert the NMS instance, solve it with a time limit of 60 seconds, and check the solution:

```
./convert_instance.sh NMS instances/NMS/NMS_input.lp > NMS_converted_instance.lp
./launch_instance.sh NMS NMS_converted_instance.lp --time-limit=60 --outf=1 > NMS_solution.txt
./launch_checker.sh NMS instances/NMS/NMS_input.lp NMS_solution.txt
```

The first two commands can be replaced by a single one:

```
./convert_and_launch.sh NMS instances/NMS/NMS_input.lp --time-limit=60 --outf=1 > NMS_solution.txt
```

To solve the converted instance with LBBD instead:

```
./launch_lbbd.sh NMS NMS_converted_instance.lp > NMS_lbbd_solution.txt
```

or, directly from the original instance:

```
./convert_and_launch_lbbd.sh NMS instances/NMS/NMS_input.lp > NMS_lbbd_solution.txt
```

