extends Node


func _ready() -> void:
	var parser := AlgebraicParser.new()
	var string := "(a+0)=0"
	var expression := parser.parse_equality(string)
	print(expression.pretty_string())
