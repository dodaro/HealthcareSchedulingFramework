import importlib
import os
import signal
import time
from collections import defaultdict
from functools import cache
import clingo
import argparse

""" 
Python script to run LBBD encoding.
"""

repository_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
os.environ.setdefault("HSF_ROOT", repository_root)

unsafe_constraints = ['hsf_assign_day', 'hsf_assign_ts_to_phase', 'hsf_assign_resource']
unsafe_constraints_day = ['hsf_assign_day']
unsafe_constraints_ts_to_phase = ['hsf_assign_ts_to_phase']
unsafe_constraints_resource = ['hsf_assign_resource']
include_day = ['hsf_assign_day', 'hsf_assign_ts_to_phase', 'hsf_assigned_shift', 'hsf_assign_resource', 'hsf_time_occupation', 'hsf_assigned_resource']
without_day = ['hsf_treatment_days', 'hsf_last_phase', 'hsf_exam_duration_without_last_phase', 'hsf_exam_duration', 'hsf_distance_among_phases', 'hsf_real_distance_among_phases', 'hsf_max_priorities']
facts = []
clingo_options = ['1', '--opt-mode=optN']

def get_execution_time(start_time):
    return time.time() - start_time

def get_encoding(file_path):
    with open(file_path, 'r') as encoding:
        return os.path.expandvars(encoding.read())

def get_input(file_path):
    with open(file_path, 'r') as file:
        return file.read()

def parse_result(arr):
    global facts
    facts = []
    res = defaultdict(list)
    for atom in arr:
        if atom.name == "hsf_day":
            res[str(atom.arguments[0])].append(atom)
        if atom.name in include_day:
            res[str(atom.arguments[1])].append(atom)
        elif atom.name not in without_day:
            facts.append(atom)
    for d in res:
        for atom in arr:
            if atom.name in without_day:
                res[d].append(atom)    
    return res

def execute_asp_solver(ctl, on_model, timeout, master_sub="master"):
    with ctl.solve(on_model=on_model, async_=True) as handle:
        try:
            finished = handle.wait(timeout) if timeout is not None else handle.wait()
            if not finished:
                handle.cancel()
                handle.wait()
                return False
        except KeyboardInterrupt:
            handle.cancel()
            handle.wait()
            raise
    return True

def tag():
    return f"[DEBUG {get_execution_time(start_time):.2f}s]"


def stop_handler(sig, frame):
    print("Killed by user.")
    exit(130)

def check_existence_of_cut_module(specific_cut_module):
    try:
        mod = importlib.import_module(specific_cut_module)
        getattr(mod, "domain_specific_cut")        
    except ModuleNotFoundError:
        print(f"Module {args.specific_cut_module} not found")       
        exit(1) 
    except AttributeError:
        print(f"Function domain_specific_cut not found in module {args.specific_cut_module}")        
        exit(1)

def domain_specific_cut(specific_cut_module, day, atoms, facts):
    check_existence_of_cut_module(specific_cut_module)
    mod = importlib.import_module(specific_cut_module)
    fun = getattr(mod, "domain_specific_cut")
    return fun(day, atoms, facts)    

@cache
def run_subproblem(encoding_file, ms_result, day, timeout):
    if not ms_result:
        return 'sat'
    ctl2 = clingo.Control(clingo_options)
    ctl2.add(get_encoding(encoding_file))
    ctl2.add("ms_result", [], '. '.join([str(x) for x in ms_result]) + '. ' + input)
    ctl2.ground([("specific", []), ("ms_result", [])])
    unsatisfiable = True
    def on_model(m):
        res[day]['cost'] = m.cost
        res[day]['model'] = m.symbols(shown=True)
        res[day]['optimality_proven'] = m.optimality_proven
        if args.print_debug:
            print(f"{tag()} Number of models found for day {day}")
        nonlocal unsatisfiable
        unsatisfiable = False
    finished = execute_asp_solver(ctl2, on_model, timeout, f"subproblem {day}")    
    if not finished and unsatisfiable:
        return 'unknown'
    if not finished:
        print(f"{tag()} Warning: subproblem {day} reached the time limit: the model found may be suboptimal.")
    return 'unsat' if unsatisfiable else 'sat'    

signal.signal(signal.SIGINT, stop_handler)
parser = argparse.ArgumentParser()
parser.add_argument('--input-file', type=str, required=True, help='ASP input file')
parser.add_argument('--encoding-file', nargs='?', type=str, default='encoding.lp', help='ASP encoding file')
parser.add_argument('--timeout-master', nargs='?', type=int, default=180, help='Timeout for master problem: 0 means no timeout')
parser.add_argument('--timeout-subproblem', nargs='?', type=int, default=30, help='Timeout for subproblems: 0 means no timeout')
parser.add_argument('--print-debug', action='store_true', help='Print debug information')
parser.add_argument('--cuts', nargs='?', type=str, default='all', help='Add cuts (all, ts, day, resource, domain_specific)')
parser.add_argument('--parallel-mode', nargs='?', type=int, default=0, help='Set the number of cores for clingo calls')
parser.add_argument('--specific-cut-module', nargs='?', type=str, default=None, help='Specify the module to compute domain specific cuts (only used and required if --cuts=domain_specific)')
args = parser.parse_args()
input = get_input(args.input_file)
encoding_file = args.encoding_file
master_timeout = args.timeout_master
subproblem_timeout = args.timeout_subproblem
if args.parallel_mode != 0:
    clingo_options.append(f"--parallel-mode={args.parallel_mode}")
if master_timeout == 0:
    master_timeout = None
if subproblem_timeout == 0:
    subproblem_timeout = None
if args.cuts not in ["all", "ts", "day", "resource", "domain_specific"]:
    print("Invalid option for --cuts")
    exit(1)

if args.cuts == 'domain_specific':
    if not args.specific_cut_module:
        print("Error: --specific-cut-module is required when --cuts=domain_specific")
        exit(1)
    else:
        check_existence_of_cut_module(args.specific_cut_module)

start_time = time.time()
solving  = True
try:
    if args.print_debug:
        print(f"{tag()} Starting LBBD algorithm")
    ctl = clingo.Control(clingo_options)
    ctl.add(input)
    ctl.add(get_encoding(encoding_file))
    res = defaultdict(dict)
    ctl.ground([("base", [])])
    if args.print_debug:
        print(f"{tag()} Grounded master problem")
    ngid = 0
    iter = -1
    master_optimum_proven = True
    added_constraints = []
    while solving:
        iter += 1
        if args.print_debug:
            print(f"{tag()} Solving Master")
        def on_model(m):
            if args.print_debug:
                print(f"{tag()} Found model for master")
            res['master']['cost'] = m.cost
            res['master']['model'] = m.symbols(shown=True)
            res['master']['opt'] = m.optimality_proven        
            if args.print_debug:
                print(f"{tag()} Optimality proven:", m.optimality_proven)        
        finished = execute_asp_solver(ctl, on_model, master_timeout, "master")
        if 'master' not in res or 'model' not in res['master'] or not res['master']['model']:
            print("Unknown: master cannot be solved within the time limit or is unsatisfiable.")
            exit(0)
        if not finished:
            master_optimum_proven = False
            print(f"{tag()} Warning: master reached the time limit at iteration {iter}: the model found may be suboptimal.")
        elif not res['master'].get('opt', False):
            master_optimum_proven = False
        if args.print_debug:
            print(f"{tag()} Done master")
        unsat = False
        parts = []
        dict = parse_result(res['master']['model'])
        if args.print_debug:
            print(f"{tag()} Master model parsed into {len(dict)} subproblems")
        for d in dict.keys():
            if args.print_debug:
                print(f"{tag()} Solving subproblem {d}")
            subproblem_status = run_subproblem(encoding_file, tuple(dict[d]), d, subproblem_timeout)
            if args.print_debug:
                print(f"{tag()} Done subproblem {d}")
            if subproblem_status == 'unknown':
                print(f"Unknown: subproblem {d} cannot be solved within the time limit.")
                exit(0)
            if subproblem_status == 'unsat':
                res['master']['model'] = None
                if args.print_debug:
                    print(f"{tag()} Subproblem unsatisfiable")
                unsat = True
                if args.print_debug:
                    print(f"{tag()} Creating no goods")
                
                constraint = ":- " + ", ".join(map(str, dict[d])) + "."                      
                if args.cuts is not None:
                    interesting_atoms = []                    
                    if args.cuts == 'domain_specific':
                        constraints = domain_specific_cut(args.specific_cut_module, str(d), dict[d], facts)                        
                        if constraints is not None:
                            constraint = constraints                          
                        elif args.print_debug:
                            print("No cut computed: using default")
                    else:
                        for s in dict[d]:   
                            if args.cuts == 'day' and s.name in unsafe_constraints_day:
                                interesting_atoms.append(str(s))
                            elif args.cuts == 'ts' and s.name in unsafe_constraints_ts_to_phase:
                                interesting_atoms.append(str(s))
                            elif args.cuts == 'resource' and s.name in unsafe_constraints_resource:
                                interesting_atoms.append(str(s))                     
                            elif args.cuts == 'all' and s.name in unsafe_constraints:
                                interesting_atoms.append(str(s))                            
                        if not interesting_atoms:
                            interesting_atoms = [str(s) for s in dict[d] if s.name in unsafe_constraints]
                            if args.print_debug:
                                print(f"{tag()} --cuts={args.cuts} not applicable to day {d}: falling back to the 'all' cut")
                        constraint = ":- " + ", ".join(interesting_atoms) + "."
                        
                    if args.print_debug:
                        print(f"{tag()} Interesting atoms: {interesting_atoms}")                                            
                if args.print_debug:
                    print(f"{tag()} Added nogood: {constraint}")
                    if constraint in added_constraints:
                        print(f"{tag()} Constraint already added: {constraint}")
                        exit(10)
                    added_constraints.append(constraint)                    
                ctl.add(f"nogood_{ngid}", [], constraint)
                ctl.ground([(f"nogood_{ngid}", [])])                
                ngid += 1
                if args.print_debug:                    
                    print(f"{tag()} Done")
                break
        if not unsat:
            solving = False
    execution_time = time.time() - start_time

    print("Master model:\n")
    print('. '.join(map(str, res['master']['model'])) + '.')
    print("Master cost:", res['master']['cost'])
    print("Master optimality proven:", master_optimum_proven)
    print('\n')
    for subproblem in res.keys():
        if subproblem != 'master':
            print(f"Subproblem {subproblem} model:\n")
            print('. '.join(map(str, res[subproblem]['model'])) + '.')
            print("Subproblem cost:", res[subproblem]['cost'])
            print("Optimality proven:", res[subproblem]['optimality_proven'])
            print('\n')
    print("Total iterations:", iter+1)
    print("Execution time: %.4f seconds" % execution_time)
except KeyboardInterrupt:
    print("Killed by user.")
    exit(130)
