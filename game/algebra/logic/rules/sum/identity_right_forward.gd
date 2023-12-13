class_name SumIdentityRightForward
extends ConcreteRule
## a + 0 -> a


func applicable(expression: AlgebraicExpression) -> bool:
	if expression is AlgebraicSum:
		if expression.right_term is AlgebraicInteger:
			return expression.right_term.is_zero()
	return false


func apply(sum: AlgebraicSum) -> AlgebraicExpression:
	return sum.left_term.copy()
