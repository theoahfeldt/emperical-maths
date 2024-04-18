class_name LevelButton
extends Button


@export var dependencies: Array[LevelButton]
@onready var expression: ParsableExpression = AlgebraicParser.parse(text)


func construct_level() -> Level:
	if dependencies.is_empty() and expression is AlgebraicEquality:
		return _axiom_level(expression)
	if expression is AlgebraicEquality:
		return _identity_level(expression)
	if expression is Implication:
		return _conditional_level(expression)
	push_error("Cannot construct level out of string: ", text)
	return null


func exported_rules() -> Array[ManipulationRule]:
	var rules := _distinct_rules(_imported_rules())
	return _level_rules() + rules


func _axiom_level(equality: AlgebraicEquality) -> Level:
	return Level.create(equality, _level_rules())


func _identity_level(equality: AlgebraicEquality) -> Level:
	return Level.create(equality, _imported_rules())


func _conditional_level(implication: Implication) -> Level:
	var assumption_rules: Array[ManipulationRule] = []
	assumption_rules.assign(AssumptionRule.from_equality(implication.antecedent))
	return Level.create(implication.consequent, assumption_rules + _imported_rules())


func _level_rules() -> Array[ManipulationRule]:
	var rules: Array[ManipulationRule] = []
	if expression is AlgebraicEquality:
		rules.assign(AlgebraicRule.from_equality(expression))
	if expression is Implication:
		rules.append(AlgebraicRule.from_implication(expression))
	return rules


func _imported_rules() -> Array[ManipulationRule]:
	var rules: Array[ManipulationRule] = []
	for dependency in dependencies:
		rules += dependency.exported_rules()
	return rules


func _distinct_rules(rules: Array[ManipulationRule]) -> Array[ManipulationRule]:
	var distinct: Array[ManipulationRule] = []
	var dict := {}
	for rule in rules:
		dict[rule.to_string()] = rule
	distinct.assign(dict.values())
	return distinct
