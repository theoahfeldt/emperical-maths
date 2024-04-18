class_name IdentityRule
extends AlgebraicRule


var _before: ManipulableExpression
var _after: ManipulableExpression


func _to_string() -> String:
	return "IdentityRule(%s, %s)" % [_before.to_string(), _after.to_string()]


static func create(
		before: ManipulableExpression, after: ManipulableExpression) -> IdentityRule:
	var new := IdentityRule.new()
	new._before = before
	new._after = after
	return new


static func from_equality(equality: AlgebraicEquality) -> Array[IdentityRule]:
	return [
		IdentityRule.create(equality.left_expression, equality.right_expression),
		IdentityRule.create(equality.right_expression, equality.left_expression),
	]


func apply(expression: ManipulableExpression) -> ApplicationResult:
	var match_result := _before.pattern_match(expression)
	if match_result is PatternMatchFailure:
		return ApplicationFailure.new()
	var instance := _after.substitute(match_result.assignments)
	return ApplicationSuccess.create(instance)
