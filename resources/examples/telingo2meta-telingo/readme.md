# Conversion of telingo examples to meta-telingo

To goal of this directory is to provide some example temporal logic
programs we will be converting to the input language of our
meta-telingo implementation.

## telingo

The telingo directory contains some examples part of the telingo
distribution. See the readme.md files for explanations of the problems,
as well as instructions on how to run them.

## meta-telingo

The meta-telingo directory mirrors the structure of the telingo
directory, and will be filled up by students with translations of the
telingo problem to meta-telingo. For an example of how to do the
translation, see the river-crossing directory, which has already been
translated.

## Some useful pointers

- In the input language of out meta-telingo, all rules/facts apply to
  all time points, as if they were in the #program always subprogram
  of telingo.
- In telingo, the _ can be used as a unary initially operator. For
  example _p evaluates to true if p holds in the initial state. Our
  input language doesn't support this syntactic sugar.
- As in the examples, #external declarations need to be added to avoid
  gringo simplifying away atoms with temporal operators during
  reification.
  
