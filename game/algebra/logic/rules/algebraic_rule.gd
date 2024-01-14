class_name AlgebraicRule


var _before: AlgebraicExpression
var _after: AlgebraicExpression


static func parse(before: String, after: String) -> AlgebraicRule:
	var new := AlgebraicRule.new()
	new._before = AlgebraicParser.parse_expression(before)
	new._after = AlgebraicParser.parse_expression(after)
	return new


func apply(expression: AlgebraicExpression) -> ApplicationResult:
	var match_result := _before.pattern_match(expression)
	if match_result is PatternMatchFailure:
		return ApplicationFailure.new()
	var bound_expression := _after.bind(match_result.bindings)
	return ApplicationSuccess.create(bound_expression)
