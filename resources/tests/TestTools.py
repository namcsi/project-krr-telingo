import unittest
import subprocess
from pathlib import Path
from typing import Sequence
import regex

# Note that your PATH needs to have the command clingo defined,
# otherwise you have to edit the command below to wherever your clingo
# is.

# The Path to your Meta Encoding, from where you run the unittest
PATH_TO_META_ENCODING = Path("./resources/meta/meta-telingo.lp")


def CheckIfOutputIsCorrect(test: unittest.TestCase, result: str,
                           expected_sm: Sequence[str], satisfiable: bool):
    """
    Check if string result passed by running meta-telingo matches the expected
    satisfiability/stable mode.

    test: The unittest class that the assertions should be thrown for.
    result: The result of running .lp file thorough our meta-telingo
    implementation.
    stable_model: The stable model we are expecting as a sequence of
    strings representing atoms, e.g.:: ["(a,0)", "(a,1)"].
    satisfiable: If the program is expected to be satisfiable or not.
    """
    # Find with regex if the result was unsatisfiable or not and compare
    # to what we expected
    satisfiable_index = result.find('UNSATISFIABLE')
    test.assertEqual(satisfiable_index == -1, satisfiable)
    expected_sm = set(expected_sm)
    print(PATH_TO_META_ENCODING)
    print(expected_sm)
    # We extract all atoms of the form (atom, int), anything else is be ignored
    sm = set(regex.findall("\((?:[^)(]+|(?R))*+\)", result))
    print(sm)
    test.assertEqual(expected_sm, sm)


def RunClingo(filename, horizon, multiple_models=False):
    """
    Runs the given file through our meta-telingo system with the given horizon.

    filename: The filename clingo should look for
    horizon: What to set the horizon to for clingo
    multiple_models: If we should run clingo with the 0 option for all models,
    this can be used to quickly check if some tests contain non unique models.
    """
    # Run clingo with reify and save the result
    result = subprocess.run(['clingo', filename, "--output=reify"],
                            capture_output=True)
    # Check if there was any error on the stderr output
    # and if there was throw an Syntax error
    error = result.stderr.decode("utf-8")
    if(error != ""):
        raise SyntaxError("Clingo has output an error: \n\n"+error)
    # What commands we want to run for the meta encoding
    cmd_list = ["clingo", "-", PATH_TO_META_ENCODING, "-c",
                f"horizon={horizon}", "-V0"]
    # If multiple models are expected to be output, we need to add
    # the 0 option, this is however not implemented to be handled at the moment
    if multiple_models:
        cmd_list.append("0")
    # Run the meta encoding defined in the meta encoding path with all
    # the options we need
    result_meta = subprocess.run(cmd_list, input=result.stdout,
                                 capture_output=True)
    # Check if there was any error on the stderr output and if there was throw
    # a Syntax error
    error = result_meta.stderr.decode("utf-8")
    if(error != ""):
        raise SyntaxError("Meta-encoding has output an error: \n\n"+error)
    return str(result_meta.stdout)
