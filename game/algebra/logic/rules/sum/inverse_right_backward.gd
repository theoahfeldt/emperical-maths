class_name SumInverseRightBackward
extends AbstractRule
## 0 -> a + -a


func applicable(expression: AlgebraicExpression) -> bool:
	if expression is AlgebraicInteger:
		return expression.is_zero()
	return false


func apply(_expression) -> AbstractZeroSumRight:
	return AbstractZeroSumRight.new()
