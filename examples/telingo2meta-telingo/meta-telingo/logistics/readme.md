# Logistics problem from the AIPS planning competition

Encodes the [standard logistics domain][sld].

## Example calls

    clingo encoding.lp instance.lp --output=reify | clingo - meta-telingo.lp -c horizon=9 0

[sld]: https://github.com/SoarGroup/Domains-Planning-Domain-Definition-Language/blob/master/pddl/logistics.pddl
