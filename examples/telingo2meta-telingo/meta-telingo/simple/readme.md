# Simple example

Simple example from the paper "Temporal Answer Set Programming on Finite
Traces".

## Example calls

    clingo encoding.lp instance.lp --output=reify | clingo - meta-telingo.lp -c horizon=3
