extends Node


func _ready() -> void:
	var string := "-(a+-0)=0"
	var expression := AlgebraicParser.parse_equality(string)
	print(expression)
