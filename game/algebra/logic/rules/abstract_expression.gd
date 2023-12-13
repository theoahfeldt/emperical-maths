class_name AbstractExpression


func bind(_expression: AlgebraicExpression) -> AlgebraicExpression:
	push_error("Function not implemented")
	return AlgebraicExpression.new()


func graphical_expression() -> GraphicalExpression:
	push_error("Function not implemented")
	return GraphicalExpression.new()
