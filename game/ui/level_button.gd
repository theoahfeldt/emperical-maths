class_name LevelButton
extends Button


@export var dependencies: Array[LevelButton]


func construct_level() -> Level:
	var equality := AlgebraicParser.parse_equality(text)
	var rules: Array[AlgebraicRule]
	if dependencies.is_empty():
		rules = level_rules()
	else:
		rules = imported_rules()
	return Level.create(equality, rules)


func level_rules() -> Array[AlgebraicRule]:
	var equality := AlgebraicParser.parse_equality(text)
	return [
		AlgebraicRule.create(equality.left_expression, equality.right_expression),
		AlgebraicRule.create(equality.right_expression, equality.left_expression),
	]


func imported_rules() -> Array[AlgebraicRule]:
	var rules: Array[AlgebraicRule] = []
	for dependency in dependencies:
		rules += dependency.exported_rules()
	return rules


func exported_rules() -> Array[AlgebraicRule]:
	return level_rules() + imported_rules()
