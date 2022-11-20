import unittest

import sys
# insert at 1, 0 is the script path (or '' in REPL)
sys.path.insert(1, '..')

import tests.TestTools as tools

if __name__ == '__main__':
    unittest.main()

class TestPreviousOperator(unittest.TestCase):
    
    def test_prev(self):
        result = tools.RunClingo("tests/amade/prev/test1.lp", 2)
        
        tools.CheckIfOutputIsCorrect(self, result, ["(a,0)", "(a,1)", "(a,2)", "(c,2)"], True)

    def test_prev_in_head(self):
        result = tools.RunClingo("tests/amade/prev/test2.lp", 3)
        
        tools.CheckIfOutputIsCorrect(self, result, ["(a,0)", "(a,1)", "(a,2)", "(a,3)",  "(c,0)", "(c,1)", "(c,2)"], True)
