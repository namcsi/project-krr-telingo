# J Moore's Problem

Encoding of [J Moore's Problem][jmp].

There are two versions one with basic temporal operators and one with complex
temporal operators. For now we consider only the basic version.

## Example calls

    clingo moore-basic.lp --output=reify | clingo - meta-telingo.lp -c horizon=13 0

[jmp]: https://www.cs.utexas.edu/users/vl/tag/jmoore_discussion


