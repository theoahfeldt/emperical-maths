class_name AssumptionRule
extends ManipulationRule


var _before: AlgebraicExpression
var _after: AlgebraicExpression


func _to_string() -> String:
	return "AssumptionRule(%s, %s)" % [_before.to_string(), _after.to_string()]


static func create(before: AlgebraicExpression, after: AlgebraicExpression
		) -> AssumptionRule:
	var new := AssumptionRule.new()
	new._before = before
	new._after = after
	return new


static func from_equality(equality: AlgebraicEquality) -> Array[AssumptionRule]:
	return [
		AssumptionRule.create(equality.left_expression, equality.right_expression),
		AssumptionRule.create(equality.right_expression, equality.left_expression),
	]


func apply(expression: ManipulableExpression) -> ApplicationResult:
	if expression.identical_to(_before):
		return ApplicationSuccess.create(_after)
	return ApplicationFailure.new()
