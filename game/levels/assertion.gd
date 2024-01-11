class_name Assertion
extends Resource


@export var equality: String


func get_rules() -> Array[AlgebraicRule]:
	push_error("Not implemented")
	return []


func create_level() -> Level:
	return Level.create(AlgebraicParser.parse_equality(equality), get_rules())
