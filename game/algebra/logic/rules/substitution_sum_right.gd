class_name SubstitutionSumRight
extends Substitution


func substitute(expression: AlgebraicExpression) -> AlgebraicExpression:
	return AlgebraicSum.create(
			expression.copy(), AlgebraicNegation.create(expression.copy()))


func graphical_expression() -> GraphicalExpression:
	return GraphicalSum.create(
			GraphicalVariable.create("?"),
			GraphicalNegation.create(GraphicalVariable.create("?")))
