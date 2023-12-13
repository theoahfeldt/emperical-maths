class_name SumCommutativity
extends AlgebraicRule
## a + b -> b + a


func applicable(expression: AlgebraicExpression) -> bool:
	return expression is AlgebraicSum


func apply(sum: AlgebraicSum) -> AlgebraicSum:
	return AlgebraicSum.create(sum.right_term.copy(), sum.left_term.copy())
