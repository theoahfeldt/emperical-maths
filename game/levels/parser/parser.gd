class_name AlgebraicParser


var _tokens: String
var _index: int = 0


static func parse_equality(equality: String) -> AlgebraicEquality:
	var parser := AlgebraicParser.new()
	parser._tokens = equality
	var left: AlgebraicExpression = parser._parse_expression()
	assert(parser._pop_token() == "=")
	var right: AlgebraicExpression = parser._parse_expression()
	return AlgebraicEquality.create(left, right)


static func parse_expression(expression: String) -> AlgebraicExpression:
	var parser := AlgebraicParser.new()
	parser._tokens = expression
	return parser._parse_expression()


func _parse_expression() -> AlgebraicExpression:
	var token = _pop_token()
	if _is_variable(token):
		return AlgebraicVariable.create(token)
	if _is_integer(token):
		return AlgebraicInteger.create(int(token))
	if token == "-":
		return AlgebraicNegation.create(_parse_expression())
	if token == "(":
		return _parse_sum()
	push_error("Parsing error: Unexpected character")
	return AlgebraicExpression.new()


func _parse_sum() -> AlgebraicSum:
	var left: AlgebraicExpression = _parse_expression()
	assert(_pop_token() == "+")
	var right: AlgebraicExpression = _parse_expression()
	assert(_pop_token() == ")")
	return AlgebraicSum.create(left, right)


func _pop_token() -> String:
	var token: String = _tokens[_index]
	_index += 1
	return token


func _is_variable(token: String):
	var regex := RegEx.create_from_string("[a-z]")
	var regex_match := regex.search(token)
	return regex_match != null


func _is_integer(token: String):
	var regex := RegEx.create_from_string("[0-9]")
	var regex_match := regex.search(token)
	return regex_match != null
