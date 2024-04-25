extends Node


func _ready() -> void:
	print(AlgebraicParser.parse("-(a+-0)=0"))
	print(AlgebraicParser.parse("a=b=>b=a"))
	print(AlgebraicParser.parse("(a^-b)"))
