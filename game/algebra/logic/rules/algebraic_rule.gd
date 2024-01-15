class_name AlgebraicRule


var _before: AlgebraicExpression
var _after: AlgebraicExpression


static func create(
		before: AlgebraicExpression, after: AlgebraicExpression
		) -> AlgebraicRule:
	var new := AlgebraicRule.new()
	new._before = before
	new._after = after
	return new


static func parse(before: String, after: String) -> AlgebraicRule:
	return AlgebraicRule.create(AlgebraicParser.parse_expression(before),
			AlgebraicParser.parse_expression(after))


func apply(expression: AlgebraicExpression) -> ApplicationResult:
	var match_result := _before.pattern_match(expression)
	if match_result is PatternMatchFailure:
		return ApplicationFailure.new()
	var instance := _after.substitute(match_result.assignments)
	return ApplicationSuccess.create(instance)
