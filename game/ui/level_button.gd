class_name LevelButton
extends Button


@export var dependencies: Array[LevelButton]


func construct_level() -> Level:
	var rules: Array[AlgebraicRule]
	if dependencies.is_empty():
		rules = level_rules()
	else:
		rules = imported_rules()
	var parts := text.split("=>")
	if len(parts) == 1:
		return Level.create(AlgebraicEquality.from_string(parts[0]), rules)
	elif len(parts) == 2:
		return conditional_level(parts[0], parts[1], rules)
	else:
		push_error("Cannot construct level out of string: ", text)
		return Level.new()


func conditional_level(
		antecedent: String, consequent: String, rules: Array[AlgebraicRule]
		) -> Level:
	var assumption := AlgebraicEquality.from_string(antecedent)
	var assumption_rules: Array[AlgebraicRule] = []
	assumption_rules.assign(AssumptionRule.from_equality(assumption))
	var level_equality := AlgebraicEquality.from_string(consequent)
	return Level.create(level_equality, assumption_rules + rules)


func level_rules() -> Array[AlgebraicRule]:
	var equality := AlgebraicEquality.from_string(text)
	var rules: Array[AlgebraicRule] = []
	rules.assign(IdentityRule.from_equality(equality))
	return rules


func imported_rules() -> Array[AlgebraicRule]:
	var rules: Array[AlgebraicRule] = []
	for dependency in dependencies:
		rules += dependency.exported_rules()
	return rules


func exported_rules() -> Array[AlgebraicRule]:
	return level_rules() + imported_rules()
