class_name AlgebraicParser


var _tokens: Array[Token]
var _index: int = 0


static func parse(expression: String) -> ParsableExpression:
	return AlgebraicParser.new()._parse(expression)


static func parse_implication(expression: String) -> Implication:
	var parsed := parse(expression)
	if parsed is Implication:
		return parsed
	push_error("%s is not a valid implication" % [expression])
	return null


static func parse_equality(expression: String) -> AlgebraicEquality:
	var parsed := parse(expression)
	if parsed is AlgebraicEquality:
		return parsed
	push_error("%s is not a valid equality" % [expression])
	return null


static func parse_algebraic(expression: String) -> AlgebraicExpression:
	var parsed := parse(expression)
	if parsed is AlgebraicExpression:
		return parsed
	push_error("%s is not a valid algebraic expression" % [expression])
	return null


func _parse(expression: String) -> ParsableExpression:
	_tokens = Tokenizer.tokenize(expression)
	var first_algebraic := _parse_algebraic()
	var next_token := _pop_token()
	if next_token == null:
		return first_algebraic
	if not next_token is EqualsToken:
		_print_error()
		return null
	var second_algebraic := _parse_algebraic()
	var first_equality := AlgebraicEquality.create(
			first_algebraic, second_algebraic)
	next_token = _pop_token()
	if next_token == null:
		return first_equality
	if not next_token is ImpliesToken:
		_print_error()
		return null
	var second_equality := _parse_equality()
	if next_token == null:
		return Implication.create(first_equality, second_equality)
	return null


func _parse_equality() -> AlgebraicEquality:
	var left: AlgebraicExpression = _parse_algebraic()
	if not _pop_token() is EqualsToken:
		_print_error()
		return null
	var right: AlgebraicExpression = _parse_algebraic()
	return AlgebraicEquality.create(left, right)


func _parse_algebraic() -> AlgebraicExpression:
	var token = _pop_token()
	if token is VariableToken:
		return AlgebraicVariable.create(token.name)
	if token is IntegerToken:
		return AlgebraicInteger.create(token.value)
	if token is MinusToken:
		return AlgebraicNegation.create(_parse_algebraic())
	if token is LeftParenthesisToken:
		return _parse_sum()
	push_error("Parsing error: Unexpected character")
	return null


func _parse_sum() -> AlgebraicSum:
	var left: AlgebraicExpression = _parse_algebraic()
	assert(_pop_token() is PlusToken)
	var right: AlgebraicExpression = _parse_algebraic()
	assert(_pop_token() is RightParenthesisToken)
	return AlgebraicSum.create(left, right)


func _pop_token() -> Token:
	if _index >= len(_tokens):
		return null
	var token := _tokens[_index]
	_index += 1
	return token


func _print_error() -> void:
	var index := _index - 1
	push_error("Unexpected token %s at index %d" % [_tokens[index], index])
