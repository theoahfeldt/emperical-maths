class_name SumInverseRightForward
extends ConcreteRule
## a + -a -> 0


func applicable(expression: AlgebraicExpression) -> bool:
	if expression is AlgebraicSum:
		if expression.right_term is AlgebraicNegation:
			return expression.right_term.expression.identical_to(expression.left_term)
	return false


func apply(_expression: AlgebraicExpression) -> AlgebraicInteger:
	return AlgebraicInteger.zero()
