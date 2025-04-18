from pathlib import Path
from pkgutil import iter_modules
from importlib import import_module
from timeit import timeit
import pytest


# Here we benchmark each problem's main() function to ensure that it runs on average in less than 2 seconds
problem_files_path = Path(__file__).parent.parent / 'src' / 'project_euler'
problem_modules = [m for (_,m,_) in iter_modules([problem_files_path]) if m.startswith("problem")] # problem001, problem002, etc

@pytest.mark.parametrize("module_name", problem_modules)
def test_performance(module_name):
    module = import_module(f"project_euler.{module_name}")
    n_runs = 5
    avg_runtime = timeit(lambda: module.main(),number = n_runs) / n_runs
    assert avg_runtime < 2