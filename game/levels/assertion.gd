class_name Assertion
extends Resource


@export var equality: String


func get_rules() -> Array[AlgebraicRule]:
	push_error("Not implemented")
	return []


func create_level() -> Level:
	var parser := AlgebraicParser.new()
	return Level.create(parser.parse_equality(equality), get_rules())
