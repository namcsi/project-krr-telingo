# Tests

To make sure our meta-telingo implementation is correct, some testing
is necessary. `TestTools.py` provides some basic utility function for
writing unittests for our operators. To see an example on how we could
test the `prev` operator, check out `./amade/prev` directory. Note
that we test the occurance of the operator in the body, as well as the
head.

To run use `python -m unittest` in your root directory, this file
should be under `tests\TestTools.py` To find tests make sure you have
__init__.py files in each of your folders you want python to look
through.
