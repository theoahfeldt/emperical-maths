class_name AbstractZeroSumRight
extends AbstractExpression


func substitute(expression: AlgebraicExpression) -> AlgebraicSum:
	return AlgebraicSum.create(
			expression, AlgebraicNegation.create(expression.copy()))


func graphical_expression() -> GraphicalSum:
	return GraphicalSum.create(
			GraphicalVariable.create("?"),
			GraphicalNegation.create(GraphicalVariable.create("?")))
